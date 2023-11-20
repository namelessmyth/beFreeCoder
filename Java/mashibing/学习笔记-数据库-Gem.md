# 数据库

## 排名

**数据库流行程度排行**：https://db-engines.com/en/ranking



## 数据库类型

数据库经过几十年的发展，出现了多种类型。根据数据的组织结构不同，主要分为网状数据库、层次数据库、关系型数据库和非关系型数据库四种。目前最常见的数据库模型主要是：关系型数据库和非关系型数据库。

1. 关系型数据库
关系型数据库模型是将复杂的数据结构用较为简单的二元关系（二维表）来表示，如图1-4所示。在该类型数据库中，对数据的操作基本上都建立在一个或多个表格上，我们可以采用结构化查询语言（SQL）对数据库进行操作。关系型数据库是目前主流的数据库技术，其中具有代表性的数据库管理系统有：Oracle、DB2、SQL Server、MySQL等。PS：关系=二维表


2. 非关系型数据库NOSQL
NOSQL（Not Only SQL）泛指非关系型数据库。关系型数据库在超大规模和高并发的web2.0纯动态网站已经显得力不从心，暴露了很多难以克服的问题。NOSQL数据库的产生就是为了解决大规模数据集合多重数据种类带来的挑战，尤其是大数据应用难题。常见的非关系型数据库管理系统有Memcached、MongoDB，redis，HBase等。 

### 关系型数据库

虽然非关系型数据库的优点很多，但是由于其并不提供SQL支持、学习和使用成本较高并且无事务处理，所以本书的重点是关系型数据库。下面我们将介绍一下常用的关系型数据库管理系统。

1. Oracle
    Oracle数据库是由美国的甲骨文（Oracle）公司开发的世界上第一款支持SQL语言的关系型数据库。经过多年的完善与发展，Oracle数据库已经成为世界上最流行的数据库，也是甲骨文公司的核心产品。
    Oracle数据库具有很好的开放性，能在所有的主流平台上运行，并且性能高、安全性高、风险低；但是其对硬件的要求很高、管理维护和操作比较复杂而且价格昂贵，所以一般用在满足对银行、金融、保险等行业大型数据库的需求上。
2. MySQL
    MySQL是一种开放源代码的轻量级关系型数据库，MySQL数据库使用最常用的结构化查询语言（SQL）对数据库进行管理。由于MySQL是开放源代码的，因此任何人都可以在General Public License的许可下下载并根据个人需要对其缺陷进行修改。
    由于MySQL数据库体积小、速度快、成本低、开放源码等优点，现已被广泛应用于互联网上的中小型网站中，并且大型网站也开始使用MySQL数据库，如网易、新浪等。  
3. DB2
    DB2是IBM公司著名的关系型数据库产品。DB2无论稳定性，安全性，恢复性等等都无可挑剔，而且从小规模到大规模的应用都可以使用，但是用起来非常繁琐，比较适合大型的分布式应用系统。
4. SQL Server
   SQL Server是由Microsoft开发和推广的关系型数据库，SQL Server的功能比较全面、效率高，可以作为中型企业或单位的数据库平台。SQL Server可以与Windows操作系统紧密继承，无论是应用程序开发速度还是系统事务处理运行速度，都能得到大幅度提升。但是，SQL Server只能在Windows系统下运行，毫无开放性可言。



## 对比

### MySQL和Postgresql

**一.PostgreSQL相对于MySQL的优势**

1、在SQL的标准实现上要比MySQL完善，而且功能实现比较严谨；

2、存储过程的功能支持要比MySQL好，具备本地缓存执行计划的能力；

3、对表连接支持较完整，优化器的功能较完整，支持的索引类型很多，复杂查询能力较强；

4、postgresql主表采用堆表存放，MySQL采用索引组织表，能够支持比MySQL更大的数据量。

5、postgresql的主备复制属于物理复制，相对于MySQL基于binlog的逻辑复制，数据的一致性更加可靠，复制性能更高，对主机性能的影响也更小。

6、MySQL的存储引擎插件化机制，存在锁机制复杂影响并发的问题，而postgresql不存在。

​    

**二、MySQL相对于PostgreSQL的优势：**

1、innodb的基于回滚段实现的MVCC机制，相对PG新老数据一起存放的基于XID的MVCC机制，是占优的。新老数据一起存放，需要定时触发VACUUM，会带来多余的IO和数据库对象加锁开销，引起数据库整体的并发能力下降。而且VACUUM清理不及时，还可能会引发数据膨胀；

2、MySQL采用索引组织表，这种存储方式非常适合基于主键匹配的查询、删改操作，但是对表结构设计存在约束；

3、MySQL的优化器较简单，系统表、运算符、数据类型的实现都很精简，非常适合简单的查询操作；

4、MySQL分区表的实现要优于PG的基于继承表的分区实现，主要体现在分区个数达到上千上万后的处理性能差异较大。

5、MySQL的存储引擎插件化机制，使得它的应用场景更加广泛，比如除了innodb适合事务处理场景外，myisam适合静态数据的查询场景。

​    

**三、结论**

总的来说，开源数据库都还不是很完善，和这两者相比，商业数据库oracle无论在架构还是功能方面都要完善很多。

postgresql和mysql相比，postgresql更加适合严格的企业应用场景（比如金融、电信、ERP、CRM），而MySQL则是更加适合业务逻辑相对简单、对数据可靠性要求比较低的互联网场景（比如google、facebook、alibaba）。



## 设计范式

1.每个字段不可再分



## 查询

### 分类

#### 即席查询

ad_hoc，也叫即时查询，执行完查询语句后要求在尽可能短的时间内返回查询结果。



## 事务

### 事务4大特性

ACID，即原子性，一致性，隔离性，持久性。

**A：Atomicity**

原子性。事务包含的一系列操作要么全部成功，要么全部回滚，不存在部分成功或者部分回滚，是一个不可分割的操作整体。。

**C：Consistency**

一致性。事务发生前后，应当始终遵循数据完整性约束并确保数据的完整性和合法性。

这里的约束包括：主键约束、唯一索引约束、外键约束，非空约束等等。拿转账举例：张三和李四加起来总共有1000块钱，不管张三和李四如何转账，转几次账，加起来的钱永远都是1000块。

**I：lsolation**

隔离性。当多个事务并发执行时，比如操作同一张表，数据库要保证每个事务相互隔离，彼此独立。当前事务不能被其他的事务所干扰或者影响。

**D：Durability**

持久性也叫永久性。事务一旦提交之后，其对数据库中的改变是永久的。即使在数据库发生故障时，也不会丢失事务已提交的数据。



### 事务并发问题

#### 脏读

读到另一个事务还未提交的数据。

#### 不可重复读

在一个事务中进行2次查询，由于其他事务发生update操作。导致某些记录2次查询结果不一致。

#### 幻读

一个事务在多次执行过程中，由于其他事务发生了新增或删除操作。导致当前事务对范围数据的预期出现偏差。仿佛出现幻觉。

例如：相同的查询执行2次，第1次是100条数据，第2次确是101条数据。

执行一个update，本来想update整张表的，结果发现执行完了有一条数据没被更新。那是因为执行过程中有人在新增数据。

执行delete删除一定范围内的数据，执行完发现还有数据存在。



### 事务隔离级别

**READ UNCOMMITTED**

未提交读。允许：幻读，不可重复读，脏读。一般不会使用这个隔离级别。

**READ COMMITTED（RC）**

已提交读。允许：幻读，不可重复读；不允许：脏读。要求解决脏读；

**REPEATABLE READ（RR）**

可重复读。允许：幻读；不允许不可重复读和脏读，要求解决不可重复读；

**SERIALIZABLE**

序列化。此时：幻读，不可重复读，脏读都不允许，要求解决幻读。

| 问题/隔离级别 | 脏读 | 不可重复读 | 幻读       |
| ------------- | ---- | ---------- | ---------- |
| 未提交读      | 可能 | 可能       | 可能       |
| 已提交读      | 不能 | 可能       | 可能       |
| 可重复读      | 不能 | 不能       | innodb不能 |
| 序列化        | 不能 | 不能       | 不能       |







# MySQL

## 参考说明

本文内容来源于个人实践以及工作经验总结，还有部分参考了以下内容。

- 马士兵教育视频教程及配套笔记（[MySQL实战调优-连鹏举](https://www.mashibing.com/study?courseNo=392&sectionNo=2801&courseVersionId=1297)）
- w3schools，https://www.w3schools.cn/mysql/mysql_ref_functions.html。
- [超详细MySQL高性能优化实战总结](https://zhuanlan.zhihu.com/p/46647057)



## 简介

MySQL数据库最初是由瑞典MySQL AB公司开发，2008年1月16号被Sun公司收购。2009年，SUN又被Oracle收购。MySQL是目前IT行业最流行的开放源代码的数据库管理系统，同时它也是一个支持多线程高并发多用户的关系型数据库管理系统。MySQL之所以受到业界人士的青睐，主要是因为其具有以下几方面优点：
1. 开放源代码
MySQL最强大的优势之一在于它是一个开放源代码的数据库管理系统。开源的特点是给予了用户根据自己需要修改DBMS的自由。MySQL采用了General Public License，这意味着授予用户阅读、修改和优化源代码的权利，这样即使是免费版的MySQL的功能也足够强大，这也是为什么MySQL越来越受欢迎的主要原因。
2. 跨平台
MySQL可以在不同的操作系统下运行，简单地说，MySQL可以支持Windows系统、UNIX系统、Linux系统等多种操作系统平台。这意味着在一个操作系统中实现的应用程序可以很方便地移植到其他的操作系统下。
3. 轻量级
MySQL的核心程序完全采用多线程编程，这些线程都是轻量级的进程，它在灵活地为用户提供服务的同时，又不会占用过多的系统资源。因此MySQL能够更快速、高效的处理数据。
4. 成本低
MySQL分为社区版和企业版，社区版是完全免费的，而企业版是收费的。即使在开发中需要用到一些付费的附加功能，价格相对于昂贵的Oracle、DB2等也是有很大优势的。其实免费的社区版也支持多种数据类型和正规的SQL查询语言，能够对数据进行各种查询、增加、删除、修改等操作，所以一般情况下社区版就可以满足开发需求了，而对数据库可靠性要求比较高的企业可以选择企业版。
另外，PHP中提供了一整套的MySQL函数，对MySQL进行了全方位的强力支持。 
总体来说，MySQL是一款开源的、免费的、轻量级的关系型数据库，其具有体积小、速度快、成本低、开放源码等优点，其发展前景是无可限量的。 

PS：社区版与企业版主要的区别是：
1. 社区版包含所有MySQL的最新功能，而企业版只包含稳定之后的功能。换句话说，社区版可以理解为是企业版的测试版。 
2.MySQL官方的支持服务只是针对企业版，如果用户在使用社区版时出现了问题，MySQL官方是不负责任的。  



## 安装卸载

### 宝塔安装

宝塔版本：8.0.3

已经在Linux中安装好宝塔的，可以通过宝塔的功能自动安装MySQL。

1. 在左侧的菜单栏中选择数据库，添加数据库服务器，然后选择你想安装的数据库版本（例如：8.0.24）
2. 选极速安装，大概等待10分钟就全自动安装好了。（实际等待时间可能因为网速不同而不同）
3. 安装成功之后，在MySQL的页签下，点“root密码”按钮，然后修改root密码。（默认的密码是自动生成，比较难记）

4. 数据库安装好以后，用户默认都是不能通过外网访问的。可以参考下文[修改root用户的外网访问权限](#用户外网访问权限)。




### 用户外部访问权限

安装好MySQL以后，默认用户是不能通过外部访问的。

如果连接会报错：`message from server: "Host 'dell-xxxx' is not allowed to connect to this MySQL server`

这时候可以按照如下步骤开通指定用户的外网访问权限，以下以root用户举例：

1. 在MySQL服务器本地输入命令：`mysql -u root -p`
2. 然后输入root用户的密码。登录后切换到mysql数据库：`use mysql`
3. 让所有ip都可以访问：`update user set host = '%' where user = 'root';`
4. 刷新权限用户权限：`flush privileges;`
5. 此时再用客户端就应该可以了。例如：navicat、dbeaver



### windows安装-msi

【1】MySQL的版本：
近期主要历史版本有5.0/5.1/5.5/5.6/5.7，目前最新版本是MySQL8。6.0曾经是个内部试验版本，已取消了。

MySQL8.0的版本历史
1) 2016-09-12第一个DM(development milestone)版本8.0.0发布
2) 2018-04-19第一个GA(General Availability)版本开始，8.0.11发布
3) 2018-07-27 8.0.12GA发布
4) 2018-10-22 8.0.13GA发布
5) 2019-01-21 8.0.14GA发布
6) 2019-02-01 8.0.15GA发布
7) 最新的版本是8.0.18,2019年10月14日正式发布
8) ....后续更新

【2】官方下载地址：
https://dev.mysql.com/downloads/windows/installer/8.0.html

![image-20231110154549382](学习笔记-数据库-Gem.assets/image-20231110154549382.png)

【3】安装过程：
1.双击MySQL安装文件mysql-installer-community-8.0.18.0.msi，出现安装类型选项。
² Developer Default：开发者默认

² Server only：只安装服务器端 

² Client only：只安装客户端

² Full：安装全部选项

² Custom：自定义安装

![image-20231110154607546](学习笔记-数据库-Gem.assets/image-20231110154607546.png)

2.选择，然后继续：

![image-20231110154619191](学习笔记-数据库-Gem.assets/image-20231110154619191.png)

3.进入产品配置向导，配置多个安装细节，点击Next按钮即可。

![image-20231110154631949](学习笔记-数据库-Gem.assets/image-20231110154631949.png)

4.高可靠性High Availability，采用默认选项即可。
² Standalone MySQL Server/Classic MySQL Replication:独立MySQL服务器/经典MySQL复制

² InnoDB Cluster:InnoDB集群

![image-20231110154645563](学习笔记-数据库-Gem.assets/image-20231110154645563.png)

5.类型和网络 Type and Networking，采用默认选项即可。记住MySQL的监听端口默认是3306。

![image-20231110154658400](学习笔记-数据库-Gem.assets/image-20231110154658400.png)

6.身份验证方法Authentication Method，采用默认选项即可。

 ![image-20231110154709204](学习笔记-数据库-Gem.assets/image-20231110154709204.png)

7.账户和角色 Accounts and Roles。MySQL管理员账户名称是root，在此处指定root用户的密码。还可以在此处通过Add User按钮添加其他新账户，此处省略该操作。

![image-20231110154717771](学习笔记-数据库-Gem.assets/image-20231110154717771.png)

8.Windows服务：Windows Service。
² Configure MySQL Server as a Windows Service:给MySQL服务器配置一个服务项。

² Windows Service Name:服务名称，采用默认名称MySQL80即可。

² Start the MySQL at System Startup：系统启动时开启MySQL服务

![image-20231110154736435](学习笔记-数据库-Gem.assets/image-20231110154736435.png)



 9.Apply Configuration：点击Execute按钮执行开始应用这些配置项。
² Writing configuration file: 写配置文件。

² Updating Windows Firewall rules：更新Windows防火墙规则

² Adjusting Windows services：调整Windows服务

² Initializing database：初始化数据库

² Starting the server： 启动服务器

² Applying security setting：应用安全设置

² Updating the Start menu link：更新开始菜单快捷方式链接

![image-20231110154756078](学习笔记-数据库-Gem.assets/image-20231110154756078.png)

PS：如果配置出错，查看右侧的log，查看对应错误信息。
执行完成后，如下图所示。单击Finish完成安装，进入产品配置环节。

![image-20231110154808773](学习笔记-数据库-Gem.assets/image-20231110154808773.png)

10.产品配置Product Configuration到此结束：点击Next按钮。

![image-20231110154817783](学习笔记-数据库-Gem.assets/image-20231110154817783.png)

11.安装完成 Installation Complete。点击Finish按钮完成安装。

![image-20231110154830915](学习笔记-数据库-Gem.assets/image-20231110154830915.png)

#### 安装确认

1)安装了Windows Service：MySQL80，并且已经启动。

![image-20231110154449912](学习笔记-数据库-Gem.assets/image-20231110154449912.png)

2)安装了MySQL软件。安装位置为：C:\Program Files\MySQL。

（MySQL文件下放的是软件的内容）
3)安装了MySQL数据文件夹，用来存放MySQL基础数据和以后新增的数据。安装位置为C:\ProgramData\MySQL\MySQL Server 8.0。

（ProgramData文件夹可能是隐藏的，显示出来即可）
（MySQL文件下的内容才是真正的MySQL中数据）
4)在MySQL数据文件夹中有MySQL的配置文件：my.ini。它是MySQL数据库中使用的配置文件，修改这个文件可以达到更新配置的目的。以下几个配置项需要大家特别理解。
² port=3306：监听端口是3306

² basedir="C:/Program Files/MySQL/MySQL Server 8.0/"：软件安装位置

² datadir=C:/ProgramData/MySQL/MySQL Server 8.0/Data：数据文件夹位置

² default_authentication_plugin=caching_sha2_password：默认验证插件

² default-storage-engine=INNODB：默认存储引擎

（这些内容在Linux下可能会手动更改）



#### 卸载

【1】卸载数据库

1)停止MySQL服务：在命令行模式下执行net stop mysql或者在Windows服务窗口下停止服务

2)在控制面板中删除MySQL软件

3)删除软件文件夹：直接删除安装文件夹C:\Program Files\MySQL，其实此时该文件夹已经被删除或者剩下一个空文件夹。

4)删除数据文件夹：直接删除文件夹C:\ProgramData\MySQL。此步不要忘记，否则会影响MySQL的再次安装。
（ProgramData文件夹可能是隐藏的，显示出来即可）
（MySQL文件下的内容才是真正的MySQL中数据）

5)删除path环境变量中关于MySQL安装路径的配置



### Windows安装-zip

以下安装步骤，已在5.7.33的zip版本中验证过。

#### zip安装包下载

1. 从官网下载zip安装包 ，[官网5.7版本zip安装包下载](https://dev.mysql.com/downloads/mysql/5.7.html)，64位系统选择“Windows (x86, 64-bit), ZIP Archive”。

2. 下载下来之后，解压缩到一个安装目录中，例如：D:\ProgramFiles\Database\mysql-5.7.33-winx64。

3. 在安装目录中新建文件my.ini，文件内容参考如下：

4. ```ini
   [mysql]
   # 设置mysql客户端默认字符集
   default-character-set=utf8
   
   [mysqld]
   #设置3306端口
   port = 3306
   
   # 设置mysql的安装目录（！！！请根据实际情况修改）
   basedir=D:\\ProgramFiles\\Database\\mysql-5.7.33-winx64
   # 设置mysql数据库的数据的存放目录（！！！请根据实际情况修改）
   datadir=D:\\ProgramFiles\\Database\\mysql-5.7.33-winx64\\data
   
   # 当数据被更新时是否默认更新timestamp的值为当前日期,off为不更新
   explicit_defaults_for_timestamp=off
   
   # 允许最大连接数
   max_connections=100
   # 服务端使用的字符集默认为UTF8
   character-set-server=utf8
   # 创建新表时将使用的默认存储引擎
   default-storage-engine=INNODB
   ```

5. 然后进入命令提示符（管理员）。注意：必须是管理员，否则可能出问题。

6. 依次执行如下三个命令

7. 初始化命令：mysqld --initialize --console

8. 注意：执行成功后root密码会显示在下方，请记住，后面登录时会用到。

9. > [Note] A temporary password is generated for root@localhost: XXXXXX

10. 安装命令：mysqld install

11. 启动服务：net start mysql

    1. 如果不希望MySQL的服务和电脑一起启动，可以去修改下启动类型。

12. 登录：mysql -u root -p

13. 输入上面步骤生成的root密码

14. 登录成功后，修改root用户密码。

    1. `ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';`



##### 安装问题解决

1. 如果执行SQL报如下错误。

   > [Err] 1055 - Expression #1 of ORDER BY clause is not in GROUP BY clause  and contains nonaggregated column 'information_schema.PROFILING.SEQ'  which is not functionally dependent on columns in GROUP BY clause; this  is incompatible with sql_mode=only_full_group_by

   原因：

   MySQL 5.7.5及以上功能依赖检测功能。如果启用了ONLY_FULL_GROUP_BY  SQL模式（默认情况下），MySQL将拒绝选择列表，HAVING条件或ORDER BY列表的查询引用在GROUP  BY子句中既未命名的非集合列，也不在功能上依赖于它们。（5.7.5之前，MySQL没有检测到功能依赖关系，默认情况下不启用ONLY_FULL_GROUP_BY。有关5.7.5之前的行为的说明，请参见“MySQL 5.6参考手册”。）

   解决方案。执行下面的SQL；

   ```sql
   -- 当前session变量生效
   SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
   -- 全局变量生效
   SET global sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
   ```

   



## 体系特性

### 执行流程

#### 查询流程

##### 流程图

```mermaid
---
title: MySQL查询流程图
---
flowchart LR
subgraph server["服务层"]
	direction TB
	1["连接器<br>管理连接<br>和权限"]-->2
    2["查询缓存<br/>（cache）"]-->3
    3["解析器<br/>（parser）<br>语法解析"]-->|解析树|4
    4["预处理器<br/>（preprocessor）<br>语义解析"]-->5
    5["优化器<br/>（optimizer）"]-->|执行计划|6
    6["执行引擎<br>调用接口<br>执行SQL"]
end
subgraph storage["存储引擎"]
    direction LR
    7["Innodb<br>MyISAM<br>......"]-->8[数据]
end
2-.->0
0[客户端<br>client]-->|"SQL"|1
6-.->|"如功能启用，则缓存结果"|2
6-->|"结果"|0
6-->7
7-->6

```

##### 连接层

连接器负责跟客户端建立连接、获取权限、维持和管理连接。

主要负责用户登录数据库，进行用户的身份认证，包括校验账户密码，权限等操作，如果用户账户密码已通过，连接器会到权限表中查询该用户的所有权限，之后在这个连接里的权限逻辑判断都是会依赖此时读取到的权限数据，也就是说，后续只要这个连接不断开，即时管理员修改了该用户的权限，该用户也是不受影响的。

客户端的sql通过3306端口传给MySQL建立连接，每一个连接MySQL都会建立一个线程来处理。5.7版本默认最大连接数是151，可以最大修改为100000。超过一定时间不活动，MySQL也会自动断开，默认是8小时。



##### 查询缓存

这个功能在MySQL5.7中默认关闭了。比较鸡肋。很多场景都会导致缓存失效。MySQL在8.0版本中已经放弃了已移除

查询缓存主要用来缓存我们所执行的 SELECT 语句以及该语句的结果集。

连接建立后，执行查询语句的时候，会先查询缓存，MySQL 会先校验这个 sql 是否执行过，以 Key-Value 的形式缓存在内存中，Key 是查询预计，Value 是结果集。如果缓存 key  被命中，就会直接返回给客户端，如果没有命中，就会执行后续的操作，完成后也会把结果缓存起来，方便下一次调用。**当然在真正执行缓存查询的时候还是会校验用户的权限，是否有该表的查询条件**。



##### 解析器parser

主要负责SQL语句的词法和语法解析。

词法解析负责将SQL语句拆分成一个个单词，检查每一个词是否正确。

语法解析负责将SQL是否符合MySQL定义的语法规则。最终会生成一个解析树。如下图。

![image-20210321163618821](../gupao/咕泡Java笔记.assets/image-20210321163618821.png)

##### 预处理器

负责语义解析。例如：如果语法解析都没有问题，但是解析出来的表或字段不存在在这里报错。

##### 优化器（Optimizer）

一个SQL语句可以有很多种执行路径。优化器会根据一系列规则选择一条成本最小的执行路径。

子查询优化

等价谓词重写

条件化简

外连接消除

嵌套连接消除

连接的消除

语义优化

非SPJ优化

##### 执行引擎

根据执行计划，调用存储引擎的接口获取数据。

##### 存储引擎

[MySQL官方存储引擎说明](https://dev.mysql.com/doc/refman/5.7/en/storage-engines.html)

MySQL有很多存储引擎，不同的存储引擎，读写方式是不同的。存储引擎负责给服务器提供内存或者硬盘的数据的访问接口

InnoDB

默认的存储引擎，支持事务、外键、行锁、索引。

MyISAM

不支持事务和聚集索引。只支持表锁。查询和新增比较快。表里记录了总行数。不像InnoDB要扫表才知道总行数

Memory

所有的数据都是在内存中读写，优点是速度快，缺点是无法持久化，一旦宕机数据会全部丢失。

使用场景，建议是用来做缓存或者是存临时数据。

CSV

一种文本格式。可以用Excel打开。使用场景：不同的数据库中同步数据。

archive。

用于存储归档数据。无索引。



##### InnoDB和MyISAM 的区别

1. InnoDB 支持事务，MyISAM 不支持事务。这是MySQL将默认存储引擎从MyISAM变成 InnoDB 的重要原因之一；

2. InnoDB 支持外键，而 MyISAM 不支持。对一个包含外键的 InnoDB 表转为 MYISAM 会失败；  

3. InnoDB 是聚集索引，MyISAM 是非聚集索引。聚簇索引的文件存放在主键索引的叶子节点上，因此 InnoDB 必须要有主键，通过主键索引效率很高。但是辅助索引需要两次查询，先查询到主键，然后再通过主键查询到数据。因此，主键不应该过大，因为主键太大，其他索引也都会很大。而 MyISAM 是非聚集索引，数据文件是分离的，索引保存的是数据文件的指针。主键索引和辅助索引是独立的。 
4. 5.6之前Innodb不支持全文索引，

4. InnoDB 不保存表的具体行数，执行 select count(*) from table 时需要全表扫描。而MyISAM 用一个变量保存了整个表的行数，执行上述语句时只需要读出该变量即可，速度很快；    

5. InnoDB 最小的锁粒度是行锁，MyISAM 最小的锁粒度是表锁。一个更新语句会锁住整张表，导致其他查询和更新都会被阻塞，因此并发访问受限。这也是 MySQL 将默认存储引擎从 MyISAM 变成 InnoDB 的重要原因之一；
6. 清空表时，Innodb是一行行删除，MyISAM会整表删除然后重建。

**如何选择：**

1. 是否要支持事务，如果要请选择 InnoDB，如果不需要可以考虑 MyISAM；

2. 如果表中绝大多数都只是读查询，可以考虑 MyISAM，如果既有读，写也挺频繁，请使用InnoDB。

3. 系统奔溃后，MyISAM恢复起来更困难，能否接受，不能接受就选 InnoDB；

4. MySQL5.5版本开始Innodb已经成为Mysql的默认引擎(之前是MyISAM)，说明其优势是有目共睹的。如果你不知道用什么存储引擎，那就用InnoDB，至少不会差。







#### 更新流程

这里的更新指：update、insert、delete。

基本流程同查询，区别在于执行引擎通过查询拿到要更新的数据之后。

1. 事务开始。

2. 将从磁盘中取到要更新的数据页放入BufferPool。

3. 执行器执行数据修改。（在执行器内部）

4. 记录修改前的数据到undo log

5. 记录修改后的数据到redo log，标记状态为prepared

6. 调用存储引擎接口，将数据更新记录到Buffer Pool中

7. 如果bin log开关开启，记录bin log

8. 提交事务

9. 将redolog中的记录状态改成已提交。



### InnoDB

#### 架构图

![image-20210519222558422](学习笔记-数据库-Gem.assets/image-20210519222558422.png)

#### 内存结构

##### Buffer Pool

Buffer Pool缓存的是页面信息，包括数据页、索引页。

Buffer Pool默认大小是128M (134217728字节)，可以调整。

查看系统变量：`SHOW VARIABLES like '%innodb_buffer_pool%';`

查看服务器状态，里面有很多跟Buffer Pool相关的信息：`SHOW STATUS LIKE '%innodb_buffer_pool%';`

这些参数都可以在官网查到详细的含义，用搜索功能。https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html



##### Change Buffer

Change Buffer是 Buffer Pool的一部分。

如果要更新的这个数据页不是唯一索引列，不存在数据重复的情况，也就不需要从磁盘加载索引页判断数据是不是重复（唯一性检查)。这种情况下可以先把修改记录在内存的缓冲池中，从而提升更新语句(Insert、Delete、Update)的执行速度。

这一块区域就是Change Buffer。5.5之前叫Insert Buffer插入缓冲，现在也能支持delete和update。

最后把Change Buffer记录到数据页的操作叫做 merge。什么时候发生merge?有几种情况:在访问这个数据页的时候，或者通过后台线程、或者数据库shut down、redo log 写满时触发。

如果数据库大部分索引都是非唯一索引，并且业务是写多读少，不会在写数据后立刻读取，就可以使用Change Buffer (写缓冲)。
可以通过调大这个值，来扩大Change的大小，以支持写多读少的业务场景。



##### Adaptive Hash Index

**用来解决什么问题？**

随着MySQL单表数据量增大。B+树的层数也会越来越大(虽然B+树算法很好的控制了层数)。

检索某个数据页需要沿着B+树逐层往下找，所以检索时间也会延长。

为了解决这个问题，MySQL就相出了一种缓存结构，根据某个条件跳过逐层查找直接找到数据页。这个缓存结构就是AHI。

**建立条件**

AHI本质就是哈希表。但不能太大也不能太小。太大了维护成本上升大于产生的收益。太小了命中率低根本没有收益。

MySQL自动根据条件建立一个不大不小刚刚好的哈希表，这个过程就是自适应（Adaptive），条件如下：

1. 某个索引树要被使用足够多次（17次）

2. 该索引树上的某个检索条件要被经常使用

   - 检索条件与索引匹配的列数
   - 第一个不匹配的列中，两者匹配的字节数
   - 匹配的方向是否从左往右进行

   我们通过一个例子来简要介绍 hash info 中第一项。假设一张表 table1，其索引是(A1, A2)两列构成的索引：

   - 如果检索条件是(A1=1 and A2=1)，那么此次检索使用了该索引的最左两列，hash info 就是(2,0,true)
   - 如果检索条件是(A1=1), 那么此次检索使用了该索引的最左一列，hash info 就是(1,0,true)

3. 该索引树上的某个数据页要被经常使用

   如果我们为表中所有数据建立 AHI，那 AHI  就失去了缓存的意义：内存已不足以存放其身躯，必然要放到磁盘上，那么其成本显然已经不低于收益。回忆一下，AHI 是为了缩短 B+  树的查询成本设计的，如果把自己再放到磁盘上，就得变成另一颗 B+ 树（B+ 树算法是处理磁盘查询的高效结构），如此循环往复，呜呼哀哉。

   因此我们只能为表中经常被查询的部分数据建立 AHI。所以关卡 3 的任务就是找出哪些数据页是经常被使用的数据页。

   https://zhuanlan.zhihu.com/p/106941474



##### (Redo) log buffer

Redo log 也不是每一次都直接写入磁盘,在Buffer Pool里面有一块内存区域(Log Buffer)专门用来保存即将要写入日志文件的数据，默认16M，它一样可以节省磁盘IO。

需要注意:redo log 的内容主要是用于崩溃恢复。磁盘的数据文件，数据来自buffer pool。redo log写入磁盘，不是写入数据文件。
那么，Log Buffer什么时候写入log file?

在我们写入数据到磁盘的时候，操作系统本身是有缓存的。flush就是把操作系统缓冲区写入到磁盘。
log buffer写入磁盘的时机，由一个参数控制，默认是1。

![image-20210520113607203](学习笔记-数据库-Gem.assets/image-20210520113607203.png)



##### LRU

缓冲池满了的处理

会采用LRU算法淘汰非热点数据。MySQL在原来的基础上做了冷热分离。新数据包含预读的和普通读的第一次加载时先放到冷区head。放到LRU List之后再次被访问到的。就会放到热区中。热区的数据长时间没被访问，会被先移动到冷区head。

预读机制

线性预读，随机预读。将可能用到的数据提前加载到内存中。提升IO性能。



#### 行格式

在 innodb 引擎中数据是以页为基本单位读取的，而一个页中又包含多个行数据，那么对应地就会有不同的行格式来存储数据，innodb  中的行格式有四种：compact、redundant、dynamic、compressed。redundant 是 5.0  之前用的行格式。

默认行格式由innodb_default_row_format定义，其默认值为DYNAMIC。 如果未明确定义ROW_FORMAT表选项或指定了ROW_FORMAT = DEFAULT，则使用默认行格式。

```sql
-- 创建数据表时,显示指定行格式
CREATE TABLE 表名 (列的信息) ROW_FORMAT=行格式名称;
-- 创建数据表时,修改行格式
ALTER TABLE 表名 ROW_FORMAT=行格式名称;
-- 查看某数据表的行格式
show table status from 数据库名 like '<数据表名>';
```

原文链接：https://cloud.tencent.com/developer/article/2194819



### 日志

#### Undo Log

undo log(撤销日志或回滚日志)记录了事务发生之前的数据状态,分为insert undolog和update undo log。如果修改数据时出现异常,可以用undo log来实现回滚操作(保持原子性)。

可以理解为undo log记录的是反向的操作，比如insert 会记录 delete，update会记录update 原来的值，跟redolog记录在哪个物理页面做了什么操作不同，所以叫做逻辑格式的日志。

`show global variables like '%undo%';`



#### Redo Log

思考一个问题：因为刷脏不是实时的，如果Buffer Pool里面的脏页还没有刷入磁盘时，数据库宕机或者重启，这些数据就会丢失。
所以内存的数据必须要有一个持久化的措施。

为了避免这个问题，InnoDB把所有对页面的修改操作专门写入一个日志文件。如果有未同步到磁盘的数据，数据库在启动的时候，会从这个日志文件进行恢复操作(实现crash-safe)。我们说的事务的ACID里面D(持久性)，就是用它来实现的。

这个日志文件就是磁盘的redo log (叫做重做日志)。

同样是写磁盘，为什么不直接写到db file里面去？为什么先写日志再写磁盘？
写日志文件和和写到数据文件有什么区别?
先说一下磁盘寻址的过程。这个是磁盘的构造。磁盘的盘片不停地旋转，磁头会在磁盘表面画出一个圆形轨迹，这个就叫磁道。从内到位半径不同有很多磁道。然后又用半径线，把磁道分割成了扇区(两根射线之内的扇区组成扇面)。如果要读写数据，必须找到数据对应的扇区，这个过程就叫寻址。

![image-20210519221746128](学习笔记-数据库-Gem.assets/image-20210519221746128.png)

如果我们所需要的数据是随机分散在磁盘上不同页的不同扇区中，那么找到相应的数据需要等到磁臂旋转到指定的页，然后盘片寻找到对应的扇区，才能找到我们所需要的一块数据，一次进行此过程直到找完所有数据,这个就是随机I/O,读取数据速度较慢。

假设我们已经找到了第一块数据，并且其他所需的数据就在这一块数据后边， 那么就不需要重新寻址，可以依次拿到我们所需的数据，这个就叫顺序I/O。

刷盘是随机I/O，而记录日志是顺序1/O (连续写的)，顺序I/O效率更高，本质上是数据集中存储和分散存储的区别。因此先把修改写入日志文件，在保证了内存数据的安全性的情况下，可以延迟刷盘时机，进而提升系统吞吐。

redo log位于/var/ib/mysql/目录下的ib_logfile0 和ib_logfile1，默认2个文件，每个48M。

这个redo log有什么特点?

1、redo log是InnoDB存储引擎实现的，并不是所有存储引擎都有。支持崩溃恢复是InnoDB的一个特性。

2、redo log 不是记录数据页更新之后的状态，而是记录的是“在某个数据页上做了什么修改”。属于物理日志。

3、redo log的大小是固定的,前面的内容会被覆盖,一旦写满,就会触发buffer pool到磁盘的同步，以便腾出空间记录后面的修改。
除了redo log之外,还有一个跟修改有关的日志,叫做undo log.redo log和undolog 与事务密切相关，统称为事务日志。



#### Bin Log

Bin log 以事件的形式记录了系统中所有的DDL语句和DML语句（记录的是操作而不是数据值，属于逻辑日志），可以用来做主从复制和数据恢复。

它的文件内容没有固定内容限制，可以无限追加。

如果开启了bin log功能，就可以导出成sql语句。把所有操作重放一遍。实现数据恢复。



### 索引

#### 介绍

索引是DBMS中一个排序的数据结构。用于协助快速查询和更新数据库中的数据。



#### 索引分类

普通索引，唯一索引，全文索引

##### 唯一索引

唯一索引要求键值不能重复。另外需要注意的是，主键索引是一种特殊的唯一索引，它还多了一个限制条件，要求键值不能为空。主键索引用primay key创建。

##### 全文索引

针对比较大的数据，比如我们存放的是消息内容、一篇文章，有几KB的数据的这种情况，如果要解决like查询在全文匹配的时候效率低的问题，可以创建全文索引。只有文本类型的字段才可以创建全文索引，比如char、varchar、text。

MylSAM和InnoDB支持全文索引。

```sql
CREATE TABLE `fulltext_test`(
`content` varchar(50)DEFAULT NULL,
FULLTEXT KEY `content` (`content`)
);

select * from fulltext_test where match(content) against('咕泡学院' IN NATURAL LANGUAGE MODE);
```





##### 聚集索引和非聚集索引

###### 聚集索引

一般是指在非空且唯一的字段上建立的索引，通常是主键、一个表只能有一个聚集索引。

如果不存在主键，就自动选择唯一索引不为空的字段作为聚集索引。

如果还不存在，Mysql会自动生成一个隐藏的字段用于标记每一行数据，作为聚集索引。

###### 非聚集索引

是指普通的索引，非主键索引。

###### 两者的关联

（1）聚集索引属于一级索引，非聚集索引为二级索引

（2）聚集索引查询不需要回表，非聚集索引查询时首先找到主键值，然后再到一级索引查询，可能需要回表。



#### 索引结构

Hash和B+树。

##### Hash索引

HASH:以KV的形式检索数据，也就是说，它会根据索引字段生成哈希码和指针，指针指向数据。

哈希索引有什么特点呢?

第一个，它的时间复杂度是O(1)，查询速度比较快。因为哈希索引里面的数据不是按顺序存储的，所以不能用于排序。

第二个，我们在查询数据的时候要根据键值计算哈希码，所以它只能支持等值查询(= lN)，不支持范围查询(><>= <= between and) 。

另外一个就是如果字段重复值很多的时候，会出现大量的哈希冲突（采用拉链法解决)，效率会降低。



