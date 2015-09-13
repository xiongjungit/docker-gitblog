<!--
author: xiongjun
date: 2015-07-31
title: linux 正则表达式 与 shell script
tags: regex,shell,linux
category: regex,shell,linux
status: publish
summary: 正则表达式就是处理字串的方法,他是以行为单位来进行字串的处理行为, 正则表达式透过一些特殊符号的辅助,可以让使用者轻易的达到『搜寻/删除/取代』某特定字串的处理程序
-->


##目录
正则表达式 
shell script 

##正则表达式
相关资料: http://deerchao.net/tutorials/regex/regex.htm

 

含义:

正则表达式就是处理字串的方法,他是以行为单位来进行字串的处理行为, 正则表达式透过一些特殊符号的辅助,可以让使用者轻易的达到『搜寻/删除/取代』某特定字串的处理程序

###基础正则表达式字符汇整 (characters)
|RE 字符	|意义与范例
|-|-|
|^word	|意义：待搜寻的字串(word)在行首！<br>范例：搜寻行首为 # 开始的那一行,并列出行号grep -n '^#' regular_express.txt
|word$	|意义：待搜寻的字串(word)在行尾！<br>范例：将行尾为 ! 的那一行列印出来,并列出行号grep -n '!$' regular_express.txt
|.	|意义：代表『一定有一个任意字节』的字符！<br>范例：搜寻的字串可以是 (eve) (eae) (eee) (e e), 但不能仅有 (ee) ！亦即 e 与 e 中间『一定』仅有一个字节,而空白字节也是字节！grep -n 'e.e' regular_express.txt
|\	|意义：跳脱字符,将特殊符号的特殊意义去除！<br>范例：搜寻含有单引号 ' 的那一行！grep -n \' regular_express.txt
|*	|意义：重复零个到无穷多个的前一个 RE 字符<br>范例：找出含有 (es) (ess) (esss) 等等的字串,注意,因为 * 可以是 0 个,所以 es 也是符合带搜寻字串.另外,因为 * 为重复『前一个 RE 字符』的符号, 因此,在 * 之前必须要紧接著一个 RE 字符喔！例如任意字节则为 『.*』 ！grep -n 'ess*' regular_express.txt
|[list]	|意义：字节集合的 RE 字符,里面列出想要撷取的字节！<br>范例：搜寻含有 (gl) 或 (gd) 的那一行,需要特别留意的是,在 [] 当中『谨代表一个待搜寻的字节』, 例如『 a[afl]y 』代表搜寻的字串可以是 aay, afy, aly 即 [afl] 代表 a 或 f 或 l 的意思！grep -n 'g[ld]' regular_express.txt
|[n1-n2]	|意义：字节集合的 RE 字符,里面列出想要撷取的字节范围！<br>范例：搜寻含有任意数字的那一行！需特别留意,在字节集合 [] 中的减号 - 是有特殊意义的,他代表两个字节之间的所有连续字节！但这个连续与否与 ASCII 编码有关,因此,你的编码需要配置正确(在 bash 当中,需要确定 LANG 与 LANGUAGE 的变量是否正确！) 例如所有大写字节则为 [A-Z]grep -n '[A-Z]' regular_express.txt
|[^list]	|意义：字节集合的 RE 字符,里面列出不要的字串或范围！<br>范例：搜寻的字串可以是 (oog) (ood) 但不能是 (oot) ,那个 ^ 在 [] 内时,代表的意义是『反向选择』的意思. 例如,我不要大写字节,则为 [^A-Z].但是,需要特别注意的是,如果以 grep -n [^A-Z] regular_express.txt 来搜寻,却发现该文件内的所有行都被列出,为什么？因为这个 [^A-Z] 是『非大写字节』的意思, 因为每一行均有非大写字节,例如第一行的 "Open Source" 就有 p,e,n,o.... 等等的小写字grep -n 'oo[^t]' regular_express.txt
|\{n,m\}	|意义：连续 n 到 m 个的『前一个 RE 字符』<br>意义：若为 \{n\} 则是连续 n 个的前一个 RE 字符,<br>意义：若是 \{n,\} 则是连续 n 个以上的前一个 RE 字符！ 范例：在 g 与 g 之间有 2 个到 3 个的 o 存在的字串,亦即 (goog)(gooog)grep -n 'go\{2,3\}g' regular_express.txt
 

