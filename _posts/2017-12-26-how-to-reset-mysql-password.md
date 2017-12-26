---
layout: post
title: "how to reset mysql password"
description: "reset mysql password when forget it"
category: database
tags: [mysql]
---
{% include JB/setup %}

1.stop mysql server

```bash
/etc/init.d/mysql stop
```

2.modify my.cnf

```bash
vi /etc/mysql/mysql.conf.d/mysqld.cnf
```
> add this config under [mysqld]<br/>
> skip-grant-tables  #Ignore the mysql permissions, log in directly

3.restart mysql server

```bash
/etc/init.d/mysql start
```

4.login mysql

```bash
[root@mysql ~]# mysql
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 7393
Server version: 5.7.20-0ubuntu0.16.04.1 (Ubuntu)

Copyright (c) 2000, 2017, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql>
mysql>use mysql;
mysql>update user set password=password("mysql") where user="root";
Query OK, 4 rows affected (0.00 sec)
8 Rows matched: 4 Changed: 4 Warnings: 0 9
mysql>flush privileges;
Query OK, 0 rows affected (0.00 sec)
```