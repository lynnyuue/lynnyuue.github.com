---
layout: post
title: "batch kill linux process"
description: "batch kill tomcat server"
category: linux
tags: [shell]
---
{% include JB/setup %}

#### kill tomcat process

```bash
ps -aux | grep tomcat | grep -v grep | cut -c 9-15 | xargs kill -9
```