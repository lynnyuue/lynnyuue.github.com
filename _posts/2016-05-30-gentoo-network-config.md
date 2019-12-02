---
layout: post
title: "gentoo network config"
description: "how to configuration network in gentoo"
category: linux
tags: [gentoo]
---


#### static ip
/etc/conf.d/net

    dns_domain_lo="homenetwork"
    config_wlp2s0="192.168.1.200 netmask 255.255.255.0 brd 192.168.1.255"
    routes_wlp2s0="default via 192.168.1.1"

    modules="wpa_supplicant"
    wpa_supplicant_wlp2s0="-Dnl80211"

#### dns server
/etc/resolv.conf

    nameserver 223.5.5.5
    nameserver 223.6.6.6
    nameserver 114.114.114.114

