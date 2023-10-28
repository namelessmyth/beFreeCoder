# 数据库

## 排名

**数据库流行程度排行**：https://db-engines.com/en/ranking



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



# MySQL

## 参考说明

本文内容来源于个人实践以及工作经验总结，还有部分参考了以下内容。

- 马士兵教育视频教程及配套笔记（[MySQL实战调优-连鹏举](https://www.mashibing.com/study?courseNo=392&sectionNo=2801&courseVersionId=1297)）
- 菜鸟教程，https://www.runoob.com/mongodb/mongodb-create-database.html。



## 安装

### 宝塔安装

宝塔版本：8.0.3

在左侧的菜单栏中选择数据库，添加数据库服务器，然后选择你想安装的数据库版本（例如：8.0.24），然后选极速安装，大概等待10分钟就全自动安装好了。（实际等待时间可能因为网速不同而不同）

安装成功之后，建议点“root密码”按钮修改root密码。

然后参考下文修改root用户的外网访问权限。



### 用户外网访问权限

安装好MySQL以后，默认root用户是不能通过外网访问的。

如果连接会报错：`message from server: "Host 'dell-xxxx' is not allowed to connect to this MySQL server`

这时候可以按照如下步骤开通root的外网访问权限：

1. 在MySQL服务器本地输入命令：`mysql -u root -p`
2. 然后输入root用户的密码。登录后切换到mysql数据库：`use mysql`
3. 让所有ip都可以访问：`update user set host = '%' where user = 'root';`
4. 刷新权限用户权限：`flush privileges;`
5. 此时再用客户端就应该可以了。例如：navicat、dbeaver



## 基础层级

- client
- server
  - 连接器，控制用户连接。
  - 分析器，词法分析，语法分析。将SQL解析成AST树（抽象语法树）
  - 优化器，优化SQL，确定执行流程。RBO&CBO，现在更多的场景是CBO，基于成本优化。
  - 执行器。实际执行SQL的组件。
  - 缓存。实际命中率很低，8.0开始就废弃了。
- 存储引擎



## 性能监控

### 自带工具

#### 精确显示sql执行时间

我们执行SQL语句时，默认会显示SQL执行时间。但是精确到小数点后2位。使用下面的命令可以显示的更精确。

```sql
mysql> select * from employee;
#默认显示时间精确到小数点后2位
Empty set (0.00 sec)

#开启时间精确显示
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

#使用下面的命令会显示更多的SQL执行细节。
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
```

可以看到show profile;命令会显示出一个sql执行过程中每一个步骤的时间。以下是每个步骤的介绍

> starting：始执行
> Executing hook on transaction：开启对应事务
> checking permissions：检查权限
> Opening tables：打开表
> init：进行初始化的操作
> optimizing：优化的操作
> statistics：统计的操作
> executing：执行的操作



# Oracle







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



## MongoDB概念 

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



## 常用操作

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

