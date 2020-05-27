---
title: 'ZeroTier-One'
subtitle: 'ZeroTier One as VPN Bridge'
summary: ZeroTier One as VPN Bridge
authors:
- admin
tags:
- ZeroTier-One
- VPN
categories:
- ZeroTier-One
date: "2020-05-27T13:42:00+02:00"
lastmod: "2020-05-27T13:42:00+02:00"
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

As an alternative to running a VPN connection, I'm now trying ZeroTier-One.

This is how I made it work:
* Add community repository (uncomment line in `/etc/apk/repositories`)

> apk add zerotier-one
> apk add iptables
> /etc/init.d/zerotier-one start
> zerotier-cli join #network-id
> add `net.ipv4.ip_forward = 1` to `/etc/sysctl.conf`

* accept join in [my.zerotier.com](my.zerotier.com) portal

The create the following script, `ZerotierRouting.start` [https://www.reddit.com/r/zerotier/comments/9714a2/easy_way_of_bridging_lan_for_remote_access/?sort=old](https://www.reddit.com/r/zerotier/comments/9714a2/easy_way_of_bridging_lan_for_remote_access/?sort=old), remember to replace network interface names with correct names:
> #!/bin/sh
> /etc/init.d/zerotier-one start
> iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
> iptables -A FORWARD -i eth0 -o ztXXXXXXXX -m state --state RELATED,ESTABLISHED -j ACCEPT
> iptables -A FORWARD -i ztXXXXXXXX -o eth0 -j ACCEPT

Enable local.d scripts at boot time and add the script (https://unix.stackexchange.com/questions/442020/alpine-linux-run-a-startup-script-to-change-the-etc-issue):
> rc-update add local default
> mv ZerotierRouting.start /etc/local.d/ZerotierRouting.start
> chmod +x /etc/local.d/ZerotierRouting.start

Finally, go to [my.zerotier.com](my.zerotier.com) portal and add a route with destination `192.168.1.0/24` `(via)` `10.1.2.3` (set destination to desired network, via IP to your Alpine Linux/Zerotier IP address).