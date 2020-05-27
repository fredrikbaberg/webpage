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
lastmod: "2020-05-27T14:54:00+02:00"
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

I always forget how to make Alpine Linux appear properly in Proxmox, with qemu guest agent. So here the steps I use are:

* Enable qemu agent in Proxmox
* In Alpine linux, run the following commands:
* > apk add qemu-guest-agent
* Modify /etc/init.d/qemu-guest-agent to port /dev/vport1p1