###特殊字符的特殊意义
|特殊符号	|代表意义
|-|-|
|[:alnum:]	|代表英文大小写字节及数字,亦即 0-9, A-Z, a-z
|[:alpha:]	|代表任何英文大小写字节,亦即 A-Z, a-z
|[:blank:]	|代表空白键与 [Tab] 按键两者
|[:cntrl:]	|代表键盘上面的控制按键,亦即包括 CR, LF, Tab, Del.. 等等
|[:digit:]	|代表数字而已,亦即 0-9
|[:graph:]	|除了空白字节 (空白键与 [Tab] 按键) 外的其他所有按键
|[:lower:]	|代表小写字节,亦即 a-z
|[:print:]	|代表任何可以被列印出来的字节
|[:punct:]	|代表标点符号 (punctuation symbol),亦即：" ' ? ! ; : # $...
|[:upper:]	|代表大写字节,亦即 A-Z
|[:space:]	|任何会产生空白的字节,包括空白键, [Tab], CR 等等
|[:xdigit:]	|代表 16 进位的数字类型,因此包括： 0-9, A-F, a-f 的数字与字节
 

###延伸正则表达式
|RE 字符	|意义与范例
|-|-|
|+	|意义：重复『一个或一个以上』的前一个 RE 字符<br>范例：搜寻 (god) (good) (goood)... 等等的字串. 那个 o+ 代表『一个以上的 o 』所以,底下的运行成果会将第 1, 9, 13 行列出来.egrep -n 'go+d' regular_express.txt
|?	|意义：『零个或一个』的前一个 RE 字符<br>范例：搜寻 (gd) (god) 这两个字串. 那个 o? 代表『空的或 1 个 o 』所以,上面的运行成果会将第 13, 14 行列出来. 有没有发现到,这两个案例( 'go+d' 与 'go?d' )的结果集合与 'go*d' 相同？ 想想看,这是为什么喔！ ^_^egrep -n 'go?d' regular_express.txt
|｜	|意义：用或( or )的方式找出数个字串<br>范例：搜寻 gd 或 good 这两个字串,注意,是『或』！ 所以,第 1,9,14 这三行都可以被列印出来喔！那如果还想要找出 dog 呢？egrep -n 'gd｜good' regular_express.txt<br>egrep -n 'gd｜good｜dog' regular_express.txt
|()	|意义：找出『群组』字串<br>范例：搜寻 (glad) 或 (good) 这两个字串,因为 g 与 d 是重复的,所以, 我就可以将 la 与 oo 列於 ( ) 当中,并以 ｜ 来分隔开来,就可以啦！egrep -n 'g(la｜oo)d' regular_express.txt
|()+	|意义：多个重复群组的判别<br>范例：将『AxyzxyzxyzxyzC』用 echo 叫出,然后再使用如下的方法搜寻一下！echo 'AxyzxyzxyzxyzC' ｜ egrep 'A(xyz)+C' 上面的例子意思是说,我要找开头是 A 结尾是 C ,中间有一个以上的 "xyz" 字串的意思～

##shell script
shell script 是利用 shell 的功能所写的一个『程序 (program)』,这个程序是使用纯文字档,将一些 shell 的语法与命令(含外部命令)写在里面, 搭配正规表示法、管线命令与数据流重导向等功能,以达到我们所想要的处理目的.

 

###注意事项
* 命令的运行是从上而下、从左而右的分析与运行；

* 命令的下达就如同第五章内提到的： 命令、选项与参数间的多个空白都会被忽略掉；

* 空白行也将被忽略掉,并且 [tab] 按键所推开的空白同样视为空白键；

* 如果读取到一个 Enter 符号 (CR) ,就尝试开始运行该行 (或该串) 命令；

* 至於如果一行的内容太多,则可以使用『 \[Enter] 』来延伸至下一行；

* 『 # 』可做为注解！任何加在 # 后面的数据将全部被视为注解文字而被忽略！
 

###运行方式

