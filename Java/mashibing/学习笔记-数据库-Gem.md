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



## 设计范式

1.每个字段不可再分



# MySQL

## 参考说明

本文内容来源于个人实践以及工作经验总结，还有部分参考了以下内容。

- 马士兵教育视频教程及配套笔记（[MySQL实战调优-连鹏举](https://www.mashibing.com/study?courseNo=392&sectionNo=2801&courseVersionId=1297)）
- 菜鸟教程，https://www.runoob.com/mysql/mysql-tutorial.html。



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

#### show profile

https://dev.mysql.com/doc/refman/8.0/en/show-profile.html

我们执行SQL语句时，默认会显示SQL执行时间。但是精确到小数点后2位。使用下面的命令可以显示的更精确。

set profiling=1;  开启显示sql profile功能

show profiles; 显示最近执行的sql的总体profile，精确到小数点后8位

show profile; 显示最后一个sql的profile的duration数据。

show profile for query 2; 显示某一个sql的profile数据。queryId可以通过show profiles;命令查询

show profile [type]; 显示一个SQL的指定类型的profile数据。如果type参数为空仅显示Duration数据。可以用all显示全部的。

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

1、提供了一种在数据库运行时实时检查server的内部执行情况的方法。performance_schema 数据库中的表使用performance_schema存储引擎。该数据库主要关注数据库运行过程中的性能相关的数据，与information_schema不同，information_schema主要关注server运行过程中的元数据信息
2、performance_schema通过监视server的事件来实现监视server内部运行情况， “事件”就是server内部活动中所做的任何事情以及对应的时间消耗，利用这些信息来判断server中的相关资源消耗在了哪里？一般来说，事件可以是函数调用、操作系统的等待、SQL语句执行的阶段（如sql语句执行过程中的parsing 或 sorting阶段）或者整个SQL语句与SQL语句集合。事件的采集可以方便的提供server中的相关存储引擎对磁盘文件、表I/O、表锁等资源的同步调用信息。
3、performance_schema中的事件与写入二进制日志中的事件（描述数据修改的events）、事件计划调度程序（这是一种存储程序）的事件不同。performance_schema中的事件记录的是server执行某些活动对某些资源的消耗、耗时、这些活动执行的次数等情况。
4、performance_schema中的事件只记录在本地server的performance_schema中，其下的这些表中数据发生变化时不会被写入binlog中，也不会通过复制机制被复制到其他server中。
5、 当前活跃事件、历史事件和事件摘要相关的表中记录的信息。能提供某个事件的执行次数、使用时长。进而可用于分析某个特定线程、特定对象（如mutex或file）相关联的活动。
6、PERFORMANCE_SCHEMA存储引擎使用server源代码中的“检测点”来实现事件数据的收集。对于performance_schema实现机制本身的代码没有相关的单独线程来检测，这与其他功能（如复制或事件计划程序）不同
7、收集的事件数据存储在performance_schema数据库的表中。这些表可以使用SELECT语句查询，也可以使用SQL语句更新performance_schema数据库中的表记录（如动态修改performance_schema的setup_*开头的几个配置表，但要注意：配置表的更改会立即生效，这会影响数据收集）
8、performance_schema的表中的数据不会持久化存储在磁盘中，而是保存在内存中，一旦服务器重启，这些数据会丢失（包括配置表在内的整个performance_schema下的所有数据）
9、MySQL支持的所有平台中事件监控功能都可用，但不同平台中用于统计事件时间开销的计时器类型可能会有所差异。



##### performance schema关闭

如果想要显式的关闭的话需要修改配置文件，不能直接进行修改，会报错Variable 'performance_schema' is a read only variable。

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



##### performance schema两个基本概念

instruments：生产者，用于采集mysql中各种各样的操作产生的事件信息，对应配置表中的配置项我们可以称为监控采集配置项。

consumers：消费者，对应的消费者表用于存储来自instruments采集的数据，对应配置表中的配置项我们可以称为消费存储配置项。



##### performance_schema表的分类

performance_schema库下的表可以按照监视不同的纬度就行分组。

```sql
--语句事件记录表，这些表记录了语句事件信息，当前语句事件表events_statements_current、历史语句事件表events_statements_history和长语句历史事件表events_statements_history_long、以及聚合后的摘要表summary，其中，summary表还可以根据帐号(account)，主机(host)，程序(program)，线程(thread)，用户(user)和全局(global)再进行细分)
show tables like '%statement%';

--等待事件记录表，与语句事件类型的相关记录表类似：
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



##### performance_schema简单配置与使用

数据库刚刚初始化并启动时，并非所有instruments(事件采集项，在采集项的配置表中每一项都有一个开关字段，或为YES，或为NO)和consumers(与采集项类似，也有一个对应的事件类型保存表配置项，为YES就表示对应的表保存性能数据，为NO就表示对应的表不保存性能数据)都启用了，所以默认不会收集所有的事件，可能你需要检测的事件并没有打开，需要进行设置，可以使用如下两个语句打开对应的instruments和consumers（行计数可能会因MySQL版本而异)。

```sql
--打开等待事件的采集器配置项开关，需要修改setup_instruments配置表中对应的采集器配置项
UPDATE setup_instruments SET ENABLED = 'YES', TIMED = 'YES'where name like 'wait%';

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

###### 指定开启单个instruments

--performance-schema-instrument= 'instrument_name=value'

###### 使用通配符指定开启多个instruments

--performance-schema-instrument= 'wait/synch/cond/%=COUNTED'

###### 开关所有的instruments

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



#### show processlist

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
```

这个命令一般用的比较少，因为一般项目的连接都是连接池管理的，比较少出问题。

- 比较有名的Java连接池有，[Druid](https://github.com/alibaba/druid/wiki/%E9%A6%96%E9%A1%B5)，C3P0，Hikari等等。目前功能和性能相对最强大的是druid。
- 功能角度考虑，Druid 功能更全面，除具备连接池基本功能外，还支持sql级监控、扩展、SQL防注入等。最新版甚至有集群监控
- 单从性能角度考虑，从数据上确实HikariCP要强，但Druid有更多、更久的生产实践，它可靠。
- 单从监控角度考虑，如果我们有像skywalking、prometheus等组件是可以将监控能力交给这些的 HikariCP 也可以将metrics暴露出去。



### 执行计划

在企业的应用场景中，为了知道优化SQL语句的执行，需要查看SQL语句的具体执行过程，以加快SQL语句的执行效率。

可以使用`explain SQL语句`来模拟优化器执行SQL查询语句，从而知道mysql是如何处理sql语句的。

官网地址： https://dev.mysql.com/doc/refman/8.0/en/explain-output.html

#### 执行计划中的字段

|    Column     |                    Meaning                     |
| :-----------: | :--------------------------------------------: |
|      id       |            The `SELECT` identifier             |
|  select_type  |               The `SELECT` type                |
|     table     |          The table for the output row          |
|  partitions   |            The matching partitions             |
|     type      |                 The join type                  |
| possible_keys |         The possible indexes to choose         |
|      key      |           The index actually chosen            |
|    key_len    |          The length of the chosen key          |
|      ref      |       The columns compared to the index        |
|     rows      |        Estimate of rows to be examined         |
|   filtered    | Percentage of rows filtered by table condition |
|     extra     |             Additional information             |

**id**

select查询的序列号，包含一组数字，表示查询中执行select子句或者操作表的顺序

id号分为三种情况：

1、如果id相同，那么执行顺序从上到下

```sql
explain select * from emp e join dept d on e.deptno = d.deptno join salgrade sg on e.sal between sg.losal and sg.hisal;
```

2、如果id不同，如果是子查询，id的序号会递增，id值越大优先级越高，越先被执行

```sql
explain select * from emp e where e.deptno in (select d.deptno from dept d where d.dname = 'SALES');
```

3、id相同和不同的，同时存在：相同的可以认为是一组，从上往下顺序执行，在所有组中，id值越大，优先级越高，越先执行

```sql
explain select * from emp e join dept d on e.deptno = d.deptno join salgrade sg on e.sal between sg.losal and sg.hisal where e.deptno in (select d.deptno from dept d where d.dname = 'SALES');
```

**select_type**

主要用来分辨查询的类型，是普通查询还是联合查询还是子查询

| `select_type` Value  |                           Meaning                            |
| :------------------: | :----------------------------------------------------------: |
|        SIMPLE        |        Simple SELECT (not using UNION or subqueries)         |
|       PRIMARY        |                       Outermost SELECT                       |
|        UNION         |         Second or later SELECT statement in a UNION          |
|   DEPENDENT UNION    | Second or later SELECT statement in a UNION, dependent on outer query |
|     UNION RESULT     |                      Result of a UNION.                      |
|       SUBQUERY       |                   First SELECT in subquery                   |
|  DEPENDENT SUBQUERY  |      First SELECT in subquery, dependent on outer query      |
|       DERIVED        |                        Derived table                         |
| UNCACHEABLE SUBQUERY | A subquery for which the result cannot be cached and must be re-evaluated for each row of the outer query |
|  UNCACHEABLE UNION   | The second or later select in a UNION that belongs to an uncacheable subquery (see UNCACHEABLE SUBQUERY) |

```sql
--sample:简单的查询，不包含子查询和union
explain select * from emp;

--primary:查询中若包含任何复杂的子查询，最外层查询则被标记为Primary
explain select staname,ename supname from (select ename staname,mgr from emp) t join emp on t.mgr=emp.empno ;

--union:若第二个select出现在union之后，则被标记为union
explain select * from emp where deptno = 10 union select * from emp where sal >2000;

--dependent union:跟union类似，此处的depentent表示union或union all联合而成的结果会受外部表影响
explain select * from emp e where e.empno  in ( select empno from emp where deptno = 10 union select empno from emp where sal >2000)

--union result:从union表获取结果的select
explain select * from emp where deptno = 10 union select * from emp where sal >2000;

--subquery:在select或者where列表中包含子查询
explain select * from emp where sal > (select avg(sal) from emp) ;

--dependent subquery:subquery的子查询要受到外部表查询的影响
explain select * from emp e where e.deptno in (select distinct deptno from dept);

--DERIVED: from子句中出现的子查询，也叫做派生类，
explain select staname,ename supname from (select ename staname,mgr from emp) t join emp on t.mgr=emp.empno ;

--UNCACHEABLE SUBQUERY：表示使用子查询的结果不能被缓存
 explain select * from emp where empno = (select empno from emp where deptno=@@sort_buffer_size);
 
--uncacheable union:表示union的查询结果不能被缓存：sql语句未验证
```

**table**

对应行正在访问哪一个表，表名或者别名，可能是临时表或者union合并结果集
1、如果是具体的表名，则表明从实际的物理表中获取数据，当然也可以是表的别名

2、表名是derivedN的形式，表示使用了id为N的查询产生的衍生表

3、当有union result的时候，表名是union n1,n2等的形式，n1,n2表示参与union的id

**type**

type显示的是访问类型，访问类型表示我是以何种方式去访问我们的数据，最容易想的是全表扫描，直接暴力的遍历一张表去寻找需要的数据，效率非常低下，访问的类型有很多，效率从最好到最坏依次是：

system > const > eq_ref > ref > fulltext > ref_or_null > index_merge > unique_subquery > index_subquery > range > index > ALL 

一般情况下，得保证查询至少达到range级别，最好能达到ref

```sql
--all:全表扫描，一般情况下出现这样的sql语句而且数据量比较大的话那么就需要进行优化。
explain select * from emp;

--index：全索引扫描这个比all的效率要好，主要有两种情况，一种是当前的查询时覆盖索引，即我们需要的数据在索引中就可以索取，或者是使用了索引进行排序，这样就避免数据的重排序
explain  select empno from emp;

--range：表示利用索引查询的时候限制了范围，在指定范围内进行查询，这样避免了index的全索引扫描，适用的操作符： =, <>, >, >=, <, <=, IS NULL, BETWEEN, LIKE, or IN() 
explain select * from emp where empno between 7000 and 7500;

--index_subquery：利用索引来关联子查询，不再扫描全表
explain select * from emp where emp.job in (select job from t_job);

--unique_subquery:该连接类型类似与index_subquery,使用的是唯一索引
 explain select * from emp e where e.deptno in (select distinct deptno from dept);
 
--index_merge：在查询过程中需要多个索引组合使用，没有模拟出来

--ref_or_null：对于某个字段即需要关联条件，也需要null值的情况下，查询优化器会选择这种访问方式
explain select * from emp e where  e.mgr is null or e.mgr=7369;

--ref：使用了非唯一性索引进行数据的查找
 create index idx_3 on emp(deptno);
 explain select * from emp e,dept d where e.deptno =d.deptno;

--eq_ref ：使用唯一性索引进行数据查找
explain select * from emp,emp2 where emp.empno = emp2.empno;

--const：这个表至多有一个匹配行，
explain select * from emp where empno = 7369;
 
--system：表只有一行记录（等于系统表），这是const类型的特例，平时不会出现
```

 **possible_keys** 

​        显示可能应用在这张表中的索引，一个或多个，查询涉及到的字段上若存在索引，则该索引将被列出，但不一定被查询实际使用

```sql
explain select * from emp,dept where emp.deptno = dept.deptno and emp.deptno = 10;
```

**key**

​		实际使用的索引，如果为null，则没有使用索引，查询中若使用了覆盖索引，则该索引和查询的select字段重叠。

```sql
explain select * from emp,dept where emp.deptno = dept.deptno and emp.deptno = 10;
```

**key_len**

表示索引中使用的字节数，可以通过key_len计算查询中使用的索引长度，在不损失精度的情况下长度越短越好。

```sql
explain select * from emp,dept where emp.deptno = dept.deptno and emp.deptno = 10;
```

**ref**

显示索引的哪一列被使用了，如果可能的话，是一个常数

```sql
explain select * from emp,dept where emp.deptno = dept.deptno and emp.deptno = 10;
```

**rows**

根据表的统计信息及索引使用情况，大致估算出找出所需记录需要读取的行数，此参数很重要，直接反应的sql找了多少数据，在完成目的的情况下越少越好

```sql
explain select * from emp;
```

**extra**

包含额外的信息。

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





## 设计优化

### Schema数据类型优化

#### 更小的更好

应该尽量使用可以正确存储数据的最小数据类型，更小的数据类型通常更快，因为它们占用更少的磁盘、内存和CPU缓存，并且处理时需要的CPU周期更少，但是要确保没有低估需要存储的值的范围，如果无法确认哪个数据类型，就选择你认为不会超过范围的最小类型

案例

设计两张表，设计不同的数据类型，然后写程序往表里插入相同数据量的数据。查看表的容量

查看表对应的数据文件可知，虽然实际大小一直，但是更大的数据类型占用空间更大。



#### 简单就好

简单数据类型的操作通常需要更少的CPU周期，例如：

1、整型比字符操作代价更低，因为字符集和校对规则是字符比较比整型比较更复杂，

2、使用mysql自建类型而不是字符串来存储日期和时间

3、用整型存储IP地址

案例：

创建两张相同的表，改变日期的数据类型，查看SQL语句执行的速度



#### 避免null

只要业务支持，尽量避免设计可为null的值。

如果查询中包含可为NULL的列，对mysql来说很难优化，因为可为null的列使得索引、索引统计和值比较都更加复杂。

坦白来说，通常情况下null的列改为not null带来的性能提升比较小，所有没有必要将所有的表的schema进行修改，但是应该尽量避免设计成可为null的列。

业务上可以为空的字段，经过业务评估，可以给字段设计默认值。但不要和可能出现的业务数据重复。

例如：字符型可以设计默认值：空字符。但不要设计成a或者b。

整形可以设计成：-1或者0。但如果业务上可能会填入-1或者0，那也不要强行设计默认值。



#### 整形类型

可以使用的几种整数类型：TINYINT，SMALLINT，MEDIUMINT，INT，BIGINT分别使用8，16，24，32，64位存储空间。
尽量使用满足需求的最小数据类型。

注意，上面的几种类型还可以指定长度。当实际是可以存储超出长度的数据的。实际还是按类型对应的字节数存储的。



#### 字符类型

mysql中常见的字符类型：char、varchar、text

1、char长度固定，即每条数据占用等长字节空间；最大长度是255个字符，适合用在身份证号、手机号等定长字符串
2、varchar可变程度，可以设置最大长度；最大空间是65535个字节，适合用在长度可变的属性
3、text不设置长度，当不知道属性的最大长度时，适合用text
按照查询速度：char>varchar>text

varchar根据实际内容长度保存数据
 1、使用最小的符合需求的长度。
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



#### Blob和text

MySQL 把每个 BLOB 和 TEXT 值当作一个独立的对象处理。

两者都是为了存储很大数据而设计的字符串类型，分别采用二进制和字符方式存储。

text一般可能的场景是存储xml文件内容，SQL语句，Json格式数据等等。

这2种格式使用场景较小，一般出现很多字符的场景还是推荐将存储文件存储路径存储到数据库中。而不是直接存文件内容。



#### 时间类型

datetime

 占用8个字节

 与时区无关，数据库底层时区配置，对datetime无效

 可保存到毫秒

 可保存时间范围大

 不要使用字符串存储日期类型，占用空间大，损失日期类型函数的便捷性

timestamp

 占用4个字节

 时间范围：1970-01-01到2038-01-19

 精确到秒

 采用整形存储

 依赖数据库设置的时区

 自动更新timestamp列的值

date

 占用的字节数比使用字符串、datetime、int存储要少，使用date类型只需要3个字节

 使用date类型还可以利用日期时间函数进行日期之间的计算

 date类型用于保存1000-01-01到9999-12-31之间的日期，不包含时分秒。



#### 枚举类型

有时可以使用枚举类代替常用的字符串类型，mysql存储枚举类型会非常紧凑，会根据列表值的数据压缩到一个或两个字节中，mysql在内部会将每个值在列表中的位置保存为整数，并且在表的.frm文件中保存“数字-字符串”映射关系的查找表
create table enumtest(e enum('fish','apple','dog') not null); insert into enumtest(e) values('fish'),('dog'),('apple');
select e+0 from enum_test;



#### 特殊类型

一般会使用varchar(15)来存储ip地址，然而ip的本质是32位无符号整数不是字符串，可以使用INETATON()和INETNTOA函数在这两种表示方法之间转换

案例：

select inetaton('1.1.1.1');

select inetntoa(16843009);



### 数据库范式

#### 范式

 优点

  范式化的更新通常比反范式要快
  当数据较好的范式化后，很少或者没有重复的数据
  范式化的数据比较小，可以放在内存中，操作比较快

 缺点

  通常需要进行关联

#### 反范式

反范式

优点

所有的数据都在同一张表中，可以避免关联

可以设计有效的索引；

缺点

表格内的冗余较多，删除数据或者更新数据时会造成表有些有用的信息丢失或者不同步。

在企业中很好能做到严格意义上的范式或者反范式，一般需要混合使用

#### 适当冗余

满足以下条件，可以考虑适当的采取冗余。Oracle中有物化视图也体现了这一思想。

 1.被频繁引用且只能通过 Join 2张(或者更多)大表的方式才能得到的独立小字段。
 2.这样的场景由于每次Join仅仅只是为了取得某个小字段的值，Join到的记录又大，会造成大量不必要的 IO，完全可以通过空间换取时间的方式来优化。不过，冗余的同时需要确保数据的一致性不会遭到破坏，确保更新的同时冗余字段也被更新。

#### 案例

在一个网站实例中，这个网站，允许用户发送消息，并且一些用户是付费用户。现在想查看付费用户最近的10条信息。  在user表和message表中都存储用户类型(account_type)而不用完全的反范式化。这避免了完全反范式化的插入和删除问题，因为即使没有消息的时候也绝不会丢失用户的信息。这样也不会把user_message表搞得太大，有利于高效地获取数据。

另一个从父表冗余一些数据到子表的理由是排序的需要。

缓存衍生值也是有用的。如果需要显示每个用户发了多少消息（类似论坛的），可以每次执行一个昂贵的自查询来计算并显示它；也可以在user表中建一个num_messages列，每当用户发新消息时更新这个值。

#### 适当拆分

当我们的表中存在类似于 TEXT 或者是很大的 VARCHAR类型的大字段的时候，如果我们大部分访问这张表的时候都不需要这个字段，我们就该义无反顾的将其拆分到另外的独立表中，以减少常用数据所占用的存储空间。这样做的一个明显好处就是每个数据块中可以存储的数据条数可以大大增加，既减少物理 IO 次数，也能大大提高内存中的缓存命中率。

一张表中有很多字段，其中经常访问的只是一部分字段，这个时候就可以考虑将不长访问的字段放到另一个张表中用一个键关联原表。



### 主键选择

代理主键

 与业务无关的，无意义的数字序列

自然主键

 事物属性中的自然唯一标识

推荐使用代理主键

 它们不与业务耦合，因此更容易维护
 一个大多数表，最好是全部表，通用的键策略能够减少需要编写的源码数量，减少系统的总体拥有成本



### 字符集选择

字符集直接决定了数据在MySQL中的存储编码方式，由于同样的内容使用不同字符集表示所占用的空间大小会有较大的差异，所以通过使用合适的字符集，可以帮助我们尽可能减少数据量，进而减少IO操作次数。

1.纯拉丁字符能表示的内容，没必要选择 latin1 之外的其他字符编码，因为这会节省大量的存储空间。

2.如果我们可以确定不需要存放多种语言，就没必要非得使用UTF8或者其他UNICODE字符类型，这回造成大量的存储空间浪费。

3.MySQL的数据类型可以精确到字段，所以当我们需要大型数据库中存放多字节数据的时候，可以通过对不同表不同字段使用不同的数据

类型来较大程度减小数据存储量，进而降低 IO 操作次数并提高缓存命中率。

如果必须使用utf8来存储字符，那推荐使用utf8mb4。MySQL中utf8默认只能存2个字节。



### 存储引擎选择

[官方存储引擎介绍](https://dev.mysql.com/doc/refman/5.7/en/storage-engines.html)

存储引擎是数据真正存放的地方，再往下就是内存和磁盘了。提供读写接口给服务器调用。

默认存储引擎的配置：在my.ini文件中有个default-storage-engine。

InnoDB

5.5开始的默认存储引擎。支持事务、外键、表锁、行锁、聚集索引、5.6之后支持全文索引。

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

1. InnoDB 支持事务，MyISAM 不支持事务。这是 MySQL 将默认存储引擎从 MyISAM 变成 InnoDB 的重要原因之一；

2. InnoDB 支持外键，而 MyISAM 不支持。对一个包含外键的 InnoDB 表转为 MYISAM 会失败；  

3. InnoDB 是聚集索引，MyISAM 是非聚集索引。聚簇索引的文件存放在主键索引的叶子节点上，因此 InnoDB 必须要有主键，通过主键索引效率很高。但是辅助索引需要两次查询，先查询到主键，然后再通过主键查询到数据。因此，主键不应该过大，因为主键太大，其他索引也都会很大。而 MyISAM 是非聚集索引，数据文件是分离的，索引保存的是数据文件的指针。主键索引和辅助索引是独立的。 

4. InnoDB 不保存表的具体行数，执行 select count(*) from table 时需要全表扫描。而MyISAM 用一个变量保存了整个表的行数，执行上述语句时只需要读出该变量即可，速度很快；    

5. InnoDB 最小的锁粒度是行锁，MyISAM 最小的锁粒度是表锁。一个更新语句会锁住整张表，导致其他查询和更新都会被阻塞，因此并发访问受限。这也是 MySQL 将默认存储引擎从 MyISAM 变成 InnoDB 的重要原因之一；

**如何选择：**

1. 是否要支持事务，如果要请选择 InnoDB，如果不需要可以考虑 MyISAM；

2. 如果表中绝大多数都只是读查询，可以考虑 MyISAM，如果既有读，写也挺频繁，请使用InnoDB。

3. 系统奔溃后，MyISAM恢复起来更困难，能否接受，不能接受就选 InnoDB；

4. MySQL5.5版本开始Innodb已经成为Mysql的默认引擎(之前是MyISAM)，说明其优势是有目共睹的。如果你不知道用什么存储引擎，那就用InnoDB，至少不会差。



## 索引优化

### 索引基础

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

