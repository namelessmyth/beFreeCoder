 

# 前言

- 本文主要说明windows11的C盘空间优化技巧，也叫减肥瘦身，目标：20G以内。
- 绝大部分内容，也适用于window10和windows7，只是操作系统不同，操作方式略有不同。
- 不关注C盘空间的读者，可以忽略此文。



# 版本修订

2023-08-31，初版发布。

2023-09-01，加入Office定制安装内容，调整格式。

2023-09-02，加入Idea目录调整内容。

2023-09-03，加入DBeaver相关内容。

2023-09-04，加入版本修订，有道翻译相关内容。



# 先决条件

首先正常安装操作系统并进行必要优化，[Windows11的安装步骤参考](https://blog.csdn.net/namelessmyth/article/details/132520445?spm=1001.2014.3001.5501)。

安装好必要的第三方优化软件。例如：

- 安全卫士或者电脑管家软件。例如：腾讯电脑管家。
- Dism++，一款强大的Windows 系统管理优化工具，[下载地址](https://github.com/Chuyu-Team/Dism-Multi-language/releases/tag/v10.1.1002.2)，[使用说明](https://zhuanlan.zhihu.com/p/37664732?utm_medium=social&utm_oi=798172504500887552)。
- CCleaner，专业的电脑系统清理软件和隐私保护工具，[下载地址](https://www.423down.com/716.html)，[使用说明](https://zhuanlan.zhihu.com/p/630171149)。
- TreeSize Free，文件大小查看器，用于手动删除垃圾文件，[下载地址](https://www.jam-software.com/treesize_free)，[使用说明](https://zhuanlan.zhihu.com/p/61293511)。



# 系统设置优化

操作系统安装好之后，C盘大小一般为30G左右。可按如下步骤，逐步优化C盘空间。



## 虚拟内存调整

将虚拟内存调整到D盘，根据内存大小本步骤至少可以节省4G以上的C盘空间。

1. 右击开始菜单点“系统”菜单。或者在桌面的“此电脑”上右击点“属性”。
2. 然后选择高级系统设置。接下来的界面，windows11，10，7基本都一样了。
3. 依次找到“高级->性能->设置"
4. ![img](https://img-blog.csdnimg.cn/1a963c97f98c4022a4e8da559da7d1b4.png)![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)
5. 在虚拟内存那边点更改
6. ![img](https://img-blog.csdnimg.cn/b19a0bfa87794502ae885a8d44037c7e.png)![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)
7. 去掉”自动管理所有驱动器的分页文件“的勾。然后选中D盘在选择”自动管理的大小“点”设置“按钮。在选择C盘然后选择”无分页文件“点”设置“按钮。最后点”确定“
8. ![img](https://img-blog.csdnimg.cn/f57a895ed32b49479306ddd92afde126.png)![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)
9. 点确定之后可能会提示你重启，可以等所有操作都做完之后一起重启。



## 关闭系统休眠

在C盘会有1个很大的隐藏文件来存储休眠之后内存中的数据，关闭休眠功能，根据内存大小至少可以节省4G以上的C盘空间。

1. 打开命令提示符（管理员）。
2. 输入如下命令：powercfg -h off
3. 腾讯电脑管家，“空间清理->一键清理”功能。
4. ![img](https://img-blog.csdnimg.cn/f907f524fbfa420ebb38cc911c6f33de.png)![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)



# 第三方优化软件

## 管家卫士优化

使用上文提到的系统管家或者安全卫士软件，对C盘进行空间清理。本文以腾讯电脑管家16为例。

打开软件，点“空间清理->一键清理”功能。然后点”一键扫描“

![img](https://img-blog.csdnimg.cn/9ecc3818250d461b8738d87af55edf47.png)![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)

选择要清理的项，点立即清理。

![img](https://img-blog.csdnimg.cn/b761877f4cbd4e9a916a97397ec9cf85.png)![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)

腾讯电脑关键还有一个C盘清理功能，需要对扫描出来的大文件做单独判断。使用者需有一定经验。否则可能造成软件无法使用。

![img](https://img-blog.csdnimg.cn/c11f65ba913b4f90880b2a3c9b6cca6f.png)![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)



## CCleaner

打开软件，在”清理“页签的”系统“和”软件“中分别勾选要清理的项。然后点分析。出现分析结果后再点清理。

![img](https://img-blog.csdnimg.cn/200019246e434e19af4189e14c012003.png)![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)



## DISM++

此工具已经很长时间没更新了，但经笔者测试windows11仍然可以使用。

1. 软件下载后，解压到某个目录后，即可打开。
2. 选择”常用工具->空间回收“。先点扫描，再点清理。
3. ![img](https://img-blog.csdnimg.cn/5b0b069d8308455d934ea732011b0f83.png)![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)



## TreeSize Free

这个工具可以将C盘的目录和文件以树状方式全部列出来，并自动统计每个文件夹的大小和占比，还会按大小排序。

此工具建议经过上述步骤之后还想继续优化的朋友。需要使用者有一定优化经验。如果对于要删除的文件没什么把握，建议先备份在删除。

打开软件后，点”选择目录“，然后选中C盘。他自动生成统计结果。

![img](https://img-blog.csdnimg.cn/99adff28610f48589195f15ae03286b9.png)![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)

一般重点清理这个目录："C:\Users\Administrator\AppData"，随着软件的增多和运行，很多软件都会将自己的升级包，日志，缓存写到这个目录里面来。

建议关注log，temp，cache这些关键字。一般删除了对程序不会有什么影响。

根据笔者的优化经验，这里面产生临时数据最多的是Tencent目录，里面的子目录WeChat（微信），WeMeet（腾讯会议），QQMusic（QQ音乐）有时候会达到1G以上。



# 软件安装定制

此章节主要说明将一些软件的安装目录改成C盘之外的其他盘，避免占用C盘空间。

## Microsoft Office安装定制

Office是我们很多人的一个常用软件，但是目前最新版的Office2021安装包默认只能装C盘，还不能选择组件，会导致C盘空间增加至少2个G。下文介绍如何定制安装过程。

首先，微软官方提供了定制工具Office Tool Plus。可以对Office2021安装包进行定制。[链接](https://otp.landian.vip/zh-cn/)。

笔者用它定制了一个只包含5个常用组件的安装包：Word，Excel，PowerPoint，OneNote，Outlook

注意：WPS Office虽然可以选择安装路径，但也会往C盘写入大量临时数据。

**定制安装步骤**

1. 安装新版本Office前，请先卸载老版本。
2. Office默认安装在C:\Program Files\Microsoft Office目录。如果想要安装到其他位置，请提前修改注册表。
3. Win+R打开运行框，输入regedit，按回车打开编辑注册表
4. 定位到HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion
5. 找到如下这三个键值并记录下原始值：ProgramFilesDir、ProgramFilesDir (x86)、ProgramW6432Dir
6. 将这三个键值修改成你想要安装Office的位置，例如：D:\ProgramFiles\，退出regedit。
7. 双击安装包：Office2021(Office_Tool_Plus).iso，此时系统会自动弹出新盘符
8. 在新盘符中。双击Office Tool Plus.exe。然后在弹出的界面中，点“是”就会默认开始安装。
9. 如果弹出窗口问你要不要更新工具，点”否“。
10. 等待几分钟后安装完毕。此时建议使用HEU_KMS_Activator工具进行激活。
11. 激活成功之后，如果之前没有改过注册表的话，已经可以正常使用Office了。
12. 如果之前修改过注册表的配置，请将其还原后，重启系统。
13. 重启之后，请修改Office图标的超链接目标位置。将其中的部分路径改成之前注册表指向的那个路径。 例如："D:\ProgramFiles\Microsoft Office\root\Office16\OUTLOOK.EXE"
14. ![img](https://img-blog.csdnimg.cn/cb8af3d47c8240188e3e75ccb1cca05e.png)![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)
15. 将所有图标链接地址都改好后，可以双击测试下，是否能正常使用。



# 软件设置调整

此章节主要说明一些软件临时目录的修改，避免临时数据写入C盘，占用C盘空间。

## OneNote

OneNote是微软Office的一个组件，主要用于记笔记。

1. 点”文件->选项->保存和备份“，里面的目录可以配置到其他盘。
2. ![img](https://img-blog.csdnimg.cn/20c8da3f1c4a489c829400a1369df5c0.png)![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)



## QQ音乐

打开软件，找到”设置“菜单。

![img](https://img-blog.csdnimg.cn/9bb4c7ce96124f8e8b122ad7c9ff04e8.png)![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)



## IntelliJ IDEA

IDEA是一个开发人员的常用IDE工具，虽然他可以选择安装地址，但是默认会往C盘写入临时文件以及缓存，大小也可以达到1G以上。如果想要把这些数据写入到安装目录下，可以按以下步骤操作。

1. 进入Idea安装目录。例如：D:\ProgramFiles\JetBrains\IntelliJ IDEA 2023\bin

2. 找到并用记事本打开：idea.properties，去掉如下配置项的注释：idea.config.path，idea.system.path，idea.plugins.path

3. 其他的项不用修改，参考配置如下：

4. ```java
   # Use ${idea.home.path} macro to specify location relative to IDE installation home.
   # Use ${xxx} where xxx is any Java property (including defined in previous lines of this file) to refer to its value.
   # Note for Windows users: please make sure you're using forward slashes: C:/dir1/dir2.
   
   #---------------------------------------------------------------------
   # Uncomment this option if you want to customize a path to the settings directory.
   #---------------------------------------------------------------------
   idea.config.path=${idea.home.path}/.IntelliJIdea/config
   
   #---------------------------------------------------------------------
   # Uncomment this option if you want to customize a path to the caches directory.
   #---------------------------------------------------------------------
   idea.system.path=${idea.home.path}/.IntelliJIdea/system
   
   #---------------------------------------------------------------------
   # Uncomment this option if you want to customize a path to the user-installed plugins directory.
   #---------------------------------------------------------------------
   idea.plugins.path=${idea.config.path}/plugins
   
   #---------------------------------------------------------------------
   # Uncomment this option if you want to customize a path to the logs directory.
   #---------------------------------------------------------------------
   idea.log.path=${idea.system.path}/log
   ```

   ![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)

   

## DBeaver

DBeaver是一款通用的数据库管理工具，类似Navicat。只是他有免费的社区版本。

DBeaver是用Java开发的，当链接不同的数据库时，它会使用内置的Maven下载不同的数据库驱动。这个默认的临时目录是：C:\Users\Administrator\AppData\Roaming\DBeaverData\drivers。同时是去默认的Maven中央仓库下载的。下载速度很慢。这里建议大家做如下优化：

- 打开“窗口->首选项->连接->驱动->驱动位置”，将“本地文件夹”改到其他盘。
- ![img](https://img-blog.csdnimg.cn/5c148c62c2664f8bba2c1e36e4e2c784.png)![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)
- 接着点下面的maven，然后点“添加”，将阿里云maven仓库地址加入，同时移动到最上面。http://maven.aliyun.com/nexus/content/groups/public/



## 网易有道翻译

有道翻译的临时目录位置：C:\Users\Administrator\AppData\Local\Yodao\DeskDict

目录大小：500M以上，存放的应该是缓存，离线词库，语音库等。

目前未找到设置可以修改这个目录的。大家知道的可以留言告诉我。