* 直接命令下达： shell.sh 文件必须要具备可读与可运行 (rx) 的权限,然后：

    1. 绝对路径：使用 /home/dmtsai/shell.sh 来下达命令；

    2. 相对路径：假设工作目录在 /home/dmtsai/ ,则使用 ./shell.sh 来运行

    3. 变量『PATH』功能：将 shell.sh 放在 PATH 指定的目录内,例如： ~/bin/

* 以 bash 程序来运行：透过『 bash shell.sh 』或『 sh shell.sh 』来运行
 

###撰写 shell script 的良好习惯创建
* script 的功能；

* script 的版本资讯；

* script 的作者与联络方式；

* script 的版权宣告方式；

* script 的 History (历史纪录)；

* script 内较特殊的命令,使用『绝对路径』的方式来下达；

* script 运行时需要的环境变量预先宣告与配置.
 

###script 的运行方式差异
* 利用直接运行的方式来运行 script
当你使用直接运行的方法来处理时,系统会给予一支新的 bash 让我们来运行 shell script 里面的命令,因此你的自定义的变量在 shell script 的 bash 中是不存在的因为它只会继承调用它的 bash 的环境变量而不会继承它的自定义变量.直到 shell script 运行完毕后系统返回到调用 shell script 的 bash 中时你将可以继续运用的你自定义变量

