---
layout: post
title: "JPA Object Relation Mapping"
description: ""
category: java
tags: [JPA]
---
{% include JB/setup %}

> Pro JPA 2<br/>
> Mastering the Java Persistence API<br/>
> ISBN 978-7-302-25802-5


Many to One
----

<center>
{% plantuml %}
class Employee {
	long id
	String name
	long salary
}

class Department {
	int id
	String name
}

Employee "*" --> "0..1" Department
{% endplantuml %}
</center>


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
