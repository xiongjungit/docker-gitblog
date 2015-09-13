<!--
author: xiongjun
head: /img/my_head.png
date: 2015-08-06
title: 在Github上搭建Octopress博客
tags: octopress,github
category: octopress,github
status: publish
summary: 本文将详细叙述在Windows下如何安装、运行Octopress博客并发布到Github Pages上，然后就可以通过http://username.github.com来访问你的站点了。先看下我发布在Github上的Octopress演示博客：
-->

本文将详细叙述在Windows下如何安装、运行Octopress博客并发布到Github Pages上，然后就可以通过`http://username.github.com`来访问你的站点了。先看下我发布在Github上的Octopress演示博客：

> 
演示地址：http://xhhjin.github.com
绑定域名：http://github.xuhehuan.com/

因为我已经绑定了域名，所以点击第一个演示地址时会自动跳转到绑定的域名上。

![Octopress](http://xuhehuan.com/wp-content/uploads/2012/08/octopress.jpg)

安装Octopress博客前需在本机上安装Ruby运行环境和Devkit，另外还要下载Octopress，更改gem的更新源，安装依赖项。本文将针对Github上的Octopress博客搭建进行详细说明。

## 一、搭建本地环境

为了在Github上使用Octopress，需要首先配置一下本地环境：

首先安装Git，下载[msysgit](http://code.google.com/p/msysgit/downloads/list)，目前最新版本是 [Git-1.7.10-preview20120409.exe](http://msysgit.googlecode.com/files/Git-1.7.10-preview20120409.exe) ，安装可参考[官方文档](https://help.github.com/articles/set-up-git)。

然后安装Ruby， [Octopress 官方文档](http://octopress.org/docs/setup/)中指定的 Ruby 版本是 1.9.2，所以我们选择 Ruby 1.9.2-p290，下载 [rubyinstaller-1.9.2-p290.exe](http://rubyforge.org/frs/download.php/75127/rubyinstaller-1.9.2-p290.exe)，双击安装，安装时记得选中“Add Ruby executables to your PATH”。

为了检查ruby是否已加入到PATH中，可在 Windows 的cmd窗口中执行以下命令：

```
ruby –version
```

接着安装Devkit，选择下载 4.5.2 版本：[DevKit-tdm-32-4.5.2-20111229-1559-sfx.exe，下载完成后，将其解压到如 E:\DevKit](https://github.com/downloads/oneclick/rubyinstaller/DevKit-tdm-32-4.5.2-20111229-1559-sfx.exe)，然后在win的cmd窗口中执行如下命令进行安装：

```
E:
cd DevKit
ruby dk.rb init
ruby dk.rb install
```

最后安装python，主要是博客代码加亮模块需要python环境的支持，[下载2.7版](http://www.activestate.com/activepython/downloads)，安装完以后，在Windows的cmd窗口中执行：

```
easy_install pygments
```

本地环境配置结束。

## 二、更新本地环境配置

为了支持中文UTF-8编码，对Windows环境变量配置如下：

```
LANG=zh_CN.UTF-8
LC_ALL=zh_CN.UTF-8
```

也可在直接在Windows的cmd窗口下运行命令

```
set LANG=zh_CN.UTF-8
set LC_ALL=zh_CN.UTF-8
```

更新gem的更新源，ruby的官方更新源经常被河蟹，换成国内的更新源，这样速度就快多了，变更如下：

```
gem sources -a http://ruby.taobao.org/
gem sources -r http://rubygems.org/
gem sources -l
```

最后一个命令可查看更该后的更新源列表。

## 三、下载并配置Octopress

首先下载Octopress源码，可以使用下面git命令下载，也可直接在Octopress Github库中下载octopress的zip包（[点击下载](https://nodeload.github.com/imathis/octopress/zipball/master)），然后将下载的压缩包解压到E盘根目录，修改解压后的文件夹名称为 octopress。

```
E:
git clone git://github.com/imathis/octopress.git  octopress
```

然后更新 Octopress 的gem更新源：进到 E:/octopress 目录，用文本编辑器（例如记事本）打开文件Gemfile，将里面`source “http://rubygems.org/”`改为`source “http://ruby.taobao.org/”`。

最后安装Octopress的依赖项，在Windows的CMD窗口输入以下命令：

```
E:
cd octopress
gem install bundler
bundle install
```

## 四、新建Github Repositories

登录[Github](https://github.com/)，假设你的用户名是username，首先要新建一个命名为 username.github.com 的Repo，命名必须是这个格式，如果不这样命名的话，在运行命令 rake setup_github_pages  之后不能够自动创建后面提到的master和source 分支，而是作为普通仓库生成 gh-pages 分支。

创建Repo，如下图：

![](http://xuhehuan.com/wp-content/uploads/2012/08/07D75867C7A2435D6F64BA67FC980F62_616_155.jpeg)

Repo的设置，如下图：

![](http://xuhehuan.com/wp-content/uploads/2012/08/BEA30C102E82E3CFDD81FC9C2ECAD685_844_554.jpeg)

## 五、发布Octopress到Github

1、打开Windows下的命令窗口，进入到Octopress所在的目录，输入命令：

```
rake setup_github_pages
```

按照提示输入刚才新建的Repo地址，类似：`git@github.com:username/username.github.com`或`git@github.com:username/username.github.com.git`。

![](http://xuhehuan.com/wp-content/uploads/2012/08/4AE9EC3E86C5F7345502F3DE34FD2995_673_436.jpeg)

2、接着输入命令：

```
rake install
rake generate
rake preview
```

其中rake install是安装Octopress默认主题的，rake gnerate是生成静态页面的，这两个命令是必须运行的，而rake preview则是用来本地浏览的（运行时看屏幕上提示，按Ctrl+C并输入Y来终止批处理操作），运行后打开浏览器，输入 http://localhost:4000/ 就可以看到如下的界面了，不想预览的话也可以不运行，直接进入下一步。

![](http://xuhehuan.com/wp-content/uploads/2012/08/1776232DF0DB15B299CE6ED32E52AA97_673_436.jpeg)

3、将博客发布到Github上，输入下面命令：

```
rake deploy
```

这样，生成的内容将会自动发布到master分支，并且可以使用 http://username.github.com 访问内容。

![](http://xuhehuan.com/wp-content/uploads/2012/08/CA535E9CF7D76A628C58F8EC287C225E_762_352.jpeg)

4、别忘了把所有源文件发布到 source 分支下面：

```
git add .
git commit -m “your message”
git push origin source
```

至此，所有发布完成，接下来就是对博客的设置了。

## 六、Ocotpress博客配置

更改下面的配置后，还需要运行 rake generate、rake deploy等等命令的。

1、默认的博客运行成功的话，就需要按照自己的要求对博客配置进行修改了，主要是修改Octopress根目录下的主配置文件_config.yml。

```
url:  http://username.github.com                 # 博客地址
title:  蔓草札记                                            # 博客标题
subtitle:  感受生活，感悟工作，感触心灵           # 副标题
author:  xhhjin                                                       # 作者
simple_search:  http://www.google.com.hk/search     # 搜索引擎
description:                                                            # 关于博客的描述
subscribe_rss:  /atom.xml                  # Rss订阅地址, 默认是  /atom.xml
subscribe_email:                               # 提供Email订阅的地址
email:                                              # Rss订阅的Email地址
root:  /               # 博客路径，默认是“/“，如果你打算在子目录中，记得修改这个路径
permalink: /blog/:year/:month/:day/:title/           # 文章的固定链接形式
```

2、更换主题

主题位于 octopress/.theme 目录下，默认主题为 classic。 如果需要更改主题（可在网上查找），下载后将主题也放在.theme目录下即可，如果主题名字为blog_theme，那么安装主题时输入以下命令即可：

```
rake install [‘blog_theme’]
```

## 七、绑定域名

Github Pages绑定域名的方法有点特殊，需要在Octopress/source目录下建个无后缀的CNAME文本文件，文件内容就是你的域名，例如github.xuhehuan.com，然后修改A纪录到207.97.227.245 ，或者 CNAME 指向 username.github.com，下面就等着解析生效了。

更多内容可参考这里：

（1）[Octopress写作及个性设置](http://xuhehuan.com/886.html)

（2）[打造Octopress博客在线写作平台](http://xuhehuan.com/1761.html)

（3）[Octopress 博客系统 —— A blogging framework for hackers](http://opoo.org/octopress/)

（4）[Octopress官方帮助文档](http://octopress.org/help/)


欢迎转载，转载请注明出处：[蔓草札记](http://xuhehuan.com/) » [在Github上搭建Octopress博客](http://xuhehuan.com/783.html)