![](http://pic002.cnblogs.com/images/2012/387401/2012090921194512.gif)

* 利用 source 来运行脚本：在父程序中运行
利用source 运行脚本时候 shell script其实是在调用它的 bash 下运行的,所以它拥有调用它的 bash 中的环境变量和自定义变量.即source 对 script 的运行方式可以使用底下的图示来说明！

![](http://pic002.cnblogs.com/images/2012/387401/2012090921224291.gif)

###利用判断符号 [ ]

```
[ "$HOME" == "$MAIL" ]
[□"$HOME"□==□"$MAIL"□]
  ↑ 　　     ↑　  ↑　　     ↑
```

* 在中括号 [] 内的每个组件都需要有空白键来分隔；

* 在中括号内的变量,最好都以双引号括号起来；

* 在中括号内的常数,最好都以单或双引号括号起来.

错误例子:

```
[ $name == "VBird" ]   等价于   [ VBird Tsai == "VBird" ] 
```

* && 代表 AND ；
* || 代表 or ；

```
[ "$yn" == "Y" -o "$yn" == "y" ]
上式可替换为
[ "$yn" == "Y" ] || [ "$yn" == "y"]
```

###Shell script 的默认变量($0, $1...)
```
/path/to/scriptname opt1 opt2 opt3 opt4 
$0　　　　　　　　    $1      $2   $3     $4
```

* $0 ：运行的脚本档名

* $Num ：脚本接收参数,$1表示第一个参数,$2表示第二个参数,依次类推

* $# ：代表后接的参数『个数』,以上表为例这里显示为『 4 』；

* $@ ：代表『 "$1" "$2" "$3" "$4" 』之意,每个变量是独立的(用双引号括起来)；

* $* ：代表『 "$1c$2c$3c$4" 』,其中 c 为分隔字节,默认为空白键, 所以本例中代表『 "$1 $2 $3 $4" 』之意.
 

###shift：造成参数变量号码偏移

```
[root@www scripts]# vi sh08.sh
#!/bin/bash
# Program:
#	Program shows the effect of shift function.
# History:
# 2009/02/17	VBird	First release
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
echo "Total parameter number is ==> $#"
echo "Your whole parameter is ==> '$@'"
shift # 进行第一次『一个变量的 shift 』
echo "Total parameter number is ==> $#"
echo "Your whole parameter is ==> '$@'"
shift 3 # 进行第二次『三个变量的 shift 』
echo "Total parameter number is ==> $#"
echo "Your whole parameter is ==> '$@'"
这玩意的运行成果如下：

[root@www scripts]# sh sh08.sh one two three four five six <==给予六个参数
Total parameter number is ==> 6 <==最原始的参数变量情况
Your whole parameter is ==> 'one two three four five six'
Total parameter number is ==> 5 <==第一次偏移,看底下发现第一个 one 不见了
Your whole parameter is ==> 'two three four five six'
Total parameter number is ==> 2 <==第二次偏移掉三个,two three four 不见了
Your whole parameter is ==> 'five six'
```
 

###选择

* if ... 
```
if [ 条件判断式 ]; then
当条件判断式成立时,可以进行的命令工作内容；
fi <==将 if 反过来写,就成为 fi 啦！结束 if 之意！
```

* if ... else ...
```
if [ 条件判断式 ]; then
当条件判断式成立时,可以进行的命令工作内容；
else
当条件判断式不成立时,可以进行的命令工作内容；
fi
```

* if ... elif ... elif ... else
```
if [ 条件判断式一 ]; then
当条件判断式一成立时,可以进行的命令工作内容；
elif [ 条件判断式二 ]; then
当条件判断式二成立时,可以进行的命令工作内容；
else
当条件判断式一与二均不成立时,可以进行的命令工作内容；
fi
```

* case ..... esac
```
case $变量名称 in <==关键字为 case ,还有变量前有钱字号
"第一个变量内容") <==每个变量内容建议用双引号括起来,关键字则为小括号 )
程序段
;; <==每个类别结尾使用两个连续的分号来处理！
"第二个变量内容")
程序段
;;
*) <==最后一个变量内容都会用 * 来代表所有其他值
不包含第一个变量内容与第二个变量内容的其他程序运行段
exit 1
;;
esac
```

例子: 

```
范例:if else 的运用

[root@www scripts]# cp sh06-2.sh sh06-3.sh
[root@www scripts]# vi sh06-3.sh
#!/bin/bash
# Program:
# This program shows the user's choice
# History:
# 2005/08/25 VBird First release
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

read -p "Please input (Y/N): " yn

if [ "$yn" == "Y" ] || [ "$yn" == "y" ]; then
echo "OK, continue"
elif [ "$yn" == "N" ] || [ "$yn" == "n" ]; then
echo "Oh, interrupt!"
else
echo "I don't know what your choice is"
fi

 

范例二:case ..... esac 的运用

[root@www scripts]# vi sh09-2.sh
#!/bin/bash
# Program:
# Show "Hello" from $1.... by using case .... esac
# History:
# 2005/08/29	VBird	First release
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

case $1 in
"hello")
echo "Hello, how are you ?"
;;
"")
echo "You MUST input parameters, ex> {$0 someword}"
;;
*) # 其实就相当於万用字节，0~无穷多个任意字节之意！
echo "Usage $0 {hello}"
;;
esac
```
 

###循环
* 满足时循环
『当 condition 条件成立时,就进行回圈,直到 condition 的条件不成立才停止』
```
while [ condition ] <==中括号内的状态就是判断式
do <==do 是回圈的开始！
程序段落
done <==done 是回圈的结束
```

* 满足时结束
『当 condition 条件成立时,就终止回圈, 否则就持续进行回圈的程序段.』
```
until [ condition ]
do
程序段落
done
```

* 固定回圈
```
for...do...done
for var in con1 con2 con3 ...
do
程序段
done
```
以上面的例子来说,这个 $var 的变量内容在回圈工作时：
    1. 第一次回圈时, $var 的内容为 con1 ；
    
    2. 第二次回圈时, $var 的内容为 con2 ；
    
    3. 第三次回圈时, $var 的内容为 con3 ；
    4. ....

* for...do...done 
```
for (( 初始值; 限制值; 运行步阶 ))
do
程序段
done
```
    * 初始值：某个变量在回圈当中的起始值,直接以类似 i=1 配置好；

    * 限制值：当变量的值在这个限制值的范围内,就继续进行回圈.例如 i<=100；

    * 运行步阶：每作一次回圈时,变量的变化量.例如 i=i+1.
 

###函数 
利用 function 功能

```
function fname() {
程序段
}
```

* 因为 shell script 的运行方式是由上而下,由左而右, 因此在 shell script 当中的 function 的配置一定要在程序的最前面

* function 也是拥有内建变量的～他的内建变量与 shell script 很类似, 函数名称代表示 $0 ,而后续接的变量也是以 $1, $2... 来取代的