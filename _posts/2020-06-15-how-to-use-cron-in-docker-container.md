---
layout: post
title: How to use cron in docker container
subtitle: 
author: Lynn 
date: 2020-06-15 08:58:10 +0800
categories: cron docker linux
tag: 
---

*how to install and config cron in docker container*

1. Install cron

    ```
    apt-get install cron
    ```

2. Install system log (**optional**)

    ```
    apt-get install rsyslog
    ```

3. Add new cron

    ```
    crontab -e
    ```

    >new task should not output any log, it not work in docker container, so we should redirect stdout to null

    eg:

    ```
    # run script per hours, stdout should redirect to /dev/null
    # otherwise, cron will print waring 
    # (CRON) info (No MTA installed, discarding output)
    # script should be better use absolute path
    0 */1 * * * cd /path/to/script && /bin/bash /name/to/script >/dev/null 2>&1
    ```

4. Start cron service

    ```
    service cron start
    ```

    >you can check task log at /var/log/syslog, this file will created when rsyslog service installed and running