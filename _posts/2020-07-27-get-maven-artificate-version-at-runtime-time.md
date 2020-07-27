---
layout: post
title: Get Maven Artifact Version At Runtime
category: java
tags: [maven]
author: Lynn
summary: How to get maven project artifact and version at runtime
---

You should not need to access Maven-specific files to get the version information of any given library/class.

You can simply use **getClass().getPackage().getImplementationVersion()** to get the version information that is stored in a .jar-files MANIFEST.MF. Luckily Maven is smart enough Unfortunately Maven does not write the correct information to the manifest as well by default!

Instead one has to modify the `<archive>` configuration element of the **maven-jar-plugin** to set **addDefaultImplementationEntries** and **addDefaultSpecificationEntries** to **true**, like this:

````
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-jar-plugin</artifactId>
    <configuration>
        <archive>
            <manifest>
                <addDefaultImplementationEntries>true</addDefaultImplementationEntries>
                <addDefaultSpecificationEntries>true</addDefaultSpecificationEntries>
            </manifest>
        </archive>
    </configuration>
</plugin>
````

Ideally this configuration should be put into the company pom or another base-pom.

Detailed documentation of the `<archive>` element can be found in the [Maven Archive documentation](http://maven.apache.org/shared/maven-archiver/index.html).
