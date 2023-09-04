---
title: "Homelab"
date: 2021-02-02T20:35:44-05:00
draft: false
---

[![PotatoLab](/images/homelab/overview.jpg)](/images/homelab/overview.jpg)

My homelab, known as "PotatoLab", has been an ongoing personal hobby to learn new tools and gain knowledge in networking/systems administration and DevOps. The homelab project has gone through 5 upgrades over the years since 2015 (freshman in college up to now). I have used it to host various applications such as Plex home media, NextCloud private cloud, ad-blocking DNS servers, etc. Most of the hardware seen in the picture were retrieved via Amazon and Ebay.

## Hardware

From top to bottom:
* CAT6 24Port Patch panel
* Netgear GSM7248R 48Port 1Gbps Managed Switch
* (Left) Qotom Q190G4N-S07 PC w/ 4 Gigabit NICs
* (Left) 2x Dell Optiplex 3020M
    * Intel i5-4590T
    * 16GB DDR3 RAM
    * 120GB SSD
* (Middle) ARRIS SURFboard (16x4) DOCSIS 3.0 Cable Modem
* (Right) 2x Dell Optiplex 3020M
    * Intel i5-4590T
    * 16GB DDR3 RAM
    * 120GB SSD
* Mikrotik CRS317-1G-16S+RM 16Port 10Gbps Managed Switch
* Supermicro 826 Chassis
    * AMD Ryzen 3 3100
    * 32GB RAM
    * 120GB SSD; 12x 2TB HDDs in RAIDZ1s in RAIDz2 pool (15.5TB Usable)
* Supermicro 826 Chassis
    * AMD Ryzen 3 3100
    * 16GB RAM
    * 120GB SSD; 12x 3TB HDDs in RAIDZ1s in RAIDz2 pool (23.2TB Usable)
* (Left of rack) APC UPS
    * APC Back-UPS Pro 1500VA (BR1500G)
    * APC External Battery Backup Pack (BR24BPG)
* Access Points
    * 2x Ubiquiti Networks UniFi AP AC Lite (one not showing in pic)

## Software

* Qotom Q190G4N-S07 PC
    * OPNsense Firewall
