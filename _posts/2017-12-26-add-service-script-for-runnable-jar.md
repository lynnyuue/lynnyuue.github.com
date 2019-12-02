---
layout: post
title: "add service script for runnable jar"
description: "add start/stop service on ubuntu"
category: linux
tags: [script]
---


1.add start/stop script
```bash
#!/bin/bash
SOURCE="$0"
while [ -h "$SOURCE"  ]; do # resolve $SOURCE until the file is no longer a symlink
    DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /*  ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
APP_HOME=$DIR
APP_NAME=`ls $APP_HOME | grep jar`
do_check(){
	ps -ef | grep -v grep | grep $APP_NAME | awk '{print $2}' | while read pid
	do
		exit 1
	done
}
do_start(){
	do_check
	if [ $? -eq 1 ];then
		printf 'app has been started\n'
		exit 1
	fi
	printf 'starting app\n'
	cd $APP_HOME
	exec java -jar $APP_NAME 2>/dev/null 1>&2 &
	printf 'app started\n'
}
do_stop(){
	printf 'stoping app\n'
	ps -ef | grep -v grep | grep $APP_NAME | awk '{print $2}' | while read pid
	do
		kill -9 $pid
	done
	printf 'app stopped\n'
}

case "$1" in
start)
do_start
;;
stop)
do_stop
;;
restart)
do_stop
do_start
;;
*)
printf 'Usage: %s {start|stop|restart}\n' "$prog"
exit 1
;;
esac
```

2.create soft link
```bash
ln -s start.sh /etc/init.d/jar-server
```

3.start/stop server
```bash
#start server
/etc/init.d/jar-server start
#stop server
/etc/init.d/jar-server stop
```

4.automatic run on boot
```bash
update-rc.d jar-server defaults
```

*NOTE:*
- grant executable permission to this script
- put this script on the jar file folder
- make sure only have one jar file in this folder