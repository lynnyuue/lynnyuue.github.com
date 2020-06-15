---
layout: post
title:  "How to export some table data in postgres"
date:   2020-01-21 14:43:09 +0800
categories: [postgres]
---

*how to use pg_dump export tables data*

```shell
cd <postgres directory>
# export as insert sql with columns
pg_dump -U postgres -W -h <host> \
    -t <table1> -t <table2> ... -f <export data file> \
    --data-only --column-inserts <database>

Password: <your password>
```