##### B+树索引

##### 使用B+树优势

[mysql 使用B+树索引有哪些优势](https://blog.csdn.net/weixin_31186111/article/details/113589684)

MySQL中的B+Tree有几个特点:

1、关键字的数量是跟路数相等

2、B+Tree的根节点和枝节点中都不会存储数据，只有叶子节点才存储数据。是完整记录的地址。

3、B+Tree的每个叶子节点增加了一个指向相邻叶子节点的指针，它的最后一个数据会指向下一个叶子节点的第一个数据，形成了一个有序链表的结构。

因为特性带来的优势:

1)它是B Tree 的变种，BTree 能解决的问题，它都能解决。B Tree解决的两大问题是什么?(每个节点存储更多关键字;路数更多)

2)扫库、扫表能力更强(如果我们要对表进行全表扫描，只需要遍历叶子节点就可以了，不需要遍历整棵B+Tree拿到所有的数据)

3)B+Tree的磁盘读写能力相对于BTree来说更强(根节点和枝节点不保存数据区，所以一个节点可以保存更多的关键字，一次磁盘加载的关键字更多)

4)排序能力更强（因为叶子节点上有下一个数据区的指针，数据形成了链表)5)效率更加稳定(B+Tree永远是在叶子节点拿到数据，所以IO次数是稳定的)



#### 索引创建原则

##### 离散度高

有个公式count(distinct(column_name))/count(*)，列的全部不同值和所有数据行的比例。数据行数相同的情况下，分子越大，列的离散度就越高。

简单来说，如果列的重复值越多，离散度就越低，重复值越少，离散度就越高。不建议在离散度低的字段上建立索引。

##### 查询条件

在用于where判断、order排序和join的(on) 、group by的字段上创建索引

##### 索引个数

索引并不是越多越好，会影响更新效率而且浪费空间。优先考虑联合索引并且尽量将离散度高的列放在最前面

##### 更新频率

不要给频繁更新的字段建立索引。会有页分裂问题。

##### 有序性

不建议给随机无序的字段建立索引。例如：UUID。



#### 索引使用原则

##### 联合索引最左匹配

当多个条件经常组合查询时会考虑建立联合索引，联合索引遵循最左匹配原则。例如：如有有联合索引a，b，c，其实等价于3个索引。

a，ab，abc。如果此时查询条件中只出现a，那就只能用到a索引。如果没有a的话就用不到索引。所以建立联合索引的时候尽量把最常用的查询条件放在前面。

值得注意的是，当遇到范围查询(>、<、between、like)就会停止匹配



##### 覆盖索引

回表:

非主键索引，先通过索引找到主键索引的键值，再通过主键值查出索引里面没有的数据，它比基于主键索引的查询多扫描了一棵索引树，这个过程就叫回表。

在二级索引里面，不管是单列索引还是联合索引，如果select的数据列只用从索引中就能够取得，不必从回表获取，这时候使用的索引就叫做覆盖索引，这样就避免了回表。

例如：组合索引a，b，但是select后面还有c字段。就需要回表了。



##### 索引下推

索引下推（index condition pushdown ）简称ICP，在Mysql5.6的版本上推出，用于优化查询

为啥要用？

在不使用ICP的情况下，在使用非主键索引（又叫普通索引或者二级索引）进行查询时，存储引擎通过索引检索到数据，然后返回给MySQL服务器，服务器然后判断数据是否符合条件 。

在使用ICP的情况下，如果存在某些被索引的列的判断条件时，MySQL服务器将这一部分判断条件传递给存储引擎，然后由存储引擎通过判断索引是否符合MySQL服务器传递的条件，只有当索引符合条件时才会将数据检索出来返回给MySQL服务器 。

索引条件下推优化可以减少存储引擎查询基础表的次数，也可以减少MySQL服务器从存储引擎接收数据的次数。 

举例说明：

- 在开始之前先先准备一张用户表(user)，其中主要几个字段有：id、name、age、address。建立联合索引（name，age）。
- 假设有一个需求，要求匹配姓名第一个为陈的所有用户，sql语句如下：

```sql
SELECT * from user where  name like '陈%'
```

- 根据 "最佳左前缀" 的原则，这里使用了联合索引（name，age）进行了查询，性能要比全表扫描肯定要高。
- 问题来了，如果有其他的条件呢？假设又有一个需求，要求匹配姓名第一个字为陈，年龄为20岁的用户，此时的sql语句如下：

```sql
SELECT * from user where  name like '陈%' and age=20
```

- 这条sql语句应该如何执行呢？下面对Mysql5.6之前版本和之后版本进行分析。

###### Mysql5.6之前的版本

- 5.6之前的版本是没有索引下推这个优化的，因此执行的过程如下图：



![img](学习笔记-数据库-Gem.assets/v2-04b4a496ab53eccc5feba150bf9fb7ea_720w.jpg)





- 会忽略age这个字段，直接通过name进行查询，在(name,age)这课树上查找到了两个结果，id分别为2,1，然后拿着取到的id值一次次的回表查询，因此这个过程需要**回表两次**。



###### Mysql5.6及之后版本

- 5.6版本添加了索引下推这个优化，执行的过程如下图：



![img](学习笔记-数据库-Gem.assets/v2-211aaba883221c81d5d7578783a80764_720w.jpg)



- InnoDB并没有忽略age这个字段，而是在索引内部就判断了age是否等于20，对于不等于20的记录直接跳过，因此在(name,age)这棵索引树中只匹配到了一个记录，此时拿着这个id去主键索引树中回表查询全部数据，这个过程只需要回表一次。



###### 实践

- 当然上述的分析只是原理上的，我们可以实战分析一下，因此陈某装了Mysql5.6版本的Mysql，解析了上述的语句，如下图：



![img](学习笔记-数据库-Gem.assets/v2-e92ce90a6c810a238e709760ed67daaf_720w.jpg)



- 根据explain解析结果可以看出Extra的值为**Using index condition**，表示已经使用了索引下推。



###### 总结

- 索引下推在**非主键索引**上的优化，可以有效减少回表的次数，大大提升了查询的效率。
- 默认开启，如果关闭索引下推可以使用如下命令，但这么优秀的功能干嘛关闭呢：

```sql
set optimizer_switch='index_condition_pushdown=off';
```





#### 索引失效

##### 下一个索引失效

1. 反向语义，例如：not in、not like、<>，!=；

2. 范围查询，例如：between and，>，<，

##### 当前索引失效

1. 索引列使用函数，例如：count、sum、substr等；

2. 字符窜不加引号，发生隐式转换。

   如果字段是int型，值是字符。不会导致索引失效。因为执行前MySQL会将字符解析成数字在执行。并不会对字段做转换。字符窜包含数字的，会自动解析出里面的数字。如果没有数字的就是0。

3. like值的前边加'%'，后面如果有就不会影响。

##### 全部失效

走了索引之后，如果查询结果为总数量的30%，（这只是一个估值，实际由优化器决定）

1. 

   ![6d452c6dc3cbc0970c52c90ac48d6949.png](学习笔记-数据库-Gem.assets/6d452c6dc3cbc0970c52c90ac48d6949.png)

#### 索引合并

MySQL 5.0版本之前，一个表一次只能选择并使用一个索引。

MySQL 5.1版本开始，引入了Index Merge Optimization技术，使得MySQL支持一个表一次查询同时使用多个索引。

官方文档：[MySQL Index Merge Optimization](https://dev.mysql.com/doc/refman/5.5/en/index-merge-optimization.html)

https://blog.csdn.net/weixin_43318367/article/details/108745650



### 事务和锁

#### [事务公共知识](#事务)

MySQL默认RR验证

```sql
-- 查看mysql版本 5.7.33
select version();
-- 关闭自动提交，不然每执行一句SQL都是一个事务
set AUTOCOMMIT=0;
-- 查看当前session是否已关闭自动提交。其他session应该还是on
show variables like 'autocommit';
-- 默认隔离级别REPEATABLE-READ
show VARIABLES  like '%isolation%';

-- 第一步 当前age=15
select * from student where id = 1;

-- 第二步，这句sql要再开一个navicat执行。不然还属于当前事务。
update student set age = 10 where id = 1;

-- 第三步，查询出来还是age=15，MySQL默认RR
select * from student where id = 1;
COMMIT;

-- 第四步，提交之后再查询，结果age=10
select * from student where id = 1;

-- 改回事务自动提交
set AUTOCOMMIT=1;
```

#### 事务开启方式

##### 自动

单条增删改语句及时没有明确声明事务，MySQL会自动开启事务，自动提交；

如果是多条语句，如果没有明确声明事务，默认也是一条SQL一个事务。

InnoDB里面有一个autocommit的参数（分为两个级别，session级别和global级别）

`show variables like 'autocommit';`

它的默认值是ON。如果它的值是true/on的话，我们在操作数据的时候，会自动提交事务。

否则的话，如果我们把autocommit设置成false/off，那么数据库的事务就需要我们手动地结束，用rollback或者commit。

还有一种情况，客户端的连接断开的时候,事务也会结束。

##### 手动

开始事务：begin或者start transaction

结束事务：commit

回滚事务：rollback



#### MVCC

https://www.jianshu.com/p/8845ddca3b23

https://blog.csdn.net/weixin_39645308/article/details/110863265

multi-version concurrent control（多版本并发控制）。mysql把每个操作都定义成一个事务，每开启一个事务，系统的事务版本号自动递增。每行记录都有两个隐藏列：创建版本号和删除版本号

- select：事务每次只能读到创建版本号小于等于此次系统版本号的记录，同时行的删除版本号不存在或者大于当前事务的版本号。
- update：插入一条新记录，并把当前系统版本号作为行记录的版本号，同时保存当前系统版本号到原有的行作为删除版本号。
- delete：把当前系统版本号作为行记录的删除版本号
- insert：把当前系统版本号作为行记录的版本号

#### LBCC

基于锁的并发控制，有记录锁，间隙锁，临键锁，当判断条件等于记录值时，使用记录锁；当判断条件在两个值区间时，使用间隙锁锁定这个区间；临键锁=记录锁+间隙锁；InnoDB默认临键锁；



#### 锁

不同的存储引擎，锁的实现是不同的。

- MyISAM 和 MEMORY 存储引擎采用的是表级锁（table-level locking）
- BDB 存储引擎采用的是页面锁（page-level locking），但也支持表级锁
- InnoDB 存储引擎既支持行级锁（row-level locking），也支持表级锁，但默认情况下是采用行级锁。

以下内容如无特别说明，介绍的都是innodb的实现

按锁的机制分：

##### 共享锁/排他锁

- 共享锁（读锁）：其他事务可以读，但不能写。

  显式加锁：

  SELECT * FROM table_name WHERE ... LOCK IN SHARE MODE。 

  其他 session  仍然可以查询记录，并也可以对该记录加 share mode 的共享锁。但是如果当前事务需要对该记录进行更新操作，则很有可能造成死锁。

- 排他锁（写锁） ：其他事务不能读取，也不能写。

  显式加锁：

  SELECT * FROM table_name WHERE ... FOR UPDATE

  其他 session 可以查询该记录，但是不能对该记录加共享锁或排他锁，而是等待获得锁

为了允许行锁和表锁共存，实现多粒度锁机制，InnoDB 还有两种内部使用的意向锁（Intention Locks），这两种意向锁都是**表锁**：

- 意向共享锁（IS）：事务打算给数据行加行共享锁，事务在给一个数据行加共享锁前必须先取得该表的 IS 锁。 
- 意向排他锁（IX）：事务打算给数据行加行排他锁，事务在给一个数据行加排他锁前必须先取得该表的 IX 锁。

##### 锁模式的兼容情况

如果一个事务请求的锁模式与当前的锁兼容， InnoDB 就将请求的锁授予该事务； 反之， 如果两者不兼容，该事务就要等待锁释放。

![img](学习笔记-数据库-Gem.assets/v2-37761612ead11ddc3762a4c20ddab3f3_720w.jpg)

##### 加锁方法：

- 意向锁是 InnoDB 自动加的， 不需用户干预。 
- 对于 UPDATE、 DELETE 和 INSERT 语句， InnoDB
  会自动给涉及数据集加排他锁（X)；
- 对于普通 SELECT 语句，如果没有事务，InnoDB 不会加任何锁；

- **隐式锁定：** 

InnoDB在事务执行过程中，使用两阶段锁协议：

随时都可以执行锁定，InnoDB会根据事务隔离级别在需要的时候自动加锁；

锁只有在执行commit或者rollback的时候才会释放，并且所有的锁都是在**同一时刻**被释放。 

- **显式锁定 ：** 

```sql
SELECT * FROM table_name WHERE 1=1 in share mode //共享锁 
SELECT * FROM table_name WHERE 1=1 for update //排他锁 
```

**select for update：**

在执行这个 select 查询语句的时候，会将对应的索引访问条目进行上排他锁（X 锁），也就是说这个语句对应的锁就相当于update带来的效果。

select *** for update 的使用场景：为了让自己查到的数据确保是最新数据，并且查到后的数据只允许自己来修改的时候，需要用到 for update 子句。

**select lock in share mode ：**in share mode 子句的作用就是将查找到的数据加上一个 share 锁，这个就是表示其他的事务只能对这些数据进行简单的select  操作，并不能够进行 DML 操作。select *** lock in share mode  使用场景：为了确保自己查到的数据没有被其他的事务正在修改，也就是说确保查到的数据是最新的数据，并且不允许其他人来修改数据。但是自己不一定能够修改数据，因为有可能其他的事务也对这些数据 使用了 in share mode 的方式上了 S 锁。

**性能影响：**
select for update 语句，相当于一个 update 语句。在业务繁忙的情况下，如果事务没有及时的commit或者rollback 可能会造成其他事务长时间的等待，从而影响数据库的并发使用效率。
select lock in share mode 语句是一个给查找的数据上一个共享锁（S 锁）的功能，它允许其他的事务也对该数据上S锁，但是不能够允许对该数据进行修改。如果不及时的commit 或者rollback 也可能会造成大量的事务等待。



**for update 和 lock in share mode 的区别：**

前一个上的是排他锁（X 锁），一旦一个事务获取了这个锁，其他的事务是没法在这些数据上执行 for update ；后一个是共享锁，多个事务可以同时的对相同数据执行 lock in share mode。



按锁的范围分

##### 表级锁

开销小，加锁快；不会出现死锁；锁定粒度大，发生锁冲突的概率最高，并发度最低

##### 行级锁

开销大，加锁慢；会出现死锁；锁定粒度最小，发生锁冲突的概率最低，并发度也最高。





##### LOCK TABLES 和 UNLOCK TABLES

- 在用 LOCK TABLES 对 InnoDB 表加锁时要注意，要将 AUTOCOMMIT 设为 0，否则MySQL 不会给表加锁；
- 事务结束前，不要用 UNLOCK TABLES 释放表锁，因为 UNLOCK TABLES会隐含地提交事务；
- COMMIT 或 ROLLBACK 并不能释放用 LOCK TABLES 加的表级锁，必须用UNLOCK TABLES 释放表锁。

正确的方式见如下语句：
例如，如果需要写表 t1 并从表 t 读，可以按如下做：

```sql
SET AUTOCOMMIT=0; 
LOCK TABLES t1 WRITE, t2 READ, ...; 
[do something with tables t1 and t2 here]; 
COMMIT; 
UNLOCK TABLES;
```



##### InnoDB 在不同隔离级别下的一致性读及锁的差异

锁和多版本数据（MVCC）是 InnoDB 实现一致性读和 ISO/ANSI SQL92 隔离级别的手段。

因此，在不同的隔离级别下，InnoDB 处理 SQL 时采用的一致性读策略和需要的锁是不同的

![img](学习笔记-数据库-Gem.assets/v2-c83c6459f8dc93a5f157fe1e3080088d_720w.jpg)

![img](学习笔记-数据库-Gem.assets/v2-568951f4cdfeb9416042627a7b94c4ac_720w.jpg)

##### 死锁

**InnoDB避免死锁：**

- 为了在单个InnoDB表上执行多个并发写入操作时避免死锁，可以在事务开始时通过为预期要修改的每个元祖（行）使用SELECT ... FOR UPDATE语句来获取必要的锁，即使这些行的更改语句是在之后才执行的。 
- 在事务中，如果要更新记录，应该直接申请足够级别的锁，即排他锁，而不应先申请共享锁、更新时再申请排他锁，因为这时候当用户再申请排他锁时，其他事务可能又已经获得了相同记录的共享锁，从而造成锁冲突，甚至死锁
- 如果事务需要修改或锁定多个表，则应在每个事务中以相同的顺序使用加锁语句。 在应用中，如果不同的程序会并发存取多个表，应尽量约定以相同的顺序来访问表，这样可以大大降低产生死锁的机会
- 通过SELECT ... LOCK IN SHARE MODE获取行的读锁后，如果当前事务再需要对该记录进行更新操作，则很有可能造成死锁。
- 改变事务隔离级别

如果出现死锁，可以用 SHOW INNODB STATUS 命令来确定最后一个死锁产生的原因。返回结果中包括死锁相关事务的详细信息，如引发死锁的 SQL 语句，事务已经获得的锁，正在等待什么锁，以及被回滚的事务等。据此可以分析死锁产生的原因和改进措施。



##### 乐观锁、悲观锁

- **乐观锁(Optimistic Lock)**：假设不会发生并发冲突，只在提交操作时检查是否违反数据完整性。 乐观锁不能解决脏读的问题。

乐观锁,  顾名思义，就是很乐观，每次去拿数据的时候都认为别人不会修改，所以不会上锁，但是在更新的时候会判断一下在此期间别人有没有去更新这个数据，可以使用版本号等机制。乐观锁适用于多读的应用类型，这样可以提高吞吐量，像数据库如果提供类似于write_condition机制的其实都是提供的乐观锁。

- **悲观锁(Pessimistic Lock)**：假定会发生并发冲突，屏蔽一切可能违反数据完整性的操作。

悲观锁，顾名思义，就是很悲观，每次去拿数据的时候都认为别人会修改，所以每次在拿数据的时候都会上锁，这样别人想拿这个数据就会block直到它拿到锁。传统的关系型数据库里边就用到了很多这种锁机制，比如行锁，表锁等，读锁，写锁等，都是在做操作之前先上锁。



#### Innodb锁

##### 行锁原理

InnoDB行锁是通过给索引项加锁来实现的，这一点mysql和oracle不同，后者是通过在数据库中对相应的数据行加锁来实现的，InnoDB这种行级锁决定，只有通过索引条件来检索数据，才能使用行级锁，否则，直接使用表级锁。

为什么通过唯一索引给数据行加锁，主键索引也会被锁住?

在InnoDB里面，在辅助索引里面，索引存储的是二级索引和主键的值。比如name=4,存储的是name的索引和主键id的值4。
而主键索引里面除了索引之外，还存储了完整的数据。所以我们通过辅助索引锁定一行数据的时候，它跟我们检索数据的步骤是一样的，会通过主键值找到主键索引，然后也锁定。
本质上是因为锁定的是同一行数据，是相互冲突的。



以下是Innodb行锁的三个实现：

##### Innodb记录锁

##### InnoDB的间隙锁

适用条件

innodb，隔离级别RR（可重复读）下，SQL语句中有锁（例如：for update，update会自动加排他锁）

当我们用范围条件而不是相等条件检索数据，并请求共享或排他锁时，InnoDB会给符合条件的已有数据记录的索引项加锁；对于键值在条件范围内但并不存在的记录，叫做“间隙（GAP)”，InnoDB也会对这个“间隙”加锁，这种锁机制就是所谓的间隙锁（Next-Key锁）。

很显然，在使用范围条件检索并锁定记录时，InnoDB这种加锁机制会阻塞符合条件范围内键值的并发插入，这往往会造成严重的锁等待。因此，在实际应用开发中，尤其是并发插入比较多的应用，我们要尽量优化业务逻辑，尽量使用相等条件来访问更新数据，避免使用范围条件。 

**InnoDB使用间隙锁的目的：**

1. 防止幻读，以满足相关隔离级别的要求；
2. 满足恢复和复制的需要：



##### InnoDB的临建锁

临键锁，是记录锁与间隙锁的组合，它的封锁范围，既包含索引记录，又包含索引区间。

注：临键锁的主要目的，也是为了避免幻读(Phantom Read)。如果把事务的隔离级别降级为RC，临键锁则也会失效。

##### 自增锁

是一种特殊的表锁，用来防止自增字段重复，数据插入后就会释放，不需要等到事务提交才释放



#### MySQL隔离级别

##### 重复读

MySQL默认的隔离级别就是RR，重复读。

- 查询如果没有加锁，mysql通过mvcc来避免幻读。
- 查询如果加锁，mysql通过临建锁来避免幻读。

##### 序列化

所有的查询语句都会被隐式转换成：select ... lock in share mode

##### 提交读

普通select，用MVCC实现。

加锁的select，不会有间隙锁。



## 性能优化

按照先后顺序，数据库性能优化可分为如下几部分

1. 数据库参数优化。安装数据库时就可以提前做好性能相关的设置，后续出现问题也可以动态调整。
2. 数据库设计优化。功能开始时，结合业务需求在做表设计或者字段设计时充分考虑性能。
3. 性能监控。性能监控方法用于辅助性能问题的发现以及原因的分析。
4. SQL优化。通过性能分析方法，找出存在性能问题的SQL后，进行SQL性能优化。

