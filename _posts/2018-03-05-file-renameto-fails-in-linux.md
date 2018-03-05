---
layout: post
title: "File renameTo fails in linux"
description: "Can not rename linux file use File.renameTo function"
category: java
tags: [io]
---
{% include JB/setup %}


*Javadoc:*
>Many aspects of the behavior of this method are inherently platform-dependent: The rename operation might not be able to move a file from one filesystem to another, it might not be atomic, and it might not succeed if a file with the destination abstract pathname already exists. The return value should always be checked to make sure that the rename operation was successful.
>Note that the Files class defines the move method to move or rename a file in a platform independent manner.

so we use commons-io to move/rename file
```bash
org.apache.comons.io.FileUtils.moveFile(File srcFile, File destFile)
```