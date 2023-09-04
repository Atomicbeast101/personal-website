---
title: "Homelab - Update (2023)"
date: 2023-04-28T12:39:59-05:00
draft: false
---

[![PotatoLab](/images/homelab-update-2023/overview.png)](/images/homelab-update-2023/overview.png)

Never thought I'd be done with hardware changes to my homelab...

The only main changes I've made since the last post is consolating both Cisco switches (4500X & 3750X) with a bigger 10G switch and upgrading the hardware in both Supermicro storage servers. These were done as an effort to cut my power consumption from ~800W down to ~550W while providing more 10G connectivity for future expansions.

* **Network Upgrade - Yet Again...**
    * Found a great deal on a **Dell PowerSwitch S4810P** switch off Ebay for like $200. It's a 48port 10G SFP+ with 4x 40G QSFP+ switch. Decided it's worth the upgrade to replace both Cisco switches with this one to provide more 10G connectivity and reduce the power consumption by almost 50-60% (300W for both switches down to 120W for a single one). 
    * Creating the Ansible playbook for this Dell switch proved to be a challenge due to no native module that allows me to easily replace existing config settings. Took me almost 1.5 weeks to come up with an acceptable approach to configure this switch 100% via Ansible (except for the initial ones such as management VLAN). You can find this playbook along with the rest that's used to maintain my homelab in my Github repo soon.

* **Storage Hardware Upgrade**
    * The main storage, KIRBY, was getting close to 80% full so I figured it may be time to give it a nice upgrade since its deployment back in 2020. I decided to replace these 12x 2TB HDDs with 6x 8TB HDDs and add 3x 256GB SSDs for the database VMs to improve the transaction times. This has doubled the storage capacity from 15TB to a little over 30TB total (HDDs only, SSDs weren't counted in this) while cutting the power consumption by almost half due to only 6x spinning disks instead of 12x.
    * Both main and backup storage servers (KIRBY & KEEBY) had power hungry processor setups (2x Intel Xeon CPU E5-2630L at 60W TDP on a Supermicro X9DR3-LN4F+ motherboard). Figured it may be good to replace the CPU/RAM/motherboard while doing the storage upgrade to cut down on wasted power consumption. I went with a single Intel Xeon E3-1265L v3 CPU on a Supermicro X10SLH-F motherboard as it only has 45W TDP and the only time the CPU maxes out is doing backup activities at night time. These upgrades has brought the main storage from 220W down to 110W and backup storage from 220W to 150W (due to 12x 3TB HDDs)

## Future Plans

There are some areas I want to improve my homelab at some point:
* **Redundant WAN Connection**
    * There has been a lot of fiber rollout as well as DOCSIS 4.0 upgrade happening in my area. There are two approaches I plan to do depending on what gets rolled out first to my subdivision:
        * **Fiber Rollout** - Get 1Gbps/1Gbps fiber as my main connection and use my existing Spectrum coax internet with lowest speed as my backup
        * **Spectrum DOCSIS 4.0 Upgrade** - Upgrade my modem to handle DOCSIS 4.0 and upgrade the existing coax internet to get 2Gbps/1Gbps speeds and then get a 5G/4G LTE home internet from T-Mobile as my backup. I may end up with this option as no additional cable infrastructure has to be done by Spectrum to do the DOCSIS 4.0 upgrade and my subdivision is non-HOA so the chances for a fiber rollout is pretty low.

For anyone who's curious why I do the homelab project, here's the original quote I put in the [original post](../homelab/):

> My homelab, known as "PotatoLab", has been an ongoing personal hobby to learn new tools and gain knowledge in networking/systems administration and DevOps. The homelab project has gone through 6 upgrades over the years since 2015 (freshman in college up to now). I have used it to host various applications such as Plex home media, NextCloud private cloud, ad-blocking DNS servers, etc. Most of the hardware seen in the picture were retrieved via Amazon and Ebay.

## Hardware

From top to bottom in 20U rack:
* Checkpoint T-180/4800
    * Intel Core 2 Q9400
    * 8GB RAM
* Cable Management Panel
* Dell PowerSwitch S4810P-AC
* CAT6 24Port Patch Panel
* 8x Dell Optiplex 7040M Micro PCs
    * Intel i5-6500T
    * 16GB RAM
    * 120GB SSD
* 2x HP Chromebox G1
    * Intel Celeron 2955U
    * 4GB RAM
    * 16GB SSD M.2
* Supermicro 826 Chassis
    * Intel Xeon CPU E3-1265L v3 @ 2.5GHz (3.7GHz turbo)
    * 32GB RAM (4x 8GB Samsung 1600MHz)
    * 120GB SSD; 6x 8TB HDDs in RAIDZ2 pool (30TB Usable); 3x 256GB SSD in RAIDZ1 pool (512GB Usable)
* Supermicro 826 Chassis
    * Intel Xeon CPU E3-1265L v3 @ 2.5GHz (3.7GHz turbo)
    * 32GB RAM (4x 8GB Samsung 1600MHz)
    * 120GB SSD; 12x 3TB HDDs in RAIDZ1s in RAIDz2 pool (24TB Usable)
* *Left of Rack (old picture only had APC UPSes: BR1500G & BR24BPG)*
    * TrippLite SMART2200RMXL2U (not in picture)

Back of the rack (top to bottom, left to right on shelf):
* CyberPower CPS1215RM PDU
* A-Neutronics 20x Outlet PDU
* BTU PDU

Not seen in the picture (located in other places):
* CAT5E 24Port Patch Panel
* Cisco WS-C3750X-24P-S
    * Powers all APs and security cameras
    * Connects to various RJ45 drops around the house
* ARRIS SURFboard (16x4) DOCSIS 3.0 Cable Modem
* Tripplite PDU

## Software

* Checkpoint T-180/4800
    * VyOS Firewall/Router
* 7x Dell Opitplex 7040M Micro PCs
    * Ubuntu OS running Kubernetes Cluster Node (3 master, 7 workers). See drawing below for list of apps I host.
* 1x Dell Optiplex 7040M Micro PC
    * Proxmox VE hosting two LXCs and 2 VMs:
        * Omega Controller (LXC)
        * Unifi Controller (LXC)
        * MariaDB (VM)
        * PostgreSQL (VM)
* 2x HP Chromebox G1
    * Ubuntu OS running Docker
        * [PiHole DNS](https://pi-hole.net/)
        * cturra NTP
* 2x Supermicro 826 Chassis
    * Ubuntu OS running ZFS

## Current Network Topology

[![Current_Network_Topology](/images/homelab-update-2023/current_network_diagram.jpg)](/images/homelab-update-2023/current_network_diagram.jpg)

## Switch Interface Configuration

[![Switch_Interface_Configuration](/images/homelab-update-2023/switch_interfaces.png)](/images/homelab-update-2023/switch_interfaces.png)

## Kubernetes Cluster

[![Kubernetes_Cluster](/images/homelab-update-2023/kubernetes_cluster.jpg)](/images/homelab-update-2023/kubernetes_cluster.jpg)

## Proxmox

[![Proxmox](/images/homelab-update-2023/proxmox.jpg)](/images/homelab-update-2023/proxmox.jpg)

See [here](../) for other homelab blog(s).
