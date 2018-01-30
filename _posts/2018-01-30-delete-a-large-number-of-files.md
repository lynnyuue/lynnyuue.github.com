---
layout: post
title: "delete a large number of files"
description: "delete files on linux when files number is 1 million"
category: linux
tags: [script]
---
{% include JB/setup %}

当目录下的文件数量非常多时，不能通过普通的方式删除

1.rm

```bash
rm -f *
/bin/bash: argument list too long: rm
```

2.find

```bash
find ./ -type f -exec rm {}
```

3.find with delete

```bash
find ./ -type f -delete
```

4.rsync

```bash
rsync -a --delete blackdir/ dir/
```

5.python

```python
import os
import timeit
def main():
    for pathname,dirnames,filenames in os.walk('/home/username/test'):
        for filename in filenames:
            file=os.path.join(pathname,filename)
            os.remove(file)
 if __name__=='__main__':
    t=timeit.Timer('main()','from __main__ import main')
    print t.timeit(1)
```

6.Perl

```bash
#this should be fastest
perl -e 'for(<*>){((stat)[9]<(unlink))}'
```