接下来将分别按章节说明。



### 优化准备

#### 数据库准备

以下部分章节需要一个数据库环境来执行案例。建议参考安装章节在自己电脑上先安装好。

MySQL版本建议是5.7+

#### 数据准备

部分案例需要数据库中已存在的表和测试数据。建议使用[官网案例数据的导入脚本](https://dev.mysql.com/doc/index-other.html)。

1. 点开上面的链接后，找到“Example Databases”，下方会有很多案例数据库。
2. 每个数据库都可以点“view”，查看这个数据库的介绍，structure里面有表结构，视图等等的介绍。
3. 找到sakila database，点zip下载。下载后解压到数据库服务器的目录中。
4. 导入解压之后的sql脚本。
5. 可以进入MySQL控制台，然后用source命令导入。
6. 也可以使用Navicat的“运行SQL文件”功能。
7. 执行脚本时，先执行sakila-schema.sql，然后是sakila-data.sql。

以下是非官方的但课程需要用到的配套脚本。

```sql
SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for dept
-- ----------------------------
DROP TABLE IF EXISTS `dept`;
CREATE TABLE `dept` (
  `DEPTNO` int(4) NOT NULL,
  `DNAME` varchar(14) DEFAULT NULL,
  `LOC` varchar(13) DEFAULT NULL,
  PRIMARY KEY (`DEPTNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dept
-- ----------------------------
INSERT INTO `dept` VALUES ('10', 'ACCOUNTING', 'NEW YORK');
INSERT INTO `dept` VALUES ('20', 'RESEARCH', 'DALLAS');
INSERT INTO `dept` VALUES ('30', 'SALES', 'CHICAGO');
INSERT INTO `dept` VALUES ('40', 'OPERATIONS', 'BOSTON');

-- ----------------------------
-- Table structure for emp
-- ----------------------------
DROP TABLE IF EXISTS `emp`;
CREATE TABLE `emp` (
  `EMPNO` int(4) NOT NULL,
  `ENAME` varchar(10) DEFAULT NULL,
  `JOB` varchar(9) DEFAULT NULL,
  `MGR` int(4) DEFAULT NULL,
  `HIREDATE` date DEFAULT NULL,
  `SAL` double(7,2) DEFAULT NULL,
  `COMM` double(7,2) DEFAULT NULL,
  `DEPTNO` int(4) DEFAULT NULL,
  PRIMARY KEY (`EMPNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of emp
-- ----------------------------
INSERT INTO `emp` VALUES ('7369', 'SMITH', 'CLERK', '7902', '1980-12-17', '800.00', null, '20');
INSERT INTO `emp` VALUES ('7499', 'ALLEN', 'SALESMAN', '7698', '1981-02-20', '1600.00', '300.00', '30');
INSERT INTO `emp` VALUES ('7521', 'WARD', 'SALESMAN', '7698', '1981-02-22', '1250.00', '500.00', '30');
INSERT INTO `emp` VALUES ('7566', 'JONES', 'MANAGER', '7839', '1981-02-02', '2975.00', null, '20');
INSERT INTO `emp` VALUES ('7654', 'MARTIN', 'SALESMAN', '7698', '1981-09-28', '1250.00', '1400.00', '30');
INSERT INTO `emp` VALUES ('7698', 'BLAKE', 'MANAGER', '7839', '1981-01-05', '2850.00', null, '30');
INSERT INTO `emp` VALUES ('7782', 'CLARK', 'MANAGER', '7839', '1981-09-06', '2450.00', null, '10');
INSERT INTO `emp` VALUES ('7839', 'KING', 'PRESIDENT', null, '1981-11-17', '5000.00', null, '10');
INSERT INTO `emp` VALUES ('7844', 'TURNER', 'SALESMAN', '7698', '1981-09-08', '1500.00', '0.00', '30');
INSERT INTO `emp` VALUES ('7900', 'JAMES', 'CLERK', '7698', '1981-12-03', '950.00', null, '30');
INSERT INTO `emp` VALUES ('7902', 'FORD', 'ANALYST', '7566', '1981-12-03', '3000.00', null, '20');
INSERT INTO `emp` VALUES ('7934', 'MILLER', 'CLERK', '7782', '1982-01-23', '1300.00', null, '10');

-- ----------------------------
-- Table structure for salgrade
-- ----------------------------
DROP TABLE IF EXISTS `salgrade`;
CREATE TABLE `salgrade` (
  `GRADE` int(11) NOT NULL,
  `LOSAL` double DEFAULT NULL,
  `HISAL` double DEFAULT NULL,
  PRIMARY KEY (`GRADE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of salgrade
-- ----------------------------
INSERT INTO `salgrade` VALUES ('1', '700', '1200');
INSERT INTO `salgrade` VALUES ('2', '1201', '1400');
INSERT INTO `salgrade` VALUES ('3', '1401', '2000');
INSERT INTO `salgrade` VALUES ('4', '2001', '3000');
INSERT INTO `salgrade` VALUES ('5', '3001', '9999');

```





### 配置优化

#### 服务端优化

#### 配置文件地址

Linux数据库配置文件地址：/etc/my.cnf

Windows数据库配置文件地址：数据库安装目录/my.ini

如果是通过宝塔安装的，可以在“软件商店 > 已安装 > MySQL x.x.x > 设置 > 配置修改”中修改，然后点保存。



#### 配置文件内容

```ini
[client]
#password	= your_password
port		= 3306
socket		= /tmp/mysql.sock

[mysqld]
port		= 3306
socket		= /tmp/mysql.sock
datadir = /www/server/data
default_storage_engine = InnoDB
performance_schema_max_table_instances = 400
table_definition_cache = 400
skip-external-locking
key_buffer_size = 128M
max_allowed_packet = 100G
table_open_cache = 512
sort_buffer_size = 2M
net_buffer_length = 4K
read_buffer_size = 2M
read_rnd_buffer_size = 256K
myisam_sort_buffer_size = 32M
thread_cache_size = 64
tmp_table_size = 64M
default_authentication_plugin = mysql_native_password
lower_case_table_names = 1
sql-mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES

explicit_defaults_for_timestamp = true
#skip-name-resolve
max_connections = 500
max_connect_errors = 100
open_files_limit = 65535

log-bin=mysql-bin
binlog_format=mixed
server-id = 1
binlog_expire_logs_seconds = 600000
slow_query_log=1
slow-query-log-file=/www/server/data/mysql-slow.log
long_query_time=3
#log_queries_not_using_indexes=on
early-plugin-load = ""

innodb_data_home_dir = /www/server/data
innodb_data_file_path = ibdata1:10M:autoextend
innodb_log_group_home_dir = /www/server/data
innodb_buffer_pool_size = 512M
innodb_log_file_size = 256M
innodb_log_buffer_size = 64M
innodb_flush_log_at_trx_commit = 1
innodb_lock_wait_timeout = 50
innodb_max_dirty_pages_pct = 90
innodb_read_io_threads = 4
innodb_write_io_threads = 4

[mysqldump]
quick
max_allowed_packet = 500M

[mysql]
no-auto-rehash

[myisamchk]
key_buffer_size = 128M
sort_buffer_size = 2M
read_buffer = 2M
write_buffer = 2M

[mysqlhotcopy]
interactive-timeout

```



#### 数据库参数说明

##### general

总体通用参数

datadir=/var/lib/mysql

数据文件存放的目录

socket=/var/lib/mysql/mysql.sock

mysql.socket表示server和client在同一台服务器，并且使用localhost进行连接，就会使用socket进行连接

pid_file=/var/lib/mysql/mysql.pid

存储mysql的pid

port=3306

mysql服务的端口号

default_storage_engine=InnoDB

mysql默认存储引擎

skip-grant-tables

当忘记mysql的用户名密码的时候，可以在mysql配置文件中配置该参数，跳过权限表验证，不需要密码即可登录mysql

##### character

字符参数，这些参数一般会设置utf8mb4，但如果确定一张表中存储的数据不会包含中文的话，也可以用latin1以节约空间。

character_set_client

客户端数据的字符集

character_set_connection

mysql处理客户端发来的信息时，会把这些数据转换成连接的字符集格式

character_set_results

mysql发送给客户端的结果集所用的字符集

character_set_database

数据库默认的字符集

character_set_server

mysql server的默认字符集

##### connection

连接参数。

max_connections

mysql的最大连接数，如果数据库的并发连接请求比较大，应该调高该值。与服务器硬件资源有关系。

在linux中，一般一个进程最大能创建的文件数默认为1024（[可修改](https://blog.csdn.net/inthat/article/details/106741499)），所以这里的最大连接数推荐不要超过这个值。

可以通过 show processlist; 查看当前数据库中所有的连接。

修改方法：set global max_connections=1024

max_user_connections

限制每个用户的连接个数，默认0，不限制。

back_log

mysql能够暂存的连接数量，当mysql的线程在一个很短时间内得到非常多的连接请求时，就会起作用，如果mysql的连接数量达到max_connections时，新的请求会被存储在堆栈中，以等待某一个连接释放资源，如果等待连接的数量超过back_log,则不再接受连接资源。

这个值设置的越大，意味着当MySQL达到最大连接时客户端的等待队列越大，同时客户端的响应时间也会延长，不建议设置的过大。

wait_timeout

mysql在关闭一个非交互的连接之前需要等待的时长。非交互连接指的是类似jdbc这种短连接。

interactive_timeout

关闭一个交互连接之前需要等待的秒数。交互连接指的是类似控制台，连接池这种长连接。

由于开启和关闭连接需要消耗一定的资源，所以连接池中的连接属于长连接。超出指定时间无交互就关闭。

##### log

日志设置

log_error

指定错误日志文件名称，用于记录当mysqld启动和停止时，以及服务器在运行中发生任何严重错误时的相关信息

log_bin

指定二进制日志文件（binlog）的名称，用于记录对数据造成更改的所有SQL语句

binlog_do_db

指定需要记录binlog的数据库名称，其他所有没有显式指定的数据库更新将忽略，不记录在日志中。多个的写法：

```ini
binlog-do-db=db1
binlog-do-db=db2
```

binlog_ignore_db

指定不需要记录binlog的数据库名称

sync_binlog

指定多少次写日志后同步磁盘。

general_log

是否开启查询日志记录。

general_log_file

指定查询日志文件名，用于记录所有的查询语句

slow_query_log

是否开启慢查询日志记录。默认关闭，但一般都会开启。和慢查询相关的是一组属性，最好一起设置。

slow_query_log_file

指定慢查询日志文件名称，用于记录耗时比较长的查询语句。

long_query_time

设置慢查询的时间，单位：秒，超过这个时间的查询语句才会记录日志

log_slow_admin_statements

是否将管理语句写入慢查询日志

##### cache

缓存相关设置

key_buffer_size

索引缓存区的大小（只对myisam表起作用）

**query cache**

查询缓存在MySQL8中已移除。

query_cache_size

查询缓存的大小，未来版本被删除

show status like '%Qcache%';查看查询缓存当前的相关属性。相当于是对缓存的一个监控。

Qcache_free_blocks：缓存中相邻内存块的个数，如果值比较大，那么查询缓存中碎片比较多

Qcache_free_memory：查询缓存中剩余的内存大小

Qcache_hits：表示有多少此命中缓存

Qcache_inserts：表示多少次未命中而插入

Qcache_lowmen_prunes：多少条query因为内存不足而被移除cache

Qcache_queries_in_cache：当前cache中缓存的query数量

Qcache_total_blocks：当前cache中block的数量

query_cache_limit

超出此大小的查询将不被缓存

query_cache_min_res_unit

缓存块最小大小

query_cache_type

缓存类型，决定缓存什么样的查询

0表示禁用

1表示将缓存所有结果，除非sql语句中使用sql_no_cache禁用查询缓存

2表示只缓存select语句中通过sql_cache指定需要缓存的查询



sort_buffer_size

排序缓存，每个需要排序的线程分派该大小的缓冲区。

innodb_sort_buffer_size，innodb的排序缓存。优先级比上面的高。

myisam_sort_buffer_size，myisam的排序缓存。优先级比上面的高。



max_allowed_packet=32M

限制server接受的数据包大小。这个参数一般很少修改。

join_buffer_size=2M

表示关联缓存的大小。关联查询时如果join列没有索引时会用到。



##### Thread

thread_cache_size，线程缓存。

服务器线程缓存，这个值表示可以重新利用保存再缓存中的线程数量，当断开连接时，那么客户端的线程将被放到缓存中以响应下一个客户而不是销毁，如果线程重新被请求，那么请求将从缓存中读取，如果缓存中是空的或者是新的请求，这个线程将被重新请求，那么这个线程将被重新创建，如果有很多新的线程，增加这个值即可

Threads_cached：代表当前此时此刻线程缓存中有多少空闲线程

Threads_connected：代表当前已建立连接的数量

Threads_created：代表最近一次服务启动，已创建现成的数量，如果该值比较大，那么服务器会一直再创建线程

Threads_running：代表当前激活的线程数



##### innodb

innodb_buffer_pool_size=

该参数指定大小的内存来缓冲数据和索引，最大可以设置为物理内存的80%

innodb_flush_log_at_trx_commit

主要控制innodb将log buffer中的数据写入磁盘的方式或时间，值分别为0，1，2。

0：此模式性能最高，但安全性较低。mysqld进程崩溃会导致上1秒钟所有事务数据的丢失。

1：默认设置，最安全但是性能最低。在mysqld 服务崩溃或者服务器主机crash的情况下，binary log 只有可能丢失最多一个语句或者一个事务

2：该模式速度较快，也比0安全，只有在操作系统崩溃或者系统断电的情况下，上一秒钟所有事务数据才可能丢失

[详细介绍](https://www.cnblogs.com/f66666/articles/10993873.html)

innodb_thread_concurrency

设置innodb线程的并发数，默认为0表示不受限制，如果要设置建议跟服务器的cpu核心数一致或者是cpu核心数的两倍

innodb_log_buffer_size

此参数确定日志文件所用的内存大小，以M为单位

innodb_log_file_size

此参数确定数据日志文件的大小，以M为单位

innodb_log_files_in_group

以循环方式将日志文件写到多个文件中

read_buffer_size

mysql读入缓冲区大小，对表进行顺序扫描的请求将分配到一个读入缓冲区

read_rnd_buffer_size

mysql随机读的缓冲区大小

innodb_file_per_table

此参数确定为每张表分配一个新的文件。默认等于on，会给每张表建立一个数据文件。如果等于off，那所有表的数据都会放到一个表空间文件内。



#### 客户端配置优化

客户端连接数据库服务器时，建议建议使用连接池，例如：druid，hikari，c3p0，DBCP。不要每次都创建一个新连接。

- 比较有名的Java连接池有，[Druid](https://github.com/alibaba/druid/wiki/%E9%A6%96%E9%A1%B5)，Hikari，C3P0等等。目前功能和性能相对最强大的是druid。
- 功能角度考虑，Druid 功能更全面，除具备连接池基本功能外，还支持sql级监控、扩展、SQL防注入等。最新版甚至有集群监控
- 单从性能角度考虑，从数据上确实HikariCP要强，但Druid有更多、更久的生产实践，更可靠。
- 单从监控角度考虑，如果我们有像skywalking、prometheus等组件是可以将监控能力交给这些的 HikariCP 也可以将metrics暴露出去。

##### 合理设置连接池大小

Druid的默认最大连接池大小是8。Hikari的默认最大连接池大小是10。

为什么默认值都是这么小呢？

在Hikari的GitHub文档中，给出了一个PostgreSQL数据库建议的设置连接池大小的公式。

它的建议是机器核数乘以2加1。也就是说：4核的机器，连接池维护9个连接就够了。

这个公式从一定程度上来说对其他数据库也是适用的。这里面还有一个减少连接池大小实现提升并发度和吞吐量的案例。

为什么有的情况下，减少连接数反而会提升吞吐量呢？为什么建议设置的连接池大小要跟CPU的核数相关呢?

每一个连接，服务端都需要创建一个线程去处理它。连接数越多，服务端创建的线程数就会越多。

CPU是怎么同时执行远远超过它的核数大小的任务的？通过时间片分配。上下文切换。

而CPU的核数是有限的，频繁的上下文切换会造成比较大的性能开销。



### 设计优化

本章节主要讲述，在数据库设计环节的性能优化建议。

#### 字段类型优化

##### 更小的更好

设计表时，应该在符合业务要求的前提下，尽量使用可以能够存储数据的最小数据类型。

更小的数据类型通常更快，因为它们占用更少的磁盘、内存和CPU缓存，并且处理时需要的CPU周期更少。

但如果无法评估数据类型的范围，就选择你认为不会超过范围的最小类型。

案例

设计两张表，设计不同的数据类型（例如：一个是int(10)，另一个是tinyint(10)）。然后通过程序往表里插入相同数据量的数据。然后去目录中查看2个表所在的数据文件的大小。可以看到，虽然实际大小相同，但是更大的数据类型占用空间更大。



##### 简单就好

简单数据类型的操作通常需要更少的CPU周期，这里的简单是指：

1、整型比字符操作代价更低，因为字符集和校对规则使得字符比整型更复杂。

2、使用日期类型而不是字符窜来存储日期和时间

3、使用数字类型而不是字符窜来存储数字。使用字符存储时，在作比较时可能得到不正确的结果。例如：

```sql
mysql> select 9 > 100;
+---------+
| 9 > 100 |
+---------+
|       0 |
+---------+
1 row in set (0.03 sec)

mysql> select '9' > '100';
+-------------+
| '9' > '100' |
+-------------+
|           1 |
+-------------+
1 row in set (0.03 sec)

mysql> 
```

使用字符还有另一个问题当和数字进行操作时，容易发生隐式转换，导致索引抑制，影响查询性能。

4、可以使用整型存储IP地址

案例：

1. 创建两张表，除了日期字段其他都一致，一个用varchar，另一个用date类型。

2. 建表脚本（test_date1，test_date2）created_on为创建日期字段。一个用datetime，一个用varchar。

3. ```sql
   DROP TABLE IF EXISTS `test_date1`;
   CREATE TABLE `test_date1`  (
     `id` int NOT NULL AUTO_INCREMENT,
     `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
     `job` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
     `salary` decimal(10, 2) NULL DEFAULT NULL,
     `created_on` date NOT NULL,
     PRIMARY KEY (`id`) USING BTREE
   ) ENGINE = InnoDB AUTO_INCREMENT = 10001 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;
   
   DROP TABLE IF EXISTS `test_date2`;
   CREATE TABLE `test_date2`  (
     `id` int NOT NULL AUTO_INCREMENT,
     `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
     `job` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
     `salary` decimal(10, 2) NULL DEFAULT NULL,
     `created_on` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
     PRIMARY KEY (`id`) USING BTREE
   ) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;
   ```

4. 使用navicat的数据生成功能给test_date1自动生成10000条数据。（大家也可以写程序自己往里面插）

5. 使用insert into select语句将test_date1的数据稍作转换插入test_date2中

6. ```sql
   INSERT INTO test_date2 (id, name, job, salary, created_on)
   SELECT id, name, job, salary, date_format(created_on,'%Y-%m-%d') FROM test_date1;
   ```

7. 然后执行相同的查询，比较2个SQL的性能。

8. ```sh
   mysql> set profiling=1;
   Query OK, 0 rows affected (0.00 sec)
   
   mysql> select * from test_date1 where created_on = '2023-03-08';
   +-------+----------------+------------+--------+------------+
   | id    | name           | job        | salary | created_on |
   +-------+----------------+------------+--------+------------+
   | 12859 | Chang Sum Wing | WpWQJlLlju | 202.11 | 2023-03-08 |
   | 15853 | Jiang Ziyi     | SOWZ94Orzn | 461.50 | 2023-03-08 |
   +-------+----------------+------------+--------+------------+
   2 rows in set (0.02 sec)
   
   mysql> select * from test_date2 where created_on = '2023-03-08';
   +-------+----------------+------------+--------+------------+
   | id    | name           | job        | salary | created_on |
   +-------+----------------+------------+--------+------------+
   | 12859 | Chang Sum Wing | WpWQJlLlju | 202.11 | 2023-03-08 |
   | 15853 | Jiang Ziyi     | SOWZ94Orzn | 461.50 | 2023-03-08 |
   +-------+----------------+------------+--------+------------+
   2 rows in set (0.02 sec)
   
   mysql> show profiles;
   +----------+------------+----------------------------------------------------------+
   | Query_ID | Duration   | Query                                                    |
   +----------+------------+----------------------------------------------------------+
   |        1 | 0.00282750 | select * from test_date1 where created_on = '2023-03-08' |
   |        2 | 0.00289125 | select * from test_date2 where created_on = '2023-03-08' |
   +----------+------------+----------------------------------------------------------+
   2 rows in set (0.02 sec)
   ```

9. 由上可知，日期类型字段性能比字符型略高。虽然在这个案例中只是搞一点点。但案例只是单表1万行记录无并发无表连接的场景。实际生产环境随着表连接，数据量，并发数的升高，性能差距会越来越大。



##### 尽量避免null

只要业务支持，尽量避免设计可为null的字段，尤其是表连接列。

如果查询中包含可为NULL的列，对mysql来说很难优化，因为可为null的列使得索引、索引统计和值比较都更加复杂。

坦白来说，通常情况下null的列改为not null带来的性能提升比较小，所有没有必要将所有的表的schema进行修改，但是应该尽量避免设计成可为null的列。

业务上可以为空的字段，经过业务评估，可以给字段设计默认值。但不要和可能出现的业务数据重复。

例如：字符型可以设计默认值：空字符。但不要设计成a或者b。

整形可以设计成：-1或者0。但如果业务上可能会填入-1或者0，那也不要强行设计默认值。



##### 整形类型

可以使用的几种整数类型：TINYINT，SMALLINT，MEDIUMINT，INT，BIGINT分别使用8，16，24，32，64位存储空间。
尽量使用满足需求的最小数据类型。

注意，上面的几种类型还可以指定长度。当实际是可以存储超出长度的数据的。实际还是按类型对应的字节数存储的。



##### 字符类型

mysql中常见的字符类型：char、varchar、text

1、char长度固定，即每条数据占用等长字节空间；最大长度是255个字符，适合用在身份证号、手机号等定长字符串
2、varchar可变程度，可以设置最大长度；最大空间是65535个字节，适合用在长度可变的属性
3、text不设置长度，当不知道属性的最大长度时，适合用text
查询速度排序：char > varchar > text

varchar根据实际内容长度保存数据
 1、使用最小的且符合业务要求的长度。
 2、varchar(n) n小于等于255使用额外一个字节保存长度，n>255使用额外两个字节保存长度。
 3、varchar(5)与varchar(255)保存同样的内容，硬盘存储空间相同，但内存空间占用不同，是指定的大小 。
 4、varchar在mysql5.6之前变更长度，或者从255一下变更到255以上时时，都会导致锁表。
 应用场景
  1、存储长度波动较大的数据，如：文章，有的会很短有的会很长
  2、字符串很少更新的场景，每次更新后都会重算并使用额外存储空间保存长度
  3、适合保存多字节字符，如：汉字，特殊字符等

char固定长度的字符串
 1、最大长度：255
 2、会自动删除末尾的空格
 3、检索效率、写效率 会比varchar高，以空间换时间
 应用场景
  1、存储长度波动不大的数据，如：md5摘要
  2、存储短字符串、经常更新的字符串



##### Blob和text

MySQL 把每个 BLOB 和 TEXT 值当作一个独立的对象处理。

两者都是为了存储很大数据而设计的字符串类型，分别采用二进制和字符方式存储。

text一般可能的场景是存储xml文件内容，SQL语句，Json格式数据等等。

这2种格式使用场景较小，一般出现很多字符的场景还是推荐将存储文件存储路径存储到数据库中。而不是直接存文件内容。



##### 时间类型

**datetime**

占用8个字节

与时区无关，数据库底层时区配置，对datetime无效

可保存到毫秒

可保存时间范围大

不要使用字符串存储日期类型，占用空间大，损失日期类型函数的便捷性

**timestamp**

占用4个字节

时间范围：1970-01-01到2038-01-19

精确到秒，采用整形存储

依赖数据库设置的时区

自动更新timestamp列的值

**date**

占用的字节数比使用字符串、datetime、int存储要少，使用date类型只需要3个字节

使用date类型还可以利用日期时间函数进行日期之间的计算

date类型用于保存1000-01-01到9999-12-31之间的日期，不包含时分秒。



##### 枚举类型

有时可以使用枚举类代替常用的字符串类型，mysql存储枚举类型会非常紧凑，会根据列表值的数据压缩到一个或两个字节中，mysql在内部会将每个值在列表中的位置保存为整数，并且在表的.frm文件中保存“数字-字符串”映射关系的查找表。

```sql
mysql> DROP TABLE IF EXISTS `enum_test`;
create table enum_test(e enum('fish','apple','dog') not null);
insert into enum_test(e) values('fish'),('dog'),('apple');
select e+0 from enum_test;

Query OK, 0 rows affected (0.01 sec)
Query OK, 0 rows affected (0.01 sec)
Query OK, 3 rows affected (0.00 sec)

Records: 3  Duplicates: 0  Warnings: 0

+-----+
| e+0 |
+-----+
|   1 |
|   3 |
|   2 |
+-----+
3 rows in set (0.02 sec)

mysql> 
```

**枚举类型的缺点**

- 更改枚举成员需要使用`ALTER TABLE`语句重建整个表，这在资源和时间方面比较昂贵。
- 获取完整的枚举列表比较复杂，因为需要访问`information_schema`数据库。
- 迁移到其他RDBMS可能是一个问题，因为`ENUM`不是SQL标准的，并且数据库系统不支持它。
- 向枚举列表添加更多属性是不可能的。
  - 例如：您要为每个枚举值添加描述，例如：`High(24h)`，`Medium(1-2天)`，`Low(1周)`，则不可以使用`ENUM`类型的。
  - 在这种情况下，需要有一个单独的表来存储这个枚举列表，例如`priority(id，name，sort_order，description)`
- 枚举列表不可重用。 例如：如果要[创建](http://www.yiibai.com/mysql/create-table.html)一个名为`tasks`并且要重用优先级列表的新表，则是不行的。



##### 整型存ip

一般会使用varchar(15)来存储ip地址，然而ip的本质是32位无符号整数不是字符串，可以考虑使用inet_aton()和inet_ntoa()函数在这两种表示类型之间转换。

案例：

```sql
# 将ip转换成整型
mysql> select inet_aton('192.168.1.3');
+--------------------------+
| inet_aton('192.168.1.3') |
+--------------------------+
|               3232235779 |
+--------------------------+
1 row in set (0.03 sec)

# 将整型转换成ip
mysql> select inet_ntoa(3232235779);
+-----------------------+
| inet_ntoa(3232235779) |
+-----------------------+
| 192.168.1.3           |
+-----------------------+
1 row in set (0.03 sec)

mysql> 
```



#### 数据库范式

##### 范式

优点

范式化的更新通常比反范式要快

当数据较好的范式化后，很少或者没有重复的数据

范式化的数据比较小，可以放在内存中，操作比较快

缺点

通常需要进行关联查询。



##### 反范式

优点

所有的数据都在同一张表中，可以避免关联

可以设计有效的索引；

缺点

表格内的冗余较多，删除数据或者更新数据时会造成表有些有用的信息丢失或者不同步。

在企业中很好能做到严格意义上的范式或者反范式，一般需要混合使用



##### 适当冗余

满足以下条件，可以考虑适当的采取冗余。Oracle中的物化视图也体现了这一思想。

 1.被频繁引用且只能通过join2张(或者更多)大表的方式才能得到的独立小字段。

 2.这样的场景由于每次Join仅仅只是为了取得某个小字段的值，Join到的记录又大，会造成大量不必要的 IO，完全可以通过空间换取时间的方式来优化。不过，冗余的同时需要确保数据的一致性不会遭到破坏，确保更新的同时冗余字段也被更新。

##### 案例

在一个互联网网站案例中，用户是存储在user表中，有个account_type字段可以区分出付费用户。而消息存储在message表。

网站现在想查看付费用户最近发送的10条信息。使用范式化设计，可以将message表关联user表然后根据时间查出最近的10条消息。

这在普通的系统中，user表可能只有几百到几万的数据量一般不会有问题。但在互联网网站，用户表数量可能达到上亿。

每次都表连接，性能上并不一定是最优的。这时可以使用反范式化设计，在user表和message表中都存储用户类型(account_type)

这避免了完全反范式化的插入和删除问题，因为即使没有消息的时候也绝不会丢失用户的信息。这样也不会把user_message表搞得太大，有利于高效地获取数据。

另一个从父表冗余一些数据到子表的理由是排序的需要。

缓存衍生值也是有用的。如果需要显示每个用户发了多少消息（类似论坛的），可以每次执行一个昂贵的自查询来计算并显示它；也可以在user表中建一个num_messages列，每当用户发新消息时更新这个值。

##### 适当拆分

当我们的表中存在类似于 TEXT 或者是很大的 VARCHAR类型的大字段的时候，如果我们大部分访问这张表的时候都不需要这个字段，我们就该义无反顾的将其拆分到另外的独立表中，以减少常用数据所占用的存储空间。这样做的一个明显好处就是每个数据块中可以存储的数据条数可以大大增加，既减少物理 IO 次数，也能大大提高内存中的缓存命中率。

一张表中有很多字段，其中经常访问的只是一部分字段，这个时候就可以考虑将不长访问的字段放到另一个张表中用一个键关联原表。



#### 主键选择

代理主键/逻辑主键

与业务无关的，无意义的数字序列

自然主键/业务主键

事物属性中的自然唯一标识

**推荐使用代理主键/逻辑主键**

它们不与业务耦合，因此更容易维护

大多数表，最好是全部表，推荐使用通用的主键键生成策略来生成主键。例如：雪花算法。在Oracle里面有序列这个对象来给每个表生成主键。可以多个表用同一个序列，也可以每个表用一个序列。减少系统的总体维护成本。



#### 字符集选择

字符集直接决定了数据在MySQL中的存储编码方式，由于同样的内容使用不同字符集表示所占用的空间大小会有较大的差异，所以通过使用合适的字符集，可以帮助我们尽可能减少数据量，进而减少IO操作次数。

1.纯拉丁字符能表示的内容，没必要选择 latin1 之外的其他字符编码，因为这会节省大量的存储空间。

2.如果我们可以确定不需要存放多种语言，就没必要非得使用UTF8或者其他UNICODE字符类型，这回造成大量的存储空间浪费。

3.MySQL的数据类型可以精确到字段，所以当我们需要大型数据库中存放多字节数据的时候，可以通过对不同表不同字段使用不同的数据

类型来较大程度减小数据存储量，进而降低 IO 操作次数并提高缓存命中率。

如果必须使用utf8来存储字符，那推荐使用utf8mb4。MySQL中utf8默认只能存2个字节。



#### 存储引擎选择

[官方存储引擎介绍](https://dev.mysql.com/doc/refman/5.7/en/storage-engines.html)

存储引擎是数据真正存放的地方，再往下就是内存和磁盘了。提供读写接口给服务器调用。

默认存储引擎的配置：在my.ini文件中有个default-storage-engine。

##### InnoDB

5.5开始的默认存储引擎。支持事务、外键、表锁、行锁、聚集索引、5.6之后支持全文索引。

##### MyISAM

不支持事务和聚集索引。只支持表锁。查询和新增比较快。表里记录了总行数。不像InnoDB要扫表才知道总行数

##### InnoDB和MyISAM的区别

1. InnoDB 支持事务，MyISAM 不支持事务。这是 MySQL 将默认存储引擎从 MyISAM 变成 InnoDB 的重要原因之一；

2. InnoDB 支持外键，而 MyISAM 不支持。对一个包含外键的 InnoDB 表转为 MYISAM 会失败；  

3. InnoDB 是聚集索引，MyISAM 是非聚集索引。聚集索引的文件存放在主键索引的叶子节点上，因此 InnoDB 建议必须要有主键，通过主键索引效率很高。但是辅助索引需要两次查询，先查询到主键，然后再通过主键查询到数据。因此，主键不应该过大，因为主键太大，其他索引也都会很大。而 MyISAM 是非聚集索引，数据文件是分离的，索引保存的是数据文件的指针。主键索引和辅助索引是独立的。 

4. InnoDB 不保存表的具体行数，执行 select count(*) from table 时需要全表扫描。而MyISAM 用一个变量保存了整个表的行数，执行上述语句时只需要读出该变量即可，速度很快；    

5. InnoDB 最小的锁粒度是行锁，MyISAM 最小的锁粒度是表锁。一个更新语句会锁住整张表，导致其他查询和更新都会被阻塞，因此并发访问受限。这也是 MySQL 将默认存储引擎从 MyISAM 变成 InnoDB 的重要原因之一；

**如何选择：**

1. 是否要支持事务，如果要请选择 InnoDB，如果不需要可以考虑 MyISAM；

2. 如果表中绝大多数都只是读查询，可以考虑 MyISAM，如果既有读，写也挺频繁，请使用InnoDB。

3. 系统奔溃后，MyISAM恢复起来更困难，能否接受，不能接受就选 InnoDB；

4. MySQL5.5版本开始Innodb已经成为Mysql的默认引擎(之前是MyISAM)，说明其优势是有目共睹的。如果你不知道用什么存储引擎，那就用InnoDB，至少不会差。

##### Memory

所有的数据都是在内存中读写，优点是速度快，缺点是无法持久化，一旦宕机数据会全部丢失。

使用场景，建议是用来做缓存或者是存临时数据。

##### CSV

一种文本格式。可以用Excel打开。使用场景：不同的数据库中同步数据。

##### archive

用于存储归档数据。无索引。



### 索引优化

#### 索引基础

索引的优点

 1、大大减少了服务器需要扫描的数据量
 2、帮助服务器避免排序和临时表
 3、将随机io变成顺序io

索引的用处

 1、快速查找匹配WHERE子句的行
 2、从consideration中消除行,如果可以在多个索引之间进行选择，mysql通常会使用找到最少行的索引
 3、如果表具有多列索引，则优化器可以使用索引的任何最左前缀来查找行
 4、当有表连接的时候，从其他表检索行数据
 5、查找特定索引列的min或max值
 6、如果排序或分组时在可用索引的最左前缀上完成的，则对表进行排序和分组
 7、在某些情况下，可以优化查询以检索值而无需查询数据行

索引的分类

 主键索引
 唯一索引
 普通索引
 全文索引
 组合索引

面试技术名词

 回表
 覆盖索引
 最左匹配
 索引下推

索引采用的数据结构

 哈希表
 B+树

索引匹配方式

 全值匹配
  全值匹配指的是和索引中的所有列进行匹配
   explain select * from staffs where name = 'July' and age = '23' and pos = 'dev';
 匹配最左前缀
  只匹配前面的几列
   explain select * from staffs where name = 'July' and age = '23';
   explain select * from staffs where name = 'July';
 匹配列前缀
  可以匹配某一列的值的开头部分
   explain select * from staffs where name like 'J%';
   explain select * from staffs where name like '%y';
 匹配范围值
  可以查找某一个范围的数据
   explain select * from staffs where name > 'Mary';
 精确匹配某一列并范围匹配另外一列
  可以查询第一列的全部和第二列的部分
   explain select * from staffs where name = 'July' and age > 25;
 只访问索引的查询
  查询的时候只需要访问索引，不需要访问数据行，本质上就是覆盖索引
   explain select name,age,pos from staffs where name = 'July' and age = 25 and pos = 'dev';



#### 索引匹配方式

```sql
create table staffs(
	id int primary key auto_increment,
    name varchar(24) not null default '' comment '姓名',
    age int not null default 0 comment '年龄', 
    pos varchar(20) not null default '' comment '职位', 
    add_time timestamp not null default current_timestamp comment '入职时间' 
) charset utf8 comment '员工记录表'; 
alter table staffs add index idxnap(name, age, pos);
```



全值匹配

全值匹配指的是和索引中的所有列进行匹配
explain select * from staffs where name = 'July' and age = '23' and pos = 'dev';

匹配最左前缀

只匹配前面的几列
explain select * from staffs where name = 'July' and age = '23';
explain select * from staffs where name = 'July';

匹配列前缀

可以匹配某一列的值的开头部分
explain select * from staffs where name like 'J%';
explain select * from staffs where name like '%y';

匹配范围值

可以查找某一个范围的数据
explain select * from staffs where name > 'Mary';
精确匹配某一列并范围匹配另外一列
可以查询第一列的全部和第二列的部分
explain select * from staffs where name = 'July' and age > 25;
只访问索引的查询
查询的时候只需要访问索引，不需要访问数据行，本质上就是覆盖索引
explain select name,age,pos from staffs where name = 'July' and age = 25 and pos = 'dev';



#### 哈希索引

 基于哈希表的实现，只有精确匹配索引所有列的查询才有效
 在mysql中，只有memory的存储引擎显式支持哈希索引
 哈希索引自身只需存储对应的hash值，所以索引的结构十分紧凑，这让哈希索引查找的速度非常快
 哈希索引的限制
  1、哈希索引只包含哈希值和行指针，而不存储字段值，索引不能使用索引中的值来避免读取行
  2、哈希索引数据并不是按照索引值顺序存储的，所以无法进行排序
  3、哈希索引不支持部分列匹配查找，哈希索引是使用索引列的全部内容来计算哈希值
  4、哈希索引支持等值比较查询，也不支持任何范围查询
  5、访问哈希索引的数据非常快，除非有很多哈希冲突，当出现哈希冲突的时候，存储引擎必须遍历链表中的所有行指针，逐行进行比较，直到找到所有符合条件的行
  6、哈希冲突比较多的话，维护的代价也会很高

案例

当需要存储大量的URL，并且根据URL进行搜索查找，如果使用B+树，存储的内容就会很大
select id from url where url=""
也可以利用将url使用CRC32做哈希，可以使用以下查询方式：
select id fom url where url="" and url_crc=CRC32("")
此查询性能较高原因是使用体积很小的索引来完成查找



#### 组合索引

当包含多个列作为索引，需要注意的是正确的顺序依赖于该索引的查询，同时需要考虑如何更好的满足排序和分组的需要

案例，建立组合索引a,b,c

where a=3, 使用索引a

where a=3 and b=5，使用索引a，b

wherea=3 and b=5 and c=4，使用索引a，b，c

where b=3 or c=4，不会使用索引。

where a=3 and c=4，使用索引a。

where a=3 and b>10 and c=7，使用索引a，b。

where a=3 and b like'％xx％' and c=7，不使用索引。



#### 聚簇索引

聚簇索引

不是单独的索引类型，而是一种数据存储方式，指的是数据行跟相邻的键值紧凑的存储在一起
   优点
    1、可以把相关数据保存在一起
    2、数据访问更快，因为索引和数据保存在同一个树中
    3、使用覆盖索引扫描的查询可以直接使用页节点中的主键值
   缺点
    1、聚簇数据最大限度地提高了IO密集型应用的性能，如果数据全部在内存，那么聚簇索引就没有什么优势
    2、插入速度严重依赖于插入顺序，按照主键的顺序插入是最快的方式
    3、更新聚簇索引列的代价很高，因为会强制将每个被更新的行移动到新的位置
    4、基于聚簇索引的表在插入新行，或者主键被更新导致需要移动行的时候，可能面临页分裂的问题
    5、聚簇索引可能导致全表扫描变慢，尤其是行比较稀疏，或者由于页分裂导致数据存储不连续的时候

非聚簇索引

数据文件跟索引文件分开存放



#### 覆盖索引

基本介绍
  1、如果一个索引包含所有需要查询的字段的值，我们称之为覆盖索引
  2、不是所有类型的索引都可以称为覆盖索引，覆盖索引必须要存储索引列的值
  3、不同的存储实现覆盖索引的方式不同，不是所有的引擎都支持覆盖索引，memory不支持覆盖索引

优势

 1、索引条目通常远小于数据行大小，如果只需要读取索引，那么mysql就会极大的较少数据访问量
 2、因为索引是按照列值顺序存储的，所以对于IO密集型的范围查询会比随机从磁盘读取每一行数据的IO要少的多
 3、一些存储引擎如MYISAM在内存中只缓存索引，数据则依赖于操作系统来缓存，因此要访问数据需要一次系统调用，这可能会导致严

重的性能问题

4、由于INNODB的聚簇索引，覆盖索引对INNODB表特别有用

##### 覆盖索引案例

如果想运行本章节的案例SQL，请先参考[数据准备章节](#数据准备)导入数据库sakila的脚本

1、当发起一个被索引覆盖的查询时，在explain的extra列可以看到using index的信息，此时就使用了覆盖索引

```sql
mysql> explain select store_id,film_id from inventory\G
*************************** 1. row ***************************
           id: 1
  select_type: SIMPLE
        table: inventory
   partitions: NULL
         type: index
possible_keys: NULL
          key: idx_store_id_film_id
      key_len: 3
          ref: NULL
         rows: 4581
     filtered: 100.00
        Extra: Using index
1 row in set, 1 warning (0.01 sec)

```

2、在大多数存储引擎中，覆盖索引只能覆盖那些只访问索引中部分列的查询。不过，可以进一步的进行优化，可以使用innodb的二级索引来覆盖查询。

例如：actor使用innodb存储引擎，并在last_name字段又二级索引，虽然该索引的列不包括主键actor_id，但也能够用于对actor_id做覆盖查询

```sql
mysql> explain select actor_id,last_name from actor where last_name='HOPPER'\G
*************************** 1. row ***************************
           id: 1
  select_type: SIMPLE
        table: actor
   partitions: NULL
         type: ref
possible_keys: idx_actor_last_name
          key: idx_actor_last_name
      key_len: 137
          ref: const
         rows: 2
     filtered: 100.00
        Extra: Using index
1 row in set, 1 warning (0.00 sec)

```



#### 前缀索引

##### 前缀索引案例

		有时候需要索引很长的字符串，这会让索引变的大且慢，通常情况下可以使用某个列开始的部分字符串，这样大大的节约索引空间，从而提高索引效率，但这会降低索引的选择性，索引的选择性是指不重复的索引值和数据表记录总数的比值，范围从1/#T到1之间。索引的选择性越高则查询效率越高，因为选择性更高的索引可以让mysql在查找的时候过滤掉更多的行。
	
		一般情况下某个列前缀的选择性也是足够高的，足以满足查询的性能，但是对应BLOB,TEXT,VARCHAR类型的列，必须要使用前缀索引，因为mysql不允许索引这些列的完整长度，使用该方法的诀窍在于要选择足够长的前缀以保证较高的选择性，通过又不能太长。

案例演示：

```sql
--创建数据表
create table citydemo(city varchar(50) not null);
insert into citydemo(city) select city from city;

--重复执行5次下面的sql语句
insert into citydemo(city) select city from citydemo;

--更新城市表的名称
update citydemo set city=(select city from city order by rand() limit 1);

--查找最常见的城市列表，发现每个值都出现45-65次，
select count(*) as cnt,city from citydemo group by city order by cnt desc limit 10;

--查找最频繁出现的城市前缀，先从3个前缀字母开始，发现比原来出现的次数更多，可以分别截取多个字符查看城市出现的次数
select count(*) as cnt,left(city,3) as pref from citydemo group by pref order by cnt desc limit 10;
select count(*) as cnt,left(city,7) as pref from citydemo group by pref order by cnt desc limit 10;
--此时前缀的选择性接近于完整列的选择性

--还可以通过另外一种方式来计算完整列的选择性，可以看到当前缀长度到达7之后，再增加前缀长度，选择性提升的幅度已经很小了
select count(distinct left(city,3))/count(*) as sel3,
count(distinct left(city,4))/count(*) as sel4,
count(distinct left(city,5))/count(*) as sel5,
count(distinct left(city,6))/count(*) as sel6,
count(distinct left(city,7))/count(*) as sel7,
count(distinct left(city,8))/count(*) as sel8 
from citydemo;

--计算完成之后可以创建前缀索引
alter table citydemo add key(city(7));

--注意：前缀索引是一种能使索引更小更快的有效方法，但是也包含缺点：mysql无法使用前缀索引做order by 和 group by。 
```



#### 关联查询Join

- [MySQL-Join官网说明](https://dev.mysql.com/doc/refman/5.7/en/nested-loop-joins.html)

- 如果join列有索引用的是Nested-Loop Join，如果没索引则用的是Block Nested-Loop Join Algorithm，

- 对于Nested-Loop Join，简单来说就是表a和表b做join，MySQL会用表a的所有行去匹配表B的所有行。

- 下面是官网给的案例，从这里可以看出这种算法的时间复杂度很高属于O(n^2^)，三张表就是O(n^3^)

- ```sql
  for each row in t1 matching range {
    for each row in t2 matching reference key {
      for each row in t3 {
        if row satisfies join conditions, send to client
      }
    }
  }
  ```

- 如果基于业务必须要进行多表join，建议使用主键字段或者在非驱动表上连接字段上加上索引，这样可以提升性能。

  - 如果有了索引在查询时，驱动表会根据关联字段的索引进行查找，当在索引上找到符合的值，再回表进行查询，也就是只有当匹配到索引以后才会进行回表查询。
  - 如果非驱动表的关联键是主键的话，性能会非常高，主键自带唯一索引。
  - 如果不是主键，要进行多次回表查询，先关联索引，然后根据二级索引的主键ID进行回表操作，性能上比索引或是主键要慢

- 如果join列没有索引，就会采用Block Nested-Loop Join。MySQL内部有个join buffer缓冲区（默认join_buffer_size=256k）。会将驱动表的所有join相关的列都先缓存到join bufer中，然后批量与匹配表进行匹配，将第一种多次比较合并为一次，降低了非驱动表的访问频率。在查找的时候MySQL会将所有需要的列缓存到join buffer当中，包括select的列，而不是仅仅只缓存关联列。在一个有N个JOIN关联的SQL当中会在执行时候分配N-1个join bufer。

  - 使用Block Nested-Loop Join算法需要开启优化器管理配置的optimizer_switch的设置block_nested_loop为on，默认为开启。
    show variables like '%optimizer_switch%'

  - 注意：由于join buffer缓冲区是有大小限制的，所以只要当要缓存的数据在这个限制内，MySQL才会使用这种方式。

  - 所以大家可以适当调大这个值的大小。

  - ```sh
    mysql> show variables like '%join_buffer_size%';
    +------------------+--------+
    | Variable_name    | Value  |
    +------------------+--------+
    | join_buffer_size | 262144 |
    +------------------+--------+
    1 row in set (0.02 sec)
    ```

- 关于驱动表：如果sql语句中写的是表a join 表b，MySQL不一定会将表a作为驱动表，而是会基于自己的优化器规则动态计算。如果你认为自己的方案比MySQL的优化器更好可以强制指定驱动表。语法：`表a STRAIGHT_JOIN 表b on 条件`

- 案例演示

  - 查看不同的顺序执行方式对查询性能的影响：
  - explain select film.film_id,film.title,film.release_year,actor.actor_id,actor.first_name,actor.lastname from film inner join film_actor using(film_id) inner join actor using(actor_id);
  - 查看执行的成本：
  - show status like 'last_query_cost';
  - 按照自己预想的规定顺序执行(straight_join)：
  - explain select straight_join film.filmid,film.title,film.releaseyear,actor.actorid,actor.firstname,actor.lastname from fil
    m inner join film_actor using(film_id) inner join actor using(actor_id); 
  - 查看执行的成本： show status like 'last_query_cost';



#### 优化细节

当使用索引列进行查询的时候尽量不要使用表达式，把计算放到业务层而不是数据库层

select actor_id from actor where actor_id=4;

select actor_id from actor where actor_id+1=5;

尽量使用主键查询，而不是其他索引，因此主键查询不会触发回表查询

使用前缀索引

使用索引扫描来排序

使用索引扫描来做排序.md

union all, in, or都能够使用索引，但是推荐使用in

explain select * from actor where actor_id = 1 union all select * from actor where actor_id = 2;

explain select * from actor where actor_id in (1,2);

explain select * from actor where actor_id = 1 or actor_id =2;

范围列可以用到索引

范围条件是：<、>

范围列可以用到索引，但是范围列后面的列无法用到索引，索引最多用于一个范围列

强制类型转换会全表扫描

explain select * from user where phone=13800001234;

不会触发索引

explain select * from user where phone='13800001234';

触发索引

更新十分频繁，数据区分度不高的字段上不宜建立索引

更新会变更B+树，更新频繁的字段建议索引会大大降低数据库性能

类似于性别这类区分不大的属性，建立索引是没有意义的，不能有效的过滤数据，

一般区分度在80%以上的时候就可以建立索引，区分度可以使用 count(distinct(列名))/count(*) 来计算

创建索引的列，不允许为null，否则可能会得到不符合预期的结果

当需要进行表连接的时候，最好不要超过三张表，因为需要join的字段，数据类型必须一致

能使用limit的时候尽量使用limit

- 例如：使用了limit 1 之后，MySQL只会计算一行的数据。但如果不写，下面如果有数据还会继续计算。
- 如果的limit的数据比较大也要慎用。例如：limit 10000，5。这时候mysql要按照顺序遍历到第10000行，再取5行。性能较低。

单表索引建议控制在5个以内

- 索引越多，索引树越大，索引文件越多，IO越多，增删改的时候维护成本越大。

组合索引字段数不要超过5个

创建索引的时候应该避免以下错误概念

- 索引越多越好

- 过早优化，在不了解系统的情况下进行优化



#### 索引监控

命令：show status like 'Handler_read%';

```shell
mysql> show status like 'Handler_read%';
+-----------------------+-------+
| Variable_name         | Value |
+-----------------------+-------+
| Handler_read_first    | 10    |
| Handler_read_key      | 863   |
| Handler_read_last     | 0     |
| Handler_read_next     | 2339  |
| Handler_read_prev     | 0     |
| Handler_read_rnd      | 283   |
| Handler_read_rnd_next | 3378  |
+-----------------------+-------+
7 rows in set (0.03 sec)
```

参数解释

Handler_read_first：

读取索引根节点的次数。如果该值很高，则表明服务器正在执行大量的全索引扫描(例如，SELECT col1 FROM foo，假设col1已被索引)。

Handler_read_key：通过index获取数据的次数（例如：总共100行数据，读了多少次索引）

Handler_read_last：读取索引最后一个条目的次数

Handler_read_next：通过索引读取下一条数据的次数

Handler_read_prev：通过索引读取上一条数据的次数

Handler_read_rnd：从固定位置读取数据的次数

Handler_read_rnd_next：从数据节点读取下一条数据的次数

**注意：以上参数为整个数据库的整体数据，一般越大越好，如果很小或者基本为零，那说明系统中大部分查询都没用到索引。在优化单个SQL时并不常用。**

[以上参数官网说明](https://dev.mysql.com/doc/refman/5.7/en/server-status-variables.html#statvar_Handler_read_first)



#### 优化案例

预先准备好数据

```sql
SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `itdragon_order_list`;
CREATE TABLE `itdragon_order_list` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键id，默认自增长',
  `transaction_id` varchar(150) DEFAULT NULL COMMENT '交易号',
  `gross` double DEFAULT NULL COMMENT '毛收入(RMB)',
  `net` double DEFAULT NULL COMMENT '净收入(RMB)',
  `stock_id` int(11) DEFAULT NULL COMMENT '发货仓库',
  `order_status` int(11) DEFAULT NULL COMMENT '订单状态',
  `descript` varchar(255) DEFAULT NULL COMMENT '客服备注',
  `finance_descript` varchar(255) DEFAULT NULL COMMENT '财务备注',
  `create_type` varchar(100) DEFAULT NULL COMMENT '创建类型',
  `order_level` int(11) DEFAULT NULL COMMENT '订单级别',
  `input_user` varchar(20) DEFAULT NULL COMMENT '录入人',
  `input_date` varchar(20) DEFAULT NULL COMMENT '录入时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10003 DEFAULT CHARSET=utf8;

INSERT INTO itdragon_order_list VALUES ('10000', '81X97310V32236260E', '6.6', '6.13', '1', '10', 'ok', 'ok', 'auto', '1', 'itdragon', '2017-08-28 17:01:49');
INSERT INTO itdragon_order_list VALUES ('10001', '61525478BB371361Q', '18.88', '18.79', '1', '10', 'ok', 'ok', 'auto', '1', 'itdragon', '2017-08-18 17:01:50');
INSERT INTO itdragon_order_list VALUES ('10002', '5RT64180WE555861V', '20.18', '20.17', '1', '10', 'ok', 'ok', 'auto', '1', 'itdragon', '2017-09-08 17:01:49');

```

逐步开始进行优化：

第一个案例：

```sql
select * from itdragon_order_list where transaction_id = "81X97310V32236260E";
--通过查看执行计划发现type=all,需要进行全表扫描
explain select * from itdragon_order_list where transaction_id = "81X97310V32236260E";

--优化一、为transaction_id创建唯一索引
 create unique index idx_order_transaID on itdragon_order_list (transaction_id);
--当创建索引之后，唯一索引对应的type是const，通过索引一次就可以找到结果，普通索引对应的type是ref，表示非唯一性索引赛秒，找到值还要进行扫描，直到将索引文件扫描完为止，显而易见，const的性能要高于ref
 explain select * from itdragon_order_list where transaction_id = "81X97310V32236260E";
 
 --优化二、使用覆盖索引，查询的结果变成 transaction_id,当extra出现using index,表示使用了覆盖索引
 explain select transaction_id from itdragon_order_list where transaction_id = "81X97310V32236260E";
```

第二个案例

```sql
--创建复合索引
create index idx_order_levelDate on itdragon_order_list (order_level,input_date);

--创建索引之后发现跟没有创建索引一样，都是全表扫描，都是文件排序
explain select * from itdragon_order_list order by order_level,input_date;

--可以使用force index强制指定索引
explain select * from itdragon_order_list force index(idx_order_levelDate) order by order_level,input_date;
--其实给订单排序意义不大，给订单级别添加索引意义也不大，因此可以先确定order_level的值，然后再给input_date排序
explain select * from itdragon_order_list where order_level=3 order by input_date;
```



### 性能监控

#### show profile

https://dev.mysql.com/doc/refman/8.0/en/show-profile.html

我们执行SQL语句时，默认会显示SQL执行时间。但是精确到小数点后2位。使用show profiles命令可以显示的更精确。

show profile和show profiles命令显示SQL的分析信息，这些信息指示当前会话过程中SQL的资源使用情况。

如果会话关闭，这些Profile信息将丢失。下面来看如何使用：

set profiling=1; 首先执行这个命令开启显示sql profile功能。

show s; 显示最近执行过的sql总体profile信息，精确到小数点后8位。

show profile; 显示最后一个sql的明细profile信息及duration列信息。

show profile for query 2; 显示某一个sql的profile数据。queryId可以通过show profiles;命令查询

show profile [type]; 显示一个SQL的指定类型的profile数据。如果type参数为空仅显示Duration数据。可以用all显示全部的。

下面是使用案例：

```sql
#系统默认显示的时间仅精确到小数点后2位
mysql> select * from employee;
Empty set (0.00 sec)

#开启profile功能，时间精确显示
mysql> set profiling=1;
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql> select * from employee;
Empty set (0.00 sec)

mysql> show profiles;
+----------+------------+------------------------+
| Query_ID | Duration   | Query                  |
+----------+------------+------------------------+
|        1 | 0.00021375 | select * from employee |
+----------+------------+------------------------+
1 row in set, 1 warning (0.00 sec)

#使用下面的命令会显示最后一个sql的明细profile信息及duration列信息
mysql> show profile;
+--------------------------------+----------+
| Status                         | Duration |
+--------------------------------+----------+
| starting                       | 0.000063 |
| Executing hook on transaction  | 0.000005 |
| starting                       | 0.000006 |
| checking permissions           | 0.000004 |
| Opening tables                 | 0.000024 |
| init                           | 0.000004 |
| System lock                    | 0.000006 |
| optimizing                     | 0.000003 |
| statistics                     | 0.000022 |
| preparing                      | 0.000011 |
| executing                      | 0.000020 |
| end                            | 0.000002 |
| query end                      | 0.000002 |
| waiting for handler commit     | 0.000006 |
| closing tables                 | 0.000006 |
| freeing items                  | 0.000023 |
| cleaning up                    | 0.000007 |
+--------------------------------+----------+
17 rows in set, 1 warning (0.00 sec)

#显示最后一个sql的明细profile信息及duration和cpu列信息
mysql> show profile cpu;
+--------------------------------+----------+----------+------------+
| Status                         | Duration | CPU_user | CPU_system |
+--------------------------------+----------+----------+------------+
| starting                       | 0.000112 | 0.000039 |   0.000067 |
| Executing hook on transaction  | 0.000007 | 0.000002 |   0.000003 |
| starting                       | 0.000010 | 0.000004 |   0.000007 |
| checking permissions           | 0.000007 | 0.000002 |   0.000004 |
| Opening tables                 | 0.000032 | 0.000012 |   0.000020 |
| init                           | 0.000005 | 0.000002 |   0.000003 |
| System lock                    | 0.000010 | 0.000004 |   0.000006 |
| optimizing                     | 0.000005 | 0.000001 |   0.000003 |
| statistics                     | 0.000016 | 0.000007 |   0.000010 |
| preparing                      | 0.000016 | 0.000006 |   0.000010 |
| executing                      | 0.000041 | 0.000015 |   0.000027 |
| end                            | 0.000005 | 0.000002 |   0.000002 |
| query end                      | 0.000004 | 0.000001 |   0.000002 |
| waiting for handler commit     | 0.000041 | 0.000016 |   0.000027 |
| closing tables                 | 0.000009 | 0.000003 |   0.000005 |
| freeing items                  | 0.000033 | 0.000012 |   0.000021 |
| cleaning up                    | 0.000008 | 0.000003 |   0.000005 |
+--------------------------------+----------+----------+------------+
17 rows in set, 1 warning (0.00 sec)

mysql> show profile cpu,ipc;
+--------------------------------+----------+----------+------------+---------------+-------------------+
| Status                         | Duration | CPU_user | CPU_system | Messages_sent | Messages_received |
+--------------------------------+----------+----------+------------+---------------+-------------------+
| starting                       | 0.000112 | 0.000039 |   0.000067 |             0 |                 0 |
| Executing hook on transaction  | 0.000007 | 0.000002 |   0.000003 |             0 |                 0 |
| starting                       | 0.000010 | 0.000004 |   0.000007 |             0 |                 0 |
| checking permissions           | 0.000007 | 0.000002 |   0.000004 |             0 |                 0 |
| Opening tables                 | 0.000032 | 0.000012 |   0.000020 |             0 |                 0 |
| init                           | 0.000005 | 0.000002 |   0.000003 |             0 |                 0 |
| System lock                    | 0.000010 | 0.000004 |   0.000006 |             0 |                 0 |
| optimizing                     | 0.000005 | 0.000001 |   0.000003 |             0 |                 0 |
| statistics                     | 0.000016 | 0.000007 |   0.000010 |             0 |                 0 |
| preparing                      | 0.000016 | 0.000006 |   0.000010 |             0 |                 0 |
| executing                      | 0.000041 | 0.000015 |   0.000027 |             0 |                 0 |
| end                            | 0.000005 | 0.000002 |   0.000002 |             0 |                 0 |
| query end                      | 0.000004 | 0.000001 |   0.000002 |             0 |                 0 |
| waiting for handler commit     | 0.000041 | 0.000016 |   0.000027 |             0 |                 0 |
| closing tables                 | 0.000009 | 0.000003 |   0.000005 |             0 |                 0 |
| freeing items                  | 0.000033 | 0.000012 |   0.000021 |             0 |                 0 |
| cleaning up                    | 0.000008 | 0.000003 |   0.000005 |             0 |                 0 |
+--------------------------------+----------+----------+------------+---------------+-------------------+
17 rows in set, 1 warning (0.00 sec)
```

##### profile步骤介绍

可以看到show profile;命令会显示出一个sql执行过程中每一个步骤的时间。以下是每个步骤的介绍

> starting：始执行
> Executing hook on transaction：开启对应事务
> checking permissions：检查权限
> Opening tables：打开表
> init：进行初始化的操作
> optimizing：优化的操作
> statistics：统计的操作
> executing：执行的操作

注意：此功能Profile可能在未来的MySQL版本移除。官网推荐使用[Performance Schema](https://dev.mysql.com/doc/refman/8.0/en/performance-schema.html)。



#### Performance Schema

[MySQL官网说明](https://dev.mysql.com/doc/refman/8.0/en/performance-schema.html)

MySQL的performance schema 用于监控MySQL server在一个较低级别的运行过程中的资源消耗、资源等待等情况。

这个功能在MySQL5.7开始时默认开启的。所以不用担心开启他会额外消耗性能。具体确认方法：

使用show databases;命令，如果结果里面包含performance_schema就代表启用了。

```shell
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
| tune               |
+--------------------+
5 rows in set (0.00 sec)
mysql> use performance_schema;
Database changed
mysql> show tables;
+------------------------------------------------------+
| Tables_in_performance_schema                         |
+------------------------------------------------------+
| accounts                                             |
| binary_log_transaction_compression_stats             |
| cond_instances                                       |
| data_lock_waits                                      |
| data_locks                                           |
| error_log                                            |
| events_errors_summary_by_account_by_error            |
| events_errors_summary_by_host_by_error               |
| events_errors_summary_by_thread_by_error             |
| events_errors_summary_by_user_by_error               |
| events_errors_summary_global_by_error                |
| events_stages_current                                |
| events_stages_history                                |
| events_stages_history_long                           |
| events_stages_summary_by_account_by_event_name       |
| events_stages_summary_by_host_by_event_name          |
| events_stages_summary_by_thread_by_event_name        |
| events_stages_summary_by_user_by_event_name          |
| events_stages_summary_global_by_event_name           |
| events_statements_current                            |
| events_statements_histogram_by_digest                |
| events_statements_histogram_global                   |
| events_statements_history                            |
| events_statements_history_long                       |
| events_statements_summary_by_account_by_event_name   |
| events_statements_summary_by_digest                  |
| events_statements_summary_by_host_by_event_name      |
| events_statements_summary_by_program                 |
| events_statements_summary_by_thread_by_event_name    |
| events_statements_summary_by_user_by_event_name      |
| events_statements_summary_global_by_event_name       |
| events_transactions_current                          |
| events_transactions_history                          |
| events_transactions_history_long                     |
| events_transactions_summary_by_account_by_event_name |
| events_transactions_summary_by_host_by_event_name    |
| events_transactions_summary_by_thread_by_event_name  |
| events_transactions_summary_by_user_by_event_name    |
| events_transactions_summary_global_by_event_name     |
| events_waits_current                                 |
| events_waits_history                                 |
| events_waits_history_long                            |
| events_waits_summary_by_account_by_event_name        |
| events_waits_summary_by_host_by_event_name           |
| events_waits_summary_by_instance                     |
| events_waits_summary_by_thread_by_event_name         |
| events_waits_summary_by_user_by_event_name           |
| events_waits_summary_global_by_event_name            |
| file_instances                                       |
| file_summary_by_event_name                           |
| file_summary_by_instance                             |
| global_status                                        |
| global_variables                                     |
| host_cache                                           |
| hosts                                                |
| keyring_component_status                             |
| keyring_keys                                         |
| log_status                                           |
| memory_summary_by_account_by_event_name              |
| memory_summary_by_host_by_event_name                 |
| memory_summary_by_thread_by_event_name               |
| memory_summary_by_user_by_event_name                 |
| memory_summary_global_by_event_name                  |
| metadata_locks                                       |
| mutex_instances                                      |
| objects_summary_global_by_type                       |
| performance_timers                                   |
| persisted_variables                                  |
| prepared_statements_instances                        |
| processlist                                          |
| replication_applier_configuration                    |
| replication_applier_filters                          |
| replication_applier_global_filters                   |
| replication_applier_status                           |
| replication_applier_status_by_coordinator            |
| replication_applier_status_by_worker                 |
| replication_asynchronous_connection_failover         |
| replication_asynchronous_connection_failover_managed |
| replication_connection_configuration                 |
| replication_connection_status                        |
| replication_group_member_stats                       |
| replication_group_members                            |
| rwlock_instances                                     |
| session_account_connect_attrs                        |
| session_connect_attrs                                |
| session_status                                       |
| session_variables                                    |
| setup_actors                                         |
| setup_consumers                                      |
| setup_instruments                                    |
| setup_objects                                        |
| setup_threads                                        |
| socket_instances                                     |
| socket_summary_by_event_name                         |
| socket_summary_by_instance                           |
| status_by_account                                    |
| status_by_host                                       |
| status_by_thread                                     |
| status_by_user                                       |
| table_handles                                        |
| table_io_waits_summary_by_index_usage                |
| table_io_waits_summary_by_table                      |
| table_lock_waits_summary_by_table                    |
| threads                                              |
| tls_channel_status                                   |
| user_defined_functions                               |
| user_variables_by_thread                             |
| users                                                |
| variables_by_thread                                  |
| variables_info                                       |
+------------------------------------------------------+
110 rows in set (0.00 sec)

mysql> 
```

##### 特点介绍

1. 提供了一种在数据库运行时实时检查server的内部执行情况的方法。performance_schema 数据库中的表使用performance_schema存储引擎。该数据库主要关注数据库运行过程中的性能相关的数据，与information_schema不同，information_schema主要关注server运行过程中的元数据信息

2. performance_schema通过监视server的事件来实现监视server内部运行情况， “事件”就是server内部活动中所做的任何事情以及对应的时间消耗，利用这些信息来判断server中的相关资源消耗在了哪里？一般来说，事件可以是函数调用. 操作系统的等待. SQL语句执行的阶段（如sql语句执行过程中的parsing 或 sorting阶段）或者整个SQL语句与SQL语句集合。事件的采集可以方便的提供server中的相关存储引擎对磁盘文件. 表I/O. 表锁等资源的同步调用信息。

3. performance_schema中的事件与写入二进制日志中的事件（描述数据修改的events）. 事件计划调度程序（这是一种存储程序）的事件不同。performance_schema中的事件记录的是server执行某些活动对某些资源的消耗. 耗时. 这些活动执行的次数等情况。

4. performance_schema中的事件只记录在本地server的performance_schema中，其下的这些表中数据发生变化时不会被写入binlog中，也不会通过复制机制被复制到其他server中。

5. 当前活跃事件. 历史事件和事件摘要相关的表中记录的信息。能提供某个事件的执行次数. 使用时长。进而可用于分析某个特定线程. 特定对象（如mutex或file）相关联的活动。

6. PERFORMANCE_SCHEMA存储引擎使用server源代码中的“检测点”来实现事件数据的收集。对于performance_schema实现机制本身的代码没有相关的单独线程来检测，这与其他功能（如复制或事件计划程序）不同

7. 收集的事件数据存储在performance_schema数据库的表中。这些表可以使用SELECT语句查询，也可以使用SQL语句更新performance_schema数据库中的表记录（如动态修改performance_schema的setup_*开头的几个配置表，但要注意：配置表的更改会立即生效，这会影响数据收集）

8. performance_schema的表中的数据不会持久化存储在磁盘中，而是保存在内存中，一旦服务器重启，这些数据会丢失（包括配置表在内的整个performance_schema下的所有数据）

9. MySQL支持的所有平台中事件监控功能都可用，但不同平台中用于统计事件时间开销的计时器类型可能会有所差异。



##### 开启关闭

performance schema默认开启，如果想要显式的关闭的话需要修改配置文件，不能直接进行修改，会报错Variable 'performance_schema' is a read only variable。

```sql
--查看performance_schema的属性
mysql> SHOW VARIABLES LIKE 'performance_schema';
+--------------------+-------+
| Variable_name      | Value |
+--------------------+-------+
| performance_schema | ON    |
+--------------------+-------+
1 row in set (0.01 sec)

--在配置文件中修改performance_schema的属性值，on表示开启，off表示关闭
[mysqld]
performance_schema=ON

--切换数据库
use performance_schema;

--查看当前数据库下的所有表,会看到有很多表存储着相关的信息
show tables;

--可以通过show create table tablename来查看创建表的时候的表结构
mysql> show create table setup_consumers;
+-----------------+---------------------------------
| Table           | Create Table                    
+-----------------+---------------------------------
| setup_consumers | CREATE TABLE `setup_consumers` (
  `NAME` varchar(64) NOT NULL,                      
  `ENABLED` enum('YES','NO') NOT NULL               
) ENGINE=PERFORMANCE_SCHEMA DEFAULT CHARSET=utf8 |  
+-----------------+---------------------------------
1 row in set (0.00 sec)                             
```



##### 基本概念

instruments：生产者，用于采集mysql中各种各样的操作产生的事件信息，对应配置表中的配置项我们可以称为监控采集配置项。

consumers：消费者，对应的消费者表用于存储来自instruments采集的数据，对应配置表中的配置项我们可以称为消费存储配置项。



##### 表的分类

performance_schema库下的表可以按照监视不同的纬度就行分组。

```sql
-- 语句事件记录表，这些表记录了语句事件信息，当前语句事件表events_statements_current、历史语句事件表events_statements_history和长语句历史事件表events_statements_history_long、以及聚合后的摘要表summary，其中，summary表还可以根据帐号(account)，主机(host)，程序(program)，线程(thread)，用户(user)和全局(global)再进行细分)
show tables like '%statement%';

-- 等待事件记录表，与语句事件类型的相关记录表类似：
show tables like '%wait%';

--阶段事件记录表，记录语句执行的阶段事件的表
show tables like '%stage%';

--事务事件记录表，记录事务相关的事件的表
show tables like '%transaction%';

--监控文件系统层调用的表
show tables like '%file%';

--监视内存使用的表
show tables like '%memory%';

--动态对performance_schema进行配置的配置表
show tables like '%setup%';
```



##### 简单配置与使用

数据库刚刚初始化并启动时，并非所有instruments(事件采集项，在采集项的配置表中每一项都有一个开关字段，或为YES，或为NO)和consumers(与采集项类似，也有一个对应的事件类型保存表配置项，为YES就表示对应的表保存性能数据，为NO就表示对应的表不保存性能数据)都启用了，所以默认不会收集所有的事件，可能你需要检测的事件并没有打开，需要进行设置，可以使用如下两个语句打开对应的instruments和consumers（行计数可能会因MySQL版本而异)。

```sql
select * from setup_instruments;
--打开等待事件的采集器配置项开关，需要修改setup_instruments配置表中对应的采集器配置项
UPDATE setup_instruments SET ENABLED = 'YES', TIMED = 'YES'where name like 'wait%';

select * from setup_consumers;
--打开等待事件的保存表配置开关，修改setup_consumers配置表中对应的配置项
UPDATE setup_consumers SET ENABLED = 'YES'where name like '%wait%';

--当配置完成之后可以查看当前server正在做什么，可以通过查询events_waits_current表来得知，该表中每个线程只包含一行数据，用于显示每个线程的最新监视事件
select * from events_waits_current\G
*************************** 1. row ***************************
            THREAD_ID: 11
             EVENT_ID: 570
         END_EVENT_ID: 570
           EVENT_NAME: wait/synch/mutex/innodb/buf_dblwr_mutex
               SOURCE: 
          TIMER_START: 4508505105239280
            TIMER_END: 4508505105270160
           TIMER_WAIT: 30880
                SPINS: NULL
        OBJECT_SCHEMA: NULL
          OBJECT_NAME: NULL
           INDEX_NAME: NULL
          OBJECT_TYPE: NULL
OBJECT_INSTANCE_BEGIN: 67918392
     NESTING_EVENT_ID: NULL
   NESTING_EVENT_TYPE: NULL
            OPERATION: lock
      NUMBER_OF_BYTES: NULL
                FLAGS: NULL
/*该信息表示线程id为11的线程正在等待buf_dblwr_mutex锁，等待事件为30880
属性说明：
	id:事件来自哪个线程，事件编号是多少
	event_name:表示检测到的具体的内容
	source:表示这个检测代码在哪个源文件中以及行号
	timer_start:表示该事件的开始时间
	timer_end:表示该事件的结束时间
	timer_wait:表示该事件总的花费时间
注意：_current表中每个线程只保留一条记录，一旦线程完成工作，该表中不会再记录该线程的事件信息
*/

/*
_history表中记录每个线程应该执行完成的事件信息，但每个线程的事件信息只会记录10条，再多就会被覆盖，*_history_long表中记录所有线程的事件信息，但总记录数量是10000，超过就会被覆盖掉
*/
select thread_id,event_id,event_name,timer_wait from events_waits_history order by thread_id limit 21;

/*
summary表提供所有事件的汇总信息，该组中的表以不同的方式汇总事件数据（如：按用户，按主机，按线程等等）。例如：要查看哪些instruments占用最多的时间，可以通过对events_waits_summary_global_by_event_name表的COUNT_STAR或SUM_TIMER_WAIT列进行查询（这两列是对事件的记录数执行COUNT（*）、事件记录的TIMER_WAIT列执行SUM（TIMER_WAIT）统计而来）
*/
SELECT EVENT_NAME,COUNT_STAR FROM events_waits_summary_global_by_event_name  ORDER BY COUNT_STAR DESC LIMIT 10;

/*
instance表记录了哪些类型的对象会被检测。这些对象在被server使用时，在该表中将会产生一条事件记录，例如，file_instances表列出了文件I/O操作及其关联文件名
*/
select * from file_instances limit 20; 
```



##### 常用配置项的参数说明

1、启动选项

```sql
performance_schema_consumer_events_statements_current=TRUE
是否在mysql server启动时就开启events_statements_current表的记录功能(该表记录当前的语句事件信息)，启动之后也可以在setup_consumers表中使用UPDATE语句进行动态更新setup_consumers配置表中的events_statements_current配置项，默认值为TRUE

performance_schema_consumer_events_statements_history=TRUE
与performance_schema_consumer_events_statements_current选项类似，但该选项是用于配置是否记录语句事件短历史信息，默认为TRUE

performance_schema_consumer_events_stages_history_long=FALSE
与performance_schema_consumer_events_statements_current选项类似，但该选项是用于配置是否记录语句事件长历史信息，默认为FALSE

除了statement(语句)事件之外，还支持：wait(等待)事件、state(阶段)事件、transaction(事务)事件，他们与statement事件一样都有三个启动项分别进行配置，但这些等待事件默认未启用，如果需要在MySQL Server启动时一同启动，则通常需要写进my.cnf配置文件中
performance_schema_consumer_global_instrumentation=TRUE
是否在MySQL Server启动时就开启全局表（如：mutex_instances、rwlock_instances、cond_instances、file_instances、users、hostsaccounts、socket_summary_by_event_name、file_summary_by_instance等大部分的全局对象计数统计和事件汇总统计信息表 ）的记录功能，启动之后也可以在setup_consumers表中使用UPDATE语句进行动态更新全局配置项
默认值为TRUE

performance_schema_consumer_statements_digest=TRUE
是否在MySQL Server启动时就开启events_statements_summary_by_digest 表的记录功能，启动之后也可以在setup_consumers表中使用UPDATE语句进行动态更新digest配置项
默认值为TRUE

performance_schema_consumer_thread_instrumentation=TRUE
是否在MySQL Server启动时就开启

events_xxx_summary_by_yyy_by_event_name表的记录功能，启动之后也可以在setup_consumers表中使用UPDATE语句进行动态更新线程配置项
默认值为TRUE

performance_schema_instrument[=name]
是否在MySQL Server启动时就启用某些采集器，由于instruments配置项多达数千个，所以该配置项支持key-value模式，还支持%号进行通配等，如下:

[=name]可以指定为具体的Instruments名称（但是这样如果有多个需要指定的时候，就需要使用该选项多次），也可以使用通配符，可以指定instruments相同的前缀+通配符，也可以使用%代表所有的instruments

####### 指定开启单个instruments

--performance-schema-instrument= 'instrument_name=value'

####### 使用通配符指定开启多个instruments

--performance-schema-instrument= 'wait/synch/cond/%=COUNTED'

####### 开关所有的instruments

--performance-schema-instrument= '%=ON'

--performance-schema-instrument= '%=OFF'

注意，这些启动选项要生效的前提是，需要设置performance_schema=ON。另外，这些启动选项虽然无法使用show variables语句查看，但我们可以通过setup_instruments和setup_consumers表查询这些选项指定的值。
```

2、系统变量

```sql
show variables like '%performance_schema%';
--重要的属性解释
performance_schema=ON
/*
控制performance_schema功能的开关，要使用MySQL的performance_schema，需要在mysqld启动时启用，以启用事件收集功能
该参数在5.7.x之前支持performance_schema的版本中默认关闭，5.7.x版本开始默认开启
注意：如果mysqld在初始化performance_schema时发现无法分配任何相关的内部缓冲区，则performance_schema将自动禁用，并将performance_schema设置为OFF
*/

performance_schema_digests_size=10000
/*
控制events_statements_summary_by_digest表中的最大行数。如果产生的语句摘要信息超过此最大值，便无法继续存入该表，此时performance_schema会增加状态变量
*/
performance_schema_events_statements_history_long_size=10000
/*
控制events_statements_history_long表中的最大行数，该参数控制所有会话在events_statements_history_long表中能够存放的总事件记录数，超过这个限制之后，最早的记录将被覆盖
全局变量，只读变量，整型值，5.6.3版本引入 * 5.6.x版本中，5.6.5及其之前的版本默认为10000，5.6.6及其之后的版本默认值为-1，通常情况下，自动计算的值都是10000 * 5.7.x版本中，默认值为-1，通常情况下，自动计算的值都是10000
*/
performance_schema_events_statements_history_size=10
/*
控制events_statements_history表中单个线程（会话）的最大行数，该参数控制单个会话在events_statements_history表中能够存放的事件记录数，超过这个限制之后，单个会话最早的记录将被覆盖
全局变量，只读变量，整型值，5.6.3版本引入 * 5.6.x版本中，5.6.5及其之前的版本默认为10，5.6.6及其之后的版本默认值为-1，通常情况下，自动计算的值都是10 * 5.7.x版本中，默认值为-1，通常情况下，自动计算的值都是10
除了statement(语句)事件之外，wait(等待)事件、state(阶段)事件、transaction(事务)事件，他们与statement事件一样都有三个参数分别进行存储限制配置，有兴趣的同学自行研究，这里不再赘述
*/
performance_schema_max_digest_length=1024
/*
用于控制标准化形式的SQL语句文本在存入performance_schema时的限制长度，该变量与max_digest_length变量相关(max_digest_length变量含义请自行查阅相关资料)
全局变量，只读变量，默认值1024字节，整型值，取值范围0~1048576
*/
performance_schema_max_sql_text_length=1024
/*
控制存入events_statements_current，events_statements_history和events_statements_history_long语句事件表中的SQL_TEXT列的最大SQL长度字节数。 超出系统变量performance_schema_max_sql_text_length的部分将被丢弃，不会记录，一般情况下不需要调整该参数，除非被截断的部分与其他SQL比起来有很大差异
全局变量，只读变量，整型值，默认值为1024字节，取值范围为0~1048576，5.7.6版本引入
降低系统变量performance_schema_max_sql_text_length值可以减少内存使用，但如果汇总的SQL中，被截断部分有较大差异，会导致没有办法再对这些有较大差异的SQL进行区分。 增加该系统变量值会增加内存使用，但对于汇总SQL来讲可以更精准地区分不同的部分。
*/
```



##### 重要配置表的相关说明

		配置表之间存在相互关联关系，按照配置影响的先后顺序，可添加为

![image-20191203125003597](C:\Users\63198\AppData\Roaming\Typora\typora-user-images\image-20191203125003597.png)

```sql
/*
performance_timers表中记录了server中有哪些可用的事件计时器
字段解释：
	timer_name:表示可用计时器名称，CYCLE是基于CPU周期计数器的定时器
	timer_frequency:表示每秒钟对应的计时器单位的数量,CYCLE计时器的换算值与CPU的频率相关、
	timer_resolution:计时器精度值，表示在每个计时器被调用时额外增加的值
	timer_overhead:表示在使用定时器获取事件时开销的最小周期值
*/
select * from performance_timers;

/*
setup_timers表中记录当前使用的事件计时器信息
字段解释：
	name:计时器类型，对应某个事件类别
	timer_name:计时器类型名称
*/
select * from setup_timers;

/*
setup_consumers表中列出了consumers可配置列表项
字段解释：
	NAME：consumers配置名称
	ENABLED：consumers是否启用，有效值为YES或NO，此列可以使用UPDATE语句修改。
*/
select * from setup_consumers;

/*
setup_instruments 表列出了instruments 列表配置项，即代表了哪些事件支持被收集：
字段解释：
	NAME：instruments名称，instruments名称可能具有多个部分并形成层次结构
	ENABLED：instrumetns是否启用，有效值为YES或NO，此列可以使用UPDATE语句修改。如果设置为NO，则这个instruments不会被执行，不会产生任何的事件信息
	TIMED：instruments是否收集时间信息，有效值为YES或NO，此列可以使用UPDATE语句修改，如果设置为NO，则这个instruments不会收集时间信息
*/
SELECT * FROM setup_instruments;

/*
setup_actors表的初始内容是匹配任何用户和主机，因此对于所有前台线程，默认情况下启用监视和历史事件收集功能
字段解释：
	HOST：与grant语句类似的主机名，一个具体的字符串名字，或使用“％”表示“任何主机”
	USER：一个具体的字符串名称，或使用“％”表示“任何用户”
	ROLE：当前未使用，MySQL 8.0中才启用角色功能
	ENABLED：是否启用与HOST，USER，ROLE匹配的前台线程的监控功能，有效值为：YES或NO
	HISTORY：是否启用与HOST， USER，ROLE匹配的前台线程的历史事件记录功能，有效值为：YES或NO
*/
SELECT * FROM setup_actors;

/*
setup_objects表控制performance_schema是否监视特定对象。默认情况下，此表的最大行数为100行。
字段解释：
	OBJECT_TYPE：instruments类型，有效值为：“EVENT”（事件调度器事件）、“FUNCTION”（存储函数）、“PROCEDURE”（存储过程）、“TABLE”（基表）、“TRIGGER”（触发器），TABLE对象类型的配置会影响表I/O事件（wait/io/table/sql/handler instrument）和表锁事件（wait/lock/table/sql/handler instrument）的收集
	OBJECT_SCHEMA：某个监视类型对象涵盖的数据库名称，一个字符串名称，或“％”(表示“任何数据库”)
	OBJECT_NAME：某个监视类型对象涵盖的表名，一个字符串名称，或“％”(表示“任何数据库内的对象”)
	ENABLED：是否开启对某个类型对象的监视功能，有效值为：YES或NO。此列可以修改
	TIMED：是否开启对某个类型对象的时间收集功能，有效值为：YES或NO，此列可以修改
*/
SELECT * FROM setup_objects;

/*
threads表对于每个server线程生成一行包含线程相关的信息，
字段解释：
	THREAD_ID：线程的唯一标识符（ID）
	NAME：与server中的线程检测代码相关联的名称(注意，这里不是instruments名称)
	TYPE：线程类型，有效值为：FOREGROUND、BACKGROUND。分别表示前台线程和后台线程
	PROCESSLIST_ID：对应INFORMATION_SCHEMA.PROCESSLIST表中的ID列。
	PROCESSLIST_USER：与前台线程相关联的用户名，对于后台线程为NULL。
	PROCESSLIST_HOST：与前台线程关联的客户端的主机名，对于后台线程为NULL。
	PROCESSLIST_DB：线程的默认数据库，如果没有，则为NULL。
	PROCESSLIST_COMMAND：对于前台线程，该值代表着当前客户端正在执行的command类型，如果是sleep则表示当前会话处于空闲状态
	PROCESSLIST_TIME：当前线程已处于当前线程状态的持续时间（秒）
	PROCESSLIST_STATE：表示线程正在做什么事情。
	PROCESSLIST_INFO：线程正在执行的语句，如果没有执行任何语句，则为NULL。
	PARENT_THREAD_ID：如果这个线程是一个子线程（由另一个线程生成），那么该字段显示其父线程ID
	ROLE：暂未使用
	INSTRUMENTED：线程执行的事件是否被检测。有效值：YES、NO 
	HISTORY：是否记录线程的历史事件。有效值：YES、NO * 
	THREAD_OS_ID：由操作系统层定义的线程或任务标识符（ID）：
*/
select * from threads
```

注意：在performance_schema库中还包含了很多其他的库和表，能对数据库的性能做完整的监控，大家需要参考官网详细了解。

##### performance_schema实践操作

		基本了解了表的相关信息之后，可以通过这些表进行实际的查询操作来进行实际的分析。

```sql
--1、哪类的SQL执行最多？
SELECT DIGEST_TEXT,COUNT_STAR,FIRST_SEEN,LAST_SEEN FROM events_statements_summary_by_digest ORDER BY COUNT_STAR DESC
--2、哪类SQL的平均响应时间最多？
SELECT DIGEST_TEXT,AVG_TIMER_WAIT FROM events_statements_summary_by_digest ORDER BY COUNT_STAR DESC
--3、哪类SQL排序记录数最多？
SELECT DIGEST_TEXT,SUM_SORT_ROWS FROM events_statements_summary_by_digest ORDER BY COUNT_STAR DESC
--4、哪类SQL扫描记录数最多？
SELECT DIGEST_TEXT,SUM_ROWS_EXAMINED FROM events_statements_summary_by_digest ORDER BY COUNT_STAR DESC
--5、哪类SQL使用临时表最多？
SELECT DIGEST_TEXT,SUM_CREATED_TMP_TABLES,SUM_CREATED_TMP_DISK_TABLES FROM events_statements_summary_by_digest ORDER BY COUNT_STAR DESC
--6、哪类SQL返回结果集最多？
SELECT DIGEST_TEXT,SUM_ROWS_SENT FROM events_statements_summary_by_digest ORDER BY COUNT_STAR DESC
--7、哪个表物理IO最多？
SELECT file_name,event_name,SUM_NUMBER_OF_BYTES_READ,SUM_NUMBER_OF_BYTES_WRITE FROM file_summary_by_instance ORDER BY SUM_NUMBER_OF_BYTES_READ + SUM_NUMBER_OF_BYTES_WRITE DESC
--8、哪个表逻辑IO最多？
SELECT object_name,COUNT_READ,COUNT_WRITE,COUNT_FETCH,SUM_TIMER_WAIT FROM table_io_waits_summary_by_table ORDER BY sum_timer_wait DESC
--9、哪个索引访问最多？
SELECT OBJECT_NAME,INDEX_NAME,COUNT_FETCH,COUNT_INSERT,COUNT_UPDATE,COUNT_DELETE FROM table_io_waits_summary_by_index_usage ORDER BY SUM_TIMER_WAIT DESC
--10、哪个索引从来没有用过？
SELECT OBJECT_SCHEMA,OBJECT_NAME,INDEX_NAME FROM table_io_waits_summary_by_index_usage WHERE INDEX_NAME IS NOT NULL AND COUNT_STAR = 0 AND OBJECT_SCHEMA <> 'mysql' ORDER BY OBJECT_SCHEMA,OBJECT_NAME;
--11、哪个等待事件消耗时间最多？
SELECT EVENT_NAME,COUNT_STAR,SUM_TIMER_WAIT,AVG_TIMER_WAIT FROM events_waits_summary_global_by_event_name WHERE event_name != 'idle' ORDER BY SUM_TIMER_WAIT DESC
--12-1、剖析某条SQL的执行情况，包括statement信息，stege信息，wait信息
SELECT EVENT_ID,sql_text FROM events_statements_history WHERE sql_text LIKE '%count(*)%';
--12-2、查看每个阶段的时间消耗
SELECT event_id,EVENT_NAME,SOURCE,TIMER_END - TIMER_START FROM events_stages_history_long WHERE NESTING_EVENT_ID = 1553;
--12-3、查看每个阶段的锁等待情况
SELECT event_id,event_name,source,timer_wait,object_name,index_name,operation,nesting_event_id FROM events_waits_history_longWHERE nesting_event_id = 1553;
```



#### show命令

##### show processlist

显示所有连接到MySQL服务器的客户端连接以及此链接的ip地址，执行的命令，执行时间，执行状态，连接的数据库等。

```shell
mysql> show processlist;
+----+-----------------+-----------+--------------------+---------+-------+------------------------+------------------+
| Id | User            | Host      | db                 | Command | Time  | State                  | Info             |
+----+-----------------+-----------+--------------------+---------+-------+------------------------+------------------+
|  5 | event_scheduler | localhost | NULL               | Daemon  | 12586 | Waiting on empty queue | NULL             |
| 10 | root            | localhost | performance_schema | Query   |     0 | init                   | show processlist |
+----+-----------------+-----------+--------------------+---------+-------+------------------------+------------------+
2 rows in set (0.01 sec)

-- 显示全部mysql进程信息
mysql> show full processlist;
+----+------+-----------------+-------+---------+-------+----------+-----------------------+
| Id | User | Host            | db    | Command | Time  | State    | Info                  |
+----+------+-----------------+-------+---------+-------+----------+-----------------------+
|  2 | root | localhost:61450 | NULL  | Sleep   | 27534 |          | NULL                  |
|  4 | root | localhost:63719 | tune  | Sleep   | 11122 |          | NULL                  |
|  5 | root | localhost:63720 | tune  | Sleep   | 11114 |          | NULL                  |
|  6 | root | localhost:63721 | tune  | Sleep   |  9042 |          | NULL                  |
|  7 | root | localhost:64652 | tune  | Query   |     0 | starting | show full processlist |
+----+------+-----------------+-------+---------+-------+----------+-----------------------+
kill [id]
```

这个命令一般用的比较少，因为一般项目的连接都是连接池管理的，比较少出问题。

**属性说明**

- id表示session id
- user表示操作的用户
- host表示操作的主机
- db表示操作的数据库
- command表示当前状态
  - sleep：线程正在等待客户端发送新的请求
  - query：线程正在执行查询或正在将结果发送给客户端
  - locked：在mysql的服务层，该线程正在等待表锁
  - analyzing and statistics：线程正在收集存储引擎的统计信息，并生成查询的执行计划
  - Copying to tmp table：线程正在执行查询，并且将其结果集都复制到一个临时表中
  - sorting result：线程正在对结果集进行排序
  - sending data：线程可能在多个状态之间传送数据，或者在生成结果集或者向客户端返回数据
- info表示详细的sql语句
- time表示相应命令执行时间
- state表示命令执行状态



##### show status

show status; 命令用来查看服务器的状态信息。

show status中混杂了全局和会话变量，其中许多变量有双重域：既是全局变量，也是会话变量，有相同的名字。如果只需要看全局变量，需要改为show global status; 查看。

show status; 的返回结果很多，可以使用LIKE来过滤返回值。

--查看当前服务器启动后的运行时间

show status like 'uptime'; 

-- 查看当前服务器缓存相关状态。

show status like '%cache%'; 

--查询本次服务器启动之后执行select语句的次数。类似还有com_insert，com_update，com_delete

show status like 'com_select'; 

--查看试图连接到MySQL(不管是否连接成功)的连接数

show status like 'connections';

--查看线程缓存内的线程的数量。

show status like 'threads_cached';

--查看当前打开的连接的数量。

show status like 'threads_connected';

--查看当前打开的连接的数量。

show status like 'threads_connected';

--查看创建用来处理连接的线程数。如果Threads_created较大，你可能要增加thread_cache_size值。

show status like 'threads_created';

--查看激活的(非睡眠状态)线程数。

show status like 'threads_running';

--查看立即获得的表的锁的次数。

show status like 'table_locks_immediate';

--查看不能立即获得的表的锁的次数。如果该值较高，并且有性能问题，你应首先优化查询，然后拆分表或使用复制。

show status like 'table_locks_waited';

--查看创建时间超过slow_launch_time秒的线程数。

show status like 'slow_launch_threads';

--查看查询时间超过long_query_time秒的查询的个数。

show status like 'slow_queries';



##### show engine

show engine 存储引擎运行信息

show engine 用来显示存储引擎的当前运行信息，包括事务持有的表锁、行锁信息;

事务的锁等待情况;线程信号量等待;文件IO请求; buffer pool统计信息。

例如∶

show engine innodb status;

开启InnoDB监控:

set GLOBAL innodb_status_output=ON;

开启标准监控和锁监控

set GLOBAL innodb_status_output_locks=ON;

很多开源的MySQL监控工具，其实他们的原理也都是读取的服务器、操作系统、MySQL服务的状态和变量。



#### 执行计划

使用explain可以模拟优化器执行SQL语句，从而知道MySQL处理SQL语句的执行计划，分析SQL语句的性能瓶颈。

使用方式：explain [你要执行的SQL语句]

说明：MySQL 5.6.3以前只能分析SELECT；5.6.3以后可以分析update、delete、insert了。

官网explain说明： https://dev.mysql.com/doc/refman/8.0/en/explain-output.html

**执行计划输出字段**

| Column                                                       | JSON Name       | Meaning                                        |
| ------------------------------------------------------------ | --------------- | ---------------------------------------------- |
| [`id`](https://dev.mysql.com/doc/refman/8.0/en/explain-output.html#explain_id) | `select_id`     | The `SELECT` identifier                        |
| [`select_type`](https://dev.mysql.com/doc/refman/8.0/en/explain-output.html#explain_select_type) | None            | The `SELECT` type                              |
| [`table`](https://dev.mysql.com/doc/refman/8.0/en/explain-output.html#explain_table) | `table_name`    | The table for the output row                   |
| [`partitions`](https://dev.mysql.com/doc/refman/8.0/en/explain-output.html#explain_partitions) | `partitions`    | The matching partitions                        |
| [`type`](https://dev.mysql.com/doc/refman/8.0/en/explain-output.html#explain_type) | `access_type`   | The join type                                  |
| [`possible_keys`](https://dev.mysql.com/doc/refman/8.0/en/explain-output.html#explain_possible_keys) | `possible_keys` | The possible indexes to choose                 |
| [`key`](https://dev.mysql.com/doc/refman/8.0/en/explain-output.html#explain_key) | `key`           | The index actually chosen                      |
| [`key_len`](https://dev.mysql.com/doc/refman/8.0/en/explain-output.html#explain_key_len) | `key_length`    | The length of the chosen key                   |
| [`ref`](https://dev.mysql.com/doc/refman/8.0/en/explain-output.html#explain_ref) | `ref`           | The columns compared to the index              |
| [`rows`](https://dev.mysql.com/doc/refman/8.0/en/explain-output.html#explain_rows) | `rows`          | Estimate of rows to be examined                |
| [`filtered`](https://dev.mysql.com/doc/refman/8.0/en/explain-output.html#explain_filtered) | `filtered`      | Percentage of rows filtered by table condition |
| [`Extra`](https://dev.mysql.com/doc/refman/8.0/en/explain-output.html#explain_extra) | None            | Additional information                         |

##### id

是一组数字，代表SQL语句每一步执行计划的序列号。

id号分三种情况：

1、如果id相同，那么代表执行顺序从上到下

```sql
explain select * from emp e join dept d on e.deptno = d.deptno join salgrade sg on e.sal between sg.losal and sg.hisal;
```

2、如果id不同，id值越大优先级越高，越先被执行。如果是子查询，id的序号会较大，

```sql
explain select * from emp e where e.deptno in (select d.deptno from dept d where d.dname = 'SALES');
```

3、id相同和不同同时存在：相同的可以认为是一组，从上往下顺序执行，在所有组中，id值越大，优先级越高，越先执行

```sql
explain select * from emp e join dept d on e.deptno = d.deptno join salgrade sg on e.sal between sg.losal and sg.hisal where e.deptno in (select d.deptno from dept d where d.dname = 'SALES');
```

##### select_type

主要用来分辨查询的类型，是普通查询还是联合查询还是子查询

```sql
-- sample:简单的查询，不包含子查询和union
explain select * from emp;

-- primary:查询中若包含任何复杂的子查询，最外层查询则被标记为Primary
explain select staname,ename supname from (select ename staname,mgr from emp) t join emp on t.mgr=emp.empno ;

-- union:若第二个select出现在union之后，则被标记为union
explain select * from emp where deptno = 10 union select * from emp where sal >2000;

-- dependent union:跟union类似，此处的depentent表示union或union all联合而成的结果会受外部表影响
explain select * from emp e where e.empno  in ( select empno from emp where deptno = 10 union select empno from emp where sal >2000)

-- union result:从union表获取结果的select
explain select * from emp where deptno = 10 union select * from emp where sal >2000;

-- subquery:在select或者where列表中包含子查询
explain select * from emp where sal > (select avg(sal) from emp) ;

-- dependent subquery:subquery的子查询要受到外部表查询的影响
explain select * from emp e where e.deptno in (select distinct deptno from dept);

-- DERIVED: 在 from 子句中的子查询。MySQL会将结果存放在一个临时表中，也称为派生表
explain select staname,ename supname from (select ename staname,mgr from emp) t join emp on t.mgr=emp.empno ;

-- UNCACHEABLE SUBQUERY：表示使用子查询的结果不能被缓存
 explain select * from emp where empno = (select empno from emp where deptno=@@sort_buffer_size);
 
-- uncacheable union:表示union的查询结果不能被缓存：sql语句未验证
```

##### table

对应行正在访问哪一个表，表名或者别名，可能是临时表或者union合并结果集
1、如果是具体的表名，则表明从实际的物理表中获取数据，当然也可以是表的别名

2、表名是derivedN的形式，表示使用了id为N的查询产生的衍生表

3、当有union result的时候，表名是union n1,n2等的形式，n1,n2表示参与union的id

##### type

type显示的是访问类型，访问类型表示我是以何种方式去访问我们的数据，最容易想的是全表扫描，直接暴力的遍历一张表去寻找需要的数据，效率非常低下，访问的类型有很多，效率从最好到最坏依次是：

system > const > eq_ref > ref > fulltext > ref_or_null > index_merge > unique_subquery > index_subquery > range > index > ALL 

一般情况下，得保证查询至少达到range级别，最好能达到ref

```sql
-- all:全表扫描，一般情况下出现这样的sql语句而且数据量比较大的话那么就需要进行优化。
explain select * from emp;

-- index：全索引扫描这个比all的效率要好，主要有两种情况，一种是当前的查询时覆盖索引，即我们需要的数据在索引中就可以索取，或者是使用了索引进行排序，这样就避免数据的重排序
explain  select empno from emp;

-- range：表示利用索引查询的时候限制了范围，在指定范围内进行查询，这样避免了index的全索引扫描，适用的操作符： =, <>, >, >=, <, <=, IS NULL, BETWEEN, LIKE, or IN() 
explain select * from emp where empno between 7000 and 7500;

-- index_subquery：利用索引来关联子查询，不再扫描全表
explain select * from emp where emp.job in (select job from t_job);

-- unique_subquery:该连接类型类似与index_subquery,使用的是唯一索引
 explain select * from emp e where e.deptno in (select distinct deptno from dept);
 
-- index_merge：在查询过程中需要多个索引组合使用，没有模拟出来

-- ref_or_null：对于某个字段即需要关联条件，也需要null值的情况下，查询优化器会选择这种访问方式
explain select * from emp e where  e.mgr is null or e.mgr=7369;

--ref：使用了非唯一性索引进行数据的查找
 create index idx_3 on emp(deptno);
 explain select * from emp e,dept d where e.deptno =d.deptno;

--eq_ref ：使用唯一性索引进行数据查找
explain select * from emp,emp2 where emp.empno = emp2.empno;

-- const：主键索引或者唯一索引，只能查到一条数据的SQL。，
explain select * from emp where empno = 7369;
 
--system：表只有一行记录（等于系统表），这是const类型的特例，平时不会出现
```

#####  possible_keys

显示可能应用在这张表中的索引，一个或多个，查询涉及到的字段上若存在索引，则该索引将被列出，但不一定被查询实际使用

```sql
explain select * from emp,dept where emp.deptno = dept.deptno and emp.deptno = 10;
```

##### key

实际使用的索引，如果为null，则没有使用索引，查询中若使用了覆盖索引，则该索引和查询的select字段重叠。

```sql
explain select * from emp,dept where emp.deptno = dept.deptno and emp.deptno = 10;
```

##### key_len

表示索引中使用的字节数，可以通过key_len计算查询中使用的索引长度，在不损失精度的情况下长度越短越好。

```sql
explain select * from emp,dept where emp.deptno = dept.deptno and emp.deptno = 10;
```

##### ref

显示索引的哪一列被使用了，如果可能的话，是一个常数

```sql
explain select * from emp,dept where emp.deptno = dept.deptno and emp.deptno = 10;
```

##### rows

根据表的统计信息及索引使用情况，大致估算出找出所需记录需要读取的行数，此参数很重要，直接反应的sql找了多少数据，在完成目的的情况下越少越好

```sql
explain select * from emp;
```

##### extra

执行计划给出的额外的信息说明。

```sql
--using filesort:说明mysql无法利用索引进行排序，只能利用排序算法进行排序，会消耗额外的位置
explain select * from emp order by sal;

--using temporary:建立临时表来保存中间结果，查询完成之后把临时表删除
explain select ename,count(*) from emp where deptno = 10 group by ename;

--using index:这个表示当前的查询时覆盖索引的，直接从索引中读取数据，而不用访问数据表。如果同时出现using where 表名索引被用来执行索引键值的查找，如果没有，表面索引被用来读取数据，而不是真的查找
explain select deptno,count(*) from emp group by deptno limit 10;

--using where:使用where进行条件过滤
explain select * from t_user where id = 1;

--using join buffer:使用连接缓存，情况没有模拟出来

--impossible where：where语句的结果总是false
explain select * from emp where empno = 7469;
```



#### 慢查询分析

慢查询，顾名思义，执行很慢的查询。有多慢？超过 long_query_time 参数设定的时间阈值（默认10s），就被认为是慢的，是需要优化的。慢查询被记录在慢查询日志里。

慢查询日志默认是不开启的，如果你需要优化SQL语句，就可以开启这个功能，它可以让你很容易地知道哪些语句是需要优化的。

##### 慢查询开启

- 输入命令开启慢查询（临时），在MySQL服务重启后会自动关闭；

  - ```sh
    mysql> show variables like '%slow_query%';
    +---------------------+-----------------------------------+
    | Variable_name       | Value                             |
    +---------------------+-----------------------------------+
    | slow_query_log      | OFF                               |
    | slow_query_log_file | /www/server/data/mysql-slow.log |
    +---------------------+-----------------------------------+
    2 rows in set (0.01 sec)
    
    # 临时开启慢查询
    mysql> set global slow_query_log='ON'; 
    Query OK, 0 rows affected (0.00 sec)
    ```

  - 开启后，当查询执行时间超过配置的阈值时（long_query_time 单位：秒，默认10秒），就会将sql打印到slow_query_log_file配置项指定的文件中。

  - 

- 配置my.cnf（windows是my.ini）系统文件开启，修改配置文件是永久开启慢查询的方式。

  - 在my.cnf文件的[mysqld]下增加如下配置开启慢查询，如下

  - ```ini
    [mysqld]
    # 开启慢查询功能
    slow_query_log=ON
    # 指定记录慢查询日志SQL执行时间得阈值
    long_query_time=3
    # 选填，默认慢查询数据文件路径
    # slow_query_log_file=/var/lib/mysql/mysql-slow.log
    # 日志输出方式，一般默认就是FILE。
    log_output=FILE
    ```

  - 重启数据库后即永久开启慢查询。

##### 慢查询参数

上文已经提到了3个：slow_query_log，long_query_time，slow_query_log_file

log_queries_not_using_indexes=OFF

这个参数如果设置成ON，则未走索引的sql语句都认为是慢查询sql，容易混消，看情况开启，一般设置成OFF。

log_output=FILE

日志输出方式，默认值是FILE，表示将日志存入文件。log_output='TABLE'表示将日志存入数据库。这样日志信息就会被写入到mysql.slow_log表中。

mysql数据库支持同时两种日志存储方式。配置的时候以逗号隔开即可。例如：log_output='FILE,TABLE'。日志记录到日志表中，要比记录到文件耗费更多的系统资源。因此对于需要启用慢查日志，又需要比够获得更高的系统性能，那么建议优先记录到文件。

查询当前系统有多少条慢查询。

```sql
show variables like 'log_output'; -- 看看日志输出类型 table或file

set global log_output='table'; -- 设置输出类型为 table

set global log_output='file'; -- 设置输出类型为file
```



```sh
mysql> show global status like '%Slow_queries%';
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| Slow_queries  | 2     |
+---------------+-------+
1 row in set (0.03 sec)
```



##### 日志分析

- 第一行：标记日志产生的时间，准确说是SQL执行完成的时间点，该行记录每一秒只打印一条。
- 第二行：客户端的账户信息，两个用户名（第一个是授权账户，第二个为登录账户），客户端IP地址，还有mysqld的线程ID。
- 第三行：查询执行的信息，包括查询时长，锁持有时长，返回客户端的行数，扫描行数。通常我需要优化的就是最后一个内容，尽量减少SQL语句扫描的数据行数。
  - Query_time 是真实记录慢查询的查询时间，查询时间越长对系统的影响越大；
  - Lock_time 是当前查询获取数据时获取记录锁而等待的时间，等待时间越长，越可能造成慢查询；
  - Rows_sent 是发送多少行数据给 client ，同一个查询语句发送的数据行数越大，越可能会造成慢查询；
  - Rows_examined 是 server 层检索的数据，检索的数据越多，需要的IO和cpu资源也就越多，越可能造成慢查询，并影响服务稳定性；
  - Rows_affected 只针对修改请求，由于绝大部分慢查询都是 select ，并不会修改数据，故此值可以忽略；
  - Bytes_sent 是发送多少字节数据给 client ，发送的数据量越多，越可能会造成慢查询；
  - 由于不同的表行大小不同，并且并不是所有列都需要返回，所以一个发送 10 行的数据，可能会比一个发送 100 行数据的查询更慢，Rows_sent 不如 Bytes_sent 更为直观，故我们选取 Bytes_sent ，忽略 Rows_sent 。
  - 慢查询指标中 Query_time、Lock_time 、 Bytes_sent 、 Rows_examined 作为慢查询评分模型中的指标
- 第四行：通过代码看，就是sql语句执行时的时间戳，用来保证now()函数之类的正确
- 第五话：最后就是产生慢查询的SQL语句。

[慢查询官网介绍](https://dev.mysql.com/doc/refman/5.7/en/slow-query-log.html)

```ini
# Time: 2023-11-13T08:58:31.041674Z
# User@Host: root[root] @ dell-3090mff [192.168.3.129]  Id:     8
# Query_time: 4.001289  Lock_time: 0.000000 Rows_sent: 1  Rows_examined: 1
SET timestamp=1699865907;
select sleep(4);
```

##### 分析工具

###### mysqldumpslow

如果慢查询的SQL比较少，可以使用上面方式人工分析。但是如果慢查询SQL数量很多时就需要接着工具了。

MySQL自带了一个慢查询分析工具mysqldumpslow，通常这个工具是安装MySQL是一起装的。不需要单独安装。

如果执行命令报错command not found，是因为系统默认会查找/usr/bin下的命令，而mysqldumpslow没有在这个目录下所以报错。

先找到你的MySQL的安装目录以及mysqldumpslow的实际路径，按照下面的步骤建立关联。

```sh
[root@localhost bin]# ln -s /www/server/mysql/bin/mysqldumpslow /usr/bin
[root@localhost bin]# cd ..
[root@localhost mysql]# mysqldumpslow --help
Usage: mysqldumpslow [ OPTS... ] [ LOGS... ]

Parse and summarize the MySQL slow query log. Options are

  --verbose    verbose
  --debug      debug
  --help       write this text to standard output
```

以下是mysqldumpslow常见使用示例：

```sh
# 以下命令需要在linux shell中执行。
# 取出使用最多的10条慢查询
[root@]# mysqldumpslow -s c -t 10 /www/server/data/mysql-slow.log
Reading mysql slow query log from /www/server/data/mysql-slow.log
Count: 1  Time=4.00s (4s)  Lock=0.00s (0s)  Rows=1.0 (1), root[root]@dell-3090mff
  select sleep(N)
Died at /usr/bin/mysqldumpslow line 162, <> chunk 1.

# 取出查询时间最慢的3条慢查询
[root@]# mysqldumpslow -s t -t 3 /www/server/data/mysql-slow.log
Reading mysql slow query log from /www/server/data/mysql-slow.log
Count: 1  Time=4.00s (4s)  Lock=0.00s (0s)  Rows=1.0 (1), root[root]@dell-3090mff
  select sleep(N)
Died at /usr/bin/mysqldumpslow line 162, <> chunk 1.

#得到按照时间排序的前10条里面含有左连接的查询语句
[root@]# mysqldumpslow -s t -t 10 -g “left join” /www/server/data/mysql-slow.log
Reading mysql slow query log from join” /www/server/data/mysql-slow.log
Can't open join”: 没有那个文件或目录 at /usr/bin/mysqldumpslow line 92.
Died at /usr/bin/mysqldumpslow line 162, <> chunk 1.

```

注意: 使用mysqldumpslow的分析结果不会显示具体完整的sql语句，只会显示sql的组成结构。

例如：select * from test where id=10 group by a limit 0, 1000;
mysqldumpslow来显示是如下效果：

```sql
Count: 1  Time=1.95s (1s)  Lock=0.00s (0s)  Rows=1000.0 (1000), vgos_dba[vgos_dba]@[192.168.1.3]
select * from test where id=N group by a limit N, N;
```



###### pt-query-digest

pt-query-digest是用于分析mysql慢查询的一个工具，它可以分析binlog、General  log、slowlog，也可以通过SHOWPROCESSLIST或者通过tcpdump抓取的MySQL协议数据来进行分析。可以把分析结果输出到文件中，分析过程是先对查询语句的条件进行参数化，然后对参数化以后的查询进行分组统计，统计出各查询的执行时间、次数、占比等，可以借助分析结果找出问题进行优化。

[使用 pt-query-digest 分析慢日志](https://zhuanlan.zhihu.com/p/257975998)，[详解 慢查询 之 mysqldumpslow](https://zhuanlan.zhihu.com/p/106405711)



#### Navicat

Navicat版本：Navicat Premium 16.1，在Navicat中已经内置一些性能分析的功能，使用得当可以增加性能分析的效率。

##### SQL性能分析

我们在Navicat的查询窗口执行SQL语句时，会在下方显示SQL语句的执行结果。在结果最下方会显示这个SQL的执行时间（小数点后3位），在“结果”页签的右侧还有2个页签：“剖析”和“状态”。同时上方还有一个按钮叫“解释”。如下图：

![image-20231115205651622](学习笔记-数据库-Gem.assets/image-20231115205651622.png)

接下来分别介绍每个功能的用处。

结果，正常情况显示的是SQL语句的执行结果。如果SQL语句中带了特殊命令，例如：explain，那结果里面显示的就是本该解释中显示的内容了。

剖析，在之前版本叫做概述，对应的MySQL命令是show profile；但这里只显示默认的三个字段。

![image-20231115210140425](学习笔记-数据库-Gem.assets/image-20231115210140425.png)

状态，对应的MySQL命令是

![image-20231115210250646](学习笔记-数据库-Gem.assets/image-20231115210250646.png)

解释，需要先点“解释”，然后会在“解释1”页签中显示解释结果。对应的MySQL命令是explain。

![image-20231115211125389](学习笔记-数据库-Gem.assets/image-20231115211125389.png)

##### 服务器监控

功能在Navicat的“工具 > 服务器监控 > MySQL”中。点开之后会出现下面的界面

![image-20231115223000844](学习笔记-数据库-Gem.assets/image-20231115223000844.png)

应该是集成了MySQL的show processlist; show variables; show status; 3个命令。

在“变量”的功能界面里不仅仅可以查询，还可以修改变量值：

![image-20231115223249455](学习笔记-数据库-Gem.assets/image-20231115223249455.png)



### SQL优化

#### 性能问题发现

性能问题可以通过性能测试发现也可能是用户使用时发现。

如果很多功能都慢，那就可能不是优化某个SQL就能解决的。需要从架构设计角度优化或者是服务器全局参数上优化。

还有一些性能问题也不定就是数据库问题。后端程序网络波动也可能导致用户主观感受：慢。

可以通过慢查询分析，来找到执行慢的SQL。



#### 查询慢的原因

- 网络
- CPU
- IO
- 上下文切换
- 系统调用
- 生成统计信息
- 锁等待时间



#### 优化数据访问

查询性能低下的主要原因是访问的数据太多，某些查询不可避免的需要筛选大量的数据，我们可以通过减少访问数据量的方式进行优化

确认应用程序是否在检索大量超过需要的数据。例如：后端程序将大量数据查出后，经过处理再将少量数据返回给前端。

确认mysql服务器层是否在分析大量超过需要的数据行

是否向数据库请求了不需要的数据

- 查询不需要的记录

  - 我们常常会误以为mysql会只返回需要的数据，实际上mysql却是先返回全部结果再进行计算，在日常的开发习惯中，经常是先用select语句查询大量的结果，然后获取前面的N行后关闭结果集。

    优化方式是在查询后面添加limit

- 多表关联时返回全部列

  - ```sql
    select * from actor inner join filmactor using(actorid) inner join film using(film_id) where film.title='Academy Dinosaur';
    
    select actor.* from actor...;
    ```

- 总是取出全部列

  - 在公司的企业需求中，禁止使用select *,虽然这种方式能够简化开发，但是会影响查询的性能，所以尽量不要使用

- 重复查询相同的数据

  - 如果需要不断的重复执行相同的查询，且每次返回完全相同的数据，因此，基于这样的应用场景，我们可以将这部分数据缓存起来，这样的话能够提高查询效率



#### 执行过程的优化

##### 查询缓存

在解析一个查询语句之前，如果查询缓存是打开的，那么mysql会优先检查这个查询是否命中查询缓存中的数据，如果查询恰好命中了查询缓存，那么会在返回结果之前会检查用户权限，如果权限没有问题，那么mysql会跳过所有的阶段，就直接从缓存中拿到结果并返回给客户端

注意：查询缓存建议用于数据不怎么变动的表。

##### 查询优化处理

> mysql查询完缓存之后会经过以下几个步骤：解析SQL、预处理、优化SQL执行计划，这几个步骤出现任何的错误，都可能会终止查询

语法解析器和预处理

> mysql通过关键字将SQL语句进行解析，并生成一颗解析树，mysql解析器将使用mysql语法规则验证和解析查询，例如验证使用使用了错误的关键字或者顺序是否正确等等，预处理器会进一步检查解析树是否合法，例如表名和列名是否存在，是否有歧义，还会验证权限等等

查询优化器

> 当语法树没有问题之后，相应的要由优化器将其转成执行计划，一条查询语句可以使用非常多的执行方式，最后都可以得到对应的结果，但是不同的执行方式带来的效率是不同的，优化器的最主要目的就是要选择最有效的执行计划
>
> mysql使用的是基于成本的优化器，在优化的时候会尝试预测一个查询使用某种查询计划时候的成本，并选择其中成本最小的一个

```shell
mysql> select count(*) from film_actor;
+----------+
| count(*) |
+----------+
|     5462 |
+----------+
1 row in set (0.02 sec)

mysql> show status like 'last_query_cost';
+-----------------+------------+
| Variable_name   | Value      |
+-----------------+------------+
| Last_query_cost | 549.199000 |
+-----------------+------------+
1 row in set (0.02 sec)
```

可以看到上面的查询语句大概需要做549个数据页才能找到对应的数据，这是经过一系列的统计信息计算来的。如下：

- 每个表或者索引的页面个数
- 索引的基数
- 索引和数据行的长度
- 索引的分布情况

在很多情况下mysql会选择错误的执行计划，原因如下：

- 统计信息不准确
  - InnoDB因为其mvcc的架构，并不能维护一个数据表的行数的精确统计信息
- 执行计划的成本估算不等同于实际执行的成本
  - 有时候某个执行计划虽然需要读取更多的页面，但是他的成本却更小，因为如果这些页面都是顺序读或者这些页面都已经在内存中的话，那么它的访问成本将很小，mysql层面并不知道哪些页面在内存中，哪些在磁盘，所以查询之际执行过程中到底需要多少次IO是无法得知的
- mysql的最优可能跟你想的不一样
  - mysql的优化是基于成本模型的优化，但是有可能不是最快的优化
- mysql不考虑其他并发执行的查询
- mysql不会考虑不受其控制的操作成本
  - 执行存储过程或者用户自定义函数的成本	

优化器的优化策略

- 静态优化
  - 直接对解析树进行分析，并完成优化
- 动态优化
  - 动态优化与查询的上下文有关，也可能跟取值、索引对应的行数有关
- mysql对查询的静态优化只需要一次，但对动态优化在每次执行时都需要重新评估

优化器的优化类型

- 重新定义关联表的顺序

  - 数据表的关联并不总是按照在查询中指定的顺序进行，决定关联顺序时优化器很重要的功能

- 将外连接转化成内连接，内连接的效率要高于外连接

- 使用等价变换规则，mysql可以使用一些等价变化来简化并规划表达式

  - 例如：a != 4，mysql可能会转换为 a < 4 or a >4

- 优化count(),min(),max()

  - 索引和列是否可以为空通常可以帮助mysql优化这类表达式：例如，要找到某一列的最小值，只需要查询索引的最左端的记录即可，不需要全文扫描比较

- 预估并转化为常数表达式，当mysql检测到一个表达式可以转化为常数的时候，就会一直把该表达式作为常数进行处理

  - explain select film.filmid,filmactor.actorid from film inner join filmactor using(filmid) where film.filmid = 1

  - ```sh
    mysql> explain select * from actor where actor_id = 10;
    +----+-------------+-------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
    | id | select_type | table | partitions | type  | possible_keys | key     | key_len | ref   | rows | filtered | Extra |
    +----+-------------+-------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
    |  1 | SIMPLE      | actor | NULL       | const | PRIMARY       | PRIMARY | 2       | const |    1 |   100.00 | NULL  |
    +----+-------------+-------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
    1 row in set (0.03 sec)
    
    mysql> explain select * from actor where actor_id > 9 and actor_id < 11;
    +----+-------------+-------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
    | id | select_type | table | partitions | type  | possible_keys | key     | key_len | ref  | rows | filtered | Extra       |
    +----+-------------+-------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
    |  1 | SIMPLE      | actor | NULL       | range | PRIMARY       | PRIMARY | 2       | NULL |    1 |   100.00 | Using where |
    +----+-------------+-------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
    1 row in set (0.05 sec)
    ```

  - 

- 索引覆盖扫描，当索引中的列包含所有查询中需要使用的列的时候，可以使用覆盖索引

- 子查询优化

  - mysql在某些情况下可以将子查询转换一种效率更高的形式，从而减少多个查询多次对数据进行访问，例如将经常查询的数据放入到缓存中

- 等值传播

  - 如果两个列的值通过等式关联，那么mysql能够把其中一个列的where条件传递到另一个上：
  - explain select film.film_id from film inner join film_actor using(film_id) where film.film_id > 500;
  - 这里使用filmid字段进行等值关联，filmid这个列不仅适用于film表而且适用于filmactor表 
  - explain select film.film_id from film inner join film_actor using(film_id) where film.film_id > 500 and film_actor.film_id > 500;



##### 排序优化

无论如何排序都是一个成本很高的操作，所以从性能的角度出发，应该尽可能避免排序或者尽可能避免对大量数据进行排序。
推荐使用利用索引进行排序，但是当不能使用索引的时候，mysql就需要自己进行排序，如果数据量小则再内存中进行，如果数据量大就需要使用磁盘，mysql中称之为filesort。

如果需要排序的数据量小于排序缓冲区(show variables like '%sort_buffer_size%';)，mysql使用内存进行快速排序操作，如果内存不够排序，那么mysql就会先将树分块，对每个独立的块使用快速排序进行排序，并将各个块的排序结果存放再磁盘上，然后将各个排好序的块进行合并，最后返回排序结果

###### 排序的算法

两次传输排序

第一次数据读取是将需要排序的字段读取出来，然后进行排序，第二次是将排好序的结果按照需要去读取数据行。

这种方式效率比较低，原因是第二次读取数据的时候因为已经排好序，需要去读取所有记录而此时更多的是随机IO，读取数据成本会比较高
两次传输的优势，在排序的时候存储尽可能少的数据，让排序缓冲区可以尽可能多的容纳行数来进行排序操作

单次传输排序

先读取查询所需要的所有列，然后再根据给定列进行排序，最后直接返回排序结果，此方式只需要一次顺序IO读取所有的数据，而无须任何的随机IO，问题在于查询的列特别多的时候，会占用大量的存储空间，无法存储大量的数据

当需要排序的列的总大小超过max_length_for_sort_data定义的字节，mysql会选择双次排序，反之使用单次排序，当然，用户可以设置

此参数的值来选择排序的方式



##### 关联查询优化

参考[Join关联查询原理](#关联查询Join)

确保on或者using子句中的列上有索引，在创建索引的时候就要考虑到关联的顺序。

> 当表A和表B使用列C关联的时候，如果优化器的关联顺序是B、A，那么就不需要再B表的对应列上建上索引，没有用到的索引只会带来额外的负担，一般情况下来说，只需要在关联顺序中的第二个表的相应列上创建索引

确保任何的group by和order by中的表达式只涉及到一个表中的列，这样mysql才有可能使用索引来优化这个过程

##### 子查询优化

子查询的优化最重要的优化建议是尽可能使用关联查询代替。

因为MySQL在处理子查询的时候，会在处理过程中使用临时表会有额外的IO，而关联查询使用临时表是用来存储查询结果的。所以子查询的效率要比关联查询低。

优化的时候需要注意，并不是所有SQL都能改成子查询。只是当一个SQL能够同时使用子查询和关联查询实现相同效果的时候，优先推荐使用关联查询。



##### 用户自定义变量

###### 自定义变量的使用

首先来看一些简单的使用案例：

```sh
# 定义@i变量
mysql> set @i:=1;
Query OK, 0 rows affected (0.00 sec)
# 查询变量值
mysql> select @i;
+----+
| @i |
+----+
|  1 |
+----+
1 row in set (0.05 sec)
# 修改变量值
mysql> select @i+1;
+------+
| @i+1 |
+------+
|    2 |
+------+
1 row in set (0.05 sec)

mysql> select @i+1;
+------+
| @i+1 |
+------+
|    2 |
+------+
1 row in set (0.05 sec)
# @@为系统变量，以下查询的是自动提交的值。
mysql> select @@autoCommit;
+--------------+
| @@autoCommit |
+--------------+
|            1 |
+--------------+
1 row in set (0.06 sec)

#自定义变量也可以等于一个子查询的值：
mysql> set @last_week:=current_date-interval 1 week;
Query OK, 0 rows affected (0.00 sec)

mysql> select @last_week;
+------------+
| @last_week |
+------------+
| 2023-10-30 |
+------------+
1 row in set (0.05 sec)

mysql> set @min_actor :=(select min(actor_id) from actor);
Query OK, 0 rows affected (0.00 sec)

mysql> select @min_actor;
+------------+
| @min_actor |
+------------+
|          1 |
+------------+
1 row in set (0.05 sec)

mysql> 
```



###### 自定义变量的限制

1. 不能在使用常量或者标识符的地方使用自定义变量，例如表名、列名或者limit子句
2. 自定义变量只在当前会话中有效。不能用它们来做连接间的通信。
3. 不能显式地声明自定义变量地类型。无法使用查询缓存。
4. mysql优化器在某些场景下可能会将这些变量优化掉，这可能导致代码不按预想地方式运行
5. 赋值符号：=的优先级非常低，所以在使用赋值表达式的时候应该明确的使用括号
6. 使用未定义变量不会产生任何语法错误

###### 使用案例

MySQL从8开始才支持开窗函数。使用自定义变量可以实现类似Oracle的row_number() over()的功能。

**优化排名语句**

1、在给一个变量赋值的同时使用这个变量

set @rownum:=0;

select actor_id,@rownum:=@rownum+1 as rownum from actor limit 10;

```sh
mysql> set @rownum:=0;
Query OK, 0 rows affected (0.00 sec)

mysql> select actor_id,@rownum:=@rownum+1 as rownum from actor limit 10;
+----------+--------+
| actor_id | rownum |
+----------+--------+
|       58 |      1 |
|       92 |      2 |
|      182 |      3 |
|      118 |      4 |
|      145 |      5 |
|      194 |      6 |
|       76 |      7 |
|      112 |      8 |
|       67 |      9 |
|      190 |     10 |
+----------+--------+
10 rows in set (0.04 sec)
```

2、查询获取演过最多电影的前10名演员，然后根据出演电影次数做一个排名

select actor_id,count(*) as cnt from film_actor group by actor_id order by cnt desc limit 10;

加上自定义变量作为排名：

set @actor_number:=0;

select actor_id, cnt, @actor_number :=@actor_number+1 as rownumber 

from (select actor_id,count(*) as cnt from film_actor group by actor_id order by cnt desc limit 10) t;

**避免重新查询刚刚更新的数据**

当更新完一条记录的时间戳后，同时希望查询这个时间戳，用于下一次更新或者返回。

案例：t1是一张表。不用自定义变量时需要update之后然后select。

update t1 set  lastUpdated=now() where id =1;

select lastUpdated from t1 where id =1;

使用自定义变量就可以不用select查询了。

update t1 set lastupdated = now() where id = 1 and @now:=now();

select @now;

**确定取值的顺序**

在赋值和读取变量的时候可能是在查询的不同阶段

set @rownum:=0;
select actor_id,@rownum:=@rownum+1 as cnt from actor where @rownum<=1;

因为where和select在查询的不同阶段执行，所以看到查询到两条记录，这不符合预期

set @rownum:=0;
select actor_id,@rownum:=@rownum+1 as cnt from actor where @rownum<=1 order by first_name

当引入了orde;r by之后，发现打印出了全部结果，这是因为order by引入了文件排序，而where条件是在文件排序操作之前取值的

解决这个问题的关键在于让变量的赋值和取值发生在执行查询的同一阶段：

set @rownum:=0;
select actor_id,@rownum as cnt from actor where (@rownum:=@rownum+1)<=1;



##### 特殊函数优化

###### count()优化

> count()是特殊的函数，有两种不同的作用，一种是某个列值的数量，也可以统计行数

count(1)，count(*)，count(id列)实际效率是差不多的。看下面的案例。

```sh
mysql> use sakila;
Database changed

mysql> set profiling=1;
Query OK, 0 rows affected (0.00 sec)

mysql> select count(1) from rental;
+----------+
| count(1) |
+----------+
|    16044 |
+----------+
1 row in set (0.03 sec)

mysql> show status like 'last_query_cost';
+-----------------+-------------+
| Variable_name   | Value       |
+-----------------+-------------+
| Last_query_cost | 1625.049000 |
+-----------------+-------------+
1 row in set (0.02 sec)

mysql> select count(rental_id) from rental;
+------------------+
| count(rental_id) |
+------------------+
|            16044 |
+------------------+
1 row in set (0.02 sec)

mysql> show status like 'last_query_cost';
+-----------------+-------------+
| Variable_name   | Value       |
+-----------------+-------------+
| Last_query_cost | 1625.049000 |
+-----------------+-------------+
1 row in set (0.05 sec)

mysql> select count(*) from rental;
+----------+
| count(*) |
+----------+
|    16044 |
+----------+
1 row in set (0.06 sec)

mysql> show status like 'last_query_cost';
+-----------------+-------------+
| Variable_name   | Value       |
+-----------------+-------------+
| Last_query_cost | 1625.049000 |
+-----------------+-------------+
1 row in set (0.05 sec)

mysql> show profiles;
+----------+------------+-------------------------------------+
| Query_ID | Duration   | Query                               |
+----------+------------+-------------------------------------+
|        1 | 0.00118600 | select count(*) from rental         |
|        2 | 0.00168750 | select count(1) from rental         |
|        3 | 0.00144050 | select count(rental_id) from rental |
+----------+------------+-------------------------------------+
3 rows in set (0.05 sec)
```

需要注意的是，count统计的是非空的值，如果count的字段可能为空，则查询结果会不一样。

总有人认为myisam的count函数比较快，这是有前提条件的，只有没有任何where条件的count(*)才是比较快的

使用近似值

在某些应用场景中，不需要完全精确的值，可以参考使用近似值来代替，比如可以使用explain来获取近似的值
其实在很多OLAP的应用中，需要计算某一个列值的基数，有一个计算近似值的算法叫hyperloglog。

更复杂的优化

一般情况下，count()需要扫描大量的行才能获取精确的数据，其实很难优化，在实际操作的时候可以考虑使用索引覆盖扫描，或者增加其他汇总表，或者增加外部缓存系统，在缓存中维护count值。



###### group by和distinct

如果对关联查询做分组，并且是按照查找表中的某个列进行分组，那么可以采用查找表的标识列分组的效率比其他列更高。

这里的标识列指的是表中的唯一列自增列。

案例：

select actor.first_name, actor.last_name,count(1) from film_actor inner join actor using(actor_id) group by actor.first_name, actor.last_name;

改成按标识列actor_id排序后，性能提升。

select actor.first_name, actor.last_name,count(1) from film_actor inner join actor using(actor_id) group by actor.actor_id;

注意：MySQL在没有开启严格模式的情况下，是可以select没有group by的字段，这点和oracle不同。

这样优化之后，查询结果可能会不同，因为first_name可能会重复，但标识列一定不会重复。所以需要结合业务场景优化。

大部分的业务场景下是不会用标识列来group by的，所以这里仅提供一种优化可能性，实际使用场景不大。



###### limit分页优化

在很多应用场景中我们需要将数据进行分页，一般会使用limit加上偏移量的方法实现，同时加上合适的order by子句

如果这种方式有索引的帮助，效率通常不错，否则需要进行大量的文件排序操作，还有一种情况，当偏移量非常大的时候，前面的大部分数据都会被抛弃，这样的代价太高。

要优化这种查询的话，要么是在页面中限制分页的数量，要么优化大偏移量的性能。

优化此类查询的最简单的办法就是尽可能地使用覆盖索引，而不是查询所有的列。

案例1：

select film_id,description from film order by title limit 50,5;

优化后：

explain select film.film_id,film.description from film inner join (select film_id from film order by title limit 50,5) as lim using(film_id);

案例2，rental_id为主键。

select * from rental limit 1000000,5;

优化后：

select * from rental a join (select rental_id from rental limit 1000000,5) b on a.rental_id = b.rental_id;



###### union优化

除非确实需要服务器消除重复的行，否则一定要使用union all，因此没有all关键字，mysql会在查询的时候给临时表加上distinct的关键字，这个操作的代价很高



### 分区表

https://dev.mysql.com/doc/refman/5.7/en/partitioning.html

对于用户而言，分区表是一个独立的逻辑表，但是底层是由多个物理子表组成。分区表对于用户而言是一个完全封装底层实现的黑盒子，对用户而言是透明的，从文件系统中可以看到多个使用#分隔命名的表文件。

mysql在创建表时使用partition by子句定义每个分区存放的数据，在执行查询的时候，优化器会根据分区定义过滤那些没有我们需要数据的分区，这样查询就无须扫描所有分区。

分区的主要目的是将数据安好一个较粗的力度分在不同的表中，这样可以将相关的数据存放在一起。

#### 分区表应用场景

表非常大以至于无法全部都放在内存中，或者只在表的最后部分有热点数据，其他均是历史数据

分区表的数据更容易维护
   批量删除大量数据可以使用清除整个分区的方式

   对一个独立分区进行优化、检查、修复等操作

分区表的数据可以分布在不同的物理设备上，从而高效地利用多个硬件设备

可以使用分区表来避免某些特殊的瓶颈

   innodb的单个索引的互斥访问

   ext3文件系统的inode锁竞争

  可以备份和恢复独立的分区

####  分区表限制

  一个表最多只能有1024个分区，在5.7版本的时候可以支持8196个分区

  在早期的mysql中，分区表达式必须是整数或者是返回整数的表达式，在mysql5.5中，某些场景可以直接使用列来进行分区

  如果分区字段中有主键或者唯一索引的列，那么所有主键列和唯一索引列都必须包含进来

  分区表无法使用外键约束

####  分区表原理

分区表由多个相关的底层表实现，这个底层表也是由句柄对象标识，我们可以直接访问各个分区。存储引擎管理分区的各个底层表和管理普通表一样（所有的底层表都必须使用相同的存储引擎），分区表的索引知识在各个底层表上各自加上一个完全相同的索引。从存储引擎的角度来看，底层表和普通表没有任何不同，存储引擎也无须知道这是一个普通表还是一个分区表的一部分。

分区表的操作按照以下的操作逻辑进行：

**select查询**

当查询一个分区表的时候，分区层先打开并锁住所有的底层表，优化器先判断是否可以过滤部分分区，然后再调用对应的存储引擎接口访问各个分区的数据

**insert操作**

当写入一条记录的时候，分区层先打开并锁住所有的底层表，然后确定哪个分区接受这条记录，再将记录写入对应底层表

**delete操作**

当删除一条记录时，分区层先打开并锁住所有的底层表，然后确定数据对应的分区，最后对相应底层表进行删除操作

**update操作**

当更新一条记录时，分区层先打开并锁住所有的底层表，mysql先确定需要更新的记录再哪个分区，然后取出数据并更新，再判断更新后的数据应该再哪个分区，最后对底层表进行写入操作，并对源数据所在的底层表进行删除操作

有些操作时支持过滤的，例如，当删除一条记录时，MySQL需要先找到这条记录，如果where条件恰好和分区表达式匹配，就可以将所有不包含这条记录的分区都过滤掉，这对update同样有效。如果是insert操作，则本身就是只命中一个分区，其他分区都会被过滤掉。mysql先确定这条记录属于哪个分区，再将记录写入对应得曾分区表，无须对任何其他分区进行操作

虽然每个操作都会“先打开并锁住所有的底层表”，但这并不是说分区表在处理过程中是锁住全表的，如果存储引擎能够自己实现行级锁，例如innodb，则会在分区层释放对应表锁。

#### 分区表类型

##### 范围分区

 根据列值在给定范围内将行分配给分区

 范围分区表的分区方式是：每个分区都包含行数据且分区的表达式在给定的范围内，分区的范围应该是连续的且不能重叠，可以使用values less than运算符来定义。

1、创建普通的表

```sql
CREATE TABLE employees (
id INT NOT NULL,
fname VARCHAR(30),
lname VARCHAR(30),
hired DATE NOT NULL DEFAULT '1970-01-01',
separated DATE NOT NULL DEFAULT '9999-12-31',
job_code INT NOT NULL,
store_id INT NOT NULL
);
```

2、创建带分区的表，下面建表的语句是按照store_id来进行分区的，指定了4个分区

```sql
CREATE TABLE employees (
id INT NOT NULL,
fname VARCHAR(30),
lname VARCHAR(30),
hired DATE NOT NULL DEFAULT '1970-01-01',
separated DATE NOT NULL DEFAULT '9999-12-31',
job_code INT NOT NULL,
store_id INT NOT NULL
)
PARTITION BY RANGE (store_id) (
PARTITION p0 VALUES LESS THAN (6),
PARTITION p1 VALUES LESS THAN (11),
PARTITION p2 VALUES LESS THAN (16),
PARTITION p3 VALUES LESS THAN (21)
);
--在当前的建表语句中可以看到，store_id的值在1-5的在p0分区，6-10的在p1分区，11-15的在p3分区，16-20的在p4分区，但是如果插入超过20的值就会报错，因为mysql不知道将数据放在哪个分区
```

3、可以使用less than maxvalue来避免此种情况

```sql
CREATE TABLE employees (
id INT NOT NULL,
fname VARCHAR(30),
lname VARCHAR(30),
hired DATE NOT NULL DEFAULT '1970-01-01',
separated DATE NOT NULL DEFAULT '9999-12-31',
job_code INT NOT NULL,
store_id INT NOT NULL
)
PARTITION BY RANGE (store_id) (
PARTITION p0 VALUES LESS THAN (6),
PARTITION p1 VALUES LESS THAN (11),
PARTITION p2 VALUES LESS THAN (16),
PARTITION p3 VALUES LESS THAN MAXVALUE
);
--maxvalue表示始终大于等于最大可能整数值的整数值
```

4、可以使用相同的方式根据员工的职务代码对表进行分区

```sql
CREATE TABLE employees (
id INT NOT NULL,
fname VARCHAR(30),
lname VARCHAR(30),
hired DATE NOT NULL DEFAULT '1970-01-01',
separated DATE NOT NULL DEFAULT '9999-12-31',
job_code INT NOT NULL,
store_id INT NOT NULL
)
PARTITION BY RANGE (job_code) (
PARTITION p0 VALUES LESS THAN (100),
PARTITION p1 VALUES LESS THAN (1000),
PARTITION p2 VALUES LESS THAN (10000)
);
```

       5、可以使用date类型进行分区：如虚妄根据每个员工离开公司的年份进行划分，如year(separated)

```sql
CREATE TABLE employees (
id INT NOT NULL,
fname VARCHAR(30),
lname VARCHAR(30),
hired DATE NOT NULL DEFAULT '1970-01-01',
separated DATE NOT NULL DEFAULT '9999-12-31',
job_code INT,
store_id INT
)
PARTITION BY RANGE ( YEAR(separated) ) (
PARTITION p0 VALUES LESS THAN (1991),
PARTITION p1 VALUES LESS THAN (1996),
PARTITION p2 VALUES LESS THAN (2001),
PARTITION p3 VALUES LESS THAN MAXVALUE
);
```

       6、可以使用函数根据range的值来对表进行分区，如timestampunix_timestamp()

```sql
CREATE TABLE quarterly_report_status (
report_id INT NOT NULL,
report_status VARCHAR(20) NOT NULL,
report_updated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)
PARTITION BY RANGE ( UNIX_TIMESTAMP(report_updated) ) (
PARTITION p0 VALUES LESS THAN ( UNIX_TIMESTAMP('2008-01-01 00:00:00') ),
PARTITION p1 VALUES LESS THAN ( UNIX_TIMESTAMP('2008-04-01 00:00:00') ),
PARTITION p2 VALUES LESS THAN ( UNIX_TIMESTAMP('2008-07-01 00:00:00') ),
PARTITION p3 VALUES LESS THAN ( UNIX_TIMESTAMP('2008-10-01 00:00:00') ),
PARTITION p4 VALUES LESS THAN ( UNIX_TIMESTAMP('2009-01-01 00:00:00') ),
PARTITION p5 VALUES LESS THAN ( UNIX_TIMESTAMP('2009-04-01 00:00:00') ),
PARTITION p6 VALUES LESS THAN ( UNIX_TIMESTAMP('2009-07-01 00:00:00') ),
PARTITION p7 VALUES LESS THAN ( UNIX_TIMESTAMP('2009-10-01 00:00:00') ),
PARTITION p8 VALUES LESS THAN ( UNIX_TIMESTAMP('2010-01-01 00:00:00') ),
PARTITION p9 VALUES LESS THAN (MAXVALUE)
);
--timestamp不允许使用任何其他涉及值的表达式
```

基于时间间隔的分区方案，在mysql5.7中，可以基于范围或事件间隔实现分区方案，有两种选择

1、基于范围的分区，对于分区表达式，可以使用操作函数基于date、time、或者datatime列来返回一个整数值

```sql
CREATE TABLE members (
firstname VARCHAR(25) NOT NULL,
lastname VARCHAR(25) NOT NULL,
username VARCHAR(16) NOT NULL,
email VARCHAR(35),
joined DATE NOT NULL
)
PARTITION BY RANGE( YEAR(joined) ) (
PARTITION p0 VALUES LESS THAN (1960),
PARTITION p1 VALUES LESS THAN (1970),
PARTITION p2 VALUES LESS THAN (1980),
PARTITION p3 VALUES LESS THAN (1990),
PARTITION p4 VALUES LESS THAN MAXVALUE
);

CREATE TABLE quarterly_report_status (
report_id INT NOT NULL,
report_status VARCHAR(20) NOT NULL,
report_updated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)
PARTITION BY RANGE ( UNIX_TIMESTAMP(report_updated) ) (
PARTITION p0 VALUES LESS THAN ( UNIX_TIMESTAMP('2008-01-01 00:00:00') ),
PARTITION p1 VALUES LESS THAN ( UNIX_TIMESTAMP('2008-04-01 00:00:00') ),
PARTITION p2 VALUES LESS THAN ( UNIX_TIMESTAMP('2008-07-01 00:00:00') ),
PARTITION p3 VALUES LESS THAN ( UNIX_TIMESTAMP('2008-10-01 00:00:00') ),
PARTITION p4 VALUES LESS THAN ( UNIX_TIMESTAMP('2009-01-01 00:00:00') ),
PARTITION p5 VALUES LESS THAN ( UNIX_TIMESTAMP('2009-04-01 00:00:00') ),
PARTITION p6 VALUES LESS THAN ( UNIX_TIMESTAMP('2009-07-01 00:00:00') ),
PARTITION p7 VALUES LESS THAN ( UNIX_TIMESTAMP('2009-10-01 00:00:00') ),
PARTITION p8 VALUES LESS THAN ( UNIX_TIMESTAMP('2010-01-01 00:00:00') ),
PARTITION p9 VALUES LESS THAN (MAXVALUE)
);
```

2、基于范围列的分区，使用date或者datatime列作为分区列

```sql
CREATE TABLE members (
firstname VARCHAR(25) NOT NULL,
lastname VARCHAR(25) NOT NULL,
username VARCHAR(16) NOT NULL,
email VARCHAR(35),
joined DATE NOT NULL
)
PARTITION BY RANGE COLUMNS(joined) (
PARTITION p0 VALUES LESS THAN ('1960-01-01'),
PARTITION p1 VALUES LESS THAN ('1970-01-01'),
PARTITION p2 VALUES LESS THAN ('1980-01-01'),
PARTITION p3 VALUES LESS THAN ('1990-01-01'),
PARTITION p4 VALUES LESS THAN MAXVALUE
);
```

#####         真实案例：

```sql
#不分区的表
CREATE TABLE no_part_tab
(id INT DEFAULT NULL,
remark VARCHAR(50) DEFAULT NULL,
d_date DATE DEFAULT NULL
)ENGINE=MYISAM;
#分区的表
CREATE TABLE part_tab
(id INT DEFAULT NULL,
remark VARCHAR(50) DEFAULT NULL,
d_date DATE DEFAULT NULL
)ENGINE=MYISAM
PARTITION BY RANGE(YEAR(d_date))(
PARTITION p0 VALUES LESS THAN(1995),
PARTITION p1 VALUES LESS THAN(1996),
PARTITION p2 VALUES LESS THAN(1997),
PARTITION p3 VALUES LESS THAN(1998),
PARTITION p4 VALUES LESS THAN(1999),
PARTITION p5 VALUES LESS THAN(2000),
PARTITION p6 VALUES LESS THAN(2001),
PARTITION p7 VALUES LESS THAN(2002),
PARTITION p8 VALUES LESS THAN(2003),
PARTITION p9 VALUES LESS THAN(2004),
PARTITION p10 VALUES LESS THAN maxvalue);
#插入未分区表记录
DROP PROCEDURE IF EXISTS no_load_part;


DELIMITER//
CREATE PROCEDURE no_load_part()
BEGIN
DECLARE i INT;
SET i =1;
WHILE i<80001
DO
INSERT INTO no_part_tab VALUES(i,'no',ADDDATE('1995-01-01',(RAND(i)*36520) MOD 3652));
SET i=i+1;
END WHILE;
END//
DELIMITER ;

CALL no_load_part;
#插入分区表记录
DROP PROCEDURE IF EXISTS load_part;

DELIMITER&&
CREATE PROCEDURE load_part()
BEGIN
DECLARE i INT;
SET i=1;
WHILE i<80001
DO
INSERT INTO part_tab VALUES(i,'partition',ADDDATE('1995-01-01',(RAND(i)*36520) MOD 3652));
SET i=i+1;
END WHILE;
END&&
DELIMITER ;

CALL load_part;
```

##### 列表分区

类似于按range分区，区别在于list分区是基于列值匹配一个离散值集合中的某个值来进行选择

##### 列分区

mysql从5.5开始支持column分区，可以认为i是range和list的升级版，在5.5之后，可以使用column分区替代range和list，但是column分区只接受普通列不接受表达式

##### hash分区

基于用户定义的表达式的返回值来进行选择的分区，该表达式使用将要插入到表中的这些行的列值进行计算。这个函数可以包含myql中有效的、产生非负整数值的任何表达式

##### key分区

类似于hash分区，区别在于key分区只支持一列或多列，且mysql服务器提供其自身的哈希函数，必须有一列或多列包含整数值

##### 子分区

在分区的基础之上，再进行分区后存储

#### 何时使用分区表

如果需要从非常大的表中查询出某一段时间的记录，而这张表中包含很多年的历史数据，数据是按照时间排序的，此时应该如何查询数据呢？因为数据量巨大，肯定不能在每次查询的时候都扫描全表。考虑到索引在空间和维护上的消耗，也不希望使用索引，即使使用索引，会发现会产生大量的碎片，还会产生大量的随机IO，但是当数据量超大的时候，索引也就无法起作用了，此时可以考虑使用分区来进行解决

全量扫描数据，不要任何索引

使用简单的分区方式存放表，不要任何索引，根据分区规则大致定位需要的数据为止，通过使用where条件将需要的数据限制在少数分区中，这种策略适用于以正常的方式访问大量数据

索引数据，并分离热点

如果数据有明显的热点，而且除了这部分数据，其他数据很少被访问到，那么可以将这部分热点数据单独放在一个分区中，让这个分区的数据能够有机会都缓存在内存中，这样查询就可以只访问一个很小的分区表，能够使用索引，也能够有效的使用缓存

#### 分区表使用注意事项

null值会使分区过滤无效

分区列和索引列不匹配，会导致查询无法进行分区过滤

选择分区的成本可能很高

打开并锁住所有底层表的成本可能很高

维护分区的成本可能很高



### 缓存优化

在系统里面有一些很慢的查询，要么是数据量大，要么是关联的表多，要么是计算逻辑非常复杂，这样的查询每次会占用连接很长的时间。

所以为了减轻数据库的压力，和提升查询效率，我们可以把数据放到内存缓存起来，比如使用Redis。

缓存适用于实时性不是特别高的业务，例如报表数据，一次查询要2分钟，但是一天只需要更新一次。

运行独立的缓存服务，属于架构层面的优化。

为了减少单台数据库服务器的读写压力，在架构层面我们还可以做其他哪些优化措施?



### 集群主从复制

在分布式开篇的课程里面，我们说到了一种提升可用性的手段，叫做冗余，也就是创建集群。

集群的话必然会面临一个问题，就是不同的节点之间数据一致性的问题。如果同时读写多台数据库节点，怎么让所有的节点数据保持一致?

这个时候我们需要用到复制技术(replication)，被复制的节点称为master，复制的节点称为slave。slave本身也可以作为其他节点的数据来源，这个叫做级联复制。

MySQL的主从复制是怎么实现的呢?

MySQL所有更新语句都会记录到Server层的binlog。有了这个binlog，从服务器会不断获取主服务器的binlog文件，然后解析里面的SQL语句，在从服务器上面执行一遍，保持主从的数据一致。

这里面涉及到三个线程，连接到master获取 binlog，并且解析binlog 写入中继日志，这个线程叫做I/О线程。

Master节点上有一个log dump线程，是用来发送binlog给slave的。从库的SQL线程，是用来读取relay log，把数据写入到数据库的。(主从同步配置和原理，详细内容见Mycat第二节课)

做了主从复制配置案之后，我们只把数据写入master节点，而读的请求可以分担到slave节点。
我们把这种方案叫做读写分离。

对于读多写少的项目来说，读写分离对于减轻主服务器的访问压力很有用。

在集群的架构中，所有的节点存储的都是相同的数据。如果单张表存储的数据过大的时候，比如一张表有上亿的数据，每天以百万的量级增加，单表的查询性能还是会大幅下降。这个时候我们应该怎么办呢?

这个时候就要用到分布式架构中的第二个重要的手段，叫做分片。把单个节点的数据分散到多个节点存储，减少存储和访问压力，这个就是分库分表。

![image-20210322232445517](学习笔记-数据库-Gem.assets/image-20210322232445517.png)

原理图

![image-20210322232358121](学习笔记-数据库-Gem.assets/image-20210322232358121.png)



### 分库分表

分库分表总体上可以分为两类。具体内容可以参考[分库分表](#分库分表)。

垂直分库，减少并发压力。水平分表，解决存储瓶颈。

垂直分库的做法，把一个数据库按照业务拆分成不同的数据库:

水平分库分表的做法，把单张表的数据按照一定的规则分布到多个数据库。

以上是架构层面的优化，可以用缓存，读写分离，分库分表。这些措施都可以减轻服务端的访问压力，提升客户端的响应效率。



### 业务优化

除了对于代码、SQL语句、表定义、架构、配置优化之外，业务层面的优化也不能忽视。举两个例子:

1）在某一年的双十一，为什么会做一个充值到余额宝和余额有奖金的活动?现在会推荐大家用花呗支付，而不是银行卡支付?

因为使用余额或者余额宝付款是记录本地或者内部数据库，而使用银行卡付款，需要调用接口，操作内部数据库肯定更快。

2)在某一年的双十一，为什么在凌晨禁止查询今天之外的账单?为什么小鸡的饲料发放延迟了?

这是一种降级措施，用来保证当前最核心的业务。3）某银行的交易记录，只能按月份查询。

4）最近几年的双十一，为什么11月1日就开始了?变成了各种定金红包模式?

预售分流。

在应用层面同样有很多其他的方案来优化，达到尽量减轻数据库的压力的目的，比如限流，或者引入MQ削峰，等等等等。

为什么同样用MySQL，有的公司可以抗住百万千万级别的并发，而有的公司几百个并发都扛不住，关键在于怎么用。所以，用数据库慢，不代表数据库本身慢，有的时候还要往上层去优化。

当然，如果关系型数据库解决不了的问题，我们可能需要用到搜索引擎或者大数据的方案了，并不是所有的数据都要放到关系型数据库存储。



### 硬件优化

搭建磁盘阵列，机械硬盘换固态硬盘，这块就需要IT运维以及领导审批了。



### 优化案例

#### 案例一

服务端状态分析:

如果出现连接变慢，查询被阻塞，无法获取连接的情况。

1、重启!

2、 show processlist查看线程状态，连接数数量、连接时间、状态

3、查看锁状态

4、kill有问题的线程

对于具体的慢SQL:
一、分析查询基本情况
涉及到的表的表结构，字段的索引情况、每张表的数据量、查询的业务含义。

这个非常重要，因为有的时候你会发现SQL根本没必要这么写，或者表设计是有问题的。

二、找出慢的原因

1、查看执行计划，分析SQL的执行情况，了解表访问顺序、访问类型、索引、扫描行数等信息。

2、如果总体的时间很长，不确定哪一个因素影响最大，通过条件的增减，顺序的调整，找出引起查询慢的主要原因，不断地尝试验证。
找到原因:比如是没有走索引引起的，还是关联查询引起的，还是order by 引起的。

找到原因之后:

三、对症下药

1、创建索引或者联合索引

2、改写SQL，这里需要平时积累经验，参考上述章节中提到的。

如果SQL本身解决不了了，就要上升到表结构和架构了。

3、表结构(冗余、拆分、not null等)、架构优化(缓存读写分离分库分表)。

4、业务层的优化，必须条件是否必要。

掌握正确的调优思路，才是解决数据库性能问题的根本。



#### 案例insert into select

原文：https://mp.weixin.qq.com/s/UWeotDAKAYg7B0Wa0IrWOg

insert into a select b where 条件1。这个sql如果where条件没法走索引，会导致a表锁表，b表会逐条枷锁。同时还有全表扫描，如果数量很大的场景下，会执行相当长的时间。

解决方案：给where后面的条件做索引。





## Mycat2







# Oracle

## 介绍

https://www.oracle.com/cn/database/technologies/

### 版本说明

1998年Oracle8i：i指internet，表示oracle向互联网发展，8i之前数据库只能对应1个实例
2001年Oracle9i：8i的升级，性能更佳，管理更人性化
2003年Oracle10g：g指grid，表示采用网格计算的方式进行操作，性能更好
2007年Oracle11g：10g的稳定版本，目前公司里面最常用
2013年Oracle12c：c指cloud，表示云计算，支持大数据处理
2018年Oracle18c：部分工作自主完成，减少手动操作的工作量
2019年Oracle19c：是12c和18c的稳定版本



## 安装卸载

### Windows

#### 安装包下载

官网上默认打开的是最新的Oracle版本，如果想要下载11g的，可以从[这个官网地址下载](https://www.oracle.com/partners/campaign/112010-win64soft-094461.html)；

打开网页后，勾选"Accept License Agreement"。windows用户可以选择这个版本：“**Oracle Database 11g Release 2 (11.2.0.1.0) for Microsoft Windows (x64)**”。注意：需要先登录Oralce账号后才能下载。

下载之后会有2个zip压缩包，将其合并解压缩成一个database文件夹。



#### 安装步骤

进入解压之后database目录里面，双击setup.exe开始安装。





![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/6bf3d83c2a6a45adb89e5b89e4dbf3c5.png)

下一步

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/74ad5eb7e6ca45cb8e93aff924c5ca93.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/725a410a46904a0299effdb6f32adcbd.png)

配置口令：统一123456

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/0252b13f3d894e0dbfaac60335c69bae.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/fc9d4c1ea1c04cc088a444299c90a473.png)

安装等待

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/d6a7091d4d1d4014833e3e04e077f46b.png)

继续等待

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/45ecba29cc50464d8ac4b611ded8c071.png)

口令管理

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/e738bc468fd54a4bb6140219813c23d1.png)

安装完成

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/67b6a0dbb15c4ae3a9c1df0a5d730ad8.png)

然后我们可以在系统 服务 中，查看启动运行的Oracle数据库

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/6351ac79d9f349088288a41268d82b9c.png)



#### Oracle服务说明

Oracle 11g服务详细介绍及哪些服务是必须开启的？

安装oracle 11g R2中的方法成功安装Oracle 11g后，共有7个服务，这7个服务的含义分别为

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/fd8a3909921e4d898c132beaab75dc4e.png)

1. Oracle ORCL VSS Writer Service：Oracle卷映射拷贝写入服务，VSS（Volume Shadow Copy Service）能够让存储基础设备（比如磁盘，阵列等）创建高保真的时间点映像，即映射拷贝（shadow copy）。它可以在多卷或者单个卷上创建映射拷贝，同时不会影响到系统的系统能。（非必须启动）
2. OracleDBConsoleorcl：Oracle数据库控制台服务，orcl是Oracle的实例标识，默认的实例为orcl。在运行Enterprise Manager（企业管理器OEM）的时候，需要启动这个服务。（非必须启动）
3. OracleJobSchedulerORCL：Oracle作业调度（定时器）服务，ORCL是Oracle实例标识。（非必须动）
4. OracleMTSRecoveryService：服务端控制。该服务允许数据库充当一个微软事务服务器MTS、COM/COM+对象和分布式环境下的事务的资源管理器。（非必须启动）
5. OracleOraDb11g_home1ClrAgent：Oracle数据库.NET扩展服务的一部分。 （非必须启动）
6. OracleOraDb11g_home1TNSListener：监听器服务，服务只有在数据库需要远程访问的时候才需要。（非必须启动，下面会有详细详解）。
7. OracleServiceORCL：数据库服务(数据库实例)，是Oracle核心服务该服务，是数据库启动的基础， 只有该服务启动，Oracle数据库才能正常启动。(必须启动)
8. 那么在开发的时候到底需要启动哪些服务呢？
   1. 对新手来说，要是只用Oracle自带的sql*plus的话，只要启动OracleServiceORCL即可，要是使用PL/SQL Developer等第三方工具的话，OracleOraDb11g_home1TNSListener服务也要开启。OracleDBConsoleorcl是进入基于web的EM必须开启的，其余服务很少用。
   2. 注：ORCL是数据库实例名，默认的实例名是ORCL，你也可以改成其他的，服务名也会对应修改：OracleService+数据库名

**个人开发电脑推荐：**

1. 所有Oracle服务建议都改成"手动"。

2. 需要使用数据库时，启动如下两个

   1. 监听服务：OracleOraDb10g_home1TNSListener监听客户端的连接

   2. 数据库服务：OracleServiceORCL 命名规则：OracleService+实例名




#### 创建数据库实例

正常安装数据库的时候会默认安装一个orcl数据库。我们也可以通过 Database Configuration Assistant 来创建新的数据库。操作如下：

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/690ec72dddb34349a0b554d66da18e2e.png)

进入操作

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/efd28c94522e45419cbfd9c8f2323953.png)

创建数据库

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/d8b4bb28492f40e8897ca64ee67f6397.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/f74e22fb9ab84bcbb2f8acaadfba3165.png)

创建数据库的唯一标识SID

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/8628513b415645bfaa43a1dad631609d.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/db52d0c4d2f84f2e8f357f852869fa23.png)

指定口令

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/ed00df3ef69f431993b44b67ced2160a.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/09153e4a382b478e8f7d5e8a88915fdb.png)

下一步

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/1f637a3212064c55b84b3f570773d7be.png)

一直下一步。最后完成

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/6f58d5cb489d4ebfb0807bc6e3dc311c.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/cd096af985bb4d0bbf21ccc80ea364ef.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/cecc676ae79e4c6388e766b37eb81bf8.png)

创建完成

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/7c908a7ca84045448b7de0fb659daa53.png)

#### SQL Developer

最新版下载（JDK11）：https://www.oracle.com/database/sqldeveloper/technologies/download/

21.4.3支持JDK8的最新版：https://www.oracle.com/tools/downloads/sqldev-downloads-2143.html

20的最新版：https://www.oracle.com/tools/downloads/sqldev-downloads-2041.html

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/37d2d659448a45b3996bdad0a26c7682.png)

解压缩出来后运行

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/abc7f67246a6459c92cc04f2cfc6ba4e.png)

打开后的主页

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/371bad4f8a5d4d1e8c6ea1d2a5613adc.png)

建立连接

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/3679b30567cb4570ad861f5558cd6b0e.png)

录入相关的信息：

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/269dd9b0cfea46bb82ad7fcb53f2d9b9.png)

添加测试。查看是否能够连接成功

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/35a7e4fff89d4d239e925fade06364be.png)

提示：状态：成功。说明我们连接正常了

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/23d68afa0ad7411aa71f6378817fc98d.png)

点开+我们就可以看到相关的数据库的信息了。

#### Oracle卸载

##### 1.关闭相关服务

&emsp;&emsp;我们进入 `service`中，关闭所有和oracle相关的服务

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/919f993ff094449fbc0f4224fe095f60.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/c15b50d679104059a057e4bd556507e1.png)

##### 3.卸载软件

&emsp;&emsp;在搜索中找到Universal Installer。双击开始卸载

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/204326be76ea4b6895af877a0282f8bc.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/0612d3a15cba453b9ddab73199d17621.png)

选中要删除的Oracle产品，然后点击删除

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/a7395f26618b4e3aad12d3cd9ebea71b.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/1c7605381a8f4726b987353903df6f99.png)

在你安装的app文件夹里面找到deinstall.bat文件，然后双击

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/8c81b83d93b94552a2a34c0d8232fefb.png)

双击后：出现指定要取消配置的所有单示例监听程序【LISTENER】：

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/180d7e2dd07a48b3947cacdaba059b05.png)

没有权限需要通过管理员打开

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/d02aa686967a45f09d44979751baf4d2.png)

然后再输入OCRL

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/3ec63a75b8d14da5802c8cb711374666.png)

等待时间比较长。输入y继续操作

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/056afdd71100453192518267185cc6ef.png)

继续

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/834a52491e6349ef8b2a7aa0c7bc0790.png)

到这一步再CMD里面的操作就完成了，等待CMD界面自动消失即可

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/39863e21762449628776d98ed41223f8.png)

##### 3.删除注册信息

&emsp;&emsp;然后我们进入注册表中删除oracle的相关注册信息。输入: regedit 进入

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/b03abd4b6c524e0b821084527925fdd8.png)

删除HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ 路径下的所有Oracle开始的服务名称

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/cd3f237d2a62490d81614b827e67fe74.png)

删除：HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Eventlog\Application注册表的所有Oracle开头的所有文件

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/d3b8745f75fa4d93a74db050590842f7.png)

删除：HKEY_LOCAL_MACHINE\SOFTWARE\ORACLE 注册表

若环境变量中存在Oracle相关的设置，直接删除，没有就跳过这一步

删除E:\app目录下的所有文件，根据自己的安装目录来

删除C盘下C:\Program File 目录下的Oracle目录

再删除C盘下C:\用户\dpb这个Oracle文件

注：所删除过程中遇到java.exe程序正在运行，按CTRL+shift+esc进入任务管理器，结束这个任务。

删除干净后重启电脑即可。

#### 用户和权限

&emsp;&emsp;Oracle中，一般不会轻易在一个服务器上创建多个数据库，在一个数据库中，不同的项目由不同的用户访问，每一个用户拥有自身创建的数据库对象，因此用户的概念在Oracle中非常重要。Oracle的用户可以用CREATE USER命令来创建。其语法是：

> CREATE
> USER 用户名 IDENTIFIED BY 口令 [ACCOUNT LOCK|UNLOCK]

说明：LOCK|UNLOCK创建用户时是否锁定，默认为锁定状态。锁定的用户无法正常的登录进行数据库操作。

案例：

CREATE  USER dpb IDENTIFIED BY  123456 ACCOUNT UNLOCK;

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/a13282fc654447c3aa33da4124134088.png)

&emsp;&emsp;尽管用户成功创建，但是还不能正常的登录Oracle数据库系统，因为该用户还没有任何权限。如果用户能够正常登录，至少需要CREATE SESSION系统权限。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/eee1ed136fc84aaeb38788b400f08e14.png)

&emsp;&emsp;Oracle用户对数据库管理或对象操作的权利，分为系统权限和数据库对象权限。系统权限比如：CREATE SESSION，CREATE TABLE等，拥有系统权限的用户，允许拥有相应的系统操作。数据库对象权限，比如对表中的数据进行增删改操作等，拥有数据库对象权限的用户可以对所拥有的对象进行对应的操作。


还有一个概念就是数据库角色（role），数据库角色就是若干个系统权限的集合。下面介绍几个常用角色：

* CONNECT角色，主要应用在临时用户，特别是那些不需要建表的用户，通常只赋予他们CONNECT role。CONNECT是使用Oracle的简单权限，拥有CONNECT角色的用户，可以与服务器建立连接会话（session，客户端对服务器连接，称为会话）。
* RESOURCE角色 **，** 更可靠和正式的数据库用户可以授予RESOURCE
  role。RESOURCE提供给用户另外的权限以创建他们自己的表、序列、过程（procedure）、触发器（trigger）、索引（index）等。
* DBA角色，DBA role拥有所有的系统权限----包括无限制的空间限额和给其他用户授予各种权限的能力。用户SYSTEM拥有DBA角色。

一般情况下，一个普通的用户（如SCOTT），拥有CONNECT和RESOURCE两个角色即可进行常规的数据库开发工作。

可以把某个权限授予某个角色，可以把权限、角色授予某个用户。系统权限只能由DBA用户授权，对象权限由拥有该对象的用户授权，授权语法是：

> GRANT 角色|权限 TO 用户（角色）

案例：

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/8cea6156f3744049b1e7f73088a187b6.png)

之后就可以通过 `dpb`这个账号来正常的登录了

删除用户操作：

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/8e01cbbc3b364800951fb0da32b7ec5e.png)

其他操作：

> //回收权限
>
> REVOKE
> 角色|权限 FROM 用户（角色）
>
> //修改用户的密码
>
> ALTER USER 用户名 IDENTIFIED BY 新密码
>
> //修改用户处于锁定（非锁定）状态
>
> ALTER USER 用户名 ACCOUNT LOCK|UNLOCK


![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/1462/1677919260096/2735942adbde4e2eb95eaa46651de1ce.png)









# PostgreSQL



# NoSQL

## NoSQL是什么

NoSQL：Not Only SQL ,本质也是一种数据库的技术，相对于传统数据库技术，它不会遵循一些约束，比如：sql标准、ACID属性，表结构等。

## Nosql优点

- 满足对数据库的高并发读写

- 对海量数据的高效存储和访问

- 对数据库高扩展性和高可用性

- 灵活的数据结构，满足数据结构不固定的场景

## Nosql缺点

- 一般不支持事务

- 实现复杂SQL查询比较复杂

- 运维人员数据维护门槛较高

- 目前不是主流的数据库技术



## NoSQL的常见类型

| 类型 | 部分代表 | 特点 |
| ------------ | -------------------------------------- | ------------------------------------------------------------ |
| 列存储 | Hbase，Cassandra，Hypertable | 顾名思义，是按列存储数据的。最大的特点是方便存储结构化和半结构化数据，方便做数据压缩，对针对某一列或者某几列的查询有非常大的IO优势。 |
| 文档存储 | MongoDB，CouchDB | 文档存储一般用类似json的格式存储，存储的内容是文档型的。这样也就有机会对某些字段建立索引，实现关系数据库的某些功能。 |
| key-value存储 | Redis，MemcacheDB，Tokyo Cabinet / Tyrant，Berkeley DB | 可以通过key快速查询到其value。一般来说，存储不管value的格式，照单全收。（Redis包含了其他功能） |
| 图存储 | Neo4J，FlockDB | 图形关系的最佳存储。使用传统关系数据库来解决的话性能低下，而且设计使用不方便。 |
| 对象存储 | db4o，Versant | 通过类似面向对象语言的语法操作数据库，通过对象的方式存取数据。 |
| xml数据库 | Berkeley DB XML，BaseX | 高效的存储XML数据，并支持XML的内部查询语法，比如XQuery,Xpath。 |



# MongoDB

## 参考说明

本文内容来源于个人实践以及工作经验总结，还有部分参考了以下内容。

- 马士兵教育视频教程及配套笔记（[MongoDB最热门NoSql数据库-李瑾](https://www.mashibing.com/study?courseNo=1480&sectionNo=57004&courseId%3D18870&courseVersionId=1999)）
- 菜鸟教程，https://www.runoob.com/mongodb/mongodb-create-database.html。



## 简介

MongoDB：是一个数据库 ,高性能、无模式、文档性，目前nosql中最热门的数据库，开源产品，基于c++开发。是nosql数据库中功能最丰富，最像关系数据库的。

**特性**

- 面向集合文档的存储：适合存储Bson（json的扩展）形式的数据；

- 格式自由，数据格式不固定，生产环境下修改结构都可以不影响程序运行；

- 强大的查询语句，面向对象的查询语言，基本覆盖sql语言所有能力；

- 完整的索引支持，支持查询计划；

- 支持复制和自动故障转移；

- 支持二进制数据及大型对象（文件）的高效存储；

- 使用分片集群提升系统扩展性；

- 使用内存映射存储引擎，把磁盘的IO操作转换成为内存的操作；



### 应用场景

并没有某个业务场景必须要使用 MongoDB才能解决，但使用 MongoDB 通常能让你以更低的成本解决问题（包括学习、开发、运维等成本）

![mongo-image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/5983/1648643790035/aec8d2322c58422985154080224f6302.png)

除了第一点必须符合之外，其他项的Yes越多，越推荐使用MongoDB。

新版本MongoDB支持事务，目前有一些电商全程已经在尝试全部使用MongoDB，据说某个航空公司（东方航空）使用MongoDB存储航班信息和用户信息。

### 使用场景案例

MongoDB 的应用已经渗透到各个领域，比如游戏、物流、电商、内容管理、社交、物联网、视频直播等，以下是几个实际的应用案例：

- 游戏场景，使用 MongoDB 存储游戏用户信息，用户的装备、积分等直接以内嵌文档的形式存储，方便查询、更新

- 物流场景，使用 MongoDB 存储订单信息，订单状态在运送过程中会不断更新，以 MongoDB 内嵌数组的形式来存储，一次查询就能将订单所有的变更读取出来。

- 社交场景，使用 MongoDB 存储存储用户信息，以及用户发表的朋友圈信息，通过地理位置索引实现附近的人、地点等功能

- 物联网场景，使用 MongoDB 存储所有接入的智能设备信息，以及设备汇报的日志信息，并对这些信息进行多维度的分析

- 视频直播，使用 MongoDB 存储用户信息、礼物信息等

### 不建议使用MongoDB的场景

- 高度依赖事务的系统：例如银行、财务等系统等和钱等重要信息相关的系统。因为MongoDB对事务的支持较弱；

- 传统的商业智能应用：特定问题的数据分析，多数据实体关联，涉及到复杂的、高度优化的查询方式；

- 使用sql更方便的场景；数据结构相对固定，使用sql进行查询统计更加便利的时候；

### 谁在使用MongoDB

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/5983/1648643790035/b48647d1c3284ce3a11502d44dc6d476.png)



## 安装

安装方式有很多，

- 手动下载安装包并安装
- 使用docker安装。
- 使用宝塔自动化安装。

### Docker安装

#### 前提

Vmware+CentOS7.9

已安装好docker

#### 步骤

搜索已存在的mongo镜像，建议安装官方镜像。（Official=[OK]）

```shell
[root@dev-study ~]# docker search mongo
NAME                                                   DESCRIPTION                                      STARS     OFFICIAL   AUTOMATED
mongo                                                  MongoDB document databases provide high avai…   9898      [OK]       
mongo-express                                          Web-based MongoDB admin interface, written w…   1371      [OK]       
mongodb/mongodb-atlas-kubernetes-operator              The MongoDB Atlas Kubernetes Operator - Kube…   5                    
mongodb/mongodb-community-server                       The Official MongoDB Community Server            42                   
mongodb/mongodb-enterprise-server                      The Official MongoDB Enterprise Advanced Ser…   4                    
mongodb/mongodb-atlas-kubernetes-operator-prerelease   This is an internal-use-only build of the Mo…   0                    
bitnami/mongodb                                        Bitnami MongoDB Docker Image                     234                  [OK]
mongodb/atlas                                          Create, manage, and automate MongoDB Atlas r…   4                    
circleci/mongo                                         CircleCI images for MongoDB                      13                   [OK]
```

下载镜像到本地。

本文选择的是latest版，实际是5.0.5版本：`docker pull mongo:latest`

下载完之后运行

```sh
docker run -itd --name mongo -p 27017:27017 mongo --auth
```

安装成功之后，使用docker ps查看运行情况。

接着使用以下命令添加用户和设置密码，并且尝试连接。

```sh
$ docker exec -it mongo mongo admin
# 创建一个名为 admin，密码为 123456 的用户。
>  db.createUser({ user:'admin',pwd:'123456',roles:[ { role:'userAdminAnyDatabase', db: 'admin'},"readWriteAnyDatabase"]});
# 尝试使用上面创建的用户信息进行连接。
> db.auth('admin', '123456')
```

使用如下命令进入mongo控制台

```sh
[root@dev-study ~]# docker exec -it  mongo mongosh
Current Mongosh Log ID: 6537e7a052689ee95d370d51
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000
Using MongoDB:          5.0.5
Using Mongosh:          1.1.6

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

Warning: Found ~/.mongorc.js, but not ~/.mongoshrc.js. ~/.mongorc.js will not be loaded.
  You may want to copy or rename ~/.mongorc.js to ~/.mongoshrc.js.
# 切换到管理员账号
test> use admin
switched to db admin
admin> db.auth('admin', '123456');
{ ok: 1 }
# 显示所有的数据库
admin> show dbs
admin    135 kB
config  49.2 kB
local     41 kB
```



## 概念术语 

在mongodb中基本的概念是文档、集合、数据库，下面挨个介绍。

| SQL术语/概念 | MongoDB术语/概念 | 解释/说明                           |
| ------------ | ---------------- | ----------------------------------- |
| database     | database         | 数据库                              |
| table        | collection       | 数据库表/集合                       |
| row          | document         | 数据记录行/文档                     |
| column       | field            | 数据字段/域                         |
| index        | index            | 索引                                |
| table joins  |                  | 表连接,MongoDB不支持                |
| primary key  | primary key      | 主键,MongoDB自动将_id字段设置为主键 |



## 基础使用

本文仅列出部分操作，更多操作可以上[菜鸟教程](https://www.runoob.com/mongodb/mongodb-create-collection.html)。

### 数据库

**创建或使用数据库**

`use [dbname]`**如果数据库不存在会自动创建**

**查看所有的数据库**

show dbs



### 集合(表)

**新增集合(表)**

db.createCollection("collection1")

说明"collection1"是集合名字

**隐式新增集合**

db.collection2.insert({uid:1, goods:2});

上面的命令会隐式新增一个结合collection2，同时还往集合中新增了行/文档

**显示所有集合(表)**

show tables 或者 show collections

```shell
test> show tables
collection1
test> show collections
collection1
test> 
```

**删除集合**

MongoDB 中使用 drop() 方法来删除集合。

**语法格式：**

```sql
db.collection.drop()
```



### 文档(行)

**插入文档**

MongoDB 使用 insert() 或 save() 方法向集合中插入文档，语法如下：

```sql
db.COLLECTION_NAME.insert(document)
或
db.COLLECTION_NAME.save(document)
```

- save()：如果 _id 主键存在则更新数据，如果不存在就插入数据。该方法新版本中已废弃，可以使用 **db.collection.insertOne()** 或 **db.collection.replaceOne()** 来代替。
- insert(): 若插入的数据主键已经存在，则会抛 **org.springframework.dao.DuplicateKeyException** 异常，提示主键重复，不保存当前数据。

**批量插入**

db.collection.insertMany() 用于向集合插入一个多个文档，语法格式如下：

```sql
db.collection.insertMany(
   [ <document 1> , <document 2>, ... ],
   {
      writeConcern: <document>,
      ordered: <boolean>
   }
)
```

例如：`db.collection1.insertMany([{a:2, b:3}, {a:3, b:4}, {a:4, b:5}]);`

#### 查询文档

MongoDB 查询文档使用 find() 方法。

find() 方法以非结构化的方式来显示所有文档。

**语法**

MongoDB 查询数据的语法格式如下：

```
db.collection.find(query, projection)
```

- **query** ：可选，使用查询操作符指定查询条件
- **projection** ：可选，使用投影操作符指定返回的键。查询时返回文档中所有键值， 只需省略该参数即可（默认省略）。

如果你需要以易读的方式来读取数据，可以使用 pretty() 方法，语法格式如下：

```
>db.col.find().pretty()
```

pretty() 方法以格式化的方式来显示所有文档。

**实例**

以下实例我们查询了集合 col 中的数据：

```
> db.col.find().pretty()
{
        "_id" : ObjectId("56063f17ade2f21f36b03133"),
        "title" : "MongoDB 教程",
        "description" : "MongoDB 是一个 Nosql 数据库",
        "by" : "菜鸟教程",
        "url" : "http://www.runoob.com",
        "tags" : [
                "mongodb",
                "database",
                "NoSQL"
        ],
        "likes" : 100
}
```

除了 find() 方法之外，还有一个 findOne() 方法，它只返回一个文档。



## Java客户端

### Springboot集成

下面的案例，是使用Springboot的MongoTemplate来对MongoDb进行操作。

MongoDb版本：5.0.5，docker版。

**maven依赖**

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
</dependency>

<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-mongodb</artifactId>
</dependency>

<dependency>
    <groupId>org.mongodb</groupId>
    <artifactId>mongo-java-driver</artifactId>
    <version>3.12.14</version>
</dependency>

<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <version>1.18.28</version>
</dependency>
```

**配置文件**

```properties
# 注意：这种配置URI的方式和下面分开指定每个参数的方式只能选一种。
#spring.data.mongodb.uri=mongodb://admin:123456@dokcer-study:27017/?authSource=admin

# MongoDB服务器连接IP地址（这里的docker-study是在hosts中做了映射）
spring.data.mongodb.host=docker-study
# MongoDB服务器连接端口
spring.data.mongodb.port=27017
# MongoDB的验证数据库
spring.data.mongodb.authentication-database=admin
# MongoDB数据库用户
spring.data.mongodb.username=admin
# MongoDB数据库密码
spring.data.mongodb.password=123456
# 带连接的数据库
spring.data.mongodb.database=test
```



#### 在集合中插入文档

**Java代码**

值对象使用@Document注解和集合进行映射。

```java
@SpringBootApplication
public class MongoDbApplication {
    public static void main(String[] args) {
        SpringApplication.run(MongoDbApplication.class, args);
    }
}

//映射集合名字
@Document("collection1")
@Data
@ToString
public class MongoPO {
    private String id;
    private Integer a;
    private Integer b;
    private String s;
}

@RestController
@RequestMapping("/mongo")
@Slf4j
public class MongoController {
    @Autowired
    MongoTemplate mongoTemplate;

    @GetMapping("/insertOne")
    public String insertOne() {
        MongoPO p = new MongoPO();
        p.setA(3);
        p.setB(3);
        mongoTemplate.insert(p);
        return p.toString();
    }
}
```

**执行结果**

```shell
test> db.collection1.find();
[
  { _id: ObjectId("6538e34c4a80d9e751786811"), a: 1, b: 2 },
  { _id: ObjectId("6538f62f4a80d9e751786812"), a: 1, b: 2 },
  { _id: ObjectId("6538f7164a80d9e751786813"), a: 2, b: 3 },
  { _id: ObjectId("6538f7164a80d9e751786814"), a: 3, b: 4 },
  { _id: ObjectId("6538f7164a80d9e751786815"), a: 4, b: 5 },
  {
    _id: ObjectId("653a10f36de296312fa8988b"),
    a: 3,
    b: 3,
    _class: 'com.gem.db.mongodb.controller.MongoPO'
  }
]
test> 
```

