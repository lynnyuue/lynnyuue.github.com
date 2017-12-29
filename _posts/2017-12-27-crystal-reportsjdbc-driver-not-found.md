---
layout: post
title: "Crystal Reports:JDBC driver not found"
description: "how to add jdbc driver to Crystal Reports"
category: errors
tags: [crystal]
---
{% include JB/setup %}

1.put jdbc driver to java lib folder

```bash
Business Objects\Common\3.5\java\lib
```

2.modify Business Objects\Common\3.5\java\CRConfig.xml

```xml
...
<CrystalReportEngine-configuration>
	<Javaserver-configuration>
		<DataDriverCommon>
			<JavaDir>%{JAVA_HOME}</JavaDir>
			<Classpath>${CLASSPATH};%{jdbc driver}</Classpath>
		</DataDriverCommon>
		...
	</Javaserver-configuration>
	...
</CrystalReportEngine-configuration>
```