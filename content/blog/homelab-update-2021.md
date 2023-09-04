---
title: "Homelab - Update (2021)"
date: 2021-08-13T17:50:52-04:00
draft: false
---

[![PotatoLab](/images/homelab-update-2021/overview.jpg)](/images/homelab-update-2021/overview.jpg)

I want to give you guys an update on my homelab hobby. Due to COVID-19 reasons, I've spent most of my time working remote from home and fiddling with my homelab. This has led me to make some more upgrades to it since last year. Some of the major changes were the Proxmox cluster (different hardware) and the storage servers (internal components replaced with enterprise-grade hardware). Details on the setup can be found below this quote below.

For anyone who's curious why I do this, here's the original quote I put in the original homelab post ([here](../homelab/)):

> My homelab, known as "PotatoLab", has been an ongoing personal hobby to learn new tools and gain knowledge in networking/systems administration and DevOps. The homelab project has gone through 6 upgrades over the years since 2015 (freshman in college up to now). I have used it to host various applications such as Plex home media, NextCloud private cloud, ad-blocking DNS servers, etc. Most of the hardware seen in the picture were retrieved via Amazon and Ebay.

## Hardware

From top to bottom:
* CAT6 24Port Patch panel
* Netgear GSM7248R 48Port 1Gbps Managed Switch
* Supermicro HYVE ZEUS 1U Server
    * Intel Xeon CPU E5-2630L v2 @ 2.40GHz x2
    * 64GB RAM (4x 16GB Samsung 1600Mhz)
    * 120GB SSD
* Supermicro HYVE ZEUS 1U Server
    * Intel Xeon CPU E5-2630L v2 @ 2.40GHz x2
    * 64GB RAM (4x 16GB Samsung 1600MHz)
    * 120GB SSD
* Supermicro 826 Chassis
    * Intel Xeon CPU E5-2630L @ 2.00GHz x2
    * 32GB RAM (8x 4GB Samsung 1333MHz)
    * 120GB SSD; 12x 2TB HDDs in RAIDZ1s in RAIDz2 pool (15.5TB Usable)
* Supermicro 826 Chassis
    * Intel Xeon CPU E5-2630L @ 2.00GHz x2
    * 16GB RAM (4x 4GB Samsung 1333MHz)
    * 120GB SSD; 12x 3TB HDDs in RAIDZ1s in RAIDz2 pool (23.2TB Usable)
* (Left of rack) APC UPS
    * APC Back-UPS Pro 1500VA (BR1500G)
    * APC External Battery Backup Pack (BR24BPG)

Back of rack (not seen in picture):
* ARRIS SURFboard (16x4) DOCSIS 3.0 Cable Modem
* Qotom Q190G4N-S07 PC w/ 4 Gigabit NICs
* Ubiquiti Networks UniFi AP AC Lite

## Software

* Qotom Q190G4N-S07 PC
    * OPNsense Firewall
* 2x Supermicro HYVE ZEUS 1Us running Proxmox in Cluster
    * 2x [PiHole](https://pi-hole.net/) DNS
    * PostgreSQL
    * MariaDB
    * MongoDB
    * [Grafana/Prometheus](https://grafana.com/)
    * [Shinobi Survelliance](https://shinobi.video/)
    * Apache2
        * NextCloud
        * tasmotaAdmin
        * [TasmotaAdmin](https://github.com/reloxx13/TasmoAdmin)
    * [HomeAssistant](https://www.home-assistant.io/)
    * Unifi Controller
    * TransmissionCLI
    * [Plex](https://www.plex.tv/) Home Media
    * [FreePBX](https://www.freepbx.org/)
    * 2x NTP Servers
    * YoutubeDL
    * Docker
    * Graylog/Elasticsearch Logging
    * 2x Go Ethereum Nodes
    * Ark Survival Game Server
    * Storj
    * [GNS](https://www.gns3.com/)
* 2x Supermicro 826 Chassis
    * Ubuntu running ZFS

## Network Topology

[![Network_Topology](/images/homelab-update-2021/network_diagram.jpg)](/images/homelab-update-2021/network_diagram.jpg)

See [here](../) for other homelab blog(s).
