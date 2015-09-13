## 一. 简介 ##
GitBlog是一个简单易用的Markdown博客系统，它不需要数据库，没有管理后台功能，更新博客只需要添加你写好的Markdown文件即可。它摆脱了在线编辑器排版困难，无法实时预览的缺点，一切都交给Markdown来完成，一篇博客就是一个Markdown文件。同时也支持评论，代码高亮，数学公式，页面PV统计等常用功能。GitBlog提供了不同的主题样式，你可以根据自己的喜好配置，如果你想自己制作博客主题，也是非常容易的。GitBlog还支持整站静态导出，你完全可以导出整站静态网页部署到Github Pages。

预览

![screenshot](https://github.com/xiongjungit/gitblog/raw/master/screenshot.png)

## 二. 功能特点 ##

1. 使用Markdown  

2. 评论框  

3. 代码高亮  

4. PV统计  

5. Latex数学公式  

6. 自制主题  

7. 响应式  

8. 全站静态导出  

9. 良好的SEO  

## 三. GitBlog优势 ##
 
1. 无需数据库，系统更轻量，移植更方便  

2. 使用Markdown编写，摆脱后台编辑排版困难，无法实时预览的缺点  

3. 可全站静态导出  

4. 配置灵活，可自由开关某些功能  

5. 多主题支持，可自制主题  

6. 博客，分类，标签，归档  

## 四. 环境要求 ##

- PHP 5.2.4+ 

- mbstring扩展支持 

- php.ini开启short_open_tag = On 

## 五. 安装步骤

1、获取镜像和运行实例

- 道客云镜像(速度快):
```
docker pull daocloud.io/xiongjun_dao/docker-gitblog:master-init 
```

- 时速云镜像(速度快): 
```
docker pull daocloud.io/xiongjun_dao/docker-gitblog:master-init
```

- DockerHub镜像(速度慢): 
```
docker pull dockerxman/docker-gitblog
```

- 运行实例
```
docker run -itd -p 80:80 --name gitblog dockerxman/docker-gitblog
```
 
2、上传Markdown文件到网站根目录`blog`文件夹 

3、访问`http://your-ip`


## 六. 详细说明 ##

[1. 安装][1]  

[2. 目录结构][2]  

[3. 配置说明][3]  

[4. 编写博客][4]  

[5. 评论，订阅，统计等][5]  

[6. 缓存机制][6]  

[7. 全站静态导出][7]  

[8. 主题制作][8]  

[9. 在Nginx上运行GitBlog][9]  

[10. 在Apache上运行GitBlog][10]  

[11. 在SAE上运行GitBlog][11]  

[12. 使用GitBlog和Github Pages搭建博客][12]  

[13. Gitblog升级][13]  

[14. 从wordpress导入][14]

## 七. 问题及bug反馈 ##

如果在实际使用过程中对GitBlog有新的功能需求，或者在使用GitBlog的过程中发现了Bug，欢迎反馈给我。可以直接在Github上提交，也可以发邮件至`164068300[AT]qq.com`与我取得联系，我将及时回复。如果你自己制作了漂亮好用的主题，也非常欢迎你提交给我，我会在这里展示你的主题链接。如果你正在使用GitBlog，也可以告诉我，我将也会在这里列出使用者名单。如果你想和其他GitBlog使用者讨论交流，欢迎加入QQ群`84692078`。

## 八. 使用者列表 ##

- [dockerxman][28]

- [Weeds][20]

- [橙子][21]

- [jockchou][22]

- [GitBlog Doc][23]

- [zxy][24]  

- [ckeyer][25]

- [江湖隐行客][26]

- [liyu34][27]

- ...


## 九. 感谢 ##

GitBlog的成长需要喜欢Markdown，喜欢写博客的各位亲们支持！感谢你们使用GitBlog，感激你们对Gitblog的良好建议和Bug反馈。



---

## 十. gitblog博客源码作者信息

- QQ群：**84692078**

- 作者邮箱：**164068300@qq.com**

- 作者github主页: **https://github.com/jockchou/gitblog**

## 十一. gitblog博客docker镜像作者信息

- 作者QQ: **479608797**

- 作者邮箱: **fenyunxx@163.com**

- 作者github主页: **https://github.com/xiongjungit**

- 作者dockerhub主页: **https://hub.docker.com/r/dockerxman**



[1]:http://gitblogdoc.sinaapp.com/blog/gitblog/install.html
[2]:http://gitblogdoc.sinaapp.com/blog/gitblog/struct.html
[3]:http://gitblogdoc.sinaapp.com/blog/gitblog/config.html
[4]:http://gitblogdoc.sinaapp.com/blog/gitblog/edit.html
[5]:http://gitblogdoc.sinaapp.com/blog/gitblog/other-func.html
[6]:http://gitblogdoc.sinaapp.com/blog/gitblog/cache.html
[7]:http://gitblogdoc.sinaapp.com/blog/gitblog/export.html
[8]:http://gitblogdoc.sinaapp.com/blog/gitblog/theme.html
[9]:http://gitblogdoc.sinaapp.com/blog/gitblog/nginx.html
[10]:http://gitblogdoc.sinaapp.com/blog/gitblog/apache.html
[11]:http://gitblogdoc.sinaapp.com/blog/gitblog/sae.html
[12]:http://gitblogdoc.sinaapp.com/blog/gitblog/github-pages.html
[13]:http://gitblogdoc.sinaapp.com/blog/gitblog/update.html
[14]:http://gitblogdoc.sinaapp.com/blog/gitblog/wordpress.html


[20]: http://blog.hiweeds.net
[21]: http://xiaochengzi.sinaapp.com
[22]: http://jockchou.com
[23]: http://gitblogdoc.sinaapp.com
[24]: http://zxy.link
[25]: http://blog.ckeyer.com
[26]: http://wangzugang.net
[27]: http://liyu34.xyz
[28]: http://gitblog.daoapp.io/

## 十二. 演示网站

- [梦想网络](http://mxnet.cc)

- [道客云Gitblog演示网站](http://gitblog.daoapp.io/)

- [时速云Gitblog演示网站](http://gitblog-dockerxman.tenxapp.com)
