---
title: 'OctoPrint in Home Assistant'
subtitle: 'Home Assistant, Docker and OctoPrint'
summary: Addon for OctoPrint in Home Assistant
authors:
- admin
tags:
- OctoPrint
- HomeAssistant
categories:
- OctoPrint
- HomeAssistant
- Docker
date: "2020-04-28T08:15:00+02:00"
lastmod: "2020-04-28T08:15:00+02:00"
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

I've previously published an addon for [Home Assistant](https://home-assistant.io), enabling the use of OctoPrint on the same device. There is now a version called "Experimental" which is my latest update. It adds features such as Ingress

Some of the challenges has been to make Ingress work, which I believe is resolved now, but also to keep the file size low. The latest published version (`0.3.0-alpha4`) is using Python3 to save space. I intended to replace `supervisord` with `s6`, but have not been able to make it run properly.

The addon is available on [GitHub](https://github.com/fredrikbaberg/hassio-addons).