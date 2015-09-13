<!--
author: xiongjun
date: 2015-08-06
title: grep正则表达式使用手册
tags: regex,shell,linux
category: regex,shell,linux
status: publish
summary: 正则表达式就是处理字串的方法,他是以行为单位来进行字串的处理行为, 正则表达式透过一些特殊符号的辅助,可以让使用者轻易的达到『搜寻/删除/取代』某特定字串的处理程序
-->


<script>
document.addEventListener("DOMContentLoaded", function() {
    // 生成目录列表
    var outline = document.createElement("ul");
    outline.setAttribute("id", "outline-list");
    outline.style.cssText = "border: 1px solid #ccc;";
    document.body.insertBefore(outline, document.body.childNodes[0]);
    // 获取所有标题
    var headers = document.querySelectorAll('h1,h2,h3,h4,h5,h6');
    for (var i = 0; i < headers.length; i++) {
        var header = headers[i];
        var hash = _hashCode(header.textContent);
        // MarkdownPad2无法为中文header正确生成id，这里生成一个
        header.setAttribute("id", header.tagName + hash);
        // 找出它是H几，为后面前置空格准备
        var prefix = parseInt(header.tagName.replace('H', ''), 10);
        outline.appendChild(document.createElement("li"));
        var a = document.createElement("a");
        // 为目录项设置链接
        a.setAttribute("href", "#" + header.tagName + hash)
        // 目录项文本前面放置对应的空格
        a.innerHTML = new Array(prefix * 4).join('&nbsp;') + header.textContent;
        outline.lastChild.appendChild(a);
    }
 
});
 
// 类似Java的hash生成方式，为一段文字生成一段基本不会重复的数字
function _hashCode(txt) {
     var hash = 0;
     if (txt.length == 0) return hash;
     for (i = 0; i < txt.length; i++) {
          char = txt.charCodeAt(i);
          hash = ((hash<<5)-hash)+char;
          hash = hash & hash; // Convert to 32bit integer
     }
     return hash;
}
 

</script>



##1 grep正则表达式元字符集(基本集)

|字符|描述
|-|-|
|^| 锚定行的开始 如：'^grep'匹配所有以grep开头的行。 
|$|锚定行的结束 如：'grep$'匹配所有以grep结尾的行。 
|.|匹配一个非换行符的字符 如：'gr.p'匹配gr后接一个任意字符，然后是p。 
|*|匹配零个或多个先前字符 如：'*grep'匹配所有一个或多个空格后紧跟grep的行。 .*一起用代表任意字符。 
|[] |匹配一个指定范围内的字符，如'[Gg]rep'匹配Grep和grep。 
|[^]|匹配一个不在指定范围内的字符，如：'[^A-FH-Z]rep'匹配不包含A-R和T-Z的一个字母开头，紧跟rep的行。 
|\\(..\\)|标记匹配字符，如'\(love\)'，love被标记为1。 
|\\<|锚定单词的开始
|\\>|锚定单词的结束，如'\<grep\>'匹配包含以grep结尾的单词的行。 
|x\\{m\\}|重复字符x，m次，如：'0\{5\}'匹配包含5个o的行。 
|x\\{m,\\}|重复字符x,至少m次，如：'o\{5,\}'匹配至少有5个o的行。 
|x\\{m,n\\}|重复字符x，至少m次，不多于n次，如：'o\{5,10\}'匹配5--10个o的行。 
|\\w |匹配文字和数字字符，也就是[A-Za-z0-9]，如：'G\w*p'匹配以G后跟零个或多个文字或数字字符，然后是p。 
|\\W |\\w的反置形式，匹配一个或多个非单词字符，如点号句号等。 
|\\b|单词锁定符，如: '\bgrepb\'只匹配grep。 
--- 
##2 用于egrep和 grep -E的元字符扩展集 
|字符|描述
|-|-|
|+|匹配一个或多个先前的字符。如：'[a-z]+able'，匹配一个或多个小写字母后跟able的串，如loveable,enable,disable等。 
|?|匹配零个或多个先前的字符。如：'gr?p'匹配gr后跟一个或没有字符，然后是p的行。 
|a｜b｜c |匹配a或b或c。如：grep｜sed匹配grep或sed 
|()|分组符号，如：love(able｜rs)ov+匹配loveable或lovers，匹配一个或多个ov。 
|x{m},x{m,},x{m,n} |作用同x\{m\},x\{m,\},x\{m,n\} 
---
##3 POSIX字符类 
 
为了在不同国家的字符编码中保持一致，POSIX(The Portable Operating System Interface)增加了特殊的字符类，如[:alnum:]是A-Za-z0-9的另一个写法。要把它们放到[]号内才能成为正则表达式，如[A- Za-z0-9]或[[: alnum:]]。在linux下的grep除fgrep外，都支持POSIX的字符类。  

|字符|描述
|-|-|
|[:alnum:]|文字数字字符 
|[:alpha:]|文字字符 
|[:digit:]|数字字符 
|[:graph:]|非空字符(非空格、控制字符) 
|[:lower:]|小写字符 
|[:cntrl:]|控制字符 
|[:print:]|非空字符(包括空格) 
|[:punct:]|标点符号 
|[:space:]|所有空白字符(新行，空格，制表符) 
|[:upper:]|大写字符 
|[:xdigit:]|十六进制数字(0-9，a-f，A-F)
---
##4 Grep命令选项

|字符|描述
|-|-|
|-?|同时显示匹配行上下的？行，如：grep -2 pattern filename同时显示匹配行的上下2行。
|-b，--byte-offset|打印匹配行前面打印该行所在的块号码。
|-c,--count|只打印匹配的行数，不显示匹配的内容。
|-f File，--file=File|从文件中提取模板。空文件中包含0个模板，所以什么都不匹配。
|-h，--no-filename|当搜索多个文件时，不显示匹配文件名前缀。
|-i，--ignore-case|忽略大小写差别。
|-q，--quiet|取消显示，只返回退出状态。0则表示找到了匹配的行。
|-l，--files-with-matches|打印匹配模板的文件清单。
|-L，--files-without-match|打印不匹配模板的文件清单。
|-n，--line-number|在匹配的行前面打印行号。
|-s，--silent|不显示关于不存在或者无法读取文件的错误信息。
|-v，--revert-match|反检索，只显示不匹配的行。
|-w，--word-regexp|如果被\<和\>引用，就把表达式做为一个单词搜索。
|-V，--version|显示软件版本信息。