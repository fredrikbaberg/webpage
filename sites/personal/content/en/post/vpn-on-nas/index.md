---
title: 'VPN server on ReadyNAS'
subtitle: ''
summary: 
authors:
- admin
tags:
- VPN
- ReadyNAS
categories:
- ReadyNAS
date: "2018-02-11T17:12:06+01:00"
lastmod: "2018-02-11T17:12:06+01:00"
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

After trying to setup VPN on my current router (which doesn't really support that), I saw that it was possible to install a VPN server on my ReadyNAS. In short, this is how I did:

* Get the VPN addon, either from the app store on the NAS or from [this page](http://apps.readynas.com/pages/). If it's visible in the app store in ReadyNAS UI, just install it, otherwise you need to upload the .deb file to install it.
    - At first it was a bit unclear to me how to use this addon. A shared folder will be created, called vpnserver, in which there is a setup file for a management tool. Just install this tool, and you should be able to configure the server.
* Since the version is a bit old by now, I wanted to install a newer version. I followed the following [instructions](https://community.netgear.com/t5/Current-NETGEAR-and-Partners/How-can-I-update-SoftEther-VPN-App-to-Newest-Version-ReadyNAS/td-p/1070626).
    - Stop the VPN server using the ReadyNAS web administration tool, since the files will be updated.
    - Enable SSH root access. This probably voids your warranty, but since my NAS is a few years by now I'm OK with that. There is an option to enable SSH access in the web UI. Don't forget to set an admin password, to be able to sign in.
    - SSH into NAS with user `root`.
    - Install tools for compiling:
        ``` apt-get update && apt-get install make libc6-dev gcc gdb libtag1-dev uuid-dev ```
    - Download newer version of the VPN server from the softether webpage, to the NAS. From `softether` download: VPN Server, Linux, arm-eabi 32-bit in my case (RN104). Not sure for how long the link will work, but just to have examples:
        ``` wget http://www.softether-download.com/files/softether/v4.25-9656-rtm-2018.01.15-tree/Linux/SoftEther_VPN_Server/32bit_-_ARM_EABI/softether-vpnserver-v4.25-9656-rtm-2018.01.15-linux-arm_eabi-32bit.tar.gz ```
    - Unpack the archive into vpnserver folder:
        ``` tar -xvf  softether-vpnserver-v4.25-9656-rtm-2018.01.15-linux-arm_eabi-32bit.tar.gz -C /apps/vpnserver/bin/arm --strip-components=1 ```
    - Compile new version:
        ``` cd /apps/vpnserver/bin/arm && ./.install.sh ``` Note that the filename is `.install.sh`, so it is normally hidden.
    - Copy the newly compiled files one level up. I'm not clear on why this is needed, but it says so.
        ``` cp -R /apps/vpnserver/bin/arm/* /apps/vpnserver/bin/ ```
    - Update ownership of the bin folder, since it is now (partially) owned by root.
        ``` cd /apps/vpnserver && chown -R admin:admin bin/ ```
    - Remove previously downloaded archive (cleanup).
        ``` rm ~/softether-vpnserver-v4.25-9656-rtm-2018.01.15-linux-arm_eabi-32bit.tar.gz ```
    - Start VPN server again using web UI.
    - As the version was updated, make sure to download and run the latest VPN server manager from the `softether` website.