* 4x Dell Optiplex 3020Ms running Proxmox in Cluster
    * 2x [PiHole](https://pi-hole.net/) DNS
    * MariaDB
    * PostgreSQL
    * MongoDB
    * NextCloud
    * [Plex](https://www.plex.tv/) Home Media
    * Unifi Controller
    * Shinobi Survelliance
    * [HomeAssistant](https://www.home-assistant.io/)
    * [FreePBX](https://www.freepbx.org/)
    * [Grafana/Prometheus](https://grafana.com/)
    * [TasmotaAdmin](https://github.com/reloxx13/TasmoAdmin)
    * phpMyAdmin
    * TransmissionCLI
    * bazarr
    * radarr
    * sonarr
* 2x Supermicro 826 Chassis
    * Ubuntu running ZFS

> For anyone wondering, with all of these applications running in my Proxmox cluster, I'm still consuming about 50-60% of that 64GB RAM space. That's not bad for a small cluster.

There are a couple of challenges I wanted to achieve with my homelab:

* Energy efficiency
* Redundancy in the following:
    * Hypervisor
    * Storage
    * Networking
    * Power supply
* Have lots of CPU and RAM capability to perform my needs & wants

With the existing homelab (as seen in picture above), I managed to keep the power consumption between 360-400watts without the storage backup server (at bottom of rack) running 18 hours of the day. It goes up to 550watts at night time from 12AM to 6PM to perform its backup duties. It does meet the challenges of energy efficiency and so-so on the power supply. The following doesn't have redundant power supply: main Netgear switch, 4x Dell mini-PCs, and the main router. I hope someday I'll get these issues resolved. I have plans to upgrade my homelab to have full 10G network between my storage servers, gaming PC, and the hypervisors.

I've attached my network topology to show how my entire homelab is wired up:

[![Network_Topology](/images/homelab/network_diagram.jpg)](/images/homelab/network_diagram.jpg)

I spent countless hours carefully designing a big, but simple, network topology design to ensure I covered how the homelab is set up. The connections between the switches and the servers, there are 5 VLANs I use for different purposes. They are configured differently in each interface coming in/out of the main Netgear switch.

VLAN Tags:
* 100 - Core Management Network
* 101 - Management Interface for Proxmox & ZFS NAS
* 102 - Private network, including VMs in Proxmox cluster
* 104 - Storage traffic between Proxmox cluster & ZFS NAS servers
* 192 - Public network for my personal devices + my roommate's stuff

# Old Homelabs

For anyone curious, here are some pictures of my old homelab setups, in order from v1 to v4:

## Homelab v1 (2015-2016)
[![Homelab v1](/images/homelab/homelab_v1.jpg)](/images/homelab/homelab_v1.jpg)

First homelab with an [EPC](https://www.epcusa.com/)-bought dual-xeon processor workstation running as a multi-purpose Ubuntu server along with a hand-me-down Antec desktop PC from my parents running MySQL database server. The blue switch (seen on left side) is a cheap 10/100Mbps unmanaged switch I bought from EPC as well.

### Homelab v2 (2016-2017)
I am unable to find photos of my Ubuntu server I got from EPC for my 3rd year in college. That server ran my NextCloud instance and CUPS for my old 2005 HP LaserJet 1320 printer.

### Homelab v3 (2017-2019)
[![Homelab v1](/images/homelab/homelab_v3.jpg)](/images/homelab/homelab_v3.jpg)

I custom-built a PC server for my 4th and 5th year in college. I was living in an apartment during those last two years and I needed a homelab server that will act as a firewall for my apt LAN network + to run additional services such as database, cloud, ad-blocking DNS, etc. so I ended up with this build. It runs a Proxmox hypervisor with the following services: pfSense, PiHole DNS, MariaDB, NextCloud, Unifi Controller and some other minor applications.

##### Hardware

* AMD FX 8350 Black Edition CPU (8-Core 4.0GHz)
* 16GB (2x8GB) DDR3 RAM
* Storage
    * 120GB SSD (Proxmox OS)
    * 1TB HDD (Data Storage)
    * 1.5TB HDD (VM Storage)
    * 2x3TB HDD in RAID1 (Backup)
* APC Back-UPS Pro 1500VA (BR1500G) UPS
* Ubiquiti Networks UniFi AP AC Lite (Not in pic)

### Homelab v4 (2019-2020)

[![Homelab v1](/images/homelab/homelab_prev4.jpg)](/images/homelab/homelab_prev4.jpg)

The above picture was the original hardware I was going to use for my v4 homelab setup when I move to Michigan for my 1st job. Due to the power consumption from these hardware + the cost of electricity in Michigan, I decided not to use the Dell PowerEdge R510 server. I was going to use it as a storage/backup server for my data & VMs. Instead, I replaced it with 8x Odroid HC2s running GlusterFS (as seen below).

#### Hardware

* 1U Supermicro Firewall Server
    * Intel Q8300 CPU (4-Core 2.5GHz)
    * 4GB DDR2 RAM
    * 120GB SSD (pfSense OS)
* 2x Dell PowerConnect 5324 Managed Switches
* Custom-built 2U server with same hardware in v3's apartment server
* Dell PowerEdge R510 Storage Server

[![Homelab v1](/images/homelab/homelab_v4.jpg)](/images/homelab/homelab_v4.jpg)

This was the final setup before I replaced a lot of hardware when I moved to a rented condo. The two Odroid HC2 stacks, the 1st one was my data storage with 4x 2TB HDDs while the 2nd one is the backup with 4x 3TB HDDs. They were running in GlusterFS cluster with file distribution feature enabled.
