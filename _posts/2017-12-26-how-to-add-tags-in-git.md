---
layout: post
title: "how to add tags in git"
description: "git tags operation"
category: git
tags: [git]
---
{% include JB/setup %}

### add tag

```bash
#add tag to current version
git tag -a tag_name -m 'tag comment'
#add tag to previous version
git tag -a tag_name 9fceb02
```


### push tag

```bash
#push tag
git push origin tag_name
#push all tags
git push origin --tags
```


### list tag

```bash
#list all tags
git tag
#filter tags
git tag -l 'v2.*'
```


### delete tag

```bash
#delete local tag
git tag -d tag_name 
#delete remote tag
git push origin :refs/tags/tag_name
```