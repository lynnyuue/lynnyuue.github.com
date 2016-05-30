---
layout: post
title: "batch kill linux process"
description: ""
category: os
tags: [linux,shell]
---
{% include JB/setup %}

#### kill tomcat process

    ps -aux | grep tomcat | grep -v grep | cut -c 9-15 | xargs kill -9
