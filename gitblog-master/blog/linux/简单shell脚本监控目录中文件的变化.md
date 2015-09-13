<!--
author: XiongJun
date: 2015-08-06
title: 简单shell脚本监控目录中文件的变化
images: 
tags: linux,shell
category: linux,shell
status: publish
summary: 定时1分钟监控/www/blog/文件夹，如果文件夹内容发生改变，则自动删除/www/app/cache/目录里面的所有内容。

新文件的定义是：文件名为新出现，和1分钟内内容有变化的文件。

脚本说明：本脚本针对gitblog。监控/www/blog/(md文档目录)文件夹，如果文件夹和内容发生改变(根据时间来判断)，则自动删除/www/app/cache/(缓存目录)目录里面的所有内容。


-->



定时1分钟监控/www/blog/文件夹，如果文件夹内容发生改变，则自动删除/www/app/cache/目录里面的所有内容。

新文件的定义是：文件名为新出现，和1分钟内内容有变化的文件。

> 
shell脚本

```
#!/bin/bash

# 脚本说明：本脚本针对gitblog。监控/www/blog/(md文档目录)文件夹，如果文件夹和内容发生改变(根据时间来判断)，则自动删除/www/app/cache/(缓存目录)目录里面的所有内容。

OLD="/tmp/old.txt"

NEW="/tmp/new.txt"

BLOG="/www/blog/"

CACHE="/www/app/cache/"



while :; do

    if [ -e "$OLD" ]; then

        mv "$OLD" "$NEW"

        ls -lR "$BLOG" | awk '{print $8}'  > "$OLD"

        diff "$OLD" "$NEW"

        if [ $? == 0 ]; then

            echo "$BLOG" Not changed

        else

            echo "$BLOG" Changed
	        echo Delete files in "$CACHE" 
	        rm -rf "$CACHE"/*

        fi

    else

        ls -lR "$BLOG" | awk '{print $8}'  > "$OLD"

    fi

    # 可以通过调整sleep的时间来更改频率,也可以加到crontab里面
	
	# crontab -e 添加 */1 * * * * /root/monitor.sh

    sleep 60

done
```