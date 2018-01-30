---
layout: post
title: "no space left on device"
description: "no space left on device"
category: linux
tags: [inode]
---
{% include JB/setup %}

*当你的 Linux 系统无法创建新文件时，有可能是你的磁盘满了，还有可能是你的磁盘的 inode 用光了，我们今天要说的就是后一种情况，要解决这个问题，只能是删除一些文件，
但是一般情况下，其实是你的系统中的某个地方产生了大量的你并不需要的文件，你要做的就是找到他们并删除就可以了，
我并不是让你删除你有用的文件，因为你一般不会有那么多有用的文件来把系统的 inode 用光。*

1.什么是 inode ？

文件储存在硬盘上，硬盘的最小存储单位叫做”扇区”（Sector）。每个扇区储存512字节（相当于0.5KB）。
操作系统读取硬盘的时候，不会一个个扇区地读取，这样效率太低，而是一次性连续读取多个扇区，即一次性读取一个”块”（block）。这种由多个扇区组成的”块”，是文件存取的最小单位。”块”的大小，最常见的是4KB，即连续八个 sector组成一个 block。
文件数据都储存在”块”中，那么很显然，我们还必须找到一个地方储存文件的元信息，比如文件的创建者、文件的创建日期、文件的大小等等。这种储存文件元信息的区域就叫做inode，中文译名为”索引节点”。
每一个文件都有对应的inode，里面包含了与该文件有关的一些信息。

2.如何查看系统的 innode 占用情况

```bash
df -ih
```

3.如何查找那个目录下文件最多

```bash
for i in /*; do echo $i; find $i | wc -l; done
#or
for i in `ls -1A | grep -v "\.\./" | grep -v "\./"`; do echo "`find $i | sort -u | wc -l` $i"; done | sort -rn | head -10
```

4.如何删除那个目录的的所有文件

一般情况下，如果这个目录下应该会有数以百万的文件，如果你直接用 rm -rf 目录名 的话效率会很低，可以用下面方法
```bash
find . -type f -name '*' -print0 | xargs -0 rm
```

原文： [linux-inode-full][1]

[1]: http://www.dahouduan.com/2014/12/19/linux-inode-full/