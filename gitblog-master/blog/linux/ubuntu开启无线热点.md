<!--
author: XiongJun
date: 2015-08-06
title: ubuntu开启无线热点，移动设备也能连
images: 
tags: linux,shell,ubuntu
category: linux,shell,ubuntu
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

##ubuntu开启wifi,移动设备也能连

> 
ubuntu开启无线热点，移动设备也能连

####1. 安装相关软件


<pre>
add-apt-repository ppa:nilarimogard/webupd8
sudo apt-get update
sudo apt-get install hostapd
sudo apt-get install ap-hotspot
</pre>

####2. 配置ap-hotspot

这一步会检查ubuntu的网络和WIFI接口，确定后会提示你配置热点，输入ssid和密码之类的就行了

<pre>
ap-hotspot configure
</pre>

<pre>
Detecting configuration...
Detected eth0 as the network interface connected to the Internet. Press ENTER if this is correct or enter the desired interface below (e.g.- eth0, ppp0 etc.):
// 回车确认

Detected wlan0 as your WiFi interface. Press ENTER if this is correct or enter the desired interface (e.g.- wlan1):
// 回车确认

Enter the desired Access Point name or press ENTER to use the default one (myhotspot):
// 输入wifi的名字

Enter the desired WPA Passphrase below or press ENTER to use the default one (qwerty0987):
// 输入wifi的密码
</pre>

####3. 查看ssid和连接密码

<pre>
cat /etc/ap-hotspot.conf|grep "^ssid" && cat /etc/ap-hotspot.conf|grep "^wpa_passphrase"
</pre>

####4. 检查ap-hotspot服务是否存在，是的话就结束相关进程

<pre>
#!/bin/sh
ap=`ps -ef|grep "[a]p-hotspot"|wc -l`
if [ "$ap" = "0" ]; then
    echo "正在启动服务..."
#   exit;
elif [ "$ap" != "0" ]; then
    echo "正在重启服务..."
    pid=`ps -ef|grep "[a]p-hotspot" | awk '{print $2}'`
    kill $pid
fi
</pre>

####5. 关闭wifi开关

<pre>
nmcli nm wifi off
</pre>

####6. 启动无线网络

<pre>
rfkill unblock wifi
</pre>

####7. 删除临时pid文件

<pre>
rm /tmp/hotspot.pid
</pre>

####8. 启动无线热点

<pre>
sudo ap-hotspot start
</pre>

####9. 监控hostapd日志文件变化

<pre>
tail -F /tmp/hostapd.log
</pre>

####10. 完整的脚本

<pre>
#!/bin/sh
echo "ubuntu开启无线热点，移动设备也能连"
echo "查看ssid和连接密码"
cat /etc/ap-hotspot.conf|grep "^ssid" && cat /etc/ap-hotspot.conf|grep "^wpa_passphrase"
sleep 3

#检查ap-hotspot服务是否存在，是的话就结束相关进程

ap=`ps -ef|grep "[a]p-hotspot"|wc -l`
if [ "$ap" = "0" ]; then
    echo "正在启动服务..."
#   exit;
elif [ "$ap" != "0" ]; then
    echo "正在重启服务..."
    pid=`ps -ef|grep "[a]p-hotspot" | awk '{print $2}'`
    kill $pid
fi

nmcli nm wifi off

sleep 3

rfkill unblock wifi

rm /tmp/hotspot.pid

sleep 3

sudo ap-hotspot start

sleep 3

echo "查看适时日志,按"Ctrl+C"退出..."
tail -F /tmp/hostapd.log

</pre>