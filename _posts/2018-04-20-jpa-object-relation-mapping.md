---
layout: post
title: "JPA Object Relation Mapping"
description: ""
category: java
tags: [JPA]
---

**JPA study notes**

> Pro JPA 2<br/>
> Mastering the Java Persistence API<br/>
> ISBN 978-7-302-25802-5


Many to One
----

```java
@Entity
public class Employee{
	// ...
	@ManyToOne
	private Department department;
	// ...
}
```

One to One
----
