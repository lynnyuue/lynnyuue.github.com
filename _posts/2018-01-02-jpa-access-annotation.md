---
layout: post
title: "JPA Access annotation"
description: "JPA mixed access mode with @Access"
category: java
tags: [JPA]
---
{% include JB/setup %}

# JPA Access annotation

```java
@Entity
@Access(AccessType.FIELD)
public class Employee implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 5300768801069469349L;

	public static final String LOCAL_AREA_CODE = "613";
	
	@Id
	private int id;
	@Transient
	private String phoneNum;
	
	public int getId(){
		return this.id;
	}
	
	public void setId(int id){
		this.id = id;
	}
	
	public String getPhoneNumber(){
		return this.phoneNum;
	}
	
	public void setPhoneNumber(String num){
		this.phoneNum = num;
	}
	
	protected String getPhoneNumberForDb(){
		if(phoneNum.length() == 10){
			return phoneNum;
		}else{
			return LOCAL_AREA_CODE + phoneNum;
		}
	}
	
	protected void setPhoneNumberForDb(String num){
		if(phoneNum.startsWith(LOCAL_AREA_CODE)){
			phoneNum = num.substring(3);
		}else{
			phoneNum = num;
		}
	}
}
```

*How to?*
1. 显式标记类胡默认访问模式，通过@Access注解对它进行注解，并指示访问的类型。除非这么做，否则如果字段和属性均被注解，那么它将是未定义的。
2. 通过@Access注解注解其他的字段或属性，但是此时指定与类级别相反的访问类型。
3. 必须把要使其具有之久化的字段或属性标记为临时的(transient)，从而默认的访问规则不会导致同样的状态被持久化两次。

*Note:*
- JPA 2.0中引入了@Access注解并且能够使用混合访问模式
