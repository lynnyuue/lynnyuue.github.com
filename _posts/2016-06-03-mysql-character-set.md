---
layout: post
title: "mysql character set"
description: "check and update mysql character setting"
category: database 
tags: [mysql]
---

#### find mysql configuration file

    find / -name 'my.cnf'

#### modify my.cnf

    [mysqld]
    character_set_server=utf8
    #default-character-set=utf8 //deprecated after 5.5
    [client]
    default-character-set=utf8

#### check mysql character set

    mysql>show variables like 'character_set_%';
    +--------------------------+----------------------------+
    | Variable_name            | Value                      |
    +--------------------------+----------------------------+
    | character_set_client     | utf8                       |
    | character_set_connection | utf8                       |
    | character_set_database   | utf8                       |
    | character_set_filesystem | binary                     |
    | character_set_results    | utf8                       |
    | character_set_server     | utf8                       |
    | character_set_system     | utf8                       |
    | character_sets_dir       | /usr/share/mysql/charsets/ |
    +--------------------------+----------------------------+
    8 rows in set (0.00 sec)
