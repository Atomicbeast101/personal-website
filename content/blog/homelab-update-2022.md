---
title: "Homelab - Update (2022)"
date: 2022-10-02T10:23:50-05:00
draft: false
---

[![PotatoLab](/images/homelab-update-2022/overview.png)](/images/homelab-update-2022/overview.png)

There has been some significant changes made to my homelab since my last update last year. Majority of the changes are the rack upgrade and architect changes to the network, servers and the application hosting:
* **Rack Size**
    * Upgraded rack from StarTech 12U to a custom-built enclosed 20U rack
* **Networking**
    * Replaced Netgear GSM7248R with a Cisco 3750X switch
    * Upgraded router & added a core switch between the router and the 3750X switch to achieve full 10G backbone connection
* **Server/Applications**
    * Downgraded from 3x Supermicro 1U servers to 8x Dell Optiplex 7040M micro-desktop PCs
    * Migrated 95% of applications from traditional VMs to Kubernetes/Docker setup

There are several reasons why I made these changes:
* Needed more room on the rack to add more hardware
* Switching to Cisco enables the ability for me to automate its configuration via Ansible
* Downsized & expanded the # of nodes as an effort to reduce power consumption. Paying for AC & homelab in a hot state (Missouri) created unpleasant electric bills....
* Switching to Docker/Kubernetes reduced the amount of maintenance I have to make to the hosts and simplified the deployment of them via Ansible & kubectl. Plus this improves the ability to automate from deploying the application to setting up SSL certifications and reverse proxy for internal & external access.

## Future Plans

There are some areas I want to improve my homelab at some point:
* **Redundant WAN Connection**
    * Get 2nd WAN circuit (perhaps 5G/4G LTE or 100Mbps Spectrum Coax) as backup to support my remote work needs. Seems to make sense to get 2nd circuit once fiber gets rolled out to my subdivision.
* **Increase Automation**
    * Build out my DevOps pipelines for my personal site & other projects to automate the build and deployment process
* **Increase Storage Pool & Reduce Power Consumption**
    * "Downsize" the Supermicro 2U storage servers by replacing the motherboard + CPU to a low TDP setup and upgrade the ZFS pool capacity from 12x 2TB HDDs to 6x 8TB HDDs with 2x 500GB SSD (for heavy read/write activities). Major effort to increase capacity while reducing power consumption. I'm hoping to see at least 100-150W reduction from my overall 750-800W.

For anyone who's curious why I do the homelab project, here's the original quote I put in the [original post](../homelab/):

> My homelab, known as "PotatoLab", has been an ongoing personal hobby to learn new tools and gain knowledge in networking/systems administration and DevOps. The homelab project has gone through 6 upgrades over the years since 2015 (freshman in college up to now). I have used it to host various applications such as Plex home media, NextCloud private cloud, ad-blocking DNS servers, etc. Most of the hardware seen in the picture were retrieved via Amazon and Ebay.

## Hardware

From top to bottom in 20U rack:
* Checkpoint T-180/4800
    * Intel Core 2 Q9400
    * 8GB RAM
* Cable Management Panel
* Cisco WS-C4500X-24X-ES
* CAT6 24Port Patch Panel
* Cisco WS-C3750X-48PF-L v01 Switch
* 8x Dell Optiplex 7040M Micro PCs
    * Intel i5-6500T
    * 16GB RAM
    * 120GB SSD
* 2x HP Chromebox G1
    * Intel Celeron 2955U
    * 4GB RAM
    * 16GB SSD M.2
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

Back of the rack (top to bottom, left to right on shelf):
* CyberPower CPS1215RM PDU
* A-Neutronics 20x Outlet PDU

Not seen in the picture (located in other places):
* CAT5E 48Port Patch Panel
* Cisco WS-C3750X-24P-S
    * Powers all APs and security cameras
    * Connects to various RJ45 drops around the house
* ARRIS SURFboard (16x4) DOCSIS 3.0 Cable Modem
* Tripplite PDU

## Software

* Checkpoint T-180/4800
    * VyOS Firewall/Router
* 7x Dell Opitplex 7040M Micro PCs
    * Ubuntu OS running Kubernetes Cluster Node (3 master, 7 workers)
        * MongoDB
        * [Gitea](https://gitea.io/)
        * [Drone](https://www.drone.io/)
        * Docker Container Registry
        * [Visual Studio Code](https://code.visualstudio.com/docs/remote/vscode-server)
        * [Grafana](https://grafana.com/)
        * [Prometheus](https://prometheus.io/)
        * [AlertManager](https://prometheus.io/docs/alerting/latest/alertmanager/)
        * [GrayLog](https://www.graylog.org/)
        * [ElasticSearch](https://www.elastic.co/)
        * [Gotify](https://gotify.net/)
        * [Plex Media](https://www.plex.tv/)
        * [Frigate Survelliance](https://frigate.video/)
        * Mosquitto (MQTT)
        * [Zigbee2MQTT](https://www.zigbee2mqtt.io/)
        * [ZwaveJS2MQTT](https://github.com/zwave-js/zwave-js-ui)
        * [Amcrest2MQTT](https://github.com/dchesterton/amcrest2mqtt)
        * [NodeRed](https://nodered.org/)
        * [HomeAssistant](https://www.home-assistant.io/)
        * [TasmotaAdmin](https://tasmota.github.io/docs/TasmoAdmin/)
        * [ESPHome](https://esphome.io/)
        * [SearX](https://searx.github.io/searx)
        * [Joplin Notes](https://joplinapp.org/)
        * Recipes
        * [Firefly-III](https://www.firefly-iii.org/)
        * [Bitwarden (VaultWarden)](https://bitwarden.com/)
        * iSCSI
        * [OnlyOffice](https://www.onlyoffice.com/)
        * [Draw.io](https://app.diagrams.net/)
        * [NextCloud](https://nextcloud.com/)
* 1x Dell Optiplex 7040M Micro PC
    * Proxmox VE
        * Omega Controller
        * Unifi Controller
        * MariaDB
        * PostgreSQL
* 2x HP Chromebox G1
    * Ubuntu OS running Docker
        * [PiHole DNS](https://pi-hole.net/)
        * cturra NTP
* 2x Supermicro 826 Chassis
    * Ubuntu OS running ZFS

## Current Network Topology

[![Current_Network_Topology](/images/homelab-update-2022/current_network_diagram.jpg)](/images/homelab-update-2022/current_network_diagram.jpg)

## Switch Interface Configuration

[![Switch_Interface_Configuration](/images/homelab-update-2022/switch_interfaces.png)](/images/homelab-update-2022/switch_interfaces.png)

## Kubernetes Cluster

[![Kubernetes_Cluster](/images/homelab-update-2022/kubernetes_cluster.jpg)](/images/homelab-update-2022/kubernetes_cluster.jpg)

## Proxmox

[![Proxmox](/images/homelab-update-2022/proxmox.jpg)](/images/homelab-update-2022/proxmox.jpg)

See [here](../) for other homelab blog(s).
