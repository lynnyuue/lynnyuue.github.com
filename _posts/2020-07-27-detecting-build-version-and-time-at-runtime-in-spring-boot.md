---
layout: Detecting build version and time at runtime
title: This is a new article
category: java
tags: [maven, spring, spring-boot]
author: Lynn
summary: how to use maven plugin add spring boot build info
---

## Build plugin configuration

If you are using Spring Boot, your **pom.xml** should already contain **spring-boot-maven-plugin**. You just need to add the following configuration.

```xml
<plugin>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-maven-plugin</artifactId>
    <executions>
        <execution>
            <id>build-info</id>
            <goals>
                <goal>build-info</goal>
            </goals>
        </execution>
    </executions>
</plugin>
```

It instructs the plugin to execute also **build-info** goal, which is not run by default. This generates build meta-data about your application, which includes artifact version, build time and more.

## Accessing Build Properties

After configuring your **spring-boot-maven-plugin** and building your application, you can access information about your application's build through **BuildProperties** object. Let the Spring inject it for you:

```java
@Autowired
BuildProperties buildProperties;
```

Now you can access various information from this object.

```java
// Artifact's name from the pom.xml file
buildProperties.getName();
// Artifact version
buildProperties.getVersion();
// Date and Time of the build
buildProperties.getTime();
// Artifact ID from the pom file
buildProperties.getArtifact();
// Group ID from the pom file
buildProperties.getGroup();
```

## Adding custom properties

If predefined properties are not enough, you can pass your own properties from **pom.xml** file to **BuildProperties**.

```xml
<plugin>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-maven-plugin</artifactId>
    <executions>
        <execution>
            <goals>
                <goal>build-info</goal>
            </goals>
            <configuration>
                <additionalProperties>
                    <java.version>${java.version}</java.version>
                    <some.custom.property>some value</some.custom.property>
                </additionalProperties>
            </configuration>
        </execution>
    </executions>
</plugin>
```