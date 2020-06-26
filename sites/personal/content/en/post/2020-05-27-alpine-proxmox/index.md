---
title: 'Alpine Linux and Proxmox'
subtitle: ''
summary: Alpine Linux and Proxmox
authors:
- admin
tags:
- Alpine
- Proxmox
categories:
- Proxmox
date: "2020-05-27T14:54:00+02:00"
lastmod: "2020-06-26T12:36:00+02:00"
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

Since I sometimes setup new Alpine Linux VMs in Proxmox, I thought I would document the base setup I use. In this case install of Qemu Guest Agent and Docker.

* Create VM with Alpine Linux, remember to enable `qemu-agent`.
* For Qemu Guest Agent:
  * Install Qemu Guest Agent through `apk add --no-cache qemu-guest-agent`
  * run `rc-update add local default`
  * create file `/etc/local.d/Qemu.start` with content (make sure to check port, it could be something else):
    * > #!/bin/sh
      > qemu-ga -d -p /dev/vport1p1
  * Make file executable `chmod +x /etc/local.d/Qemu.start`
* For Docker
  * Uncomment `community` from `/etc/apk/repositories`
  * Install through `apk add --no-cache docker docker-compose`
  * Launch daemon at boot through `rc-update add docker boot`
