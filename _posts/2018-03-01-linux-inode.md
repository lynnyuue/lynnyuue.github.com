---
layout: post
title: "linux inode"
description: "What is inode?"
category: linux
tags: [inode]
---

*What is inode?*

#### inode

>inode是指在许多“类[Unix][0][文件系统][1]”中的一种数据结构。每个inode保存了文件系统中的一个文件系统对象（包括文件、目录、设备文件、socket、管道, 等等）的元信息数据，但不包括数据内容或者文件名

POSIX inode
----
POSIX标准强制规范了文件系统的行为。每个“文件系统对象”必须具有：
* 以字节为单位表示的文件大小。
* 设备ID，标识容纳该文件的设备。
* 文件所有者的User ID。
* 文件的Group ID
* 文件的模式（mode），确定了文件的类型，以及它的所有者、它的group、其它用户访问此文件的权限。
* 额外的系统与用户标志（flag），用来保护该文件。
* 3个时间戳，记录了inode自身被修改（ctime, inode change time）、文件内容被修改（mtime, modification time）、最后一次访问（atime, access time）的时间。
* 1个链接数，表示有多少个硬链接指向此inode。
* 到文件系统存储位置的指针。通常是1K字节或者2K字节的存储容量为基本单位。

**使用stat系统调用可以查询一个文件的inode号码及一些元信息。**

推论
----
* 一个文件系统对象可以有多个名字，这些具有硬链接关系的文件系统对象名字具有相同的inode号码，彼此是平等的。即首个被创建的文件并没有特殊的地位。这与符号链接不同。一个符号链接文件有自己的inode，符号链接文件的内容是它所指向的文件的名字。因此删除符号链接所指向的文件，将导致这个符号链接文件在访问时报错。
* 删除一个文件或目录，实际上是把它的inode的链接数减1。这并不影响指向此inode的别的硬链接。
* 一个inode如果没有硬链接，此时inode的链接数为0，文件系统将回收该inode所指向的存储块，并回收该inode自身。
* 从一个inode，通常是无法确定是用哪个文件名查到此inode号码的。打开一个文件后，操作系统实际上就抛掉了文件名，只保留了inode号码来访问文件的内容。库函数getcwd()用来查询当前工作目录的绝对路径名。其实现是从当前工作目录的inode逐级查找其上级目录的inode，最后拼出整个绝对路径的名字。
* 历史上，对目录的硬链接是可能的。这可以使目录结构成为一个有向图，而不是通常的目录树的有向无环图。一个目录甚至可以是自身的父目录。现代文件系统一般禁止这些混淆状态，只有根目录保持了特例：根目录是自身的父目录。ls /..就是根目录的内容。
* 一个文件或目录在文件系统内部移动时，其inode号码不变。文件系统碎片整理可能会改变一个文件的物理存储位置，但其inode号码不变。非UNIX的FAT及其衍生的文件系统是无法实现inode不变这一特点。
* inode文件系统中安装新库十分容易。当一些进程正在使用一个库时，其它进程可以替换该库文件名字的inode号码指向新创建的inode，随后对该库的访问都被自动引导到新inode所指向的新的库文件的内容。这减少了替换库时重启系统的需要。而旧的inode的链接数已经为0，在使用旧函式库的进程结束后，旧的inode与旧函式库文件会被系统自动回收。
* 用stat查询、显示一个文件名所对应的inode的元信息数据。
* 查看文件系统的inode总数和已经使用的数量，可以使用df -i
* 查看inode自身占用字节数量，可以用sudo dumpe2fs -h /dev/hda | grep "Inode size"


外部链接
----
* [wiki inode][2]
* [Inode Definition][3]
* [理解inode][4]

[0]: https://zh.wikipedia.org/wiki/UNIX
[1]: https://zh.wikipedia.org/wiki/%E6%96%87%E4%BB%B6%E7%B3%BB%E7%BB%9F
[2]: https://zh.wikipedia.org/wiki/Inode
[3]: http://www.linfo.org/inode.html
[4]: http://www.ruanyifeng.com/blog/2011/12/inode.html