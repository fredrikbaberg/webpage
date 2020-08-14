---
title: 'InfluxDB and retention'
subtitle: 'Archive data'
summary: Archive data in InfluxDB
authors:
- admin
tags:
- InfluxDB
- Home Assistant
categories:
- HomeAssistant
date: "2020-08-11T20:12:00+02:00"
lastmod: "2020-08-14T10:46:00+02:00"
featured: false
draft: false

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Placement options: 1 = Full column width, 2 = Out-set, 3 = Screen-width
# Focal point options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
image:
  placement: 2
  caption: 'Image credit: '
  focal_point: ""
  preview_only: false

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects: []
---

I recently encountered an issue where my backup of Home Assistant took to much space compared to what I had available. One reason could be that I stored all data in InfluxDB, without any retention policy. After purging all the data from InfluxDB the backup size went from 4GB to 500MB, and backups were faster.

I found the following thread with an example of retention policies which I based my setup on: [https://monitoring-portal.org/t/retention-policies-and-continuous-queries-made-simple/1792](https://monitoring-portal.org/t/retention-policies-and-continuous-queries-made-simple/1792).

In the new setup there is a separate database, `archive` used for long-term storage, while the raw data is purged after 7 days. `archive` has three levels with different granularity:
* Sampled with mean of five minutes, for shorter timespan.
* Sampled with mean of 30 minutes, for medium timespan.
* Sampled with mean of 1 hour, for longer time.

### Setup in InfluxDB

The following commands are entered under _Explore_ in Chronograf, which is the graphical user interface I get with InfluxDB as Home Assistant addon.

#### First level

First level is for incoming data, which is sampled to five minutes using mean value.
> CREATE DATABASE "archive" WITH DURATION 1d1h

For each domain and instance of Home Assistant I use one continuous query.
My two instances are called _homeassistant_ and _homeassistantpissd_ (Home Assistant running on a Raspberry Pi with an SSD).
```
CREATE CONTINUOUS QUERY "cq_5m_homeassistantpissd_sensor" ON "archive" BEGIN
    SELECT mean("value") AS "value", mean("battery_level") AS battery_level
    INTO "archive"."autogen"."sensor"
    FROM "homeassistantpissd"."autogen"."sensor"
    GROUP BY time(5m),*
END
```
```
CREATE CONTINUOUS QUERY "cq_5m_homeassistant_binary_sensor" ON "archive" BEGIN
    SELECT mean("value") AS "value", mean("voltage") AS "voltage", mean("temperature") AS "temperature", mean("on") AS "on", mean("battery_level") AS "battery_level"
    INTO "archive"."autogen"."binary_sensor"
    FROM "homeassistant"."autogen"."binary_sensor"
    GROUP BY time(5m),*
END
```
```
CREATE CONTINUOUS QUERY "cq_5m_homeassistant_fan" ON "archive" BEGIN
    SELECT mean("value") AS "value", mean("aqi") AS "aqi", mean("filter_hours_used") AS "filter_hours_used", mean("filter_life_remaining") AS "filter_life_remaining", mean("humidity") AS "humidity", mean("illuminance") AS "illuminance", mean("motor_speed") AS "motor_speed", mean("temperature") AS "temperature"
    INTO "archive"."autogen"."fan"
    FROM "homeassistant"."autogen"."fan"
    GROUP BY time(5m),*
END
```
```
CREATE CONTINUOUS QUERY "cq_5m_homeassistant_person" ON "archive" BEGIN
    SELECT last("state") AS "state", median("latitude") AS "latitude", median("longitude") AS "longitude"
    INTO "archive"."autogen"."person"
    FROM "homeassistant"."autogen"."person"
    GROUP BY time(5m),*
END
```
```
CREATE CONTINUOUS QUERY "cq_5m_homeassistant_sensor" ON "archive" BEGIN
    SELECT mean("value") AS "value", mean("battery_level") AS battery_level, mean("temperature") AS temperature
    INTO "archive"."autogen"."sensor"
    FROM "homeassistant"."autogen"."sensor"
    GROUP BY time(5m),*
END
```
```
CREATE CONTINUOUS QUERY "cq_5m_homeassistant_weather" ON "archive" BEGIN
    SELECT mean("humidity") AS "humidity", mean("pressure") AS "pressure", last("state") AS "state", mean("temperature") AS "temperature", mean("wind_bearing") AS "wind_bearing", mean("wind_speed") AS "wind_speed"
    INTO "archive"."autogen"."weather"
    FROM "homeassistant"."autogen"."weather"
    GROUP BY time(5m),*
END
```

#### Second level

The second level keeps data for one week, sampled to 30 minutes. For simplicity I use `mean(*)` instead of writing each entry, this has the disadvantage that data will be prefixed by `mean`, e.g. `value` will be called `mean_value`.
This is only for sensor, separate CQs need to be configured for other data.

```
CREATE RETENTION POLICY "rp_1_week" ON "archive" DURATION 1w1d REPLICATION 1
CREATE CONTINUOUS QUERY "cq_into_1_week_sensor" ON "archive" BEGIN
    SELECT mean(*)
    INTO "rp_1_week"."sensor"
    FROM "autogen"."sensor"
    GROUP BY time(30m),*
END
```

#### Third level

The third and final level is kept infinitely, where the mean value of 1 hour is used. Data here will be called `mean_mean_value` due to the wildcard.

```
CREATE RETENTION POLICY "rp_infinite" ON "archive" DURATION INF REPLICATION 1
CREATE CONTINUOUS QUERY "cq_into_infinity_sensor" ON "archive" BEGIN
    SELECT mean(*)
    INTO "archive"."rp_infinite"."sensor"
    FROM "archive"."rp_1_week"."sensor"
    GROUP BY time(1h),*
END
```

### Improvements

I'm currently more or less running the above setup, but with all duration for retention policy on `archive` set to `INF`. Raw data will still be deleted after 7 days. I'll let this run for a week or so before I decide if I need to make any modifications.