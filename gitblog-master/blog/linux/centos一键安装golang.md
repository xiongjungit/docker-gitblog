<!--
author: XiongJun
date: 2015-08-06
title: ubuntu开启无线热点，移动设备也能连
images: 
tags: linux,shell,centos,golang
category: linux,shell,centos,golang
status: publish
summary: ubuntu开启无线热点，移动设备也能连

####1. 安装相关软件


<pre>
add-apt-repository ppa:nilarimogard/webupd8
sudo apt-get update
sudo apt-get install hostapd
sudo apt-get install ap-hotspot
</pre>

-->


##安装脚本

```
#!/bin/bash
#下载安装
SET_GOPATH=/home/wangzg/go
TMP_PATH=$(cd "$(dirname '$0')";pwd)
[ ! -f go1.4.2.linux-386.tar.gz ] && wget http://www.golangtc.com/static/go/go1.4.2.linux-386.tar.gz
[ ! -d /usr/local/go ] && tar -zxvf go1.4.2.linux-386.tar.gz  -C /usr/local/
cd /usr/local/go/src/
/usr/local/go/src/all.bash
cd "${TMP_PATH}"
#环境配置
cat >/etc/profile.d/go.sh<<EOF
#!/bin/bash
export GOROOT=/usr/local/go
export GOBIN=$GOROOT/bin
export GOARCH=386
export GOOS=linux 
export GOPATH=${SET_GOPATH}
export GOLINKTOOL=$GOROOT/pkg/tool/linux_386
export PATH=\$GOLINKTOOL:\$GOBIN:\$PATH
EOF
[ ! -d ${SET_GOPATH} ] && mkdir -p ${SET_GOPATH}
chmod +x /etc/profile.d/go.sh
source /etc/profile.d/go.sh
#判断是否成功
[ ! -z "$(go version |grep go1.4.2)" ] && echo "go1.4.2 installed.->succeed<-";exit 0
echo "install failed."
```

##安装实施

1. 将上述脚本保存为go_install.sh

2. 在go_install.sh目录下执行 chmod +x go_install.sh

3. 执行命令source ./go_install.sh