---
layout: post
title: "windows tomcat log file"
description: "how to make tomcat write log file to log direcotry on windows"
category: java
tags: [tomcat,windows]
---


1.modify startup.bat

```bash
call "%EXECUTABLE%" run %CMD_LINE_ARGS%
```
*Note:*

modify start to run

2.modify catalina.bat

```bash
rem Execute Java with the applicable properties
if not "%JPDA%" == "" goto doJpda
if not "%SECURITY_POLICY_FILE%" == "" goto doSecurity
%_EXECJAVA% %JAVA_OPTS% %CATALINA_OPTS% %DEBUG_OPTS% -Djava.endorsed.dirs="%JAVA_ENDORSED_DIRS%" -classpath "%CLASSPATH%" -Dcatalina.base="%CATALINA_BASE%" -Dcatalina.home="%CATALINA_HOME%" -Djava.io.tmpdir="%CATALINA_TMPDIR%" %MAINCLASS% %CMD_LINE_ARGS% %ACTION% >> %CATALINA_HOME%\logs\catalina.%date:~6,4%-%date:~3,2%-%date:~0,2%.out
goto end
:doSecurity
%_EXECJAVA% %JAVA_OPTS% %CATALINA_OPTS% %DEBUG_OPTS% -Djava.endorsed.dirs="%JAVA_ENDORSED_DIRS%" -classpath "%CLASSPATH%" -Djava.security.manager -Djava.security.policy=="%SECURITY_POLICY_FILE%" -Dcatalina.base="%CATALINA_BASE%" -Dcatalina.home="%CATALINA_HOME%" -Djava.io.tmpdir="%CATALINA_TMPDIR%" %MAINCLASS% %CMD_LINE_ARGS% %ACTION% >> %CATALINA_HOME%\logs\catalina.%date:~6,4%-%date:~3,2%-%date:~0,2%.out
goto end
:doJpda
if not "%SECURITY_POLICY_FILE%" == "" goto doSecurityJpda
%_EXECJAVA% %JAVA_OPTS% %CATALINA_OPTS% %JPDA_OPTS% %DEBUG_OPTS% -Djava.endorsed.dirs="%JAVA_ENDORSED_DIRS%" -classpath "%CLASSPATH%" -Dcatalina.base="%CATALINA_BASE%" -Dcatalina.home="%CATALINA_HOME%" -Djava.io.tmpdir="%CATALINA_TMPDIR%" %MAINCLASS% %CMD_LINE_ARGS% %ACTION% >> %CATALINA_HOME%\logs\catalina.%date:~6,4%-%date:~3,2%-%date:~0,2%.out
goto end
:doSecurityJpda
%_EXECJAVA% %JAVA_OPTS% %CATALINA_OPTS% %JPDA_OPTS% %DEBUG_OPTS% -Djava.endorsed.dirs="%JAVA_ENDORSED_DIRS%" -classpath "%CLASSPATH%" -Djava.security.manager -Djava.security.policy=="%SECURITY_POLICY_FILE%" -Dcatalina.base="%CATALINA_BASE%" -Dcatalina.home="%CATALINA_HOME%" -Djava.io.tmpdir="%CATALINA_TMPDIR%" %MAINCLASS% %CMD_LINE_ARGS% %ACTION% >> %CATALINA_HOME%\logs\catalina.%date:~6,4%-%date:~3,2%-%date:~0,2%.out
goto end
```

*Note:*

append '>> %CATALINA_HOME%\logs\catalina.%date:~6,4%-%date:~3,2%-%date:~0,2%.out' after %ACTION%<br/>
echo %date% expect result should be '04/01/2018' or '04.01.2018'<br/>
otherwise you should modify data format part code