---
title: 'OctoPrint i Home Assistant'
subtitle: 'Home Assistant, Docker och OctoPrint'
summary: Tillägg för OctoPrint i Home Assistant
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

Jag har sedan tidigare publicerat ett tillägg till [Home Assistant](https://home-assistant.io) för att kunna köra OctoPrint på samma enhet. Där finns det nu en version som heter "Experimental", vilket är ett försök att uppdatera till senaste versionen och lägga till funktioner så som Ingress.

Utmaningar har dels varit att få Ingress att fungera över huvud taget, vilket jag tror är löst nu, men även att hålla nere storleken. Publicerad version (`0.3.0-alpha4`) kör endast Python3 för att spara utrymme. Jag hade även tänkt byta ut `supervisord` mot `s6`, men har inte fått det att fungera tillräckligt bra.

Tillägget finns på: [GitHub](https://github.com/fredrikbaberg/hassio-addons).