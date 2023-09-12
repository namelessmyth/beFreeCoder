# 学习路线

马士兵官网个人学习路线链接：https://www.mashibing.com/subject/studyline/1?courseId=18870

```mermaid
flowchart TB
    subgraph question [提问]
    q1[提问的智慧]
    end
    subgraph suanfa [算法 & 数据结构]
    s1[算法和数据结构新手班]-->s2
    s2[算法数据结构体系学习班]-->s3
    s3[每周有营养的大厂算法面试题]
    end
    question-->suanfa
    
    suanfa-->design
    subgraph design [设计模式]
    d1[坦克大战一期]-->d2
    d2[抽丝剥茧设计模式精讲]
    end
    
    design-->sourceCode
    subgraph sourceCode [框架源码]
    c1[Spring源码]-->c2
    c2[SpringMVC源码]-->c3
    c3[SpringBoot源码]-->c4
    c4[SpringCloudAlibaba实战与源码]-->c5
    c5[Mybatis源码]-->c6
    c6[Tomcat源码]-->c7
    c7[Netty源码]
    end
    
    sourceCode-->server
    subgraph server [中间件]
    se1[Redis]-->se2
    se2[ZooKeeper]-->se3
    se3[Kafka]-->se4
    se4[RocketMQ]-->se5
    se5[MySQL实战调优]-->se6
    se6[MongoDB实战]-->se7
    se7[集群内并发-LVS]-->se8
    se8[mycat&sharding-jdbc从入门到精通]
    end
    
    server-->jvm
    subgraph jvm [Java底层]
    j1[JVM调优]-->j2
    j2[hotspot源码]-->j3
    j3[多线程与高并发实战]
    end
    
    jvm-->action
    subgraph action [互联网项目实战]
    a1[亿级流量多级缓存分布式课程]-->a2
    a2[网约车项目实战三期]-->a3
    a3[常见痛点规避与大厂Bug处理专题]-->a4
    a4[游戏高级架构师]
    end
    
    action-->principle
    subgraph principle [计算机底层原理]
    p1[操作系统]-->p2
    p2[计算机网络]-->p3[编译原理]
    end
```

## 个人心得

今天用笔记把老师给我设计的学习路线重新复习了一遍，加深些印象。

努力很重要，努力之前的选择也很重要。现在比较关注职业规划和学习路线。不希望把时间荒废在和目标无关的事情上。

之前在一个公司干了7年，虽然很努力，也拿到了优秀员工，但一直没有对自己做一个清晰的职业规划也没有明确的目标。导致7年后突然发现自己用的技术都已经过时了。想换工作都难。所以现在比较关注职业规划和学习路线。不希望把时间荒废在和目标无关的事情上。

关于年薪百万这个目标，对于从没达到过的人会觉得这个很难。但对于曾今实现过这个目标的人就会有实现方法。所以选择了马士兵，希望马士兵各位老师能给一些宝贵的建议。当路上遇到困难时，有老师们的帮助能降低自己摸索，走弯路花费的时间。



## 提问的智慧

沟通的核心思想：沟通以对方为中心。

用最快最舒服的方式让对方知道你想表达的意思。了解前因后果和目前的问题。



### 专业术语的使用

尽量使用行业专业术语，不要自己造词汇。但也不要过度使用专业术语，使得一个简单问题变成一个学术论文。

如果要问老师，尽量使用老师说过的专业术语。



### 问题描述准确具体

能截图就尽量截图，截图时最好把重点圈出来。



### 提供分析材料

可以换位思考：如果是你在处理别人的问题，那针对这个问题，你想看到哪些材料？

例如：如果想让别人帮忙分析SQL语句，最好除了把SQL语句发给对方之外，最好还能提供表结构说明文档，建表和数据插入语句。

必要时最好能提供运行环境说明。例如：jdk版本，编辑工具，服务器环境。



## 程序调试技巧

### 日志查看

精确定位异常的代码行。灰色的行代表并不是自己项目的源代码，蓝色的才是。

从上往下看cause by：一般看最下面的异常。



### 博客和工具网站介绍

日志中如果出现一些没见过的异常，可以去网上搜索。例如：百度、csdn。

随着处理的问题越来越多，学到的东西也越来越多。

一个问题至少查阅3篇文章。

csdn：开发者社区网站。

菜鸟教程：https://www.runoob.com/

w3school（偏前端）：https://www.w3school.com.cn/



## 线上教育平台问答系统

1. 账号注册与登录 联系班主任
2. 知识问答。一般30分钟之内回复。可以悬赏。在我的问答中会显示别人的回复。
3. 题库。汇集了常见的面试题。



# 职业规划

## 架构师

### 什么是架构师？

对于一个公司而言，架构师引领着整个公司的技术方向，架构师的眼界和高度决定了一个公司的技术高度。

对一个技术团队而言，架构师的决策和技术方案，影响着工程师的开发模式和开发工作量。

一个好的架构师能让团队用最少的工作达到最好的效果。就是事半功倍。一个差的架构师可能就是事倍功半。

一个好的架构师一个公司的宝贵财富，一个差的架构师是一个团队的噩梦。

不同的公司，不同的国家对架构师的分类是不一样的。



### 架构师分类

#### 按照职责分

架构师分为：产品架构师，开发架构师，运维架构师。



**产品架构师**

负责整个产品的技术架构，当产品的业务规划和规则确定后，产品架构师需要开始设计产品，确定产品模块之间的架构，

和运维团队确定用户数，PV数（PageView，网页访问量）商品数，订单量等等非功能性的运维指标。

和产品经理确定功能需求，功能模块的划分。

和项目经理确认开发资源，测试资源。每种资源能安排多少人到项目上。

收集到所有相关信息后进行整体的架构设计。然后给销售，运营，开发，测试，运维确定目标。

还需要参与到产品的整个生命周期中去。从无到有到最后上线，版本升级。

这种架构师比较高端。



**开发架构师**

1. 负责开发基础框架，公共组件，通用服务等等可以让很多人使用的功能。
2. 对于开发成果需要承担海量数据存储，高性能，高并发，高可用等三高问题。
3. 负责核心功能开发。项目组疑难问题解决。以及其他具有技术挑战性的工作。



**运维架构师**

负责网络存储等运维工作，例如：负载均衡，多个数据库，多个存储，多个消息队列，多个日志如何归类如何存储等等。



#### 按照工作分

架构师分为：普通架构师，极客型架构师，助人型架构师，扫地僧架构师，布道型架构师。

**普通架构师**

负责系统架构设计，框架的实施落地，后期技术演化重构，核心代码编写等

**极客型架构师**

满足普通架构师的要求，对于某些技术领域有特别深入的研究，达到精通的程度。例如：阿里P7

**助人型架构师**

当团队成员遇到困难时，需要给予一定的帮助，帮助其他成员快速成长。

**扫地僧架构师**

每当系统出现故障，一般人搞不定时都需要他们出马。他们可能是随着公司的开发发展到壮大一直都在，所以他们对公司的整体技术架构非常清楚，所以他们是公司的定海神针。

**布道型架构师**

存在较好的个人影响力，以及坚定的技术信仰，乐于分享，在公司内部能推动推广自己的技术主张。这种类型的架构师也反面教材，也有一部分放弃学习，停止成长，出于自身的局限最终成为一个忽悠型架构师，阻碍公司发展的。



#### 关注点

### 功能



### 非功能



### 团队与组织管理



### 产品运营



### 产品未来



## 进大厂

### 大厂介绍

一线大厂：bat，字节，美团，华为，微软

二线大厂：京东(836)、网易(680)、拼多多(610)、百度(480)、快手(380)、携程(250)、贝壳(150)、滴滴(100)



### 面试内容

#### 算法

美国的大厂对于应届生基本主要考察这个。这个是程序员的基本功，相当于易筋经，不是短期突击就能突击出来的。



#### 架构设计

这是另一个国外大厂考核有经验程序猿的主要内容。也是需要长期积累的。

同样是设计一辆车，张三设计出来的可能是奥拓，李四设计出来的可能是奔驰。虽然功能类似都是设计理念，未来扩展，质量并不相同。

会通过一些实际的案例，要求面试者进行架构设计来达到业务要求。知识包括：设计模式，框架源码，技术选型等。

例如：设计架构支持春节红包雨，30秒内抢1亿的红包。红包数量：1000万，用户数：3000万。每个用户只能抢成功1次。



#### 面试八股

包含面试的常见内容，不同的厂可能问的内容不一定一样。但是这部分知识积累的越多越好。

例如：JVM，并发优化，Redis，MQ，设计模式，Spring源码



#### 项目应用

主要是看简历中项目经验中对于考察知识的实际应用。前面答得好



#### 加分项

这部分内容有的话加分，没有影响也不大。例如：云原生，大数据，AI。



## 大龄问题





# 架构设计

## 1 概述

### 代码质量好坏评价标准

#### 可维护性

可维护性强的代码指的是：在不去破坏原有的代码设计以及不引入新的BUG的前提下，能够快速的修改或者新增代码。

不易维护的代码指的是：在添加或者修改一些功能逻辑的时候，存在极大的引入新的BUG的风险，并且需要花费的时间也很长。

> 代码可维护性的评判标准比较模糊, 因为是否易维护是针对维护的人员来说的,不同水平的人对于同一份代码的维护能力是不同的. 所谓 ''难者不会 会者不难''. 对于同样的系统,熟悉它的资深工程师会觉得代码可维护性还可以,而新人则会因为能力不足、了解不够深入等原因觉得代码的可维护性不是很好.



#### 可读性

软件开发教父，Martin Fowler曾经说过一句话: "任何傻瓜都能够编写计算机能理解的代码，而优秀的程序员能够编写人类能理解的代码。这句话的意思是，好的代码应该是易读的且易理解的，不仅针对其他人也针对作者本人。

**易读的标准**

**代码风格，编程规范**

可使用checkstyle插件检查。

**代码坏味道**

https://blog.csdn.net/uuuyy_/article/details/122433110



#### 可扩展性

代码的可扩展性表示，我们在不修改或少量修改原有代码的情况下，通过扩展的方式添加新的功能代码。

设计原则中的开闭原则就是符合这个标准的。



#### 灵活性

"灵活" 是指在添加新代码的时候，已有代码能够不受影响，不产生冲突，不出现排斥，在保证自身不遭到破坏的前提下灵活地接纳新代码。灵活性评价标准

添加新功能代码时，原有代码是否已经预留了扩展点，可以不修改原有代码。

实现功能模块时，原有代码是否已经抽象出了很多可复用的通用方法或者组件。

在使用某组接口时，接口是否能应对多种场景，满足不同的需求。



#### 简洁性

代码的写法应当使别人理解它所需的时间最小化。换句话说就是代码要尽可能简单。



#### 可复用性

代码的可复用性可以简单地理解为，尽量减少重复代码的编写，复用已有的代码。这也是很多设计模式想要达到的目标。



#### 可测试性

单元测试在一个完整的软件开发流程中是必不可少的、非常重要的一个环节。通常写单元测试并不难，但有的时候，有的代码和功能难以测试，导致写起测试来困难重重。所以写出的代码具有可测试性，具有很重要的作用。



### 编程方法论

想要拥有编写高质量代码的能力,我们就要学习一些编程的方法论.其中就包含面向对象（我们可以把它看成一种设计思想）、设计原则、设计模式、编程规范、重构技巧等。

#### 面向对象

面向对象是一种编程思想,也是一种编程范式. 现在比较流行的编程语言大部分都是面向对象编程语言.而大部分项目也都是基于面向对象编程风格进行开发的.

除了面向对象，还有面向过程，函数式编程。

#### 设计原则

设计原则是指导我们代码设计的一些经验总结。在软件开发中，为了提高软件系统的可维护性和可复用性，增加软件的可扩展性和灵活性，程序员要尽量根据设计原则来开发程序，从而提高软件开发效率、节约软件开发成本和维护成本。

#### 设计模式

设计模式是针对软件开发中经常遇到的一些设计问题，总结出来的一套解决方案或者设计思路。大部分设计模式要解决的都是代码的可扩展性问题。

#### 编程规范

编程规范主要解决的是代码的可读性问题。编码规范相对于设计原则、设计模式，更加具体、更加偏重代码细节。

#### 重构

维基百科: 在软件工程学里，重构代码一词通常是指在不改变代码的外部行为情况下而修改源代码，有时非正式地称为“清理干净”。在极限编程或其他敏捷方法学中，重构常常是软件开发循环的一部分：开发者轮流增加新的测试和功能，并重构代码来增进内部的清晰性和一致性。

软件是不停的迭代的，持续的重构是保持代码质量不下降的非常重要的方式。



#### **提高代码质量的方法论总结**

面向对象思想 (基础)

设计原则 (指导方针)

设计模式 (设计原则的具体实现)

编程规范 (提高代码可读性)



### 设计模式概述

#### 什么是设计模式

设计模式（Design pattern）是一套被反复使用、多数人知晓的、经过分类编目的、代码设计经验的总结.

在程序员的世界中，本没有设计模式，写代码是人多了，他们便总结出了一套能提高开发和维护效率的套路，这就是设计模式。



#### **学习设计模式的好处**

从容的面对面试中的设计模式相关问题。

不再编写bullshit-code

提高复杂代码的设计和开发能力

有助于读懂源码，学习框架更加事半功倍



#### **设计模式的产生**

"设计模式" 最初并不是出现在软件设计中，而是被用于建筑领域的设计中。

![image-20230315235101472](马士兵-学习笔记-沈俊杰.assets/image-20230315235101472.png)

1977年美国著名建筑大师、加利福尼亚大学伯克利分校环境结构中心主任克里斯托夫·亚历山大（Christopher Alexander）在他的著作《建筑模式语言：城镇、建筑、构造》中描述了一些常见的建筑设计问题，并提出了 253 种关于对城镇、邻里、住宅、花园和房间等进行设计的基本模式。

四人帮（GOF）![image-20230315235037630](马士兵-学习笔记-沈俊杰.assets/image-20230315235037630.png)

1990年软件工程界开始研讨设计模式的话题，后来召开了多次关于设计模式的研讨会。

1994 年，艾瑞克·伽马（ErichGamma）、理査德·海尔姆（Richard Helm）、拉尔夫·约翰森（Ralph Johnson）、约翰·威利斯迪斯（John Vlissides）等 4 位作者合作出版了《设计模式：可复用面向对象软件的基础》一书，在此书中收录了 23 个设计模式，这是设计模式领域里程碑的事件，导致了软件设计模式的突破。

备注：由于书名太长， 人们将其简称为 "四人组 （Gang of Four， GoF） 的书"， 并且很快进一步简化为 "GoF 的书"。



#### 好书推荐

《图解设计模式》结城浩，《大话设计模式》程杰



### 设计模式分类

GoF设计模式有23个，它们各具特色，每个模式都为某一个可重复的设计问题提供了一套解决方案。根据它们的用途，设计模式可分为:

1. 创建型(Creational)
2. 结构型(Structural)
3. 行为型(Behavioral)

#### 创建型（5个）

主要关注对象创建

1. 单例模式。某个类只能生成一个实例，该类提供了一个全局访问点供外部获取该实例
2. 工厂方法。定义一个用于创建产品的接口，由子类决定生产什么产品。
3. 抽象工厂。主要关注多维度产品的创建。
4. 建造者模式。将一个复杂对象分解成多个相对简单的部分，然后根据不同需要分别创建它们，最后构建成该复杂对象
5. 原型模式。将一个对象作为原型，通过对其进行复制而克隆出多个和原型类似的新实例。

#### 结构型（7种）

通过组织类和对象的结构以实现更多功能

1. 代理（Proxy）模式：为某对象提供一种代理以控制对该对象的访问。即客户端通过代理间接地访问该对象，从而限制、增强或修改该对象的一些特性。
2. 适配器（Adapter）模式：将一个类的接口转换成客户希望的另外一个接口，使得原本由于接口不兼容而不能一起工作的那些类能一起工作。
3. 桥接（Bridge）模式：将抽象与实现分离，使它们可以独立变化。它是用组合关系代替继承关系来实现的，从而降低了抽象和实现这两个可变维度的耦合度。
4. 装饰（Decorator）模式：动态地给对象增加一些职责，即增加其额外的功能。
5. 外观（Facade）模式：为多个复杂的子系统提供一个一致的接口，使这些子系统更加容易被访问。
6. 享元（Flyweight）模式：运用共享技术来有效地支持大量细粒度对象的复用。
7. 组合（Composite）模式：将对象组合成树状层次结构，使用户对单个对象和组合对象具有一致的访问性。

#### 行为型（11种）

描述多个类或对象之间怎样相互协作共同完成单个对象都无法单独完成的任务

1. 模板方法模式（Template Method）：定义一个操作中的算法骨架，将算法的一些步骤延迟到子类中，使得子类在可以不改变该算法结构的情况下重定义该算法的某些特定步骤。
2. 策略模式（Strategy）：定义了一系列算法，并将每个算法封装起来，使它们可以相互替换，且算法的改变不会影响使用算法的客户端。
3. 命令模式（Command）：将一个请求封装为一个对象，使发出请求的责任和执行请求的责任分割开。
4. 职责链（Chain of Responsibility）模式：把请求从链中的一个对象传到下一个对象，直到请求被响应为止。通过这种方式去除对象之间的耦合。
5. 状态（State）模式：允许一个对象在其内部状态发生改变时改变其行为能力。
6. 观察者（Observer）模式：多个对象间存在一对多关系，当一个对象发生改变时，把这种改变通知给其他多个对象，从而影响其他对象的行为。
7. 中介者（Mediator）模式：定义一个中介对象来简化原有对象之间的交互关系，降低系统中对象间的耦合度，使原有对象之间不必相互了解。
8. 迭代器（Iterator）模式：提供一种方法来顺序访问聚合对象中的一系列数据，而不暴露聚合对象的内部表示。
9. 访问者（Visitor）模式：在不改变集合元素的前提下，为一个集合中的每个元素提供多种访问方式，即每个元素有多个访问者对象访问。
10. 备忘录（Memento）模式：在不破坏封装性的前提下，获取并保存一个对象的内部状态，以便以后恢复它。
11. 解释器（Interpreter）模式：提供如何定义语言的文法，以及对语言句子的解释方法，即解释器。



## 2 UML图

### 2.1 类图概述

类图(Class diagram)是显示了模型的静态结构，特别是模型中存在的类、类的内部结构以及它们与其他类的关系等。类图不显示暂时性的信息。类图是面向对象建模的主要组成部分。

### 2.2 类图的作用

* 在软件工程中，类图是一种静态的结构图，描述了系统的类的集合，类的属性和类之间的关系，可以简化了人们对系统的理解；
* 类图是系统分析和设计阶段的重要产物，是系统编码和测试的重要模型。

### 2.3 类图表示法

UML类图中具体类、抽象类、接口和包有不同的表示方法。

#### 2.3.1 在UML类图中表示具体类

具体类在类图中用矩形框表示，矩形框分为三层：第一层是类名字。第二层是类的成员变量；第三层是类的方法。成员变量以及方法前的访问修饰符用符号来表示：

- “+” 表示 `public`；
- “-” 表示 `private`；
- “#” 表示 `protected`；
- 不带符号表示 `default`。

<img src="马士兵-学习笔记-沈俊杰.assets/06-1680102385311-2.jpg" alt="image-20220530160637842" style="zoom: 50%;" />  

#### 2.3.2 在UML类图中表示抽象类

抽象类在UML类图中同样用矩形框表示，但是抽象类的类名以及抽象方法的名字都用斜体字表示，如图所示。

<img src="马士兵-学习笔记-沈俊杰.assets/05-1680102385312-3.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

#### 2.3.3 在UML类图中表示接口

接口在类图中也是用矩形框表示，但是与类的表示法不同的是，接口在类图中的第一层顶端用构造型 <<interface>>表示，下面是接口的名字，第二层是方法。

<img src="马士兵-学习笔记-沈俊杰.assets/07-1680102385313-4.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

> 此外，接口还有另一种表示法，俗称棒棒糖表示法，就是类上面的一根棒棒糖（圆圈+实线）。圆圈旁为接口名称，接口方法在实现类中出现。

#### 2.3.4 在类图中表示关系

类和类、类和接口、接口和接口之间存在一定关系，UML类图中一般会有连线指明它们之间的关系。

关系共有六种类型 ,如下图: 

<img src="马士兵-学习笔记-沈俊杰.assets/17-1680102385313-5.jpg" alt="image-20220530160637842" style="zoom: 50%;" />  



#### 3.3.4.1 实现关系

实现关系是接口与实现类之间的关系。在这种关系中，类实现了接口，类中的操作实现了接口中所声明的所有的抽象操作。

在 UML 类图中，实现关系使用带空心三角箭头的虚线来表示，箭头从实现类指向接口。

例如，汽车和船实现了交通工具，其类图:

​								<img src="马士兵-学习笔记-沈俊杰.assets/09-1680102385314-6.jpg" alt="image-20220530160637842" style="zoom: 90%;" /> 



#### 2.3.4.2 泛化关系

泛化关系是对象之间耦合度最大的一种关系，表示一般与特殊的关系，是父类与子类之间的关系，是一种继承关系。

在 UML 类图中，泛化关系用带空心三角箭头的实线来表示，箭头从子类指向父类。在代码实现时，使用面向对象的继承机制来实现泛化关系。

例如，Student 类和 Teacher 类都是 Person 类的子类，其类图如下图所示：

​									<img src="马士兵-学习笔记-沈俊杰.assets/10-1680102385314-7.jpg" alt="image-20220530160637842" style="zoom: 90%;" /> 

#### 2.3.4.3 关联关系

关联关系是对象之间的一种引用关系，用于表示一类对象与另一类对象之间的联系，如老师和学生、师傅和徒弟、丈夫和妻子等。关联关系是类与类之间最常用的一种关系，分为一般关联关系、聚合关系和组合关系。

我们先介绍一般关联关系, 一般关联关系又可以分为单向关联，双向关联，自关联。

**1) 单向关联**

​								<img src="马士兵-学习笔记-沈俊杰.assets/11-1680102385314-8.jpg" alt="image-20220530160637842" style="zoom: 100%;" /> 

在UML类图中单向关联用一个带箭头的实线表示。上图表示每个顾客都有一个地址，这通过让Customer类持有一个类型为Address的成员变量类实现。

**2) 双向关联**

​								<img src="马士兵-学习笔记-沈俊杰.assets/12-1680102385315-9.jpg" alt="image-20220530160637842" style="zoom: 100%;" /> 

从上图中我们很容易看出，所谓的双向关联就是双方各自持有对方类型的成员变量。

在UML类图中，双向关联用一个不带箭头的直线表示。上图中在Customer类中维护一个List\<Product>，表示一个顾客可以购买多个商品；在Product类中维护一个Customer类型的成员变量表示这个产品被哪个顾客所购买。

**3) 自关联**

​														<img src="马士兵-学习笔记-沈俊杰.assets/13-1680102385315-10.jpg" alt="image-20220530160637842" style="zoom: 100%;" /> 

自关联在UML类图中用一个带有箭头且指向自身的线表示。上图的意思就是Node类包含类型为Node的成员变量，也就是“自己包含自己”。

##### 2.3.4.4 聚合关系

聚合关系是关联关系的一种，表示一种弱的‘拥有’关系，体现的是A对象可以包含B对象，但是B对象不是A对象的一部分

> 在代码中: 比如A 类对象包含 B 类对象，B 类对象的生命周期可以不依赖 A 类对象的生命周期，也就是说可以单独销毁 A 类对象而不影响 B 对象

```java
public class A{

	private B b;
	
	public A(B b){
		this.b = b;
	}
}
```

在 UML 类图中，聚合关系可以用带空心菱形的实线来表示，菱形指向整体。

下图所示是大学和教师的关系图：							

<img src="马士兵-学习笔记-沈俊杰.assets/14-1680102385315-11.jpg" alt="image-20220530160637842" style="zoom: 100%;" />

##### 2.3.4.5 组合关系

组合关系是一种强‘拥有’关系，体现了严格的部分和整体的关系，部分和整体的声明周期一样

> 在代码中: 比如A 类对象包含 B 类对象，B 类对象的生命周期依赖A 类对象的生命周期，B 类对象不可以单独存在

```java
public class A{
    
    private B b;
    
    public A(){
        this.b = new B();
    }
    
}
```

在 UML 类图中，组合关系用带实心菱形的实线来表示，菱形指向整体。

下图所示是头和嘴的关系图：

​								<img src="马士兵-学习笔记-沈俊杰.assets/15-1680102385315-12.jpg" alt="image-20220530160637842" style="zoom: 100%;" /> 

##### 2.3.4.6 依赖关系

依赖关系是一种使用关系，它是对象之间耦合度最弱的一种关联方式，是临时性的关联。

在代码中，某个类的方法通过局部变量、方法的参数或者对静态方法的调用来访问另一个类（被依赖类）中的某些方法来完成一些职责。

在 UML 类图中，依赖关系使用带箭头的虚线来表示，箭头从使用类指向被依赖的类。

下图所示是司机和汽车的关系图，司机驾驶汽车：

​                            <img src="马士兵-学习笔记-沈俊杰.assets/16-1680102385316-13.jpg" alt="image-20220530160637842" style="zoom: 100%;" /> 

### 2.4 UML类图总结

之前我们一共学习了六种类关系的表示方式

- 实现关系
- 泛化关系
- 关联关系
- 聚合关系
- 组合关系
- 依赖关系

为了节省学习成本, 方便记忆,我们可以将类和类之间的关系重新调整一下,使其更加贴近编程的角度:

- 实现关系
- 泛化关系
- 依赖关系
- 组合关系 (组合关系+关联关系+聚合关系)

> 我们也没有必要去区分组合与聚合这两个概念,只需要记住一点就是: 多用组合少用继承 
>
> 也就是说只要 B 类对象是 A 类对象的成员变量，那我们就称，A类跟B类是组合关系.
>

**表格整理**


| 类型 | 说明                                                 | 图示               | 代码体现                         | 图例 |
| ---- | ---------------------------------------------------- | ------------------ | -------------------------------- | ---- |
| 泛化 | Generalization，也叫继承，一般化                     | 实线+三角形        | extends                          | ─▷   |
| 实现 | Implementation，接口和其实现类的关系                 | 虚线+三角形        | implements                       | ┄▷   |
| 依赖 | Dependence，是一种使用关系，A类的变化引起了B类的变化 | 虚线+箭头          | 方法入参，局部变量，调用静态方法 | ┄>   |
| 关联 | Association，是一种拥有关系，分单向和双向关联        | 实线+箭头          | 成员变量（实例变量）             | ─>   |
| 聚合 | 特殊的关联关系，整体与部分，可以分离独立存在         | 空心菱形+实线+箭头 | 电脑中的各个部件                 | ◇─>  |
| 组合 | 特殊的关联关系，整体与部分，不可分离独立存在         | 实心菱形+实线+箭头 | 公司与部门                       | ♦─>  |





## 3 设计原则(SOLID)

### 3.1 设计原则概述

> 古人云: 有道无术,术可求.有术无道,止于术. 
>
> 而设计模式通常需要遵循一些设计原则，在设计原则的基础之上衍生出了各种各样的设计模式。设计原则是设计要求，设计模式是设计方案，使用设计模式的代码则是具体的实现。

   

设计模式中主要有6大设计原则，简称为SOLID ，是由于各个原则的首字母简称合并的来(两个L算一个,solid 稳定的)，六大设计原则分别如下：

​	**单一职责原则（Single Responsibitity Principle）**

​	**开放封闭原则（Open Close Principle）**

​	**里氏替换原则（Liskov Substitution Principle）**

​	**接口分离原则（Interface Segregation Principle）**

​	**依赖倒置原则（Dependence Inversion Principle）**

​	**迪米特法则（Law Of Demter）**

还有的文章会加入**合成复用原则**，变成7种设计原则。



### 3.2 单一职责原则

#### 3.2.1 官方定义

**单一职责原则**，英文缩写SRP，全称 Single Responsibility Principle。

在<<架构整洁之道>>一书中 关于这个原则的英文描述是这样的：A class or module should have a single responsibility 。如果我们把它翻译成中文，那就是**：一个类或者模块只负责完成一个职责（或者功能）**。

#### 3.2.2 通俗解释

单一职责原则的定义描述非常简单，也不难理解。**一个类只负责完成一个职责或者功能。**

也就是说在类的设计中 我们不要设计大而全的类,而是要设计粒度小、功能单一的类. 

> 比如 我们设计一个类里面既包含了用户的一些操作,又包含了支付的一些操作,那这个类的职责就不够单一,应该将该类进行拆分,拆分成多个功能更加单一的,粒度更细的类.

#### 3.2.3 场景示例

那么该如何判断一个类的职责是否单一 ?

> 其实在软件设计中，要真正用好单一职责原则并不简单，因为遵循这一原则最关键的地方在于职责的划分，而职责的划分是根据需求定的，同一个类（接口）的设计，在不同的需求里面，可能职责的划分并不一样.

我们来看下面这个例子:

在一个社交媒体产品中,我们使用UserInfo去记录用户的信息,包括如下的属性.

```mermaid
classDiagram
    class UserInfo{
        -long userId
        -String userName
        -String email
        -String telePhone
        -String province
        -String city
        -String district
        ...
    }
```

   

请问上面的UserInfo类是否满足单一职责原则呢 ?

- 观点1: 满足,因为记录的都是跟用户相关的信息
- 观点2: 不满足,因为地址信息应该被拆分出来,单独放到地址表中保存.

正确答案: 根据实际业务场景选择是否拆分

- 该社交产品的有用户信息只是用来展示的,那么这个类这样设计就没有问题
- 假设后面这个社交产品又添加了电商模块, 那就需要将地址信息提取出来,单独设计一个类

<img src="马士兵-学习笔记-沈俊杰.assets/20.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 



**总结: 不同的应用场景、不同阶段的需求背景下，对同一个类的职责是否单一的判定，可能都是不一样的,最好的方式就是: **

> 我们可以先写一个粗粒度的类，满足业务需求。随着业务的发展，如果粗粒度的类越来越庞大，代码越来越多，这个时候，我们就可以将这个粗粒度的类，拆分成几个更细粒度的类。这就是所谓的持续重构



**如何判断一个类的职责是否单一?**

这里没有一个具体的金科玉律，但从实际代码开发经验上，有一些可执行性的侧面判断指标，可供参考：

- 类中的代码行数、函数、或者属性过多；

- 类依赖的其他类过多

- 私有方法过多

- 类中大量的方法都是集中操作类中的几个属性



### 3.3 开闭原则

#### 3.3.1 官方定义

一般认为最早提出开闭原则（Open-Close Principle，OCP）的是伯特兰·迈耶。他在1988 年发表的《面向对象软件构造》中给出的。在面向对象编程领域中，

开闭原则规定软件中的对象、类、模块和函数对扩展应该是开放的，但对于修改是封闭的。这意味着应该用抽象定义结构，用具体实现扩展细节，以此确保软件系统开发和维护过程的可靠性。

#### 3.3.2 通俗解释

定义：**对扩展开放，对修改关闭**

> 对扩展开放和对修改关闭表示当一个类或一个方法有新需求或者需求发生改变时应该采用扩展的方式而不应该采用修改原有逻辑的方式来实现。因为扩展了新的逻辑如果有问题只会影响新的业务，不会影响老业务；而如果采用修改的方式，很有可能就会影响到老业务受影响。
>
> 开闭原则是所有设计模式的最核心目标，也是最难实现的目标，但是所有的软件设计模式都应该以开闭原则当作标准，才能使软件更加的稳定和健壮。

优点：

1. 新老逻辑解耦，需求发生改变不会影响老业务的逻辑

2. 改动成本最小，只需要追加新逻辑，不需要改的老逻辑

3. 提供代码的稳定性和可扩展性

#### 3.3.3 场景示例

系统A与系统B之间进行数据传输使用的是427版本的协议，一年以后对427版本的协议进行了修正。

设计时应该考虑的数据传输协议的可变性，抽象出具有报文解译、编制、校验等所有版本协议使用的通用方法，调用方针对接口进行编程即可，如上述示例设计类图如下

<img src="马士兵-学习笔记-沈俊杰.assets/21.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

调用方依赖于报文接口，报文接口是稳定的，而不针对具体的427协议或427修正协议。利用接口多态技术，实现了开闭原则。

**顶层设计思维**

- 抽象意识
- 封装意识
- 扩展意识

> 在写代码的时候后，我们要多花点时间往前多思考一下，这段代码未来可能有哪些需求变 更、如何设计代码结构，事先留好扩展点，以便在未来需求变更的时候，不需要改动代码整 体结构、做到最小代码改动的情况下，新的代码能够很灵活地插入到扩展点上，做到“对扩 展开放、对修改关闭”。



### 3.4 里氏替换原则

#### 3.4.1 官方定义

里氏替换原则（Liskov Substitution Principle，LSP）是由麻省理工学院计算机科学系教授芭芭拉·利斯科夫于 1987 年在“面向对象技术的高峰会议”（OOPSLA）上发表的一篇论文《数据抽象和层次》（Data Abstractionand Hierarchy）里提出的.

她在论文中提到：如果S是T的子类型，对于S类型的任意对象，如果将他们看作是T类型的对象，则对象的行为也理应与期望的行为一致。



> 子类对象能够替换程序中父类对象出现的任何地方，并且保证原来程序的逻辑行为不变及正确性不被破坏。

#### 3.4.2 通俗解释

**如何理解里氏替换原则？**

要理解里氏替换原则，其实就是要理解两个问题：

- 什么是替换？
- 什么是与期望行为一致的替换（Robert Martin所说的“必须能够替换”）？



**1 ) 什么是替换 ?**

替换的前提是面向对象语言所支持的多态特性，同一个行为具有多个不同表现形式或形态的能力。

> 以JDK的集合框架为例，`List`接口的定义为有序集合，`List`接口有多个派生类，比如大家耳熟能详的`ArrayList`, `LinkedList`。那当某个方法参数或变量是`List`接口类型时，既可以是`ArrayList`的实现, 也可以是`LinkedList`的实现，这就是替换。

**2 ) 什么是与期望行为一致的替换？** 

在不了解派生类的情况下，仅通过接口或基类的方法，即可清楚的知道方法的行为，而不管哪种派生类的实现，都与接口或基类方法的期望行为一致。

> 不需要关心是哪个类对接口进行了实现,因为不管底层如何实现,最终的结果都会符合接口中关于方法的描述(也就是与接口中方法的期望行为一致).
>
> 或者说接口或基类的方法是一种契约，使用方按照这个契约来使用，派生类也按照这个契约来实现。这就是与期望行为一致的替换。



#### 3.4.3 场景示例

里氏替换原则要求我们在编码时使用基类或接口去定义对象变量，使用时可以由具体实现对象进行赋值，实现变化的多样性，完成代码对修改的封闭，扩展的开放。

比如在一个商城项目中, 定义结算接口Istrategy，该接口有三个具体实现类，分别为 PromotionalStrategy （满减活动，两百以上百八折）、RebateStrategy （打折活动）、 ReduceStrategy（返现活动）

<img src="马士兵-学习笔记-沈俊杰.assets/22.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

```java
public interface Istrategy {
    public double realPrice(double consumePrice);
}

public class PromotionalStrategy implements Istrategy {
    public double realPrice(double consumePrice) {
        if (consumePrice > 200) {
            return 200 + (consumePrice - 200) * 0.8;
        } else {
            return consumePrice;
        }
    }
}
public class RebateStrategy implements Istrategy {
    private final double rate;
    public RebateStrategy() {
        this.rate = 0.8;
    }
    public double realPrice(double consumePrice) {
        return consumePrice * this.rate;
    }
}
public class ReduceStrategy implements Istrategy {
    public double realPrice(double consumePrice) {
        if (consumePrice >= 1000) {
            return consumePrice - 200;
        } else {
            return consumePrice;
        }
    }
}
```

调用方为Context，在此类中使用接口定义了一个对象。

 <img src="马士兵-学习笔记-沈俊杰.assets/23.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

```java
public class Context {
    //使用基类定义对象变量
    private Istrategy strategy;
    // 注入当前活动使用的具体对象
    public void setStrategy(Istrategy strategy) {
        this.strategy = strategy;
    }
    // 计算并返回费用
    public double cul(double consumePrice) {
        // 使用具体商品促销策略获得实际消费金额
        double realPrice = this.strategy.realPrice(consumePrice);
        // 格式化保留小数点后1位，即：精确到角
        BigDecimal bd = new BigDecimal(realPrice);
        bd = bd.setScale(1, BigDecimal.ROUND_DOWN);
        return bd.doubleValue();
    }
}
```

Context 中代码使用接口定义对象变量，这个对象变量可以是实现了lStrategy接口的PromotionalStrategy、RebateStrategy 、 ReduceStrategy任意一个。

里氏代换原则与多态的区别 ?

> 虽然从定义描述和代码实现上 来看，多态和里式替换有点类似，但它们关注的角度是不一样的。多态是面向对象编程的一 大特性，也是面向对象编程语言的一种语法。它是一种代码实现的思路。而里式替换是一种 设计原则，用来指导继承关系中子类该如何设计，子类的设计要保证在替换父类的时候，不 改变原有程序的逻辑及不破坏原有程序的正确性。

里氏替换原则和依赖倒置原则，构成了面向接口编程的基础，正因为里氏替换原则，才使得程序呈现多样性。

### 3.5 接口隔离原则

#### 3.5.1 官方定义

<<代码整洁之道>>作者**罗伯特 C·马丁** 为 “接口隔离原则” 的定义是：客户端不应该被迫依赖于它不使用的方法（Clients should not be forced to depend on methods they do not use）。

该原则还有另外一个定义：一**个类对另一个类的依赖应该建立在最小的接口上**

#### 3.5.2 通俗解释

上面两个定义的含义用一句话概括就是：**要为各个类建立它们需要的专用接口，而不要试图去建立一个很庞大的接口供所有依赖它的类去调用。** 

**接口隔离原则与单一职责原则的区别**

接口隔离原则和单一职责都是为了提高类的内聚性、降低它们之间的耦合性，体现了封装的思想，但两者是不同的：

- 单一职责原则注重的是职责，而接口隔离原则注重的是对接口依赖的隔离。
- 单一职责原则主要是约束类，它针对的是程序中的实现和细节；接口隔离原则主要约束接口，主要针对抽象和程序整体框架的构建。

#### 3.5.3 场景示例

微服务用户系统提供了一组跟用户相关的 API 给其他系统 使用，比如：注册、登录、获取用户信息等。

<img src="马士兵-学习笔记-沈俊杰.assets/24.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

```java
public interface UserService {
    boolean register(String cellphone, String password);
    boolean login(String cellphone, String password);
    UserInfo getUserInfoById(long id);
    UserInfo getUserInfoByCellphone(String cellphone);
}

public class UserServiceImpl implements UserService {
		//...
}
```

需求: 后台管理系统要实现删除用户的功能，希望用户系统提供一个删除用户的接口,应该如何设计这个接口(假设这里我们不去考虑使用鉴权框架).

- 方案1: 直接在UserService接口中添加一个删除用户的接口

  > 这个方法可以解决问题，但是也隐藏了一些安全隐患。删除用户是一个非常慎重的操作，我们只希望通过后台管理系统来执行，所以这个接口只限于给后台管理系统使用。如果我们把它放到 UserService 中，那所有使用到 UserService 
  > 的系统，都可以调用这个接口。不加限制地被其他业务系统调用，就有可能导致误删用户。

- 方案2: 遵照接口隔离原则,为依赖接口的类定制服务。只提供调用者需要的方法，屏蔽不需要的方法。

​	  将删除接口单独放到另外 一个接口 RestrictedUserService 中, 然后将 RestrictedUserService 只打包提供给后台管理系统来	  使用。

​	 <img src="马士兵-学习笔记-沈俊杰.assets/25.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 	

```java
public interface UserService {
    boolean register(String cellphone, String password);
    boolean login(String cellphone, String password);
    UserInfo getUserInfoById(long id);
    UserInfo getUserInfoByCellphone(String cellphone);
}

public interface RestrictedUserService {
 boolean deleteUserByCellphone(String cellphone);
 boolean deleteUserById(long id);
}

public class UserServiceImpl implements UserService, RestrictedUserService {
		//...
}
```

遵循接口隔离原则的优势

1. 将臃肿庞大的接口分解为多个粒度小的接口，可以预防外来变更的扩散，提高系统的灵活性和可维护性。
2. 使用多个专门的接口还能够体现对象的层次，因为可以通过接口的继承，实现对总接口的定义。
3. 能减少项目工程中的代码冗余。过大的大接口里面通常放置许多不用的方法，当实现这个接口的时候，被迫设计冗余的代码.



### 3.6 依赖倒置原则

#### 3.6.1 官方定义

依赖倒置原则是Robert C.Martin于1996年在C++Report上发表的文章中提出的。

```
High level modules should not depend upon low level modules. Both should depend upon abstractions.
Abstractions should not depend upon details. Details should depend upon abstractions
```

依赖倒置原则（Dependence Inversion Principle，DIP）是指在设计代码架构时，高层模块不应该依赖于底层模块，二者都应该依赖于抽象。抽象不应该依赖于细节，细节应该依赖于抽象。

#### 3.6.2 通俗解释

依赖倒置原则是实现开闭原则的重要途径之一，它降低了客户与实现模块之间的耦合。

> 1. 高层级的模块应该依赖的是低层级的模块的行为的抽象，取决于具体编程语言，可以是抽象类或者接口等技术；
> 2. 第2句话其实很简单，只有一个意思：只要依赖了实现，就是耦合了代码，所以我们需要始终依赖的是抽象，而不是实现。

- **传统的自定向下的设计**

  > 传统设计方式采用自顶向下的原则， 逐级依赖，中层模块和高层模块的耦合度很高，如果需要修改其中的一个模块，则可能会导致其它很多模块也需要修改，牵一发动全身，不易于维护。
  >
  > 不使用依赖反转的系统构架，控制流和依赖关系流的依赖箭头是一个方向的，由高层指向底层，也就是高层依赖底层

<img src="马士兵-学习笔记-沈俊杰.assets/29.jpg" alt="image-20220530160637842" style="zoom: 50%;" />	

- 依赖倒置原则

  > 依赖倒置原则的好处:
  >
  > - 减少类间的耦合性，提高系统的稳定性 . (根据类与类之间的耦合度从弱到强排列：依赖关系、关联关系、聚合关系、组合关系、泛化关系和实现关系 )
  > - 降低并行开发引起的风险 (两个类之间有依赖关系，只要制定出两者之间的接口（或抽象类）就可以独立开发了)
  > - 提高代码的可读性和可维护性

​		<img src="马士兵-学习笔记-沈俊杰.assets/30.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

#### 3.6.3 场景示例

假设我们现在要组装一台电脑,需要的配件有 cpu，硬盘，内存条。只有这些配置都有了，计算机才能正常的运行。选择cpu有很多选择，如Intel，AMD等，硬盘可以选择希捷，西数等，内存条可以选择金士顿，海盗船等。

<img src="马士兵-学习笔记-沈俊杰.assets/26.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

代码如下：

**希捷硬盘类（XiJieHardDisk）:**

```java
public class XiJieHardDisk implements HardDisk {

    public void save(String data) {
        System.out.println("使用希捷硬盘存储数据" + data);
    }

    public String get() {
        System.out.println("使用希捷希捷硬盘取数据");
        return "数据";
    }
}
```

**Intel处理器（IntelCpu）：**

```java
public class IntelCpu implements Cpu {

    public void run() {
        System.out.println("使用Intel处理器");
    }
}
```

**金士顿内存条（KingstonMemory）：**

```java
public class KingstonMemory implements Memory {

    public void save() {
        System.out.println("使用金士顿作为内存条");
    }
}
```

**电脑（Computer）：**

```java
public class Computer {

    private XiJieHardDisk hardDisk;
    private IntelCpu cpu;
    private KingstonMemory memory;

    public IntelCpu getCpu() {
        return cpu;
    }

    public void setCpu(IntelCpu cpu) {
        this.cpu = cpu;
    }

    public KingstonMemory getMemory() {
        return memory;
    }

    public void setMemory(KingstonMemory memory) {
        this.memory = memory;
    }

    public XiJieHardDisk getHardDisk() {
        return hardDisk;
    }

    public void setHardDisk(XiJieHardDisk hardDisk) {
        this.hardDisk = hardDisk;
    }

    public void run() {
        System.out.println("计算机工作");
        cpu.run();
        memory.save();
        String data = hardDisk.get();
        System.out.println("从硬盘中获取的数据为：" + data);
    }
}
```

**测试类（TestComputer）：**

测试类用来组装电脑。

```java
public class TestComputer {
    public static void main(String[] args) {
        Computer computer = new Computer();
        computer.setHardDisk(new XiJieHardDisk());
        computer.setCpu(new IntelCpu());
        computer.setMemory(new KingstonMemory());

        computer.run();
    }
}
```

上面代码可以看到已经组装了一台电脑，但是似乎组装的电脑的cpu只能是Intel的，内存条只能是金士顿的，硬盘只能是希捷的，这对用户肯定是不友好的，用户有了机箱肯定是想按照自己的喜好，选择自己喜欢的配件。

根据依赖倒转原则进行改进：

代码我们需要修改Computer类，让Computer类依赖抽象（各个配件的接口），而不是依赖于各个组件具体的实现类。

**类图如下：**

<img src="马士兵-学习笔记-沈俊杰.assets/32.jpg" alt="image-20220530160637842" style="zoom: 50%;" />  

**电脑（Computer）：**

```java
public class Computer {

    private HardDisk hardDisk;
    private Cpu cpu;
    private Memory memory;
	
    //getter/setter......
    
    public void run() {
        System.out.println("计算机工作");
    }
}
```



**关于依赖倒置、依赖注入、控制反转这三者之间的区别与联系**   

1 )  依赖倒置原则

依赖倒置是一种通用的软件设计原则, 主要用来指导框架层面的设计。

> 高层模块不依赖低层模块，它们共同依赖同一个抽象。抽象不要依赖具体实现细节，具体实现细节依赖抽象。

2 ) 控制反转

控制反转与依赖倒置有一些相似, 它也是一种框架设计常用的模式,但并不是具体的方法。

> “控制”指的是对程序执行流程的控制，而“反转”指的是在没有使用框架之前，程序员自己控制整个程序的执行。在使用框架之后，整个程序的执行流程通过框架来控制。流程的控制权从程序员“反转”给了框架。
>
> Spring框架，核心模块IoC容器,就是通过控制反转这一种思想进行设计的

3 ) 依赖注入

依赖注入是实现控制反转的一个手段，它是一种具体的编码技巧。

> 我们不通过 new 的方式在类内部创建依赖的对象，而是将依赖的对象在外部创建好之后，通过构造函数等
> 方式传递（或注入）进来, 给类来使用。
>
> 依赖注入真正实现了面向接口编程的愿景，可以很方便地替换同一接口的不同实现，而不会影响到依赖这个接口的客户端。



### 3.7 迪米特法则

#### 3.7.1 官方定义

1987年秋天，迪米特法则由美国Northeastern University的Ian Holland(伊恩 霍兰德)提出，被UML的创始者之一Booch(布奇)等人普及。后来，因为经典著作The PragmaticProgrammer <<程序员修炼之道>>而广为人知。

迪米特法则（LoD：Law of Demeter）又叫最少知识原则（LKP：Least Knowledge Principle ），指的是一个类/模块对其他的类/模块有越少的了解越好。简言之：talk only to your immediate friends（只跟你最亲密的朋友交谈），不跟陌生人说话。

#### 3.7.2 通俗解释

大部分设计原则和思想都非常抽象，有各种各样的解读，要想灵活地应用到 实际的开发中，需要有实战经验的积累。迪米特法则也不例外。

简单来说迪米特法则想要表达的思想就是:  **不该有直接依赖关系的类之间，不要有依赖；有依赖关系的类之间，尽量只依赖必要的接口。**

> 如果两个软件实体无须直接通信，那么就不应当发生直接的相互调用，可以通过第三方转发该调用。其目的是降低类之间的耦合度，提高模块的相对独立性。

#### 3.7.3 场景示例

我们一起来看下面这个例子: 

明星由于全身心投入艺术，所以许多日常事务由经纪人负责处理，如和粉丝的见面会，和媒体公司的业务洽淡等。这里的经纪人是明星的朋友，而粉丝和媒体公司是陌生人，所以适合使用迪米特法则。

<img src="马士兵-学习笔记-沈俊杰.assets/31.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 



> 迪米特法则的独特之处在于它简洁而准确的定义，它允许在编写代码时直接应用，几乎自动地应用了适当的封装、高内聚和低耦合。
>
> 但是，过度使用迪米特法则会使系统产生大量的中介类，从而增加系统的复杂性，使模块之间的通信效率降低。所以，在釆用迪米特法则时需要反复权衡，确保高内聚和低耦合的同时，保证系统的结构清晰。

 

代码如下：

**明星类（Star）**

```java
public class Star {
    private String name;

    public Star(String name) {
        this.name=name;
    }

    public String getName() {
        return name;
    }
}
```

**粉丝类（Fans）**

```java
public class Fans {
    private String name;

    public Fans(String name) {
        this.name=name;
    }

    public String getName() {
        return name;
    }
}
```

**媒体公司类（Company）**

```java
public class Company {
    private String name;

    public Company(String name) {
        this.name=name;
    }

    public String getName() {
        return name;
    }
}
```

**经纪人类（Agent）**

```java
public class Agent {
    private Star star;
    private Fans fans;
    private Company company;

    public void setStar(Star star) {
        this.star = star;
    }

    public void setFans(Fans fans) {
        this.fans = fans;
    }

    public void setCompany(Company company) {
        this.company = company;
    }

    public void meeting() {
        System.out.println(fans.getName() + "与明星" + star.getName() + "见面了。");
    }

    public void business() {
        System.out.println(company.getName() + "与明星" + star.getName() + "洽淡业务。");
    }
}
```



### 3.8 合成复用原则

**简介**

- 定义：尽量使用对象组合/聚合，而不是继承关系达到软件复用的目的。
- 聚合has-A和组合contains-A。
- 优点：可以使系统更加灵活，降低类与类之间的耦合度，一个雷的变化对其他类造成的影响相对较少。

继承复用虽然简单，但是存在很大的缺点：
  （1）耦合度高，父类代码的修改会影响到子类，不利于代码的维护。
  （2）破坏了类的封装性，因为继承会将父类的实现细节暴露给子类，所以又叫做 "白箱" 复用。
  （3）限制了复用的灵活性，从父类继承来的实现是静态的，在运行期是无法改变的。

合成复用是将已有的对象作为新对象的成员对象来实现，新对象调用已有对象的功能，达到复用：
  （1）不会破坏封装性，因为新对象只能调用已有对象暴露出来的方法，所以又叫做 "黑箱" 复用
  （2）耦合度低，已有对象的变化对新对象的影响较小，可以在新对象的中，根据需要调用已有对象的一些操作。
  （3）复用的灵活性高，可以在代码的运行中，动态选择相同类型的其他具体类。

**实现参考**

先看通过继承来复用的案例。

```java
/**
* 数据库链接类，目前只有MySQL。
*/
public class DBConnection {
    public String getConnection() {
        return "MySQL数据库连接";
    }
}

/**
* 通过继承来使用工具类的方法。后面如果改成Oracle了，需要修改代码。而且改了之后还会影响老功能。
*/
public class ProductDao extends DBConnection{

    public void addProduct(){
        String conn=super.getConnection();
        System.out.println("使用"+conn+"增加产品");
    }
}

/**
* 客户端使用
*/
public class CompositionAggregationTest {
    public static void main(String[] args) {
        ProductDao productDao = new ProductDao();
        productDao.addProduct();
    }
}
```

改成合成的方式复用。

```java
/**
* 数据库链接类，改成抽象类，后面用不同的数据库实现类来继承他。
*/
public abstract class DBConnection {
    public abstract String getConnection();
}

public class MySQLConnection extends DBConnection{
    @Override
    public String getConnection() {
        return "MySQL数据库连接";
    }
}

public class PostgreSQLConnection extends DBConnection{
    @Override
    public String getConnection() {
        return "PostgreSQL数据库连接";
    }
}

/**
* 通过成员变量合成复用。
*/
public class ProductDao {
    private DBConnection dbConnection;

    public void setDbConnection(DBConnection dbConnection) {
        this.dbConnection = dbConnection;
    }

    public void addProduct() {
        String conn = dbConnection.getConnection();
        System.out.println("使用" + conn + "增加产品");
    }
}

public class CompositionAggregationTest {
    public static void main(String[] args) {
        ProductDao productDao = new ProductDao();
        productDao.setDbConnection(new PostgreSQLConnection());
        productDao.addProduct();
    }
}
```







### 3.9 设计原则总结

我们之前给的大家介绍了评判代码质量的标准,比如可读性、可复用性、可扩展性等等,这是从代码的整体质量的角度来评判.

而设计原则就是我们要使用到的更加具体的对于代码进行评判的标准,比如, 我们说这段代码的可扩展性比较差，主要原因是违背了开闭原则。

这里我们只需要重点关注三个常用的原则即可:

**1 ) 单一职责原则**

单一职责原则是类职责划分的重要参考依据，是保证代码”高内聚“的有效手段，是我们在进行面向对象设计时的主要指导原则。

> 单一职责原则的难点在于，对代码职责是否足够单一的判定。这要根据具体的场景来具体分析。同一个类的设计，在不同的场景下，对职责是否单一的判定，可能是不同的。

**2 ) 开闭原则**

开闭原则是保证代码可扩展性的重要指导原则，是对代码扩展性的具体解读。很多设计模式诞生的初衷都是为了提高代码的扩展性，都是以满足开闭原则为设计目的的。

> 开闭原则是所有设计模式的最核心目标，也是最难实现的目标，但是所有的软件设计模式都应该以开闭原则当作标准，才能使软件更加的稳定和健壮。

**3 ) 依赖倒置原则**

依赖倒置原则主要用来指导框架层面的设计。高层模块不依赖低层模块，它们共同依赖同一个抽象。

> 依赖倒置原则其实也是实现开闭原则的重要途径之一，它降低了类之间的耦合，提高了系统的稳定性和可维护性，同时这样的代码一般更易读，且便于传承。



## 4 创建型模式(5种)

创建型模式提供创建对象的机制，能够提升已有代码的灵活性和复用性

- 常用的有：单例模式、工厂模式（工厂方法和抽象工厂）、建造者模式。 


- 不常用的有：原型模式。
- 单例模式用来创建全局唯一对象
- 工厂模式用来创建不同但是相关类型的对象(继承同一父类或者接口的一组子类),由给定的参数来决定创建哪种类型的对象.
- 建造者模式是用来创建复杂对象,可以通过设置不同的可选参数,定制化地创建不同的对象.
- 原型模式针对创建成本比较大的对象,利用对已有对象进行复制的方式进行创建,以达到节省创建时间的目的.



### 4.1 单例模式

#### 4.1.1 模式介绍

**定义**

单例模式（Singleton Pattern）是 Java 中最简单的设计模式之一，此模式保证某个类在运行期间，只有一个实例对外提供服务，而这个类被称为单例类。

**作用**

1. 保证一个类只有一个实例
2. 为该实例提供一个全局访问节点

**使用场景**

需要频繁的进行创建和销毁的对象、创建对象时耗时过多或耗费资源过多(即:重量级对象)，但又经常用到的对象、工具类对象、频繁访问数据库或文件的对象(比如数据源、session工厂等)

**案例**

1. Windows的Task Manager（任务管理器）就是典型的单例模式
2. Windows的Recycle Bin（回收站）也是典型的单例应用。在整个系统运行过程中，回收站一直维护着仅有的一个实例。
3. 应用程序的日志应用，一般都何用单例模式实现，这一般是由于共享的日志文件一直处于打开状态，因为只能有一个实例去操作，否则内容不好追加。
4. Java开发中，controller，service，mapper等等非业务数据对象，一般都是单例。
5. 实际生活中的例子：一个人一生当中只能有一个真实的身份证号，一个国家只有一个政府，类似的场景都是属于单例模式。

**结构**

```mermaid
classDiagram
class Client
class Singleton {
	-instance Singleton
	-Singleton()
	+getInstance():Singleton
}
Client ..> Singleton 
Singleton --> Singleton
```



#### 4.1.2 饿汉式

在类加载期间初始化静态实例,保证 instance 实例的创建是线程安全的 ( 实例在类加载时实例化，有JVM保证线程安全).

​	特点: 不支持延迟加载实例(懒加载) , 此种方式类加载比较慢，但是获取实例对象比较快

​	问题: 该对象足够大的话，而一直没有使用就会造成内存的浪费。

```java
public class Singleton_01 {

    //1. 私有构造方法
    private Singleton_01(){

    }

    //2. 在本类中创建私有静态的全局对象
    private static Singleton_01 instance = new Singleton_01();


    //3. 提供一个全局访问点,供外部获取单例对象
    public static  Singleton_01 getInstance(){

        return instance;
    }

}
```



#### 4.1.3 懒汉式-线程不安全

此种方式的单例实现了懒加载,只有调用getInstance方法时 才创建对象.但是如果是多线程情况,会出现线程安全问题.

```java
public class Singleton_02 {

    //1. 私有构造方法
    private Singleton_02(){
    }

    //2. 在本类中创建私有静态的全局对象
    private static Singleton_02 instance;
    
    //3. 通过判断对象是否被初始化,来选择是否创建对象
    public static Singleton_02 getInstance(){
        if(instance == null){
            instance = new Singleton_02();
        }
        return instance;
    }

}
```

> 假设在单例类被实例化之前，有两个线程同时在获取单例对象，线程A在执行完if (instance == null) 后，线程调度机制将 CPU 资源分配给线程B，此时线程B在执行 if (instance == null)时也发现单例类还没有被实例化，这样就会导致单例类被实例化两次。为了防止这种情况发生，需要对 getInstance() 方法同步处理。改进后的懒汉模式.

##### 4.1.3.1 单例破坏-多线程

```java
/**
 * 测试在多线程环境下，普通懒汉单例是否线程安全<br>
 * @author namelessmyth
 * @version 1.0
 * @date 2023/3/29
 */
public class SingletonThreadSafeTest implements Runnable {

    @Override
    public void run() {
        SingletonLasy instance = SingletonLasy.getInstance();
        System.out.println(instance);
    }

	public static void main(String[] args) throws Exception {
        //SingletonLasy s1 = SingletonLasy.getInstance();
        //多线程下，下面的代码运行多次，会发现实例不是同一个。但上面的代码如果先执行，就不会破坏单例。
        Thread t1 = new Thread(new SingletonThreadSafeTest());
        Thread t2 = new Thread(new SingletonThreadSafeTest());
        Thread t3 = new Thread(new SingletonThreadSafeTest());
        t1.start();
        t2.start();
        t3.start();
    }
}
```



#### 4.1.4 懒汉式-线程安全

原理: 使用同步锁 `synchronized`锁住 创建单例的方法 ，防止多个线程同时调用，从而避免造成单例被多次创建

1. 即`getInstance（）`方法块只能运行在1个线程中

2. 若该段代码已在1个线程中运行，另外1个线程试图运行该块代码，则 **会被阻塞而一直等待** 

3. 而在这个线程安全的方法里我们实现了单例的创建，保证了多线程模式下 单例对象的唯一性

```java
public class Singleton_03 {

    //1. 私有构造方法
    private Singleton_03(){}

    //2. 在本类中创建私有静态的全局对象
    private static Singleton_03 instance;


    //3. 通过添加synchronize,保证多线程模式下的单例对象的唯一性
    public static synchronized  Singleton_03 getInstance(){

        if(instance == null){
            instance = new Singleton_03();
        }
        return instance;
    }

}
```

> 懒汉式的缺点也很明显，我们给 getInstance() 这个方法加了一把大锁（synchronzed），导致这个函数的并发度很低。量化一下的话，并发度是 1，也就相当于串行操作了。而这个函数是在单例使用期间，一直会被调用。如果这个单例类偶尔会被用到，那这种实现方式还可以接受。但是，如果频繁地用到，那频繁加锁、释放锁及并发度低等问题，会导致性能瓶颈，这种实现方式就不可取了。

#### 4.1.5 懒汉式-双重检查锁

饿汉式不支持延迟加载，懒汉式有性能问题，不支持高并发。那我们再来看一种既支持延迟加载、又支持高并发的单例实现方式，也就是双重检测实现方式。

实现步骤:

1. 在声明变量时使用了 volatile 关键字,其作用有两个: 

​		**保证变量的可见性**：当一个被volatile关键字修饰的变量被一个线程修改的时候，其他线程可以立刻得到修改之后的结果。

​		**屏蔽指令重排序**：指令重排序是编译器和处理器为了高效对程序进行优化的手段，它只能保证程序执行的结果时正确的，但		是无法保证程序的操作顺序与代码顺序一致。这在单线程中不会构成问题，但是在多线程中就会出现问题。

2. 将同步方法改为同步代码块. 在同步代码块中使用二次检查，以保证其不被重复实例化 同时在调用getInstance()方法时不进行同步锁，效率高。

```java
/**
 * 单例模式-双重校验
 * @author spikeCong
 * @date 2022/9/5
 **/
public class Singleton_04 {

    //使用 volatile保证变量的可见性
    private volatile static Singleton_04 instance = null;

    private Singleton_04(){
    }

    //对外提供静态方法获取对象
    public static Singleton_04 getInstance(){
        //第一次判断,如果instance不为null,不进入抢锁阶段,直接返回实例
        if(instance == null){
            synchronized (Singleton_04.class){
                //抢到锁之后再次进行判断是否为null
                if(instance == null){
                    instance = new Singleton_04();
                }
            }
        }

        return instance;
    }
}
```

**在双重检查锁模式中为什么需要使用 volatile 关键字?**

在java内存模型中，volatile 关键字作用可以是保证可见性或者禁止指令重排。这里是因为 singleton = new Singleton() ，它并非是一个原子操作，事实上，在 JVM 中上述语句至少做了以下这 3 件事：

- 第一步是给 singleton 分配内存空间；
- 第二步开始调用 Singleton 的构造函数等，来初始化 singleton；
- 第三步，将 singleton 对象指向分配的内存空间（执行完这步 singleton 就不是 null 了）。

这里需要留意一下 1-2-3 的顺序，因为存在指令重排序的优化，也就是说第 2 步和第 3 步的顺序是不能保证的，最终的执行顺序，可能是 1-2-3，也有可能是 1-3-2。

如果是 1-3-2，那么在第 3 步执行完以后，singleton 就不是 null 了，可是这时第 2 步并没有执行，singleton 对象未完成初始化，它的属性的值可能不是我们所预期的值。假设此时线程 2 进入 getInstance 方法，由于 singleton 已经不是 null 了，所以会通过第一重检查并直接返回，但其实这时的 singleton 并没有完成初始化，所以使用这个实例的时候会报错.

详细流程如下图所示：

<img src="马士兵-学习笔记-沈俊杰.assets/35.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

线程 1 首先执行新建实例的第一步，也就是分配单例对象的内存空间，由于线程 1 被重排序，所以执行了新建实例的第三步，也就是把 singleton 指向之前分配出来的内存地址，在这第三步执行之后，singleton 对象便不再是 null。

这时线程 2 进入 getInstance 方法，判断 singleton 对象不是 null，紧接着线程 2 就返回 singleton 对象并使用，由于没有初始化，所以报错了。最后，线程 1 “姗姗来迟”，才开始执行新建实例的第二步——初始化对象，可是这时的初始化已经晚了，因为前面已经报错了。

使用了 volatile 之后，相当于是表明了该字段的更新可能是在其他线程中发生的，因此应确保在读取另一个线程写入的值时，可以顺利执行接下来所需的操作。在 JDK 5 以及后续版本所使用的 JMM 中，在使用了 volatile 后，会一定程度禁止相关语句的重排序，从而避免了上述由于重排序所导致的读取到不完整对象的问题的发生。



#### 4.1.6 懒汉式-静态内部类

- 原理
  根据 **静态内部类** 的特性(外部类的加载不影响内部类)，同时解决了按需加载、线程安全的问题，同时实现简洁

> 1. 在静态内部类里创建单例，在装载该内部类时才会去创建单例
> 2. 线程安全：类是由 `JVM`加载，而`JVM`只会加载1遍，保证只有1个单例

```java
public class Singleton_05 {

    private static class SingletonHandler{
        private static Singleton_05 instance = new Singleton_05();
    }

    private Singleton_05(){}

    public static Singleton_05 getInstance(){
        return SingletonHandler.instance;
    }
}
```

#### 4.1.7 单例破坏-反射

反射技术过于强大，它可以通过`setAccessible()`来修改构造器，字段，方法的可见性。单例模式的构造方法是私有的，如果将其可见性设为`public`，那么将无法控制对象的创建。

```java
public class Test_Reflect {

    public static void main(String[] args) {

        try {
            //反射中，欲获取一个类或者调用某个类的方法，首先要获取到该类的Class 对象。
            Class<Singleton_05> clazz = Singleton_05.class;

            //getDeclaredXxx: 不受权限控制的获取类的成员.
            Constructor c = clazz.getDeclaredConstructor(null);

            //设置为true,就可以对类中的私有成员进行操作了
            c.setAccessible(true);

            Object instance1 = c.newInstance();
            Object instance2 = c.newInstance();

            System.out.println("成功破坏单例：" + (instance1 == instance2);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
```

**解决方法**

在单例类的构造方法中 添加判断 `instance != null` 时,直接抛出异常

```java
public class Singleton_05 {

    private static class SingletonHandler{
        private static Singleton_05 instance = new Singleton_05();
    }

    private Singleton_05(){
        if(SingletonHandler.instance != null){
            throw new RuntimeException("不允许非法访问!");
        }
    }

    public static Singleton_05 getInstance(){
        return SingletonHandler.instance;
    }
}
```

上面的这种方式使代码简洁性遭到破坏,设计不够优雅.

#### 4.1.8 单例破坏-序列化

```java
/**
 * 序列化对单例的破坏
 * @author spikeCong
 * @date 2022/9/6
 **/
public class Test_Serializable {

    @Test
    public void test() throws Exception{

        //序列化对象输出流
        ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream("tempFile.obj"));
        oos.writeObject(Singleton.getInstance());

        //序列化对象输入流
        File file = new File("tempFile.obj");
        ObjectInputStream ois = new ObjectInputStream(new FileInputStream(file));
        Singleton Singleton = (Singleton) ois.readObject();

        System.out.println(Singleton);
        System.out.println(Singleton.getInstance());

        //判断是否是同一个对象
        System.out.println(Singleton.getInstance() == Singleton);//false

    }
}


/**
 * 单例类实现序列化接口
 */
class Singleton implements Serializable {

    private volatile static Singleton singleton;

    private Singleton() {

    }

    public static Singleton getInstance() {
        if (singleton == null) {
            synchronized (Singleton.class) {
                if (singleton == null) {
                    singleton = new Singleton();
                }
            }
        }
        return singleton;
    }

}
```

输出结构为false，说明：

通过对Singleton的序列化与反序列化得到的对象是一个新的对象，这就`破坏了Singleton的单例性`。

解决方案

```java
/**
* 解决方案:只要在Singleton类中定义readResolve就可以解决该问题
* 程序会判断是否有readResolve方法,如果存在就在执行该方法,如果不存在--就创建一个对象
*/
private Object readResolve() {
	return singleton;
}
```

问题是出在ObjectInputputStream 的readObject 方法上, 我们来看一下ObjectInputStream的readObject的调用栈:

ObjectInputStream中readObject方法的代码片段

```java
try {
    Object obj = readObject0(false); //最终会返回一个object对象,其实就是序列化对象
    return obj;
} finally {
    passHandle = outerHandle;
    if (closed && depth == 0) {
        clear();
    }
}
```

ObjectInputStream中readObject0方法的代码片段

```java
private Object readObject0(boolean unshared) throws IOException {

 case TC_OBJECT: //匹配如果是对象
        return checkResolve(readOrdinaryObject(unshared));
}
```

readOrdinaryObject方法的代码片段

```java
private Object readOrdinaryObject(boolean unshared)
        throws IOException
    {
        //此处省略部分代码

        Object obj;
        try {
            //通过反射创建的这个obj对象，就是本方法要返回的对象，也可以暂时理解为是ObjectInputStream的readObject返回的对象。
            //isInstantiable：如果一个serializable的类可以在运行时被实例化，那么该方法就返回true
            //desc.newInstance：该方法通过反射的方式调用无参构造方法新建一个对象。
            obj = desc.isInstantiable() ? desc.newInstance() : null;
        } catch (Exception ex) {
            throw (IOException) new InvalidClassException(
                desc.forClass().getName(),
                "unable to create instance").initCause(ex);
        }

        return obj;
    }
```

到目前为止，也就可以解释，为什么序列化可以破坏单例了:?

答: 序列化会通过反射调用无参数的构造方法创建一个新的对象。

我们是如何解决的呢?

答: 只要在Singleton类中定义readResolve就可以解决该问题

```java
//只要在Singleton类中定义readResolve就可以解决该问题
private Object readResolve() {
	return singleton;
}
```

实现原理

```java
if (obj != null &&
            handles.lookupException(passHandle) == null &&
            desc.hasReadResolveMethod())
        {
            Object rep = desc.invokeReadResolve(obj);
            if (unshared && rep.getClass().isArray()) {
                rep = cloneArray(rep);
            }
            if (rep != obj) {
                handles.setObject(passHandle, obj = rep);
            }
        }

```

`hasReadResolveMethod`:如果实现了serializable 接口的类中包含readResolve则返回true

`invokeReadResolve`:通过反射的方式调用要被反序列化的类的readResolve方法。

**总结: Singleton中定义readResolve方法，并在该方法中指定要返回的对象的生成策略，就可以防止单例被破坏。**



#### 4.1.9  饿汉式-枚举(推荐)

枚举单例方式是`<<Effective Java>>`作者推荐的使用方式,这种方式

> 在使用枚举时，构造方法会被自动调用，利用这一特性也可以实现单例；默认枚举实例的创建是线程安全的，即使反序列化也不会生成新的实例，任何情况下都是一个单例(暴力反射对枚举方式无效)。

特点: 满足单例模式所需的 **创建单例、线程安全、实现简洁的需求** 

缺点：同饿汉式单例。

```java
public enum SingletonEnum{

    INSTANCE;

    //这里可以定义一些其他字段
    private Object f1;
    private Object f2;

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public static SingletonEnum getInstance(){

        return INSTANCE;
    }
}
```



**问题1: 为什么枚举类可以阻止反射的破坏?**

1. 首先枚举类中是没有空参构造方法的,只有一个带两个参数的构造方法.

2. 真正原因是: 反射方法中不予许使用反射创建枚举对象

   > 异常: 不能使用反射方式创建enum对象


**问题2: 为什么枚举类可以阻止序列化的破坏?**

Java规范字规定，每个枚举类型及其定义的枚举变量在JVM中都是唯一的，因此在枚举类型的序列化和反序列化上，Java做了特殊的规定。

在序列化的时候Java仅仅是将枚举对象的name属性输到结果中，反序列化的时候则是通过java.lang.Enum的valueOf()方法来根据名字查找枚举对象。

比如说，序列化的时候只将`INSTANCE`这个名称输出，反序列化的时候再通过这个名称，查找对应的枚举类型，因此反序列化后的实例也会和之前被序列化的对象实例相同。



##### 枚举局部单例

这种场景并不是正真的单例模式，只有通过枚举实例化的时候才是单例。不通过枚举也可以自行实例化。

主要应用场景：某些对象的初始化时间较长。客户端可通过公共方法统一实例化（单例），但也允许自行实例化。

下面的案例是登录会话创建接口。每次创建会话开销较大，需要读取配置信息并连接到远程服务器上登录。

可通过这个公共类获得管理员会话。

```java
public enum ISessionUtil {
    session;
    private IAgileSession adminSession;

    ISessionUtil(){
        adminSession = new IAgileSession();
    }

    /**
     * 枚举内部单例，在枚举内部的这个管理员会话只会初始化一次。
     */
    public IAgileSession getAdmin(){
        return adminSession;
    }

    public static void main(String[] args) {
        IAgileSession s1 = ISessionUtil.session.getAdmin();
        IAgileSession s2 = ISessionUtil.session.getAdmin();
        System.out.println(s1 == s2);
    }
}
```





#### 4.1.10 容器型单例

**适用场景**

适用于需要大量创建单例对象的场景，不考虑线程安全问题。

**介绍**

可以是饿汉也可以是懒汉，饿汉就是类似Spring容易在启动时统一初始化好。懒汉就是等到方法调用 时，在判断实例是否存在，如果不存在则实例化。

**参考代码**

```java
/**
 * 容器单例
 */
public class ContainerSingleton {

    private ContainerSingleton() {
    }

    private static Map<String, Object> ioc = new ConcurrentHashMap<String, Object>();

    public static Object getInstance(String className) {
        Object instance = null;
        if (!ioc.containsKey(className)) {
            try {
                instance = Class.forName(className).newInstance();
                ioc.put(className, instance);
            } catch (Exception e) {
                e.printStackTrace();
            }
            return instance;
        } else {
            return ioc.get(className);
        }
    }
}
```

**案例**

Spring的applicationContext就是一个大型的容器型单例。他还可以通过配置决定是否单例。



#### 4.1.11 本地线程单例

严格意义上不算单例模式，不能保证全局唯一，但是可以线程唯一

```java
/**
 * 线程单例
 */
public class ThreadLocalSingleton {
    private static final ThreadLocal<ThreadLocalSingleton> threadLocaLInstance =
            new ThreadLocal<ThreadLocalSingleton>() {
                @Override
                protected ThreadLocalSingleton initialValue() {
                    return new ThreadLocalSingleton();
                }
            };

    private ThreadLocalSingleton() {
    }

    public static ThreadLocalSingleton getInstance() {
        return threadLocaLInstance.get();
    }
}
```





#### 4.1.11 单例模式总结

**饿汉式**

- 饿汉式的实现方式，在类加载的期间，就已经将 instance 静态实例初始化好了，所以，instance 实例的创建是线程安全的。不过，这样的实现方式不支持延迟加载实例。

**懒汉式**

- 相对于饿汉式的优势是支持延迟加载。这种实现方式会导致频繁加锁、释放锁，以及并发度低等问题，频繁的调用会产生性能瓶颈。

**双重检测**

- 双重检测实现方式既支持延迟加载、又支持高并发的单例实现方式。只要 instance 被创建之后，再调用 getInstance() 函数都不会进入到加锁逻辑中。所以，这种实现方式解决了懒汉式并发度低的问题。

**静态内部类**

- 利用 Java 的静态内部类来实现单例。这种实现方式，既支持延迟加载，也支持高并发，实现起来也比双重检测简单。

**枚举方式**

- 最简单的实现方式，基于枚举类型的单例实现。这种实现方式通过 Java 枚举类型本身的特性，保证了实例创建的线程安全性和实例的唯一性(同时阻止了反射和序列化对单例的破坏)。



### 4.2 工厂模式

工厂模式（Factory Pattern）是 Java 中最常用的设计模式之一。这种类型的设计模式属于创建型模式，它提供了一种创建对象的最佳方式。

- **在工厂模式中，我们在创建对象时不会对客户端暴露创建逻辑，并且是通过使用一个共同的接口来指向新创建的对象。**

《设计模式》一书中，工厂模式被分为了三种：简单工厂、工厂方法和抽象工厂。（不过，在书中作者将简单工厂模式看作是工厂方法模式的一种特例。）

接下来我会介绍三种工厂模式的原理及使用

* 简单工厂模式（不属于GOF的23种经典设计模式）
* 工厂方法模式
* 抽象工厂模式

#### 4.2.1 简单工厂模式

##### 4.2.3.1 简单工厂模式介绍

简单工厂不是一种设计模式，反而比较像是一种编程习惯。简单工厂模式又叫做静态工厂方法模式（static Factory Method pattern）,它是通过使用静态方法接收不同的参数来返回不同的实例对象.

**实现方式:**  

​		定义一个工厂类，根据传入的参数不同返回不同的实例，被创建的实例具有共同的父类或接口。

**适用场景：**
　　（1）需要创建的对象较少。
　　（2）客户端不关心对象的创建过程。

##### 4.2.3.2 简单工厂原理

简单工厂包含如下角色：

* 抽象产品 ：定义了产品的规范，描述了产品的主要特性和功能。
* 具体产品 ：实现或者继承抽象产品的子类
* 具体工厂 ：提供了创建产品的方法，调用者通过该方法来获取产品。    

##### 4.2.3.3 简单工厂模式参考代码

**1) 抽象产品** 

```java
public interface IProduct {
    void functionA();
}
```

**2) 具体产品** 

```java
public class ProductA implements IProduct {
    @Override
    public void functionA() {
        System.out.println("productA!");
    }
}

public class ProductB implements IProduct {
    @Override
    public void functionA() {
        System.out.println("productB!");
    }
}
```

**3）具体工厂**

```java
public class ProductFactory {
    public static IProduct getProduct(String prodType) {
        if ("A".equals(prodType)) {
            return new ProductA();
        } else {
            return new ProductB();
        }
    }
}
```

**4) 客户端** 

```java
    public static void main(String[] args) {
        IProduct a = ProductFactory.getProduct("A");
        a.functionA();

        IProduct b = ProductFactory.getProduct("B");
        b.functionA();
    }
```

##### 4.2.3.4 简单工厂模式总结

**优点：**

封装了创建对象的过程，可以通过参数直接获取对象。把对象的创建和业务逻辑层分开，这样以后就避免了修改客户代码，如果要实现新产品直接修改工厂类，而不需要在原代码中修改，这样就降低了客户代码修改的可能性，更加容易扩展。

**缺点：**

增加新产品时还是需要修改工厂类的代码，违背了“开闭原则”。



#### 4.2.4 工厂方法模式

##### 4.2.4.1 工厂方法模式介绍

工厂方法模式 `Factory Method pattern`,属于创建型模式. 

概念: 定义一个用于创建对象的接口，让子类决定实例化哪个产品类对象。工厂方法使一个产品类的实例化延迟到其工厂的子类。

##### 4.2.4.2 工厂方法模式原理

工厂方法模式的目的很简单，就是**封装对象创建的过程，提升创建对象方法的可复用性**。

工厂方法模式的主要角色：

* 抽象工厂：提供了创建产品的接口，调用者通过它访问具体工厂的工厂方法来创建产品。
* 具体工厂：主要是实现抽象工厂中的抽象方法，完成具体产品的创建。
* 抽象产品：定义了产品的规范，描述了产品的主要特性和功能。
* 具体产品：实现了抽象产品角色所定义的接口，由具体工厂来创建，它同具体工厂之间一一对应。

我们直接来看看工厂方法模式的 UML 图：

<img src="马士兵-学习笔记-沈俊杰.assets/44.jpg" alt="image-20220530160637842" style="zoom: 100%;" /> 

#####  4.2.4.3 工厂方法模式重构代码

为了提高代码扩展性,我们需要将简单工厂中的if分支逻辑去掉,通过增加抽象工厂(**生产工厂的工厂**)的方式,让具体工厂去进行实现,由具体工厂来决定实例化哪一个具体的产品对象.

**抽象工厂**

```java
public interface IProductFactory {
    IProduct getProduct();
}
```

**具体工厂**

```java
public class ProductFactoryA implements IProductFactory {
    public IProduct getProduct() {
        return new ProductA();
    }
}

public class ProductFactoryB implements IProductFactory {
    public IProduct getProduct() {
        return new ProductB();
    }
}
```

**客户端**

```java
public class Client {
    public static void main(String[] args) {
        IProductFactory af = new ProductFactoryA();
        IProduct a = af.getProduct();
        a.functionA();

        IProductFactory bf = new ProductFactoryA();
        IProduct b = bf.getProduct();
        b.functionA();
    }
}
```

现在我们的代码已经基本上符合了开闭原则,当有新增的产品时,我们需要做的事情包括:

1. 创建新的产品类,并且让该产品实现抽象产品接口
2. 创建产品类对应的具体工厂,并让具体工厂实现抽象工厂.

##### 4.2.4.4 工厂方法模式总结

**工厂方法模优缺点**

**优点：**

- **不关心创建细节 :** 用户 只需要 关心 所需产品 对应的工厂 , 无需关心创建细节 ;
- **符合开闭原则 :** 加入 新产品 , 符合开闭原则 , 提高可扩展性 ;
- 工厂方法模式 中 , 使用 工厂类创建 产品对象 , 同时 隐藏了 具体的 产品类 被 实例化 的细节 ;

**缺点：**

* **增加复杂性** : 类的个数容易过多 , 增加系统复杂度 ;
  在 添加新产品 时 , 除了编写 新的产品类 之外 , 还要 编写该产品类对应的 工厂类 ;
* **增加难度** : 增加了系统 抽象性 和 理解难度 ;
  工厂方法本身 利用了抽象 , 该模式中会 引入抽象层 , 如果要动态创建产品类 , 还要 引入反射技术 ;

**工厂方法模式适用场景**

- **重复代码 :** 创建对象 需要使用 大量重复的代码 ;
- **不关心创建过程 :** 客户端 不依赖 产品类 , 不关心 实例 如何被创建 , 实现等细节 ;
- **创建对象 :** 一个类 通过其 子类 来 指定 创建哪个对象 ;



### 4.3 抽象工厂模式

#### 4.3.1 抽象工厂模式介绍

> 抽象工厂模式比工厂方法模式的抽象程度更高. 在工厂方法模式中每一个具体工厂只需要生产一种具体产品,但是在抽象工厂模式中一个具体工厂可以生产一组相关的具体产品,这样一组产品被称为产品族.产品族中的每一个产品都分属于某一个产品继承等级结构. 



**1) 产品等级结构与产品族** 

为了更好的理解抽象工厂, 我们这里先引入两个概念:

- **产品等级结构** ：产品等级结构即产品的继承结构，如一个抽象类是电视机，其子类有海尔电视机、海信电视机、TCL电视机，则抽象电视机与具体品牌的电视机之间构成了一个产品等级结构，抽象电视机是父类，而具体品牌的电视机是其子类。

- **产品族** ：在抽象工厂模式中，产品族是指由同一个工厂生产的，位于不同产品等级结构中的一组产品，如海尔电器工厂生产的海尔电视机、海尔电冰箱，海尔电视机位于电视机产品等级结构中，海尔电冰箱位于电冰箱产品等级结构中。

<img src="马士兵-学习笔记-沈俊杰.assets/46.jpg" alt="image-20220530160637842" style="zoom: 100%;" /> 

> 在上图中,每一个具体工厂可以生产属于一个产品族的所有产品,例如海尔工厂生产海尔电视机、海尔空调和海尔冰箱,所生产的产品又位于不同的产品等级结构中. 如果使用工厂方法模式,上图所示的结构需要提供9个具体工厂,而使用抽象工厂模式只需要提供3个具体工厂,极大减少了系统中类的个数.

**2) 抽象工厂模式概述**

抽象工厂模式(Abstract Factory Pattern)  原始定义：**提供一个创建一系列相关或相互依赖对象的接口，而无须指定它们具体的类。**

抽象工厂模式为创建一组对象提供了解决方案.与工厂方法模式相比,**抽象工厂模式中的具体工厂不只是创建一种产品,而是负责创建一个产品族**.如下图:

<img src="马士兵-学习笔记-沈俊杰.assets/47.jpg" alt="image-20220530160637842" style="zoom: 100%;" /> 

4.3.2 抽象工厂模式原理

在抽象工厂模式中,每一个具体工厂都提供了多个工厂方法,用于产生多种不同类型的产品.这些产品构成了一个产品族.

<img src="马士兵-学习笔记-沈俊杰.assets/49.jpg" alt="image-20220530160637842" style="zoom: 100%;" />  

抽象工厂模式的主要角色如下：

* 抽象工厂（Abstract Factory）：它声明了一种用于创建一族产品的方法,每一个方法对应一种产品.
* 具体工厂（Concrete Factory）：主要是实现抽象工厂中的多个抽象方法，完成具体产品的创建.
* 抽象产品（Product）：定义了产品的规范，描述了产品的主要特性和功能，抽象工厂模式有多个抽象产品。
* 具体产品（ConcreteProduct）：实现了抽象产品角色所定义的接口，由具体工厂来创建，它 同具体工厂之间是多对一的关系。

#### 4.3.3 抽象工厂模式实现

抽象工厂

```java
/**
 * 抽象工厂: 家电工厂，在一个抽象工厂中可以声明多个工厂方法,用于创建不同类型的产品
 * @author spikeCong
 * @date 2022/9/15
 **/
public interface AppliancesFactory {

    AbstractTV createTV();

    AbstractFreezer createFreezer();
}
```

具体工厂: 每一个具体工厂方法,可以返回一个特定的产品对象,而同一个具体工厂所创建的产品对象构成了一个产品族.

```java
public class HairFactory implements AppliancesFactory {

    @Override
    public AbstractTV createTV() {
        return new HairTV();
    }

    @Override
    public AbstractFreezer createFreezer() {
        return new HairFreezer();
    }
}

public class HisenseFactory implements AppliancesFactory {

    @Override
    public AbstractTV createTV() {
        return new HisenseTV();
    }

    @Override
    public AbstractFreezer createFreezer() {
        return new HisenseFreezer();
    }
}
```

抽象产品

```java
public interface AbstractFreezer {}
public interface AbstractTV {}
```

具体产品

```java
public class HairFreezer implements AbstractFreezer {}
public class HisenseFreezer implements AbstractFreezer {}
public class HairTV implements AbstractTV {}
public class HisenseTV implements AbstractTV {}
```

客户端

```java
public class Client {

    private AbstractTV tv;

    private AbstractFreezer freezer;

    public Client(AppliancesFactory factory){

        //在客户端看来就是使用抽象工厂来生产家电
        this.tv = factory.createTV();
        this.freezer = factory.createFreezer();
    }

    public AbstractTV getTv() {
        return tv;
    }

    public void setTv(AbstractTV tv) {
        this.tv = tv;
    }

    public AbstractFreezer getFreezer() {
        return freezer;
    }

    public void setFreezer(AbstractFreezer freezer) {
        this.freezer = freezer;
    }

    public static void main(String[] args) {

        Client client = new Client(new HisenseFactory());
        AbstractTV tv = client.getTv();
        System.out.println(tv);

        AbstractFreezer freezer = client.getFreezer();
        System.out.println(freezer);
    }
}
```



#### 4.3.4 抽象工厂模式总结

从上面代码实现中我们可以看出，抽象工厂模式向使用（客户）方隐藏了下列变化：

- 程序所支持的实例集合（具体工厂）的数目；
- 当前是使用的实例集合中的哪一个实例；
- 在任意给定时刻被实例化的具体类型；

所以说，在理解抽象工厂模式原理时，你一定要牢牢记住“如何找到某一个类产品的正确共性功能”这个重点。

**抽象工厂模式优点**

1) 对于不同产品系列有比较多共性特征时，可以使用抽象工厂模式，有助于提升组件的复用性.

2) 当需要提升代码的扩展性并降低维护成本时，把对象的创建和使用过程分开，能有效地将代码统一到一个级别上


3. 解决跨平台带来的兼容性问题


**抽象工厂模式缺点**

   增加新的产品等级结构麻烦,需要对原有结构进行较大的修改,甚至需要修改抽象层代码,这显然会带来较大不变,违背了开闭原则.



抽象工厂实际案例

JDK案例：ComponentFactory

DocumentBuilderFactory：这个类，是JDK里面提供的，用于创建DOM模式的XML解析器的，用于对XML文件内容进行解析。

https://www.bilibili.com/read/cv18266097/ 



### 4.4 建造者模式

#### 4.4.1 建造者模式介绍

**建造者模式** (builder pattern), 也被称为**生成器模式** , 他的定义是：将一个复杂对象的构建与表示分离，使得同样的构建过程可以创建不同的表示。

**建造者模式要解决的问题 **

建造者模式可以将部件和其组装过程分开，一步一步创建一个复杂的对象。用户只需要指定复杂对象的类型就可以得到该对象，而无须知道其内部的具体构造细节。

> 比如: 一辆汽车是由多个部件组成的,包括了车轮、方向盘、发动机等等.对于大多数用户而言,并不需要知道这些部件的装配细节,并且几乎不会使用单独某个部件,而是使用一辆完整的汽车.而建造者模式就是负责将这些部件进行组装让后将完整的汽车返回给用户.

>  我的理解：计算机都是由cpu，内存，主板，硬盘等固定部分组成的。但每台计算机在创建时，cpu，内存的具体型号参数又是可以动态选择的。 

#### 4.4.2 建造者模式原理

建造者（Builder）模式包含以下4个角色 :

* 抽象建造者类（Builder）：这个接口规定要实现复杂对象的哪些部分的创建，并不涉及具体的部件对象的创建。 

* **具体建造者类**（ConcreteBuilder）：实现 Builder 接口，完成复杂产品的各个部件的具体创建方法。在构造过程完成后，提供一个方法,返回创建好的负责产品对象。 

* 产品类（Product）：要创建的复杂对象 (包含多个组成部件).

* 指挥者类（Director）：调用具体建造者来创建复杂对象的各个部分，在指导者中不涉及具体产品的信息，只负责保证对象各部分完整创建或按某种顺序创建(客户端一般只需要与指挥者进行交互)。 

<img src="马士兵-学习笔记-沈俊杰.assets/52.jpg" alt="image-20220530160637842" style="zoom: 50%;" />  

#### 4.4.3 建造者模式实现方式1

**创建共享单车**

生产自行车是一个复杂的过程，它包含了车架，车座等组件的生产。而车架又有碳纤维，铝合金等材质的，车座有橡胶，真皮等材质。对于自行车的生产就可以使用建造者模式。

这里Bike是产品，包含车架，车座等组件；Builder是抽象建造者，MobikeBuilder和HelloBuilder是具体的建造者；Director是指挥者。类图如下：

<img src="马士兵-学习笔记-沈俊杰.assets/53.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

具体产品

```java
public class Bike {

    //车架
    private String frame;

    //座椅
    private String seat;

    public String getFrame() {
        return frame;
    }

    public void setFrame(String frame) {
        this.frame = frame;
    }

    public String getSeat() {
        return seat;
    }

    public void setSeat(String seat) {
        this.seat = seat;
    }
}
```

构建者类

```java
public abstract class Builder {

    protected Bike mBike = new Bike();

    public abstract void buildFrame();
    public abstract void buildSeat();
    public abstract Bike createBike();
}

public class HelloBuilder extends Builder {
    @Override
    public void buildFrame() {
        mBike.setFrame("碳纤维车架");
    }

    @Override
    public void buildSeat() {
        mBike.setSeat("橡胶车座");
    }

    @Override
    public Bike createBike() {
        return mBike;
    }
}

public class MobikeBuilder extends Builder {

    @Override
    public void buildFrame() {
        mBike.setFrame("铝合金车架");
    }

    @Override
    public void buildSeat() {
        mBike.setSeat("真皮车座");
    }

    @Override
    public Bike createBike() {
        return mBike;
    }
}
```

指挥者类

```java
public class Director {

    private Builder mBuilder;

    public Director(Builder builder) {
        this.mBuilder = builder;
    }

    public Bike construct() {
        mBuilder.buildFrame();
        mBuilder.buildSeat();
        return mBuilder.createBike();
    }
}
```

客户端

```java
public class Client {

    public static void main(String[] args) {
        showBike(new HelloBuilder());
        showBike(new MobikeBuilder());
    }

    private static void showBike(Builder builder) {
        Director director = new Director(builder);
        Bike bike = director.construct();
        System.out.println(bike.getFrame());
        System.out.println(bike.getSeat());
    }
}
```

#### 4.4.4 建造者模式实现方式2

建造者模式除了上面的用途外，在开发中还有一个常用的使用方式，就是当一个类构造器需要传入很多参数时，如果创建这个类的实例，代码可读性会非常差，而且很容易引入错误，此时就可以利用建造者模式进行重构。

**1 ) 构造方法创建复杂对象的问题**

- 构造方法如果参数过多,代码的可读性和易用性都会变差. 在使用构造函数时,很容易搞错参数的顺序,传递进去错误的参数值,导致很有隐蔽的BUG出现.

```java
package com.mashibing.example02;

/**
 * MQ连接客户端
 * @author spikeCong
 * @date 2022/9/19
 **/
public class RabbitMQClient1 {

    private String host = "127.0.0.1";

    private int port = 5672;

    private int mode;

    private String exchange;

    private String queue;

    private boolean isDurable = true;

    int connectionTimeout = 1000;

    
    //构造方法参数过多,代码的可读性和易用性太差,在使用构造函数时,很容易搞错顺序,传递错误的参数值,导致很有隐蔽的BUG
    public RabbitMQClient1(String host, int port, int mode, String exchange, String queue, boolean isDurable, int connectionTimeout) {
        this.host = host;
        this.port = port;
        this.mode = mode;
        this.exchange = exchange;
        this.queue = queue;
        this.isDurable = isDurable;
        this.connectionTimeout = connectionTimeout;

        if(mode == 1){ //工作队列模式不需要设计交换机,但是队列名称一定要有
            if(exchange != null){
                throw new RuntimeException("工作队列模式无需设计交换机");
            }
            if(queue == null || queue.trim().equals("")){
                throw new RuntimeException("工作队列模式名称不能为空");
            }
            if(isDurable == false){
                throw new RuntimeException("工作队列模式必须开启持久化");
            }
        }else if(mode == 2){ //路由模式必须设计交换机,但是不能设计队列
            if(exchange == null){
                throw new RuntimeException("路由模式下必须设置交换机");
            }
            if(queue != null){
                throw new RuntimeException("路由模式无须设计队列名称");
            }
        }

        //其他验证方式,
    }

    public void sendMessage(String msg){

        System.out.println("发送消息......");
    }

    public static void main(String[] args) {
        //每一种模式,都需要根据不同的情况进行实例化,构造方法会变得过于复杂.
        RabbitMQClient1 client1 = new RabbitMQClient1("192.168.52.123",5672,
                2,"sample-exchange",null,true,5000);

        client1.sendMessage("Test-MSG");
    }
}
```

**2) set方法创建复杂对象的问题** 

- set方式设置对象属性时,存在中间状态,并且属性校验时有前后顺序约束,逻辑校验的代码找不到合适的地方放置.

  > 比如下面的代码,  创建对象后使用set 的方式，那就会导致在第一个 set 之后，对象处于无效状态
  >
  > Rectangle r = new Rectangle ();  //无效状态
  >
  > r.setWidth(2);  //无效状态
  >
  > r.setHeight(3);  //有效状态

- set方法还破坏了"不可变对象"的密闭性 .

  > 不可变对象:  对象创建好了,就不能再修改内部的属性值,下面的client类就是典型的不可变对象,创建好的连接对象不能再改动

```java
package com.mashibing.example02;

/**
 * MQ连接客户端
 * @author spikeCong
 * @date 2022/9/19
 **/
public class RabbitMQClient2 {

    private String host = "127.0.0.1";

    private int port = 5672;

    private int mode;

    private String exchange;

    private String queue;

    private boolean isDurable = true;

    int connectionTimeout = 1000;

    //私有化构造方法
    private RabbitMQClient2() {

    }

    public String getExchange() {
        return exchange;
    }

    public void setExchange(String exchange) {

        if(mode == 1){ //工作队列模式不需要设计交换机,但是队列名称一定要有
            if(exchange != null){
                throw new RuntimeException("工作队列模式无需设计交换机");
            }
            if(queue == null || queue.trim().equals("")){
                throw new RuntimeException("工作队列模式名称不能为空");
            }
            if(isDurable == false){
                throw new RuntimeException("工作队列模式必须开启持久化");
            }
        }else if(mode == 2){ //路由模式必须设计交换机,但是不能设计队列
            if(exchange == null){
                throw new RuntimeException("路由模式下必须设置交换机");
            }
            if(queue != null){
                throw new RuntimeException("路由模式无须设计队列名称");
            }
        }

        //其他验证方式,

        this.exchange = exchange;
    }

    public String getHost() {
        return host;
    }

    public void setHost(String host) {
        this.host = host;
    }

    public int getPort() {
        return port;
    }

    public void setPort(int port) {
        this.port = port;
    }

    public int getMode() {
        return mode;
    }

    public void setMode(int mode) {

        if(mode == 1){ //工作队列模式不需要设计交换机,但是队列名称一定要有
            if(exchange != null){
                throw new RuntimeException("工作队列模式无需设计交换机");
            }
            if(queue == null || queue.trim().equals("")){
                throw new RuntimeException("工作队列模式名称不能为空");
            }
            if(isDurable == false){
                throw new RuntimeException("工作队列模式必须开启持久化");
            }
        }else if(mode == 2){ //路由模式必须设计交换机,但是不能设计队列
            if(exchange == null){
                throw new RuntimeException("路由模式下必须设置交换机");
            }
            if(queue != null){
                throw new RuntimeException("路由模式无须设计队列名称");
            }
        }

        this.mode = mode;
    }

    public String getQueue() {
        return queue;
    }

    public void setQueue(String queue) {
        this.queue = queue;
    }

    public boolean isDurable() {
        return isDurable;
    }

    public void setDurable(boolean durable) {
        isDurable = durable;
    }

    public int getConnectionTimeout() {
        return connectionTimeout;
    }

    public void setConnectionTimeout(int connectionTimeout) {
        this.connectionTimeout = connectionTimeout;
    }

    public void sendMessage(String msg){

        System.out.println("发送消息......");
    }

    /**
     * set方法的好处是参数的设计更加的灵活,但是通过set方式设置对象属性时,对象有可能存在中间状态(无效状态),
     * 并且进行属性校验时有前后顺序约束.
     * 怎么保证灵活设置参数又不会存在中间状态呢? 答案就是: 使用建造者模式
     */
    public static void main(String[] args) {

        RabbitMQClient2 client2 = new RabbitMQClient2();
        client2.setHost("192.168.52.123");
        client2.setQueue("queue");
        client2.setMode(1);
        client2.setDurable(true);
        client2.sendMessage("Test-MSG2");
    }
}
```



**3) 建造者方式实现**

建造者使用步骤如下:

1. 目标类的构造方法要传入Builder对象
2. Builder建造者类位于目标类内部,并且使用static修饰
3. Builder建造者对象提供内置的各种set方法,注意set方法返回的是builder对象本身
4. Builder建造者类提供build()方法实现目标对象的创建

```java
public class 目标类{
	
    //目标类的构造方法需要传入Builder对象
    public 目标类(Builder builder){
        
    }

    public 返回值 业务方法(参数列表){
        
    }
    
    //Builder建造者类位于目标类内部,并且使用static修饰
    public static class Builder(){
        //Builder建造者对象提供内置的各种set方法,注意set方法返回的是builder对象本身
        private String xxx;
        public Builder setXxx(String xxx){
            this.xxx = xxx;
            return this;
        }
        
        //Builder建造者类提供build()方法实现目标对象的创建
        public 目标类 build(){
            //校验
            return new 目标类(this);
        }
    }
}
```

**重写案例代码**

```java
/**
 * 建造者模式
 * @author spikeCong
 * @date 2022/9/19
 **/
public class RabbitMQClient {

    //私有构造方法
    private RabbitMQClient(Builder builder) {

    }

    public static class Builder{
        //属性密闭性,保证对象不可变
        private String host = "127.0.0.1";
        private int port = 5672;
        private int mode;
        private String exchange;
        private String queue;
        private boolean isDurable = true;
        int connectionTimeout = 1000;

        public Builder setHost(String host) {
            this.host = host;
            return this;
        }

        public Builder setPort(int port) {
            this.port = port;
            return this;
        }

        public Builder setMode(int mode) {
            this.mode = mode;
            return this;
        }

        public Builder setExchange(String exchange) {
            this.exchange = exchange;
            return this;
        }

        public Builder setQueue(String queue) {
            this.queue = queue;
            return this;
        }

        public Builder setDurable(boolean durable) {
            isDurable = durable;
            return this;
        }

        public Builder setConnectionTimeout(int connectionTimeout) {
            this.connectionTimeout = connectionTimeout;
            return this;
        }


        //返回构建好的复杂对象
        public RabbitMQClient build(){
            //首先进行校验
            if(mode == 1){ //工作队列模式不需要设计交换机,但是队列名称一定要有
                if(exchange != null){
                    throw new RuntimeException("工作队列模式无需设计交换机");
                }
                if(queue == null || queue.trim().equals("")){
                    throw new RuntimeException("工作队列模式名称不能为空");
                }
                if(isDurable == false){
                    throw new RuntimeException("工作队列模式必须开启持久化");
                }
            }else if(mode == 2){ //路由模式必须设计交换机,但是不能设计队列
                if(exchange == null){
                    throw new RuntimeException("路由模式下必须设置交换机");
                }
                if(queue != null){
                    throw new RuntimeException("路由模式无须设计队列名称");
                }
            }

            return new RabbitMQClient(this);
        }
    }

    public void sendMessage(String msg){
        System.out.println("发送消息......");
    }
}
```

测试

```java
public class MainAPP {

    public static void main(String[] args) {

        //使用链式编程设置参数
        RabbitMQClient client = new RabbitMQClient.Builder().setHost("192.168.52.123").setMode(2).setExchange("text-exchange")
                .setPort(5672).setDurable(true).build();

        client.sendMessage("Test");
    }
}
```

#### 4.4.5 建造者模式总结

**1) 建造者模式与工厂模式区别** 

- 工厂模式是用来创建不同但是相关类型的对象（继承同一父类或者接口的一组子类），由给定的参数来决定创建哪种类型的对象。
- 建造者模式是用来创建一种类型的复杂对象，通过设置不同的动态参数，“定制化”地创建不同的对象。

> 举例: 顾客走进一家餐馆点餐，我们利用工厂模式，根据用户不同的选择，来制作不同的食物，比
> 如披萨、汉堡、沙拉。对于披萨来说，用户又有各种配料可以定制，比如奶酪、西红柿、起
> 司，我们通过建造者模式根据用户选择的不同配料来制作披萨。



**2) 建造者模式的优缺点**

- 优点

  - 建造者模式的封装性很好。使用建造者模式可以有效的封装变化，在使用建造者模式的场景中，一般产品类和建造者类是比较稳定的，因此，将主要的业务逻辑封装在指挥者类中对整体而言可以取得比较好的稳定性。
  - 在建造者模式中，客户端不必知道产品内部组成的细节，将产品本身与产品的创建过程解耦，使得相同的创建过程可以创建不同的产品对象。
  - 可以更加精细地控制产品的创建过程 。将复杂产品的创建步骤分解在不同的方法中，使得创建过程更加清晰，也更方便使用程序来控制创建过程。
  - 建造者模式很容易进行扩展。如果有新的需求，通过实现一个新的建造者类就可以完成，基本上不用修改之前已经测试通过的代码，因此也就不会对原有功能引入风险。符合开闭原则。

- 缺点

  - 建造者模式所创建的产品一般具有较多的共同点，其组成部分相似，如果产品之间的差异性很大，则不适合使用建造者模式，因此其使用范围受到一定的限制。

  

**3) 应用场景**

- 建造者（Builder）模式创建的是复杂对象，其产品的各个部分经常面临着剧烈的变化，但将它们组合在一起的算法却相对稳定，所以它通常在以下场合使用。
  - 创建的对象较复杂，由多个部件构成，各部件面临着复杂的变化，但构件间的建造顺序是稳定的。
  - 创建复杂对象的算法独立于该对象的组成部分以及它们的装配方式，即产品的构建过程和最终的表示是独立的。

#### 4.4.6 建造者模式实际案例

StringBuilder；



### 4.5 原型模式

#### 4.5.1 原型模式介绍

定义: 原型模式(Prototype Design Pattern)用一个已经创建的实例作为原型，通过复制该原型对象来创建一个和原型对象相同的新对象。

> 西游记中的孙悟空 拔毛变小猴,孙悟空这种根据自己的形状复制出多个身外化身的技巧,在面向对象软件设计领域被称为原型模式.孙悟空就是原型对象.

<img src="马士兵-学习笔记-沈俊杰.assets/54.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 



**原型模式主要解决的问题**

- 如果创建对象的成本比较大,比如对象中的数据是经过复杂计算才能得到,或者需要从RPC接口或者数据库等比较慢的IO中获取,这种情况我们就可以使用原型模式,从其他已有的对象中进行拷贝,而不是每次都创建新对象,进行一些耗时的操作.



#### 4.5.2 原型模式原理

原型模式包含如下角色：

* 抽象原型类(Prototype)：它是声明克隆方法的接口,是所有具体原型类的公共父类,它可以是抽象类也可以是接口.
* 具体原型类(ConcretePrototype)：实现在抽象原型类中声明的克隆方法,在克隆方法中返回自己的一个克隆对象.
* 客户类(Client)：在客户类中,让一个原型对象克隆自身从而创建一个新的对象.由于客户类针对抽象原型类Prototype编程.因此用户可以根据需要选择具体原型类,系统具有较好的扩展性,增加或者替换具体原型类都比较方便.

<img src="马士兵-学习笔记-沈俊杰.assets/55.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

#### 4.5.3 深克隆与浅克隆

根据在**复制原型对象的同时是否复制包含在原型对象中引用类型的成员变量** 这个条件,原型模式的克隆机制分为两种,即浅克隆(Shallow Clone)和深克隆(Deep Clone)

**1) 什么是浅克隆**

被复制对象的所有变量都含有与原来的对象相同的值，而所有的对其他对象的引用仍然指向原来的对象(克隆对象与原型对象共享引用数据类型变量)。

​								<img src="马士兵-学习笔记-沈俊杰.assets/56.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

**2) 什么是深克隆**

除去那些引用其他对象的变量，被复制对象的所有变量都含有与原来的对象相同的值。那些引用其他对象的变量将指向被复制过的新对象，而不再是原有的那些被引用的对象。换言之，深复制把要复制的对象所引用的对象都复制了一遍。

​								<img src="马士兵-学习笔记-沈俊杰.assets/57.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 



Java中的Object类中提供了 `clone()` 方法来实现**浅克隆**。需要注意的是要想实现克隆的Java类必须实现一个标识接口 Cloneable ,来表示这个Java类支持被复制.

Cloneable接口是上面的类图中的抽象原型类，而实现了Cloneable接口的子实现类就是具体的原型类。代码如下：

**3) 浅克隆代码实现：**  

```java
public class ConcretePrototype implements Cloneable {

    public ConcretePrototype() {
        System.out.println("具体的原型对象创建完成!");
    }

    @Override
    protected ConcretePrototype clone() throws CloneNotSupportedException {
        System.out.println("具体的原型对象复制成功!");
        return (ConcretePrototype)super.clone();
    }
}
```

测试

```java
    @Test
    public void test01() throws CloneNotSupportedException {
        ConcretePrototype c1 = new ConcretePrototype();
        ConcretePrototype c2 = c1.clone();

        System.out.println("对象c1和c2是同一个对象？" + (c1 == c2));
    }
```

**4) 深克隆代码实现**  

在ConcretePrototype类中添加一个对象属性为Person类型

```java
public class ConcretePrototype implements Cloneable {

    private Person person;

    public Person getPerson() {
        return person;
    }

    public void setPerson(Person person) {
        this.person = person;
    }

    void show(){
        System.out.println("嫌疑人姓名: " +person.getName());
    }

    public ConcretePrototype() {
        System.out.println("具体的原型对象创建完成!");
    }

    @Override
    protected ConcretePrototype clone() throws CloneNotSupportedException {
        System.out.println("具体的原型对象复制成功!");
        return (ConcretePrototype)super.clone();
    }

}

public class Person {

    private String name;

    public Person() {
    }

    public Person(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
```

测试

```java
    @Test
    public void test02() throws CloneNotSupportedException {
        ConcretePrototype c1 = new ConcretePrototype();
        Person p1 = new Person();
        c1.setPerson(p1);

        //复制c1
        ConcretePrototype c2 = c1.clone();
        //获取复制对象c2中的Person对象
        Person p2 = c2.getPerson();
        p2.setName("峰哥");

        //判断p1与p2是否是同一对象
        System.out.println("p1和p2是同一个对象？" + (p1 == p2));

        c1.show();
        c2.show();
    }
```

打印结果

<img src="马士兵-学习笔记-沈俊杰.assets/61.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

**说明: p1与p2是同一对象,这是浅克隆的效果,也就是对具体原型类中的引用数据类型的属性进行引用的复制.**

如果有需求场景中不允许共享同一对象,那么就需要使用**深拷贝**,如果想要进行深拷贝需要使用到对象序列化流 (对象序列化之后,再进行反序列化获取到的是不同对象).  代码如下:

```java
    @Test
    public void test03() throws Exception {

        ConcretePrototype c1 = new ConcretePrototype();
        Person p1 = new Person("峰哥");
        c1.setPerson(p1);

        //创建对象序列化输出流
        ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream("c.txt"));

        //将c1对象写到文件中
        oos.writeObject(c1);
        oos.close();

        //创建对象序列化输入流
        ObjectInputStream ois = new ObjectInputStream(new FileInputStream("c.txt"));

        //读取对象
        ConcretePrototype c2 = (ConcretePrototype) ois.readObject();
        Person p2 = c2.getPerson();
        p2.setName("凡哥");

        //判断p1与p2是否是同一个对象
        System.out.println("p1和p2是同一个对象?" + (p1 == p2));

        c1.show();
        c2.show();
    }
```

打印结果:

<img src="马士兵-学习笔记-沈俊杰.assets/63.jpg" alt="image-20220530160637842" style="zoom: 50%;" />  

> 注意：ConcretePrototype类和Person类必须实现Serializable接口，否则会抛NotSerializableException异常。



其实现在不推荐大家用Cloneable接口，实现比较麻烦，现在借助Apache Commons或者springframework可以直接实现：

- 浅克隆：`BeanUtils.cloneBean(Object obj);BeanUtils.copyProperties(S,T);`
- 深克隆：`SerializationUtils.clone(T object);` 

BeanUtils是利用反射原理获得所有类可见的属性和方法，然后复制到target类。
SerializationUtils.clone()就是使用我们的前面讲的序列化实现深克隆，当然你要把要克隆的类实现Serialization接口。

国产工具包Hutool，深克隆方法推荐：ObjectUtil.cloneByStream(p); SerializeUtil.clone(obj);



#### 4.5.4 原型模式应用实例

模拟某银行电子账单系统的广告信发送功能,广告信的发送都是有一个模板的,从数据库查出客户的信息,然后放到模板中生成一份完整的邮件,然后交给发送机进行发送处理.

 

**发送广告信邮件UML类图** 

<img src="马士兵-学习笔记-沈俊杰.assets/59.jpg" alt="image-20220530160637842" style="zoom: 50%;" />  



**代码实现**

- **广告模板代码** 

```java
/**
 * 广告信模板代码
 * @author spikeCong
 * @date 2022/9/20
 **/
public class AdvTemplate {

    //广告信名称
    private String advSubject = "xx银行本月还款达标,可抽iPhone 13等好礼!";

    //广告信内容
    private String advContext = "达标用户请在2022年3月1日到2022年3月30参与抽奖......";

    public String getAdvSubject() {
        return this.advSubject;
    }

    public String getAdvContext() {
        return this.advContext;
    }
}
```

- **邮件类代码**

```java
package com.mashibing.example01;

/**
 * 邮件类
 * @author spikeCong
 * @date 2022/9/20
 **/
public class Mail {

    //收件人
    private String receiver;
    //邮件名称
    private String subject;
    //称谓
    private String appellation;
    //邮件内容
    private String context;
    //邮件尾部, 一般是"xxx版权所有"等信息
    private String tail;


    //构造函数
    public Mail(AdvTemplate advTemplate) {
        this.context = advTemplate.getAdvContext();
        this.subject = advTemplate.getAdvSubject();
    }

    public String getReceiver() {
        return receiver;
    }

    public void setReceiver(String receiver) {
        this.receiver = receiver;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getAppellation() {
        return appellation;
    }

    public void setAppellation(String appellation) {
        this.appellation = appellation;
    }

    public String getContext() {
        return context;
    }

    public void setContext(String context) {
        this.context = context;
    }

    public String getTail() {
        return tail;
    }

    public void setTail(String tail) {
        this.tail = tail;
    }
}
```

- **客户类**

```java
/**
 * 业务场景类
 * @author spikeCong
 * @date 2022/9/20
 **/
public class Client {

    //发送信息的是数量,这个值可以从数据库获取
    private static int MAX_COUNT = 6;

    //发送邮件
    public static void sendMail(Mail mail){
        System.out.println("标题: " + mail.getSubject() + "\t收件人: " + mail.getReceiver()
        + "\t..发送成功!");
    }

    public static void main(String[] args) {

        //模拟邮件发送
        int i = 0;

        //把模板定义出来,数据是从数据库获取的
        Mail mail = new Mail(new AdvTemplate());
        mail.setTail("xxx银行版权所有");
        while(i < MAX_COUNT){
            //下面是每封邮件不同的地方
            mail.setAppellation(" 先生 (女士)");
            Random random = new Random();
            int num = random.nextInt(9999999);
            mail.setReceiver(num+"@"+"liuliuqiu.com");
            //发送 邮件
            sendMail(mail);
            i++;
        }
    }
}
```

- **运行结果** 

<img src="马士兵-学习笔记-沈俊杰.assets/60.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

上面的代码存在的问题: 

- 发送邮件需要重复创建Mail类对象,而且Mail类的不同对象之间差别非常小,这样重复的创建操作十分的浪费资源.
- 这种情况我们就可以使用原型模式,从其他已有的对象中进行拷贝,而不是每次都创建新对象,进行一些耗时的操作.

**代码重构**

- Mail类

```java
/**
 * 邮件类 实现Cloneable接口,表示该类的实例可以被复制
 * @author spikeCong
 * @date 2022/9/20
 **/
public class Mail implements Cloneable{

    //收件人
    private String receiver;
    //邮件名称
    private String subject;
    //称谓
    private String appellation;
    //邮件内容
    private String context;
    //邮件尾部, 一般是"xxx版权所有"等信息
    private String tail;


    //构造函数
    public Mail(AdvTemplate advTemplate) {
        this.context = advTemplate.getAdvContext();
        this.subject = advTemplate.getAdvSubject();
    }

    public String getReceiver() {
        return receiver;
    }

    public void setReceiver(String receiver) {
        this.receiver = receiver;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getAppellation() {
        return appellation;
    }

    public void setAppellation(String appellation) {
        this.appellation = appellation;
    }

    public String getContext() {
        return context;
    }

    public void setContext(String context) {
        this.context = context;
    }

    public String getTail() {
        return tail;
    }

    public void setTail(String tail) {
        this.tail = tail;
    }

    @Override
    public Mail clone(){
        Mail mail = null;
        try {
            mail = (Mail)super.clone();
        } catch (CloneNotSupportedException e) {
            e.printStackTrace();
        }
        return mail;
    }
}
```

- Client类


```java
/**
 * 业务场景类
 * @author spikeCong
 * @date 2022/9/20
 **/
public class Client {

    //发送信息的是数量,这个值可以从数据库获取
    private static int MAX_COUNT = 6;

    //发送邮件
    public static void sendMail(Mail mail){
        System.out.println("标题: " + mail.getSubject() + "\t收件人: " + mail.getReceiver()
        + "\t..发送成功!");
    }

    public static void main(String[] args) {

        //模拟邮件发送
        int i = 0;

        //把模板定义出来,数据是从数据库获取的
        Mail mail = new Mail(new AdvTemplate());
        mail.setTail("xxx银行版权所有");
        while(i < MAX_COUNT){
            //下面是每封邮件不同的地方
            Mail cloneMail = mail.clone();
            cloneMail.setAppellation(" 先生 (女士)");
            Random random = new Random();
            int num = random.nextInt(9999999);
            cloneMail.setReceiver(num+"@"+"liuliuqiu.com");
            //发送 邮件
            sendMail(cloneMail);
            i++;
        }
    }
}
```

#### 4.5.5 原型模式总结

**原型模式的优点**

1. 当创建新的对象实例较为复杂时,使用原型模式可以简化对象的创建过程, 通过复制一个已有实例可以提高新实例的创建效率.

   > 比如，在 AI 系统中，我们经常需要频繁使用大量不同分类的数据模型文件，在对这一类文件建立对象模型时，不仅会长时间占用 IO 读写资源，还会消耗大量 CPU 运算资源，如果频繁创建模型对象，就会很容易造成服务器 CPU 被打满而导致系统宕机。通过原型模式我们可以很容易地解决这个问题，当我们完成对象的第一次初始化后，新创建的对象便使用对象拷贝（在内存中进行二进制流的拷贝），虽然拷贝也会消耗一定资源，但是相比初始化的外部读写和运算来说，内存拷贝消耗会小很多，而且速度快很多

2. 原型模式提供了简化的创建结构,工厂方法模式常常需要有一个与产品类等级结构相同的工厂等级结构(具体工厂对应具体产品),而原型模式就不需要这样,原型模式的产品复制是通过封装在原型类中的克隆方法实现的,无须专门的工厂类来创建产品.

3. 可以使用深克隆的方式保存对象状态,使用原型模式将对象复制一份并将其状态保存起来,以便在需要的时候使用,比如恢复到某一历史状态,可以辅助实现撤销操作.

   > 在某些需要保存历史状态的场景中，比如，聊天消息、上线发布流程、需要撤销操作的程序等，原型模式能快速地复制现有对象的状态并留存副本，方便快速地回滚到上一次保存或最初的状态，避免因网络延迟、误操作等原因而造成数据的不可恢复。			

**原型模式缺点**

- 需要为每一个类配备一个克隆方法,而且该克隆方法位于一个类的内部,当对已有的类进行改造时需要修改源代码,违背了开闭原则.



**使用场景**

原型模式常见的使用场景有以下六种。

- 资源优化场景。也就是当进行对象初始化需要使用很多外部资源时，比如，IO 资源、数据文件、CPU、网络和内存等。

- 复杂的依赖场景。 比如：某些业务场景下，需要复制一个F对象，但F 对象的创建依赖 A，A 又依赖 B，B 又依赖 C……于是创建过程是一连串对象的 get 和 set。

- 性能和安全要求的场景。 比如，同一个用户在一个会话周期里，可能会反复登录平台或使用某些受限的功能，每一次访问请求都会访问授权服务器进行授权，但如果每次都通过 new 产生一个对象会非常烦琐，这时则可以使用原型模式。

- 同一个对象可能被多个修改者使用的场景。 比如，一个商品对象需要提供给物流、会员、订单等多个服务访问，而且各个调用者可能都需要修改其值时，就可以考虑使用原型模式。

- 需要保存原始对象状态的场景。 比如，记录历史操作的场景中，就可以通过原型模式快速保存记录。





## 5 结构型模式(7种)

我们已经学习过了设计模式中的创建型模式. 创建型模式主要解决**对象的创建问题**,封装复杂的创建过程,解耦对象的创建代码和使用代码.

从本节课开始我们来学习结构型设计模式, 结构型模式主要总结了一些类和对象组合在一起的经典结构,这些经典结构可以解决对应特定场景的问题.

一共包括七种：代理模式、桥接模式、装饰者模式、适配器模式、门面(外观)模式、组合模式、和享元模式。



### 5.1 代理模式

#### 模式介绍

在软件开发中,由于一些原因,客户端不想或不能直接访问一个对象,此时可以通过一个称为"代理"的第三者来实现间接访问.该方案对应的设计模式被称为代理模式.

代理模式(Proxy Design Pattern ) 原始定义是：让你能够提供对象的替代品或其占位符。代理控制着对于原对象的访问，并允许将请求提交给对象前后进行一些处理。

- 现实生活中的代理: **海外代购**

​		<img src="马士兵-学习笔记-沈俊杰.assets/65.jpg" alt="image-20220530160637842" style="zoom: 50%;" />

- 软件开发中的代理

  代理模式中引入了一个新的代理对象,代理对象在客户端对象和目标对象之间起到了中介的作用,它去掉客户不能看到的内容和服务或者增加客户需要的额外的新服务.

   

#### 使用场景 

* 功能增强

  当需要对一个对象的访问提供一些额外操作时,可以使用代理模式。例如：事务注解

* 保护代理（Protect or Access）

  控制对一个对象的访问，如果需要，可以给不同的用户提供不同级别的使用权限。例如：权限注解

* 远程代理（Remote）

  实际上，RPC 框架也可以看作一种代理模式，GoF 的《设计模式》一书中把它称作远程代理。通过远程代理，将网络通信、数据编解码等细节隐藏起来。客户端在使用 RPC 服务的时候，就像使用本地函数一样，无需了解跟服务器交互的细节。除此之外，RPC 服务的开发者也只需要开发业务逻辑，就像开发本地使用的函数一样，不需要关注跟客户端的交互细节。

* 防火墙代理（Firewall）

  当你将浏览器配置成使用代理功能时，防火墙就将你的浏览器的请求转给互联网；当互联网返回响应时，代理服务器再把它转给你的浏览器。

  

#### 模式角色

代理（Proxy）模式分为三种角色：

* 抽象主题（Subject）类： 声明了真实主题和代理主题的共同接口,这样就可以保证任何使用真实主题的地方都可以使用代理主题,客户端一般针对抽象主题类进行编程。
* 代理（Proxy）类 ： 提供了与真实主题相同的接口，其内部含有对真实主题的引用，它可以在任何时候访问、控制或扩展真实主题的功能。
* 真实主题（Real Subject）类： 实现了抽象主题中的具体业务，是代理对象所代表的真实对象，是最终要引用的对象。

<img src="马士兵-学习笔记-沈俊杰.assets/66.jpg" alt="image-20220530160637842" style="zoom: 80%;" /> 

####  静态代理实现

这种代理方式需要代理对象和目标对象实现一样的接口。

- 优点：可以在不修改目标对象的前提下扩展目标对象的功能。

- 缺点：

  1. 冗余。由于代理对象要实现与目标对象一致的接口，会产生过多的代理类。

  2. 不易维护。一旦接口增加方法，目标对象与代理对象都要进行修改。
  

**标准实现参考**

```java
/**
 * 抽象主题
 */
public interface ISubject {
    void request();
}

/**
 * 真实主题
 */
public class RealSubject implements ISubject{
    @Override
    public void request() {
        System.out.println("真实对象请求。");
    }
}

/**
 * 静态代理主题
 */
public class StaticProxy implements ISubject{
    ISubject subject;

    public StaticProxy(ISubject subject) {
        this.subject = subject;
    }

    public ISubject getSubject() {
        return subject;
    }

    public void setSubject(ISubject subject) {
        this.subject = subject;
    }

    @Override
    public void request() {
        this.before();
        getSubject().request();
        this.after();
    }

    public void before(){
        System.out.println("代理请求开始");
    }

    public void after(){
        System.out.println("代理请求结束");
    }
}

/**
 * 静态代理调用
 */
public class StaticClient {
    public static void main(String[] args) {
        StaticProxy proxy = new StaticProxy(new RealSubject());
        proxy.request();
    }
}
```



> 举例：保存用户功能的静态代理实现

```java
//接口类： IUserDao
public interface IUserDao {
    void save();
}

//目标对象：UserDaoImpl
public class UserDaoImpl implements IUserDao {
    @Override
    public void save() {
        System.out.println("保存数据");
    }
}

//静态代理对象：UserDaoProxy 需要实现IUserDao接口
public class UserDaoProxy implements IUserDao {

    private IUserDao target;

    public UserDaoProxy(IUserDao target) {
        this.target = target;
    }

    @Override
    public void save() {
        System.out.println("开启事务"); //扩展额外功能
        target.save();
        System.out.println("提交事务");
    }
}

//测试类
public class TestProxy {

    @Test
    public void testStaticProxy(){

        //目标对象
        UserDaoImpl userDao = new UserDaoImpl();
        //代理对象
        UserDaoProxy proxy = new UserDaoProxy(userDao);
        proxy.save();
    }
}
```

#### 动态代理（JDK）

#####  JDK动态代理实现

动态代理利用了JDK API,动态地在内存中构建代理对象,从而实现对目标对象的代理功能.动态代理又被称为JDK代理或接口代理.

静态代理与动态代理的区别:

1. 静态代理在编译时就已经实现了,编译完成后代理类是一个实际的class文件
2. 动态代理是在运行时动态生成的,即编译完成后没有实际的class文件,而是在运行时动态生成类字节码,并加载到JVM中.



JDK中生成代理对象主要涉及的类有

- java.lang.reflect Proxy，主要方法为

  ```java
  static Object newProxyInstance(
      ClassLoader loader,  		//指定当前目标对象使用类加载器
      Class<?>[] interfaces,    //目标对象实现的接口的类型
      InvocationHandler h      //事件处理器
  ) 
  //返回一个指定接口的代理类实例，该接口可以将方法调用指派到指定的调用处理程序。
  ```

- java.lang.reflect InvocationHandler，主要方法为

  ```java
  Object invoke(Object proxy, Method method, Object[] args) 
  // 在代理实例上处理方法调用并返回结果。
  ```

> 举例：保存用户功能的静态代理实现

```java
/**
 * 代理工厂-动态生成代理对象
 * @author spikeCong
 * @date 2022/9/22
 **/
public class ProxyFactory {

    private Object target; //维护一个目标对象

    public ProxyFactory(Object target) {
        this.target = target;
    }

    //为目标对象生成代理对象
    public Object getProxyInstance(){

        //使用Proxy获取代理对象
        return Proxy.newProxyInstance(
                target.getClass().getClassLoader(), //目标类使用的类加载器
                target.getClass().getInterfaces(), //目标对象实现的接口类型
                new InvocationHandler(){ //事件处理器

                    /**
                     * invoke方法参数说明
                     * @param proxy 代理对象
                     * @param method 对应于在代理对象上调用的接口方法Method实例
                     * @param args 代理对象调用接口方法时传递的实际参数
                     * @return: java.lang.Object 返回目标对象方法的返回值,没有返回值就返回null
                     */
                    @Override
                    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
                        System.out.println("开启事务");

                        //执行目标对象方法
                        method.invoke(target, args);
                        System.out.println("提交事务");
                        return null;
                    }
                }
        );
    }

}


//测试
public static void main(String[] args) {
    IUserDao target = new UserDaoImpl();
    System.out.println(target.getClass());//目标对象信息

    IUserDao proxy = (IUserDao) new ProxyFactory(target).getProxyInstance();
    System.out.println(proxy.getClass()); //输出代理对象信息
    proxy.save(); //执行代理方法
}
```

##### 类是如何动态生成的

Java虚拟机类加载过程主要分为五个阶段：加载、验证、准备、解析、初始化。其中加载阶段需要完成以下3件事情：

1. 通过一个类的全限定名来获取定义此类的二进制字节流
2. 将这个字节流所代表的静态存储结构转化为方法区的运行时数据结构
3. 在内存中生成一个代表这个类的 `java.lang.Class` 对象，作为方法区这个类的各种数据访问入口

由于虚拟机规范对这3点要求并不具体，所以实际的实现是非常灵活的，关于第1点，**获取类的二进制字节流**（class字节码）就有很多途径：

<img src="马士兵-学习笔记-沈俊杰.assets/69.jpg" alt="image-20220530160637842" style="zoom: 100%;" /> 

- 从本地获取

- 从网络中获取

- **运行时计算生成**，这种场景使用最多的是动态代理技术，在 java.lang.reflect.Proxy 类中，就是用了 ProxyGenerator.generateProxyClass 来为特定接口生成形式为 `*$Proxy` 的代理类的二进制字节流

  <img src="马士兵-学习笔记-沈俊杰.assets/70.jpg" alt="image-20220530160637842" style="zoom: 100%;" /> 

  

所以，动态代理就是想办法，根据接口或目标对象，计算出代理类的字节码，然后再加载到JVM中使用

##### 代理类的调用过程

我们通过借用阿里巴巴的一款线上监控诊断产品 Arthas(阿尔萨斯) ,对动态生成的代理类代码进行查看

<img src="马士兵-学习笔记-沈俊杰.assets/67.jpg" alt="image-20220530160637842" style="zoom: 80%;" />

<img src="马士兵-学习笔记-沈俊杰.assets/68.jpg" alt="image-20220530160637842" style="zoom: 80%;" /> 



代理类代码如下:

```java
package com.sun.proxy;

import com.mashibing.proxy.example01.IUserDao;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.lang.reflect.UndeclaredThrowableException;

public final class $Proxy0 extends Proxy implements IUserDao {
    private static Method m1;
    private static Method m3;
    private static Method m2;
    private static Method m0;

    public $Proxy0(InvocationHandler invocationHandler) {
        super(invocationHandler);
    }

    static {
        try {
            m1 = Class.forName("java.lang.Object").getMethod("equals", Class.forName("java.lang.Object"));
            m3 = Class.forName("com.mashibing.proxy.example01.IUserDao").getMethod("save", new Class[0]);
            m2 = Class.forName("java.lang.Object").getMethod("toString", new Class[0]);
            m0 = Class.forName("java.lang.Object").getMethod("hashCode", new Class[0]);
            return;
        }
        catch (NoSuchMethodException noSuchMethodException) {
            throw new NoSuchMethodError(noSuchMethodException.getMessage());
        }
        catch (ClassNotFoundException classNotFoundException) {
            throw new NoClassDefFoundError(classNotFoundException.getMessage());
        }
    }

    public final boolean equals(Object object) {
        try {
            return (Boolean)this.h.invoke(this, m1, new Object[]{object});
        }
        catch (Error | RuntimeException throwable) {
            throw throwable;
        }
        catch (Throwable throwable) {
            throw new UndeclaredThrowableException(throwable);
        }
    }

    public final String toString() {
        try {
            return (String)this.h.invoke(this, m2, null);
        }
        catch (Error | RuntimeException throwable) {
            throw throwable;
        }
        catch (Throwable throwable) {
            throw new UndeclaredThrowableException(throwable);
        }
    }

    public final int hashCode() {
        try {
            return (Integer)this.h.invoke(this, m0, null);
        }
        catch (Error | RuntimeException throwable) {
            throw throwable;
        }
        catch (Throwable throwable) {
            throw new UndeclaredThrowableException(throwable);
        }
    }

    public final void save() {
        try {
            this.h.invoke(this, m3, null);
            return;
        }
        catch (Error | RuntimeException throwable) {
            throw throwable;
        }
        catch (Throwable throwable) {
            throw new UndeclaredThrowableException(throwable);
        }
    }
}
```

简化后的代码

```java
package com.sun.proxy;

import com.mashibing.proxy.example01.IUserDao;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.lang.reflect.UndeclaredThrowableException;

public final class $Proxy0 extends Proxy implements IUserDao {
    private static Method m3;

    public $Proxy0(InvocationHandler invocationHandler) {
        super(invocationHandler);
    }

    static {
        try {
         m3 = Class.forName("com.mashibing.proxy.example01.IUserDao").getMethod("save", new Class[0]);
          return;
        }
    }

    public final void save() {
        try {
            this.h.invoke(this, m3, null);
            return;
        }
    }
}
```

- 动态代理类对象 继承了 Proxy 类，并且实现了被代理的所有接口，以及equals、hashCode、toString等方法

- 代理类的构造函数，参数是`InvocationHandler`实例，`Proxy.newInstance`方法就是通过这个构造函数来创建代理实例的

- 类和所有方法都被 `public final` 修饰，所以代理类只可被使用，不可以再被继承

- 每个方法都有一个 Method 对象来描述，Method 对象在static静态代码块中创建，以 `m + 数字` 的格式命名

- 调用方法的时候通过 `this.h.invoke(this, m3, null));`  **实际上 h.invoke就是在调用ProxyFactory中我们重写的invoke方法**  

  ```java
  @Override
  public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
      System.out.println("开启事务");
  
      //执行目标对象方法
      method.invoke(target, args);
      System.out.println("提交事务");
      return null;
  }
  ```

#### 动态代理（cglib）

##### cglib动态代理实现

cglib (Code Generation Library ) 是一个第三方代码生成类库，运行时在内存中动态生成一个子类对象从而实现对目标对象功能的扩展。cglib 为没有实现接口的类提供代理，为JDK的动态代理提供了很好的补充。

<img src="马士兵-学习笔记-沈俊杰.assets/72.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

- 最底层是字节码
- ASM是操作字节码的工具
- cglib基于ASM字节码工具操作字节码（即动态生成代理，对方法进行增强）
- SpringAOP基于cglib进行封装，实现cglib方式的动态代理

使用cglib 需要引入cglib 的jar包，如果你已经有spring-core的jar包，则无需引入，因为spring中包含了cglib 。

- cglib 的Maven坐标

```xml
<dependency>
    <groupId>cglib</groupId>
    <artifactId>cglib</artifactId>
    <version>3.2.9</version>
</dependency>
```

**示例代码**

目标类

```java
public class UserServiceImpl {

    public List<User> findUserList(){

        return Collections.singletonList(new User("tom",18));
    }
}


public class User {

    private String name;

    private int age;
	
    .....
}
```

cglib代理类，需要实现MethodInterceptor接口，并指定代理目标类target

```java
public class UserLogProxy implements MethodInterceptor {

    private Object target;

    public UserLogProxy(Object target) {
        this.target = target;
    }

    public Object getLogProxy(){

        //增强器类,用来创建动态代理类
        Enhancer en = new Enhancer();

        //设置代理类的父类字节码对象
        en.setSuperclass(target.getClass());

        //设置回调: 对于代理类上所有的方法的调用,都会调用CallBack,而Callback则需要实现intercept()方法进行拦截
        en.setCallback(this);

        //创建动态代理对象并返回
        return en.create();
    }

    /**
     * 实现回调方法
     * @param o     代理对象
     * @param method  目标对象中的方法的Method实例
     * @param args      实际参数
     * @param methodProxy  代理对象中的方法的method实例
     * @return: java.lang.Object
     */
    @Override
    public Object intercept(Object o, Method method, Object[] args,
                            MethodProxy methodProxy) throws Throwable {

        Calendar calendar = Calendar.getInstance();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        System.out.println(formatter.format(calendar.getTime()) + " [" +method.getName() + "] 查询用户信息...]");

        Object result = methodProxy.invokeSuper(o, args);
        return result;
    }
}
```

```java
public class Client {

    public static void main(String[] args) {

        //目标对象
        UserServiceImpl userService = new UserServiceImpl();
        System.out.println(userService.getClass());

        //代理对象
        UserServiceImpl proxy = (UserServiceImpl) new UserLogProxy(userService).getLogProxy();
        System.out.println(proxy.getClass());

        List<User> userList = proxy.findUserList();
        System.out.println("用户信息: "+userList);
    }
}
```

##### cglib代理流程

<img src="马士兵-学习笔记-沈俊杰.assets/74.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

#### 模式总结

##### 三种模式实现方式对比

* jdk代理和CGLIB代理

  使用CGLib实现动态代理，CGLib底层采用ASM字节码生成框架，使用字节码技术生成代理类，在JDK1.6之前比使用Java反射效率要高。唯一需要注意的是，CGLib不能对声明为final的类或者方法进行代理，因为CGLib原理是动态生成被代理类的子类。

  在JDK1.6、JDK1.7、JDK1.8逐步对JDK动态代理优化之后，在调用次数较少的情况下，JDK代理效率高于CGLib代理效率，只有当进行大量调用的时候，JDK1.6和JDK1.7比CGLib代理效率低一点，但是到JDK1.8的时候，JDK代理效率高于CGLib代理。所以如果有接口建议使用JDK动态代理，如果没有接口使用CGLIB代理。

* 动态代理和静态代理

  动态代理与静态代理相比较，最大的好处是接口中声明的所有方法都被转移到调用处理器一个集中的方法中处理（InvocationHandler.invoke）。这样，在接口方法数量比较多的时候，我们可以进行灵活处理，而不需要像静态代理那样每一个方法进行中转。

  如果接口增加一个方法，静态代理模式除了所有实现类需要实现这个方法外，所有代理类也需要实现此方法。增加了代码维护的复杂度。而动态代理不会出现该问题

##### 优缺点

**优点：**

- 代理模式在客户端与目标对象之间起到一个中介作用和保护目标对象的作用；
- 代理对象可以扩展目标对象的功能；
- 代理模式能将客户端与目标对象分离，在一定程度上降低了系统的耦合度；

**缺点：**

* 增加了系统的复杂度；



### 5.2 桥接模式

#### 5.2.1 桥接模式介绍

桥接模式(bridge pattern) 的定义是：将抽象部分与它的实现部分分离，使它们都可以独立地变化。

> 桥接模式用一种巧妙的方式处理多层继承存在的问题。用抽象关联来取代传统的多层继承。将类之间的静态继承关系转变为动态的组合关系。使得系统更加灵活，并易于扩展，有效的控制了系统中类的个数 (避免了继承层次的指数级爆炸)。

#### 5.2.2 桥接模式原理

<img src="马士兵-学习笔记-沈俊杰.assets/75.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

桥接（Bridge）模式包含以下主要角色：

* 抽象化（Abstraction）角色 ：主要负责定义出该角色的行为 ,并包含一个对实现化对象的引用。
* 扩展抽象化（RefinedAbstraction）角色 ：是抽象化角色的子类，实现父类中的业务方法，并通过组合关系调用实现化角色中的业务方法。
* 实现化（Implementor）角色 ：定义实现化角色的接口，包含角色必须的行为和属性,并供扩展抽象化角色调用。
* 具体实现化（Concrete Implementor）角色 ：给出实现化角色接口的具体实现。

**桥接模式原理的核心是: 首先有要识别出一个类所具有的的两个独立变化维度,将它们设计为两个独立的继承等级结构,为两个维度都提供抽象层,并建立抽象耦合.总结一句话就是: 抽象角色引用实现角色** 



#### 5.2.3 桥接模式的应用实例

模拟不同的支付工具对应不同的支付模式,比如微信和支付宝都可以完成支付操作,而支付操作又可以有扫码支付、密码支付、人脸支付等,那么关于支付操作其实就有两个维度, 包括:**支付渠道和支付方式** 

<img src="马士兵-学习笔记-沈俊杰.assets/78.jpg" alt="image-20220530160637842" style="zoom: 50%;" />  

**1) 不使用设计模式**

```java
public class PayController {


    /**
     * @param uId   用户id
     * @param tradeId 交易流水号
     * @param amount    交易金额
     * @param channelType 渠道类型 1 微信, 2 支付宝
     * @param modeType    支付模式 1 密码,2 人脸,3 指纹
     * @return: boolean
     */
    public boolean doPay(String uId, String tradeId, BigDecimal amount,int channelType,int modeType){
        //微信支付
        if(1 == channelType){
            System.out.println("微信渠道支付划账开始......");
            if(1 == modeType){
                System.out.println("密码支付");
            }if(2 == modeType){
                System.out.println("人脸支付");
            }if(3 == modeType){
                System.out.println("指纹支付");
            }
        }

        //支付宝支付
        if(2 == channelType){
            System.out.println("支付宝渠道支付划账开始......");
            if(1 == modeType){
                System.out.println("密码支付");
            }if(2 == modeType){
                System.out.println("人脸支付");
            }if(3 == modeType){
                System.out.println("指纹支付");
            }
        }
        return true;
    }
}

//测试
public class Test_Pay {

    public static void main(String[] args) {
        PayController payController = new PayController();
        System.out.println("测试: 微信支付、人脸支付方式");
        payController.doPay("weixin_001","1000112333333",new BigDecimal(100),1,2);

        System.out.println("\n测试: 支付宝支付、指纹支付方式");
        payController.doPay("hifubao_002","1000112334567",new BigDecimal(100),2,3);
    }
}
```

从测试结果看,是满足了需求,但是这样的代码设计,后面的维护和扩展都会变得非常复杂.

**1) 桥接模式重构代码**

**桥接模式原理的核心是: 首先有要识别出一个类所具有的的两个独立变化维度,将它们设计为两个独立的继承等级结构,为两个维度都提供抽象层,并建立抽象耦合.**

- Pay抽象类
  - 支付渠道子类: 微信支付
  - 支付渠道子类: 支付宝支付
- IPayMode接口
  - 支付模式实现: 刷脸支付
  - 支付模式实现: 指纹支付
- 支付渠道*支付模式 = 相对应的组合.
- 重构类图

<img src="马士兵-学习笔记-沈俊杰.assets/80.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

**1) 支付模式接口 (实现化角色)**

```java
/**
 * 支付模式接口
 * @author spikeCong
 * @date 2022/9/26
 **/
public interface IPayMode {

    //安全校验功能: 对各种支付模式进行风控校验
    boolean security(String uId);
}
```

**2) 三种具体支付模式 (具体实现化角色)**

```java
//指纹支付及风控校验
public class PayFingerprintMode implements IPayMode {

    @Override
    public boolean security(String uId) {
        System.out.println("指纹支付,风控校验-指纹信息");
        return true;
    }
}

//刷脸支付及风控校验
public class PayFaceMode implements IPayMode {

    @Override
    public boolean security(String uId) {
        System.out.println("人脸支付,风控校验-脸部识别");
        return true;
    }
}
//密码支付及风控校验
public class PayCypher implements IPayMode {

    @Override
    public boolean security(String uId) {
        System.out.println("密码支付,风控校验-环境安全");
        return false;
    }
}
```

**3) 支付抽象类 (抽象化角色)** 

```JAVA
public abstract class Pay {
    //桥接对象
    protected IPayMode payMode;

    public Pay(IPayMode payMode) {
        this.payMode = payMode;
    }

    //划账功能
    public abstract String transfer(String uId, String tradeId, BigDecimal amount);

}
```

**4) 支付渠道实现 (扩展抽象化角色)**

```java
/**
 * 支付渠道-微信划账
 * @author spikeCong
 * @date 2022/9/26
 **/
public class WxPay extends Pay {
    
    public WxPay(IPayMode payMode) {
        super(payMode);
    }

    @Override
    public String transfer(String uId, String tradeId, BigDecimal amount) {
        System.out.println("微信渠道支付划账开始......");

        boolean security = payMode.security(uId);
        System.out.println("微信渠道支付风险校验: " + uId + " , " + tradeId +" , " + security);

        if(!security){
            System.out.println("微信渠道支付划账失败!");
            return "500";
        }

        System.out.println("微信渠道划账成功! 金额: "+ amount);
        return "200";
    }
}

/**
 * 支付渠道-支付宝划账
 * @author spikeCong
 * @date 2022/9/26
 **/
public class ZfbPay extends Pay {

    public ZfbPay(IPayMode payMode) {
        super(payMode);
    }

    @Override
    public String transfer(String uId, String tradeId, BigDecimal amount) {
        System.out.println("支付宝渠道支付划账开始......");

        boolean security = payMode.security(uId);
        System.out.println("支付宝渠道支付风险校验: " + uId + " , " + tradeId +" , " + security);

        if(!security){
            System.out.println("支付宝渠道支付划账失败!");
            return "500";
        }

        System.out.println("支付宝渠道划账成功! 金额: "+ amount);
        return "200";
    }
}
```

**5) 测试**

```java
public class Client {
    public static void main(String[] args) {
        System.out.println("测试场景1: 微信支付、人脸方式.");
        Pay wxpay = new WxPay(new PayFaceMode());
        wxpay.transfer("wx_00100100", "10001900", new BigDecimal(100));

        System.out.println("测试场景2: 支付宝支付、指纹方式");
        Pay zfbPay = new ZfbPay(new PayFingerprintMode());
        zfbPay.transfer("jlu1234567", "567689999999", new BigDecimal(200));
    }
}
```

代码重构完成后,结构更加清晰整洁, 可读性和易用性更高,外部的使用接口的用户不需要关心具体实现.桥接模式满足了单一职责原则和开闭原则,让每一部分都更加清晰并且易扩展.

#### 5.2.4 桥接模式总结

**桥接模式的优点:**

1. 分离抽象接口及其实现部分.桥接模式使用"对象间的关联关系"解耦了抽象和实现之间固有的绑定关系,使得抽象和实现可以沿着各自的维度来变化.
2. 在很多情况下,桥接模式可以取代多层继承方案.多层继承方案违背了单一职责原则,复用性差,类的个数多.桥接模式很好的解决了这些问题.
3. 桥接模式提高了系统的扩展性,在两个变化维度中任意扩展一个维度都不需要修改原有系统,符合开闭原则.

**桥接模式的缺点:**

1. 桥接模式的使用会增加系统的理解和设计难度,由于关联关系建立在抽象层,要求开发者一开始就要对抽象层进行设计和编程
2. 桥接模式要求正确识别出系统中的两个独立变化的维度,因此具有一定的局限性,并且如果正确的进行维度的划分,也需要相当丰富的经验.

##### 桥接模式使用场景

1. 需要提供平台独立性的应用程序时。 比如，不同数据库的 JDBC 驱动程序、硬盘驱动程序等。

2. 需要在某种统一协议下增加更多组件时。 比如，在支付场景中，我们期望支持微信、支付宝、各大银行的支付组件等。这里的统一协议是收款、支付、扣款，而组件就是微信、支付宝等。

3. 基于消息驱动的场景。 虽然消息的行为比较统一，主要包括发送、接收、处理和回执，但其实具体客户端的实现通常却各不相同，比如，手机短信、邮件消息、QQ 消息、微信消息等。

4. 拆分复杂的类对象时。 当一个类中包含大量对象和方法时，既不方便阅读，也不方便修改。

5. 希望从多个独立维度上扩展时。 比如，系统功能性和非功能性角度，业务或技术角度等。

#### 5.2.5 实际案例

在Spring框架中，桥接模式通常通过[JdbcTemplate类](https://www.zhihu.com/search?q=JdbcTemplate类&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A2952647358})来实现。JdbcTemplate是Spring JDBC框架的核心类，它提供了一系列方法来执行SQL查询和更新操作。

JdbcTemplate内部使用了桥接模式，将不同类型的连接API转换成统一的API，从而使得应用程序无需关心底层数据库的细节。

总之，Spring框架中的桥接模式是一种用于解决不同API之间不兼容性问题的[设计模式](https://www.zhihu.com/search?q=设计模式&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A2952647358})，通过将不同类型的API转换成统一的API，使得应用程序能够无缝地集成各种类型的数据库。

以下是Spring框架中使用桥接模式的示例代码：

```java
// JDBC模板类


public class JdbcTemplate {
    private DataSource dataSource;

    // 构造函数，传入数据源
    public JdbcTemplate(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    // 查询方法
    public <T> List<T> query(String sql, Object[] args, RowMapper<T> rowMapper) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<T> results = new ArrayList<T>();

        try {
            // 通过数据源获取数据库连接
            conn = this.dataSource.getConnection();
            // 创建预编译语句

对象
            stmt = conn.prepareStatement(sql);
            // 设置参数
            for (int i = 0; i < args.length; i++) {
                stmt.setObject

(i + 1, args[i]);
            }
            // 执行查询
            rs = stmt.executeQuery();
            // 处理结果集
            while (rs.next()) {
                T result = rowMapper.mapRow(rs, rs.getRow());
                results.add(result);
            }
        } catch (SQLException e) {
            // 处理异常
        } finally {
            // 关闭连接、语句和结果集
            closeResultSet(rs);
            closeStatement(stmt);
            closeConnection(conn);
        }

        return results;
    }

    // 关闭连接方法
    private void closeConnection(Connection conn) {
        // ...
    }

    // 关闭语句方法
    private void closeStatement(Statement stmt) {
        // ...
    }

    // 关闭结果集方法
    private void closeResultSet(ResultSet rs) {
        // ...
    }
}

// 数据源接口
public interface DataSource {
    Connection getConnection() throws SQLException;
}

// MySQL数据源实现类
public class MySQLDataSource implements DataSource {
    // 实现获取连接方法
    public Connection getConnection() throws SQLException {
        // ...
    }
}

// Oracle数据源实现类
public class OracleDataSource implements DataSource {
    // 实现获取连接方法
    public Connection getConnection() throws SQLException {
        // ...
    }
}
```

在这个示例中，`JdbcTemplate`是桥接模式的核心类，它通过数据源接口`DataSource`来桥接不同类型的数据库连接API。`MySQLDataSource`和`OracleDataSource`是实现`DataSource`接口的具体实现类，它们分别提供了不同类型的数据库连接实现。

通过这种方式，`JdbcTemplate`类就可以使用不同类型的数据库连接API，而不必担心底层的细节。这样，应用程序就可以方便地连接和操作各种类型的数据库了。





### 5.3 装饰器模式

#### 5.3.1 装饰器模式介绍

装饰模式(decorator pattern) 的原始定义是：动态的给一个对象添加一些额外的职责. 就扩展功能而言,装饰器模式提供了一种比使用子类更加灵活的替代方案.

> 假设现在有一块蛋糕,如果只有涂上奶油那这个蛋糕就是普通的**奶油蛋糕**, 这时如果我们添加上一些蓝莓,那这个蛋糕就是**蓝莓蛋糕**.如果我们再拿一块黑巧克力 然后写上姓名、插上代表年龄的蜡烛, 这就是变成了一块生日蛋糕 

<img src="马士兵-学习笔记-沈俊杰.assets/81.jpg" alt="image-20220530160637842" style="zoom: 50%;" />



在软件设计中，装饰器模式是一种用于替代继承的技术，它通过一种无须定义子类的方式给对象动态的增加职责，使用对象之间的关联关系取代类之间的继承关系。

#### 5.3.2 装饰器模式原理

装饰（Decorator）模式中的角色：

* 抽象构件（Component）角色 ：它是具体构件和抽象装饰类的共同父类或接口。声明了在具体构件中实现的业务方法。它引进了可以使客户端以一致的方式处理未被装饰的对象以及装饰之后的对象，实现客户端的透明操作
* 具体构件（Concrete  Component）角色 ：它是抽象构件类的子类或者实现类，用于定义具体的构建对象，实现了在抽象构建中声明的方法。装饰类可以给它增加额外的职责(方法)。
* 抽象装饰（Decorator）角色 ：它也是抽象构件类的子类,用于给具体构件增加职责,但是具体职责在其子类中实现.它维护了一个指向抽象构件对象的引用,通过该引用可以调用装饰之前构件对象的方法,并通过其子类扩展该方法,以达到装饰的目的.
* 具体装饰（ConcreteDecorator）角色 : 它是抽象装饰类的子类,负责向构件添加新的职责.每一个具体装饰类都定义了一些新的行为,它可以调用在抽象装饰类中定义的方法,并可以增加新的方法用于扩充对象的行为.

<img src="马士兵-学习笔记-沈俊杰.assets/82.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

代码如下

```java
/**
 * 抽象构件类
 * @author spikeCong
 * @date 2022/9/27
 **/
public abstract class Component {

    //抽象方法
    public abstract void operation();
}

/**
 * 具体构建类
 * @author spikeCong
 * @date 2022/9/27
 **/
public class ConcreteComponent extends Component {

    @Override
    public void operation() {
        //基础功能实现(复杂功能通过装饰类进行扩展)
    }
}
```

```java
/**
 * 抽象装饰类-装饰者模式的核心
 * @author spikeCong
 * @date 2022/9/27
 **/
public class Decorator extends Component{

    //维持一个对抽象构件对象的引用
    private Component component;

    //注入一个抽象构件类型的对象
    public Decorator(Component component) {
        this.component = component;
    }

    @Override
    public void operation() {
        //调用原有业务方法(这里并没有真正实施装饰,而是提供了一个统一的接口,将装饰过程交给子类完成)
        component.operation();
    }
}


/**
 * 具体装饰类
 * @author spikeCong
 * @date 2022/9/27
 **/
public class ConcreteDecorator extends Decorator {


    public ConcreteDecorator(Component component) {
        super(component);
    }

    @Override
    public void operation() {
        super.operation(); //调用原有业务方法
        addedBehavior(); //调用新增业务方法
    }

    //新增业务方法
    public void addedBehavior(){
        //......
    }
}
```

#### 5.3.3 装饰器模式应用实例

我们以一个文件读写器程序为例, 演示一下装饰者模式的使用,下面是该程序的UML类图

<img src="马士兵-学习笔记-沈俊杰.assets/84.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

- **DataLoader** 
  - 抽象的文件读取接口DataLoader 
- **BaseFileDataLoader**
  - 具体组件BaseFileDataLoader，重写组件 DataLoader 的读写方法
- **DataLoaderDecorator**
  - 装饰器DataLoaderDecorator，这里要包含一个引用 DataLoader 的对象实例 wrapper，同样是重写 DataLoader 方法，不过这里使用 wrapper 来读写,并不进行扩展
- **EncryptionDataDecorator**
  - 读写时有加解密功能的具体装饰器EncryptionDataDecorator，它继承了装饰器 DataLoaderDecorator 重写读写方法

导入IO工具类

```xml
    <dependencies>
        <dependency>
            <groupId>cn.hutool</groupId>
            <artifactId>hutool-all</artifactId>
            <version>5.8.15</version>
        </dependency>
    </dependencies>
```

1 ) DataLoader

```java
/**
 * 装饰器模式-抽象构件（Component）角色
 **/
public interface DataLoader {
    String read();
    void write(String data);
}
```

2 ) BaseFileDataLoader

```java
/**
 * 具体构件（Concrete Component）角色<br>
 **/
public class BaseFileDataLoader implements DataLoader {

    private String filePath;

    public BaseFileDataLoader(String filePath) {
        this.filePath = filePath;
    }

    @Override
    public String read() {
        String result = FileUtil.readString(new File(filePath), Charset.forName("utf-8"));
        return result;
    }

    @Override
    public void write(String data) {
        FileUtil.writeString(data, new File(filePath), Charset.forName("utf-8"));
    }
}
```

3 ) DataLoaderDecorator

```java
/**
 * 装抽象饰者类
 * @author spikeCong
 * @date 2022/9/27
 **/
public class DataLoaderDecorator implements DataLoader {

    private DataLoader wrapper;

    public DataLoaderDecorator(DataLoader wrapper) {
        this.wrapper = wrapper;
    }

    @Override
    public String read() {
        return wrapper.read();
    }

    @Override
    public void write(String data) {
        wrapper.write(data);
    }
}
```

4 ) EncryptionDataDecorator

```java
/**
 * 具体装饰者-对文件内容进行加密和解密
 * @author spikeCong
 * @date 2022/9/27
 **/
public class EncryptionDataDecorator extends DataLoaderDecorator {

    public EncryptionDataDecorator(DataLoader wrapper) {
        super(wrapper);
    }

    @Override
    public String read() {
        return decode(super.read());
    }

    @Override
    public void write(String data) {
        super.write(encode(data));
    }


    //加密操作
    private String encode(String data) {
        try {
             Base64.Encoder encoder = Base64.getEncoder();
             byte[] bytes = data.getBytes("UTF-8");
             String result = encoder.encodeToString(bytes);
             return result;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    //解密
    private String decode(String data) {
        try {
            Base64.Decoder decoder = Base64.getDecoder();
            String result = new String(decoder.decode(data), "UTF-8");
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
```

5 ) 测试

```java
public class TestDecorator {

    public static void main(String[] args) {
        String info = "name:tom,age:15";
        DataLoaderDecorator decorator = new EncryptionDataDecorator(new BaseFileDataLoader("demo.txt"));
        decorator.write(info);

        String data = decorator.read();
        System.out.println(data);
    }
}
```



#### 5.3.4 装饰器模式总结

 **装饰器模式的优点:**

1. 对于扩展一个对象的功能,装饰模式比继承更加灵活,不会导致类的个数急剧增加
2. 可以通过一种动态的方式来扩展一个对象的功能,通过配置文件可以在运行时选择不同的具体装饰类,从而实现不同的行为.
3. 可以对一个对象进行多次装饰,通过使用不同的具体装饰类以及这些装饰类的排列组合可以创造出很多不同行为的组合,得到更加强大的对象.
4. 具体构建类与具体装饰类可以独立变化,用户可以根据需要增加新的具体构建类和具体装饰类,原有类库代码无序改变,符合开闭原则.

**装饰器模式的缺点:**

1. 在使用装饰模式进行系统设计时将产生很多小对象,这些对象的区别在于它们之间相互连接的方式有所不同,而不是它们的类或者属性值不同,大量的小对象的产生势必会占用更多的系统资源,在一定程度上影响程序的性能.
2. 装饰器模式提供了一种比继承更加灵活、机动的解决方案,但同时也意味着比继承更加易于出错,排错也更加困难,对于多次装饰的对象,在调试寻找错误时可能需要逐级排查,较为烦琐.

**装饰器模式的适用场景**

1. 快速动态扩展和撤销一个类的功能场景。 比如，有的场景下对 API 接口的安全性要求较高，那么就可以使用装饰模式对传输的字符串数据进行压缩或加密。如果安全性要求不高，则可以不使用。

2. 不支持继承扩展类的场景。 比如，使用 final 关键字的类，或者系统中存在大量通过继承产生的子类。



#### 5.3.5 与代理模式的区别

两者都是对类的方法进行增强，但装饰器模式强调的是增强自身，在被装饰之后你能够够在被增强的类上使用增强后的方法。增强过后还是你，只不过能力变强了。

而代理模式则强调要别人帮你去做一些本身与你业务没有太多关系的职责。代理模式是为了实现对象的控制，因为被代理的对象往往难以直接获得或者是其内部不想暴露出来。

装饰类的代码编写和代理很类似，具体区别如下：

    代理是全权代理，被代理类根本不对外，全部由代理类来完成，通过代理对象来访问。
    装饰是增强，是辅助，被代理类仍然可以自行对外提供服务，装饰器只起增强作用。
    代理的目标也可以是类，装饰目标必须是接口。
    代理模式应用有Spring AOP和Spring 事务等；装饰模式应用IO类，Spring过滤器也会用到装饰模式，可以链式调用。

总之，一句话，代理模式只能通过代理类访问，装饰模式被装饰都可以被访问，只是功能被增强。



### 5.4 适配器模式

#### 5.4.1 适配器模式介绍

适配器模式(adapter pattern )的原始定义是：将类的接口转换为客户期望的另一个接口，适配器可以让不兼容的两个类一起协同工作。

> 如果去欧洲国家去旅游的话，他们的插座如下图最左边，是欧洲标准。而我们使用的插头如下图最右边的。因此我们的笔记本电脑，手机在当地不能直接充电。所以就需要一个插座转换器，转换器第1面插入当地的插座，第2面供我们充电，这样使得我们的插头在当地能使用。生活中这样的例子很多，手机充电器（将220v转换为5v的电压），读卡器等，其实就是使用到了适配器模式。

<img src="马士兵-学习笔记-沈俊杰.assets/85.jpg" alt="image-20220530160637842" style="zoom: 100%;" />

适配器模式是用来做适配，它将不兼容的接口转换为可兼容的接口，让原本由于接口不兼容而不能一起工作的类可以一起工作。适配器模式有两种实现方式：类适配器和对象适配器。其中，类适配器使用继承关系来实现，对象适配器使用组合关系来实现。

类适配器模式的耦合度比后者高，且要求程序员了解现有组件库中的相关组件的内部结构，所以应用相对较少些。

#### 5.4.2 适配器模式原理

适配器模式（Adapter）包含以下主要角色：

* 目标（Target）接口：当前系统业务所期待的接口，也是适配器要转换的接口。
* 适配者（Adaptee）类：适配者即被适配的角色，它是被访问和适配的现存组件库中的组件接口。
* 适配器（Adapter）类：它是一个转换器，通过继承或引用适配者的对象，把适配者接口转换成目标接口，让客户端按目标接口的格式访问适配者。

<img src="马士兵-学习笔记-沈俊杰.assets/87.jpg" alt="image-20220530160637842" style="zoom: 50%;" />  

<img src="马士兵-学习笔记-沈俊杰.assets/88.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

#### 5.4.3 适配器模式应用实例

##### 5.4.3.1 类适配器模式

假设现有一台电脑目前只能读取SD卡的信息，这时我们想要使用电脑读取TF卡的内容, 就需要将TF卡加上卡套，转换成SD卡!

创建一个读卡器，将TF卡中的内容读取出来。

类图如下：

<img src="马士兵-学习笔记-沈俊杰.assets/89.jpg" alt="image-20220530160637842" style="zoom: 70%;" /> 

代码如下:

```java
/**
 * 目标（Target）接口-SD卡接口
 **/
public interface SDCard {
    //读取SD卡方法
    String readSD();
    //写入SD卡功能
    void writeSD(String msg);
}

/**
 * SD卡实现类
 **/
public class SDCardImpl implements SDCard {
    @Override
    public String readSD() {
        String msg = "sd card reading data";
        return msg;
    }

    @Override
    public void writeSD(String msg) {
        System.out.println("sd card write data : " + msg);
    }
}

/**
 * TF卡接口
 **/
public interface TFCard {
    //读取TF卡方法
    String readTF();
    //写入TF卡功能
    void writeTF(String msg);
}

/**
 * 适配者（Adaptee）类-TF卡实现类
 * @author spikeCong
 * @date 2022/9/28
 **/
public class TFCardImpl implements TFCard {
    @Override
    public String readTF() {
        String msg = "tf card reading data";
        return msg;
    }

    @Override
    public void writeTF(String msg) {
        System.out.println("tf card write data : " + msg);
    }
}

/**
 * 适配器（Adapter）类-(SD兼容TF)
 **/
public class SDAdapterTF extends TFCardImpl implements SDCard{
    @Override
    public String readSD() {
        System.out.println("adapter read tf card ");
        return readTF();
    }

    @Override
    public void writeSD(String msg) {
        System.out.println("adapter write tf card");
        writeTF(msg);
    }
}

/**
 * 电脑读写SD卡<br>
 */
public class Computer {
    public String read(SDCard sd){
        System.out.println("computer read sdcard.");
        return sd.readSD();
    }

    public void writer(SDCard sd,String data){
        System.out.println("computer write sdcard.");
        sd.writeSD(data);
    }
}

public class Client {
    public static void main(String[] args) {
        Computer computer = new Computer();
        SDCard sdCard = new SDCardImpl();
        System.out.println(computer.read(sdCard));

        System.out.println("========================");
        SDAdapterTF adapterTF = new SDAdapterTF();
        System.out.println(computer.read(adapterTF));
    }
}
```

#### 5.43.2 对象适配器模式

实现方式：对象适配器模式可釆用将现有组件库中已经实现的组件引入适配器类中，该类同时实现当前系统的业务接口。

<img src="马士兵-学习笔记-沈俊杰.assets/90.jpg" alt="image-20220530160637842" style="zoom: 70%;" /> 



代码如下：

类适配器模式的代码，我们只需要修改适配器类（SDAdapterTF）和测试类。

```java
public class SDAdapterTF implements SDCard{

    private TFCard tfCard;

    public SDAdapterTF(TFCard tfCard) {
        this.tfCard = tfCard;
    }

    @Override
    public String readSD() {
        System.out.println("adapter read tf card ");
        return tfCard.readTF();
    }

    @Override
    public void writeSD(String msg) {
        System.out.println("adapter write tf card");
        tfCard.writeTF(msg);
    }
}


public class Client {

    public static void main(String[] args) {
        Computer computer = new Computer();
        SDCard sdCard = new SDCardImpl();
        System.out.println(computer.read(sdCard));

        System.out.println("========================");
        TFCard tfCard = new TFCardImpl();
        SDAdapterTF adapterTF = new SDAdapterTF(tfCard);
        System.out.println(computer.read(adapterTF));
    }
}
```



#### 5.4.3 适配器模式总结

**适配器模式的优点**

1. 将目标类和适配者类解耦,通过引入一个适配器类来重用现有的适配者类,无序修改原有结构
2. 增加了类的透明性和复用性,将具体业务实现过程封装在适配者类中,对于客户端类而言是透明的,而且提高了适配者的复用性,同一个适配者类可以在多个不同的系统中复用.
3. 灵活性和扩展性都非常好,通过使用配置文件可以很方便的更换适配器,也可以在不修改原有代码的基础上增加新的适配器类,符合开闭原则.

**适配器模式的缺点**

- 类适配器的缺点
  1. 对于Java等不支持多重继承的语言,一次最多只能适配一个适配者类,不能同时适配多个适配者
  2. 适配者类不能为最终类
- 对象适配器的缺点
  1. 与类适配器模式相比较,在该模式下要在适配器中置换适配者类的某些方法比较麻烦.

**适配器模式适用的场景**

- 统一多个类的接口设计时。

  > 某个功能的实现依赖多个外部系统（或者说类）。通过适配器模式，将它们的接口适配为统一的接口定义
  >
  > 例如：多个接口其实都是提供供电功能的，只是有的是220v，有的是110v或者240v。这时候就可以适配器进行统一。

- 需要依赖外部系统时

  > 当我们把项目中依赖的一个外部系统替换为另一个外部系统的时候，利用适配器模式，可以减少对代码的改动。

- 原有接口无法修改时或者原有接口功能太老旧但又需要兼容；

  > JDK1.0 Enumeration 到 Iterator 的替换,适用适配器模式保留 Enumeration 类，并将其实现替换为直接调用 Itertor.

- 适配不同数据格式时；

  > Slf4j 日志框架,定义打印日志的统一接口,提供针对不同日志框架的适配器

**代理、桥接、装饰器、适配器 4 种设计模式的区别**

代理、桥接、装饰器、适配器，这 4 种模式是比较常用的结构型设计模式。它们的代码结构非常相似.但其各自的用意却不同,简单说一下它们之间的关系

- 代理模式：代理模式在不改变原始类接口的条件下，为原始类定义一个代理类，主要目的是控制访问，而非加强功能，这是它跟装饰器模式最大的不同。

- 桥接模式：桥接模式的目的是将接口部分和实现部分分离，从而让它们可以较为容易、也相对独立地加以改变。

- 装饰器模式：装饰者模式在不改变原始类接口的情况下，对原始类功能进行增强，并且支持多个装饰器的嵌套使用。

- 适配器模式：将一个类的接口转换为客户希望的另一个接口.适配器模式让那些不兼容的类可以一起工作.

### 5.5 外观模式

#### 5.5.1 外观模式介绍

外观模式( Facade Pattern)，也叫门面模式, 外观模式的原始定义是：为子系统中的一组接口提供统一的接口。它定义了一个更高级别的接口，使子系统更易于使用。

外观模式，是一种通过为多个复杂的子系统提供一个一致的接口，而使这些子系统更加容易被访问的模式。该模式对外有一个统一接口，外部应用程序不用关心内部子系统的具体的细节，这样会大大降低应用程序的复杂度，提高了程序的可维护性。

门面模式有点类似之前讲到的迪米特法则（最少知识原则）和接口隔离原则：两个有交互的系统，只暴露有限的必要的接口

<img src="马士兵-学习笔记-沈俊杰.assets/91.jpg" alt="image-20220530160637842" style="zoom: 70%;" /> 

门面类充当了系统中的"服务员",它为多个业务类的调用提供了一个统一的入口,简化了类与类之间的交互,如果没有门面类,每个客户类需要和多个子系统之间进行复杂的交互,系统的耦合度将会很大.

#### 5.5.2 外观模式原理

<img src="马士兵-学习笔记-沈俊杰.assets/92.jpg" alt="image-20220530160637842" style="zoom: 50%;" />

外观（Facade）模式包含以下主要角色：

* 外观（Facade）角色：为多个子系统对外提供一个共同的接口。

  > 外观角色中可以知道多个相关的子系统中的功能和责任.在正常情况下,它将所有从客户端发来的请求委派到相应的子系统,传递给相应的子系统对象处理

* 子系统（Sub System）角色：实现系统的部分功能，客户可以通过外观角色访问它。

  > 每一个子系统可以是一个类也可以是多个类的集合.每一个子系统都可以被客户端直接调用,或者被外观角色调用.子系统并不	知道外观的存在,对于子系统而言,外观角色仅仅是另一个客户端而已.

代码示例

```java
public class SubSystemA {

    public void methodA(){
        //业务代码
    }
}

public class SubSystemB {

    public void methodB(){
        //业务代码
    }
}

public class SubSystemC {

    public void methodC(){
        //业务代码
    }
}

public class Facade {

    private SubSystemA obj1 = new SubSystemA();
    private SubSystemB obj2 = new SubSystemB();
    private SubSystemC obj3 = new SubSystemC();

    public void method(){

        obj1.methodA();
        obj2.methodB();
        obj3.methodC();
    }
}

public class Client {

    public static void main(String[] args) {

        Facade facade = new Facade();
        facade.method();
    }
}
```



#### 5.5.3 外观模式应用实例

智能家电控制

- 通过智能音箱来控制室内的 灯、电视、空调.本来每个设备都需要进行独立的开关操作,现在通过智能音箱完成对这几个设备的统一控制. 

类图如下

<img src="马士兵-学习笔记-沈俊杰.assets/93.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

代码如下

```java
/**
 * 子系统角色：灯<br>
 */
public class Light {

    public void on(){
        System.out.println("打开灯......");
    }

    public void off(){
        System.out.println("关闭灯......");
    }
}

/**
 * 子系统角色：电视<br>
 */
public class TV {

    public void on(){
        System.out.println("打开电视......");
    }

    public void off(){
        System.out.println("关闭电视......");
    }
}

/**
 * 子系统角色：空调<br>
 */
public class AirCondition {

    public void on(){
        System.out.println("打开空调......");
    }

    public void off(){
        System.out.println("关闭空调......");
    }
}

/**
 * 外观角色：智能家电<br>
 */
public class SmartAppliancesFacade {

    private Light light;
    private TV tv;
    private AirCondition airCondition;

    public SmartAppliancesFacade() {
        this.light =new Light();
        this.tv = new TV();
        this.airCondition = new AirCondition();
    }

    public void say(String message){
        if(message.contains("打开家电")){
            on();
        }else if(message.contains("关闭家电")){
            off();
        }else{
            System.out.println("对不起没有听清楚您说什么! 请重新再说一遍");
        }
    }


    //起床后 语音开启 电灯 电视 空调
    private void on() {
        System.out.println("起床了!");
        light.on();
        tv.on();
        airCondition.on();
    }

    //睡觉前 语音关闭 电灯 电视 空调
    private void off() {
        System.out.println("睡觉了!");
        light.off();
        tv.off();
        airCondition.off();
    }
}

public class Client {

    public static void main(String[] args) {
        //创建外观对象
        SmartAppliancesFacade facade = new SmartAppliancesFacade();

        facade.say("打开家电");
        facade.say("关闭家电");
    }
}
```



#### 5.5.4 外观模式总结

**外观模式的优点:**

1. 它对客户端屏蔽了子系统组件,减少了客户端所需要处理的对象数目,并使子系统使用起来更加的容易.通过引入外观模式,客户端代码将变得很简单,与之关联的对象也很少.
2. 它实现了子系统与客户端之间的松耦合关系,这使得子系统的变化不会影响到调用它的客户端,只需要调整外观类即可
3. 一个子系统的修改对其他子系统没有任何影响,而子系统内部变化也不会影响到外观对象. 

**外观模式缺点:**

1. 不能很好的控制客户端直接使用子系统类,如果客户端访问子系统类做太多的限制则减少了可变性和灵活性.
2. 如果设计不当,增加新的子系统可能需要修改外观类的源代码,违背了开闭原则.

**使用场景分析:** 

- 简化系统复杂度。 比如，当我们开发了一整套的电商系统后（包括订单、商品、支付、会员等系统），我们不能让用户依次使用这些系统后才能完成商品的购买，而是需要一个门户网站或手机 App 这样简化过的门面系统来提供在线的购物功能。
- 减少客户端处理的系统数量。 比如，在 Web 应用中，系统与系统之间的调用可能需要处理 Database 数据库、Model 业务对象等，其中使用 Database 对象就需要处理打开数据库、关闭连接等操作，然后转换为 Model 业务对象，实在是太麻烦了。如果能够创建一个数据库使用的门面（其实就是常说的 DAO 层），那么实现以上过程将变得容易很多。
- 让一个系统（或对象）为多个系统（或对象）工作。 比如，线程池 ThreadPool 就是一个门面模式，它为系统提供了统一的线程对象的创建、销毁、使用等。
- 联合更多的系统来扩展原有系统。 当我们的电商系统中需要一些新功能时，比如，人脸识别，我们可以不需要自行研发，而是购买别家公司的系统来提供服务，这时通过门面系统就能方便快速地进行扩展。
- 作为一个简洁的中间层。 门面模式还可以用来隐藏或者封装系统中的分层结构，同时作为一个简化的中间层来使用。比如，在秒杀、库存、钱包等场景中，我们需要共享有状态的数据时（如商品库存、账户里的钱），在不改变原有系统的前提下，通过一个中间的共享层（如将秒杀活动的商品库存总数统一放在 Redis 里），就能统一进行各种服务（如，秒杀详情页、商品详情页、购物车等）的调用。

**源码案例**

Spring的ApplicationContext：它实现了Factory、ResourceLoader等接口，并通过引用这些接口的实例，对外统一提供：加载配置、解析资源、创建Bean、提供环境、启动流程等功能；

Spring的DbUtils：封装了和JDBC相关的很多很多方法。很多其他Utils类其实也都是门面模式。



### 5.6 组合模式

**引言**

树形结构是很常见的，比如目录系统，随便点开一个文件夹，文件夹下面可能有文件，也有子文件夹，子文件夹中还有子子文件夹和文件......还有公司的部门构造等，展开来看都是树形的结构。

这些树形结构在面向对象的世界中一般是用**组合模式**来处理的。



#### 5.6.1 组合模式介绍

组合模式(Composite Pattern)：组合多个对象形成树形结构以表示具有“整体—部分”关系的层次结构。组合模式对单个对象（即叶子对象）和组合对象（即容器对象）的使用具有一致性，组合模式又可以称为“整体—部分”(Part-Whole)模式，它是一种对象结构型模式。 

对于树形结构，当容器对象（如文件夹）的某一个方法被调用时，将遍历整个树形结构，寻找也包含这个方法的成员对象（可以是容器对象，也可以是叶子对象）并调用执行。这是靠递归调用的机制实现的。

由于容器对象和叶子对象在功能上的区别，在使用这些对象的代码中必须有区别地对待容器对象和叶子对象，而实际上大多数情况下我们希望一致地处理它们，因为对于这些对象的区别对待将会使得程序非常复杂。组合模式为解决此类问题而诞生，它可以让叶子对象和容器对象的使用具有一致性。

组合模式通过一种巧妙的设计方案，可以一致性地处理整个树形结构或者树形结构的一部分，也可以一致性地处理树形结构中的叶子节点（不包含子节点的节点）和容器节点（包含子节点的节点）。

#### 5.6.2 组合模式原理

<img src="马士兵-学习笔记-沈俊杰.assets/96.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

组合模式主要包含三种角色：

* **Component（抽象构件）**：它可以是接口或抽象类，为叶子构件和容器构件对象声明接口，在该角色中可以包含所有子类共有行为的声明和实现。在抽象构件中定义了访问及管理它的子构件的方法，如增加子构件、删除子构件、获取子构件等。

* **Leaf（叶子构件）**：它在组合结构中表示叶子节点对象，叶子节点没有子节点，它实现了在抽象构件中定义的行为。对于那些访问及管理子构件的方法，可以通过异常等方式进行处理。
* **Composite（容器构件）**：它在组合结构中表示容器节点对象，容器节点包含子节点，其子节点可以是叶子节点，也可以是容器节点，它提供一个集合用于存储子节点，实现了在抽象构件中定义的行为，包括那些访问及管理子构件的方法，在其业务方法中可以递归调用其子节点的业务方法。

#### 5.6.3 组合模式实现

组合模式的关键是定义了一个抽象构件类，它既可以代表叶子，又可以代表容器，而客户端针对该抽象构件类进行编程，无须知道它到底表示的是叶子还是容器，可以对其进行统一处理。同时容器对象与抽象构件类之间还建立一个聚合关联关系，在容器对象中既可以包含叶子，也可以包含容器，以此实现递归组合，形成一个树形结构。

如果不使用组合模式，客户端代码将过多地依赖于容器对象复杂的内部实现结构，容器对象内部实现结构的变化将引起客户代码的频繁变化，带来了代码维护复杂、可扩展性差等弊端。组合模式的引入将在一定程度上解决这些问题。

**组合模式的分类**

* 透明组合模式

    透明组合模式中，抽象根节点角色中声明了所有用于管理成员对象的方法，比如在示例中 `Component` 声明了 `add`、`remove` 、`getChild` 方法，这样做的好处是确保所有的构件类都有相同的接口。透明组合模式也是组合模式的标准形式。

    透明组合模式的缺点是不够安全，因为叶子对象和容器对象在本质上是有区别的，叶子对象不可能有下一个层次的对象，即不可能包含成员对象，因此为其提供 add()、remove() 等方法是没有意义的，这在编译阶段不会出错，但在运行阶段如果调用这些方法可能会出错（如果没有提供相应的错误处理代码） 

* 在安全组合模式中，在抽象构件角色中没有声明任何用于管理成员对象的方法，而是在树枝节点类中声明并实现这些方法。安全组合模式的缺点是不够透明，因为叶子构件和容器构件具有不同的方法，且容器构件中那些用于管理成员对象的方法没有在抽象构件类中定义，因此客户端不能完全针对抽象编程，必须有区别地对待叶子构件和容器构件。 

代码实现(透明)

```java
/**
 * 抽象根节点
 * 对于客户端而言将针对抽象编程,无需关心其具体子类是容器构件还是叶子构件.
 **/
public abstract class Component {
    protected String name;

    public Component(String name) {
        this.name = name;
    }

    public abstract String operation();

    public boolean addChild(Component component) {
        throw new UnsupportedOperationException("addChild not supported!");
    }

    public boolean removeChild(Component component) {
        throw new UnsupportedOperationException("removeChild not supported!");
    }

    public Component getChild(int index) {
        throw new UnsupportedOperationException("getChild not supported!");
    }
}

/**
 * 叶子节点：叶子节点中不能包含子节点
 **/
public class Leaf extends Component {
    public Leaf(String name) {
        super(name);
    }

    @Override
    public String operation() {
        return this.name;
    }
}

/**
 * 树枝节点：容器对象,可以包含子节点
 **/
public class Composite extends Component {
    private List<Component> mComponents;

    public Composite(String name) {
        super(name);
        this.mComponents = new ArrayList<Component>();
    }

    @Override
    public String operation() {
        StringBuilder builder = new StringBuilder(this.name);
        for (Component component : this.mComponents) {
            builder.append("\n");
            builder.append(component.operation());
        }
        return builder.toString();
    }

    @Override
    public boolean addChild(Component component) {
        return this.mComponents.add(component);
    }

    @Override
    public boolean removeChild(Component component) {
        return this.mComponents.remove(component);
    }

    @Override
    public Component getChild(int index) {
        return this.mComponents.get(index);
    }
}

public class CompositeClient {
    public static void main(String[] args) {
        // 来一个根节点
        Component root = new Composite("root");
        // 来一个树枝节点
        Component branchA = new Composite("---branchA");
        Component branchB = new Composite("------branchB");
        // 来一个叶子节点
        Component leafA = new Leaf("------leafA");
        Component leafB = new Leaf("---------leafB");
        Component leafC = new Leaf("---leafC");

        root.addChild(branchA);
        root.addChild(leafC);
        branchA.addChild(leafA);
        branchA.addChild(branchB);
        branchB.addChild(leafB);

        String result = root.operation();
        System.out.println(result);

    }
}
```

安全组合模式

```java
// 抽象根节点
public abstract class Component {
    protected String name;

    public Component(String name) {
        this.name = name;
    }

    public abstract String operation();
}

// 树节点
public class Composite extends Component {
    private List<Component> mComponents;

    public Composite(String name) {
        super(name);
        this.mComponents = new ArrayList<Component>();
    }

    @Override
    public String operation() {
        StringBuilder builder = new StringBuilder(this.name);
        for (Component component : this.mComponents) {
            builder.append("\n");
            builder.append(component.operation());
        }
        return builder.toString();
    }


    public boolean addChild(Component component) {
        return this.mComponents.add(component);
    }


    public boolean removeChild(Component component) {
        return this.mComponents.remove(component);
    }


    public Component getChild(int index) {
        return this.mComponents.get(index);
    }

}

//叶子节点
public class Leaf extends Component {

    public Leaf(String name) {
        super(name);
    }

    @Override
    public String operation() {
        return this.name;
    }
}

/**
 * Created by Tom.
 */
public class Test {
    public static void main(String[] args) {
        // 来一个根节点
        Composite root = new Composite("root");
        // 来一个树枝节点
        Composite branchA = new Composite("---branchA");
        Composite branchB = new Composite("------branchB");
        // 来一个叶子节点
        Component leafA = new Leaf("------leafA");
        Component leafB = new Leaf("---------leafB");
        Component leafC = new Leaf("---leafC");

        root.addChild(branchA);
        root.addChild(leafC);
        branchA.addChild(leafA);
        branchA.addChild(branchB);
        branchB.addChild(leafB);

        String result = root.operation();
        System.out.println(result);

    }
}
```



#### 5.6.4 组合模式应用实例

下面我们通过一段程序来演示一下组合模式的使用. 程序的功能是列出某一目录下所有的文件和文件夹.类图如下: 

<img src="马士兵-学习笔记-沈俊杰.assets/98.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

我们按照下图的表示,进行文件和文件夹的构建.

<img src="马士兵-学习笔记-沈俊杰.assets/97.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

Entry类: 抽象类,用来定义File类和Directory类的共性内容

```java
/**
 * Entry抽象类,用来定义File类和Directory类的共性内容
 **/
public abstract class Entry {

    public abstract String getName(); //获取文件名

    public abstract int getSize(); //获取文件大小

    //添加文件夹或文件
    public abstract Entry add(Entry entry);

    //显示指定目录下的所有信息
    public abstract void printList(String prefix);

    @Override
    public String toString() {
        return getName() + "(" +getSize() + ")";
    }
}
```

File类,叶子节点,表示文件.

```java
/**
 * File类 表示文件
 **/
public class File extends Entry {

    private String name; //文件名
    private int size; //文件大小

    public File(String name, int size) {
        this.name = name;
        this.size = size;
    }

    @Override
    public String getName() {
        return name;
    }

    @Override
    public int getSize() {
        return size;
    }

    @Override
    public Entry add(Entry entry) {
        return null;
    }

    @Override
    public void printList(String prefix) {

        System.out.println(prefix + "/" + this);
    }
}
```

Directory类，树枝节点，表示文件夹

```java
/**
 * Directory类，树枝节点，表示文件夹
 **/
public class Directory extends Entry{

    //文件的名字
    private String name;

    //文件夹与文件的集合
    private ArrayList<Entry> directory = new ArrayList();

    //构造函数
    public Directory(String name) {
        this.name = name;
    }

    //获取文件名称
    @Override
    public String getName() {
        return this.name;
    }

    /**
     * 获取文件大小
     *      1.如果entry对象是File类型,则调用getSize方法获取文件大小
     *      2.如果entry对象是Directory类型,会继续调用子文件夹的getSize方法,形成递归调用.
     */
    @Override
    public int getSize() {
        int size = 0;

        //遍历或者去文件大小
        for (Entry entry : directory) {
            size += entry.getSize();
        }
        return size;
    }

    @Override
    public Entry add(Entry entry) {
        directory.add(entry);
        return this;
    }

    //显示目录
    @Override
    public void printList(String prefix) {
        System.out.println("/" + this);
        for (Entry entry : directory) {
            entry.printList("/" + name);
        }
    }
}
```

测试

```java
public class Client {

    public static void main(String[] args) {
        //根节点
        Entry rootDir = new Directory("root");
        //树枝节点
        Entry binDir = new Directory("bin");
        //向bin目录中添加叶子节点
        binDir.add(new File("vi",10000));
        binDir.add(new File("test",20000));

        Entry tmpDir = new Directory("tmp");
        Entry usrDir = new Directory("usr");
        Entry mysqlDir = new Directory("mysql");
        mysqlDir.add(new File("my.cnf",30));
        mysqlDir.add(new File("test.db",25000));
        usrDir.add(mysqlDir);

        rootDir.add(binDir);
        rootDir.add(tmpDir);
        rootDir.add(mysqlDir);

        rootDir.printList("");
    }
}
```



#### 5.6.5 组合模式总结

**2 ) 组合模式优点** 

* 组合模式可以清楚地定义分层次的复杂对象，表示对象的全部或部分层次，它让客户端忽略了层次的差异，方便对整个层次结构进行控制。
* 客户端可以一致地使用一个组合结构或其中单个对象，不必关心处理的是单个对象还是整个组合结构，简化了客户端代码。
* 在组合模式中增加新的树枝节点和叶子节点都很方便，无须对现有类库进行任何修改，符合“开闭原则”。
* 组合模式为树形结构的面向对象实现提供了一种灵活的解决方案，通过叶子节点和树枝节点的递归组合，可以形成复杂的树形结构，但对树形结构的控制却非常简单。

**3 ) 组合模式的缺点**

- 使用组合模式的前提在于，你的业务场景必须能够表示成树形结构。所以，组合模式的应用场景也比较局限，它并不是一种很常用的设计模式。

**4 ) 组合模式使用场景分析**

- 处理一个树形结构，比如，公司人员组织架构、订单信息等；

- 跨越多个层次结构聚合数据，比如，统计文件夹下文件总数；

- 统一处理一个结构中的多个对象，比如，遍历文件夹下所有 XML 类型文件内容。




#### 5.6.6 源码案例

Java SE中的AWT和Swing包的设计就基于组合模式，在这些界面包中为用户提供了大量的容器构件（如Container）和成员构件（如Checkbox、Button和TextArea等）。

```java
/**
* 抽象构建
*/
public abstract class Component implements ImageObserver, MenuContainer,
                                           Serializable{ 
    /**
     * The parent of the object. It may be <code>null</code>
     * for top-level components.
     * @see #getParent
     */
    transient Container parent;
}

/**
* Composite（容器构件）
*/
public class Container extends Component {
    /**
     * The components in this container.
     * @see #add
     * @see #getComponents
     */
    private java.util.List<Component> component = new ArrayList<>();
}

/**
* 叶子构件
*/
public class Checkbox extends Component implements ItemSelectable, Accessible {
    String label;
    boolean state;
    CheckboxGroup group;
}
```





### 5.7 享元模式

#### 5.7.1 享元模式介绍

享元模式 (flyweight pattern) 的原始定义是：摒弃了在每个对象中保存所有数据的方式，通过共享多个对象所共有的相同状态，从而让我们能在有限的内存容量中载入更多对象。

从这个定义中你可以发现，享元模式要解决的核心问题就是节约内存空间，使用的办法是找出相似对象之间的共有特征，然后复用这些特征。所谓“享元”，顾名思义就是被共享的单元。

比如: 一个文本字符串中存在很多重复的字符,如果每一个字符都用一个单独的对象来表示,将会占用较多的内存空间,我们可以使用享元模式解决这一类问题.

​												<img src="马士兵-学习笔记-沈俊杰.assets/101.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

享元模式通过共享技术实现相同或者相似对象的重用,在逻辑上每一个出现的字符都有一个对象与之对应,然而在物理上他们却是共享同一个享元对象.

#### 5.7.2 享元模式原理

享元模式的结构较为复杂,通常会结合工厂模式一起使用,在它的结构图中包含了一个享元工厂类.

<img src="马士兵-学习笔记-沈俊杰.assets/102.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

享元模式的主要有以下角色：

* 抽象享元角色（Flyweight）：通常是一个接口或抽象类，在抽象享元类中声明了具体享元类公共的方法，这些方法可以向外界提供享元对象的内部数据（内部状态），同时也可以通过这些方法来设置外部数据（外部状态）。

  享元（Flyweight）模式中存在以下两种状态：

  1. 内部状态，即不会随着环境的改变而改变的可共享部分。
  2. 外部状态，指随环境改变而改变的不可以共享的部分。享元模式的实现要领就是区分应用中的这两种状态，并将外部状态外部化。

* 可共享的具体享元（Concrete Flyweight）角色 ：它实现了抽象享元类，称为享元对象；在具体享元类中为内部状态提供了存储空间。通常我们可以结合单例模式来设计具体享元类，为每一个具体享元类提供唯一的享元对象。

* 非共享的具体享元（Unshared Flyweight)角色 ：并不是所有的抽象享元类的子类都需要被共享，不能被共享的子类可设计为非共享具体享元类；当需要一个非共享具体享元类的对象时可以直接通过实例化创建。

* 享元工厂（Flyweight Factory）角色 ：负责创建和管理享元角色。当客户对象请求一个享元对象时，享元工厂检査系统中是否存在符合要求的享元对象，如果存在则提供给客户；如果不存在的话，则创建一个新的享元对象。

  

#### 5.7.3 享元模式实现

- 抽象享元类可以是一个接口也可以是一个抽象类,作为所有享元类的公共父类, 主要作用是提高系统的可扩展性.

```java
/**
 * 抽象享元类
 * @author spikeCong
 * @date 2022/10/10
 **/
public abstract class Flyweight {

    public abstract void operation(String extrinsicState);

}
```

- 具体享元类,具体享元类中要将内部状态和外部状态分开处理,内部状态作为具体享元类的成员变量,而外部状态通过注入的方式添加到具体享元类中.

```java
/**
 * 可共享-具体享元类
 * @author spikeCong
 * @date 2022/10/10
 **/
public class ConcreteFlyweight extends Flyweight {

    //内部状态 intrinsicState作为成员变量,同一个享元对象的内部状态是一致的
    private String intrinsicState;

    public ConcreteFlyweight(String intrinsicState) {
        this.intrinsicState = intrinsicState;
    }

    /**
     * 外部状态在使用时由外部设置,不保存在享元对象中,即使是同一个对象
     * @param extrinsicState  外部状态,每次调用可以传入不同的外部状态
     */
    @Override
    public void operation(String extrinsicState) {
        //实现业务方法
        System.out.println("=== 享元对象内部状态" + intrinsicState +",外部状态:" + extrinsicState);
    }
}
```

- 非共享享元类,不复用享元工厂内部状态,但是是抽象享元类的子类或实现类

```java
/**
 * 非共享具体享元类
 * @author spikeCong
 * @date 2022/10/10
 **/
public class UnsharedConcreteFlyweight extends Flyweight {

    private String intrinsicState;

    public UnsharedConcreteFlyweight(String intrinsicState) {
        this.intrinsicState = intrinsicState;
    }


    @Override
    public void operation(String extrinsicState) {
        System.out.println("=== 使用不共享对象,内部状态: " + intrinsicState +",外部状态: " + extrinsicState);
    }
}
```

- 享元工厂类, 管理一个享元对象类的缓存池。它会存储享元对象之间需要传递的共有状态，比如，按照大写英文字母来作为状态标识，这种只在享元对象之间传递的方式就叫内部状态。同时，它还提供了一个通用方法 getFlyweight()，主要通过内部状态标识来获取享元对象。

```java
/**
 * 享元工厂类
 *      作用: 作为存储享元对象的享元池.用户获取享元对象时先从享元池获取,有则返回,没有创建新的
 *      享元对象返回给用户,并在享元池中保存新增的对象.
 * @author spikeCong
 * @date 2022/10/10
 **/
public class FlyweightFactory {

    //定义一个HashMap用于存储享元对象,实现享元池
    private Map<String,Flyweight> pool = new HashMap();

    public FlyweightFactory() {
        //添加对应的内部状态
        pool.put("A",new ConcreteFlyweight("A"));
        pool.put("B",new ConcreteFlyweight("B"));
        pool.put("C",new ConcreteFlyweight("C"));
    }

    //根据内部状态来进行查找
    public Flyweight getFlyweight(String key){
        //对象存在,从享元池直接返回
        if(pool.containsKey(key)){
            System.out.println("===享元池中存在,直接复用,key:" + key);
            return pool.get(key);

        }else{
            //如果对象不存在,先创建一个新的对象添加到享元池中,然后返回
            System.out.println("===享元池中不存在,创建并复用,key:" + key);
            Flyweight fw = new ConcreteFlyweight(key);
            pool.put(key,fw);
            return fw;
        }
    }
}
```

#### 5.7.4 享元模式应用实例

五子棋中有大量的黑子和白子,它们的形状大小都是一样的,只是出现的位置不同,所以一个棋子作为一个独立的对象存储在内存中,会导致大量的内存的浪费,我们使用享元模式来进行优化.

<img src="马士兵-学习笔记-沈俊杰.assets/103.jpg" alt="image-20220530160637842" style="zoom: 90%;" /> 

类图如下

<img src="马士兵-学习笔记-沈俊杰.assets/104.jpg" alt="image-20220530160637842" style="zoom: 90%;" /> 

代码如下

```java
/**
 * 抽象享元类: 五子棋类
 * @author spikeCong
 * @date 2022/10/10
 **/
public abstract class GobangFlyweight {

    public abstract String getColor();

    public void display(){
        System.out.println("棋子颜色: " + this.getColor());
    }
}

/**
 * 共享享元类-白色棋子
 * @author spikeCong
 * @date 2022/10/10
 **/
public class WhiteGobang extends GobangFlyweight{

    @Override
    public String getColor() {
        return "白色";
    }
}

/**
 * 共享享元类-黑色棋子
 * @author spikeCong
 * @date 2022/10/10
 **/
public class BlackGobang extends GobangFlyweight {

    @Override
    public String getColor() {
        return "黑色";
    }
}

/**
 * 享元工厂类-生产五子棋子,使用单例模式进行设计
 * @author spikeCong
 * @date 2022/10/10
 **/
public class GobangFactory {

    private static GobangFactory factory = new GobangFactory();

    private static Map<String,GobangFlyweight> pool;

    //设置共享对象的内部状态,在享元对象中传递
    private GobangFactory() {
        pool = new HashMap<String,GobangFlyweight>();
        GobangFlyweight black = new BlackGobang(); //黑子
        GobangFlyweight white = new WhiteGobang(); //白子
        pool.put("b",black);
        pool.put("w",white);
    }

    //返回享元工厂类唯一实例
    public static final GobangFactory getInstance(){
        return SingletonHolder.INSTANCE;
    }

    //静态内部类-单例
    private static class SingletonHolder{
        private static final GobangFactory INSTANCE = new GobangFactory();
    }

    //通过key获取集合中的享元对象
    public GobangFlyweight getGobang(String key){
        return pool.get(key);
    }
}

public class Client {

    public static void main(String[] args) {

        //获取享元工厂对象
        GobangFactory instance = GobangFactory.getInstance();

        //获取3颗黑子
        GobangFlyweight b1 = instance.getGobang("b");
        GobangFlyweight b2 = instance.getGobang("b");
        GobangFlyweight b3 = instance.getGobang("b");
        System.out.println("判断两颗黑子是否相同: " + (b1 == b2));

        //获取2颗白子
        GobangFlyweight w1 = instance.getGobang("w");
        GobangFlyweight w2 = instance.getGobang("w");
        System.out.println("判断两颗白子是否相同: " + (w1 == w2));

        //显示棋子
        b1.display();
        b2.display();
        b3.display();
        w1.display();
        w2.display();
    }
}
```

三颗黑子(两颗白子)对象比较之后内存地址都是一样的.说明它们是同一个对象.在实现享元模式时使用了单例模式和简单工厂模式,保证了享元工厂对象的唯一性,并提供工厂方法向客户端返回享元对象.

上述案例还可以进一步重构，将棋子位置也加入到享元对象的缓存规则中。

#### 5.7.5 享元模式总结

**1) 享元模式的优点**

- 极大减少内存中相似或相同对象数量，节约系统资源，提供系统性能

  > 比如，当大量商家的商品图片、固定文字（如商品介绍、商品属性）在不同的网页进行展示时，通常不需要重复创建对象，而是可以使用同一个对象，以避免重复存储而浪费内存空间。由于通过享元模式构建的对象是共享的，所以当程序在运行时不仅不用重复创建，还能减少程序与操作系统的 IO 交互次数，大大提升了读写性能。

- 享元模式中的外部状态相对独立，且不影响内部状态

**2) 享元模式的缺点**  

- 为了使对象可以共享，需要将享元对象的部分状态外部化，分离内部状态和外部状态，使程序逻辑复杂

**3) 使用场景**

- 一个系统有大量相同或者相似的对象，造成内存的大量耗费。

  注意: 在使用享元模式时需要维护一个存储享元对象的享元池，而这需要耗费一定的系统资源，因此，应当在需要多次重复使用享元对象时才值得使用享元模式。

- 在 Java 中，享元模式一个常用的场景就是，使用数据类的包装类对象的 valueOf() 方法。比如，使用 Integer.valueOf() 方法时，实际的代码实现中有一个叫 IntegerCache 的静态类，它就是一直缓存了 -127 到 128 范围内的数值，如下代码所示，你可以在 Java JDK 中的 Integer 类的源码中找到这段代码。

  ```java
  public class Test1 {
  
      public static void main(String[] args) {
          Integer i1 = 127;
          Integer i2 = 127;
  
          System.out.println("i1和i2对象是否是同一个对象？" + (i1 == i2));
  
          Integer i3 = 128;
          Integer i4 = 128;
  
          System.out.println("i3和i4对象是否是同一个对象？" + (i3 == i4));
      }
     
  }
  
  
  //传入的值在-128 - 127 之间,直接从缓存中返回
  public static Integer valueOf(int i) {
  	if (i >= IntegerCache.low && i <= IntegerCache.high)
  		return IntegerCache.cache[i + (-IntegerCache.low)];
      return new Integer(i);
  }
  ```

  可以看到 `Integer` 默认先创建并缓存 `-128 ~ 127` 之间数的 `Integer` 对象，当调用 `valueOf` 时如果参数在 `-128 ~ 127` 之间则计算下标并从缓存中返回，否则创建一个新的 `Integer` 对象。

  其实享元模式本质上就是找到对象的不可变特征，并缓存起来，当类似对象使用时从缓存中读取，以达到节省内存空间的目的。



## 6 行为型模式(11种)

行为型模式用于描述程序在运行时复杂的流程控制，即描述多个类或对象之间怎样相互协作共同完成单个对象都无法单独完成的任务，它涉及算法与对象间职责的分配。

行为型模式分为类行为模式和对象行为模式，前者采用继承机制来在类间分派行为，后者采用组合或聚合在对象间分配行为。由于组合关系或聚合关系比继承关系耦合度低，满足“合成复用原则”，所以对象行为模式比类行为模式具有更大的灵活性。

行为型模式分为：

* 观察者模式
* 模板方法模式
* 策略模式
* 职责链模式
* 状态模式
* 命令模式
* 中介者模式
* 迭代器模式
* 访问者模式
* 备忘录模式
* 解释器模式

以上 11 种行为型模式，除了模板方法模式和解释器模式是类行为型模式，其他的全部属于对象行为型模式。

### 6.1 观察者模式

#### 6.1.1 观察者模式介绍

观察者模式的应用场景非常广泛，小到代码层面的解耦，大到架构层面的系统解耦，再或者 一些产品的设计思路，都有这种模式的影子.

现在我们常说的基于事件驱动的架构，其实也是观察者模式的一种最佳实践。当我们观察某一个对象时，对象传递出的每一个行为都被看成是一个事件，观察者通过处理每一个事件来完成自身的操作处理。

生活中也有许多观察者模式的应用,比如 汽车与红绿灯的关系,'红灯停,绿灯行',在这个过程中交通信号灯是汽车的观察目标,而汽车是观察者.

​													<img src="马士兵-学习笔记-沈俊杰.assets/105.jpg" alt="image-20220530160637842" style="zoom: 90%;" />	



**观察者模式(observer pattern)的原始定义是：定义对象之间的一对多依赖关系，这样当一个对象改变状态时，它的所有依赖项都会自动得到通知和更新。**

解释一下上面的定义: 观察者模式它是用于建立一种对象与对象之间的依赖关系,一个对象发生改变时将自动通知其他对象,其他对象将相应的作出反应. 

> 在观察者模式中发生改变的对象称为**观察目标**,而被通知的对象称为**观察者**,一个观察目标可以应对多个观察者,而且这些观察者之间可以没有任何相互联系,可以根据需要增加和删除观察者,使得系统更易于扩展.
>
> 观察者模式的别名有发布-订阅(Publish/Subscribe)模式,模型-视图(Model-View)模式、源-监听(Source-Listener) 模式等

#### 6.1.2 观察者模式原理

观察者模式结构中通常包括: 观察目标和观察者两个继承层次结构.

<img src="马士兵-学习笔记-沈俊杰.assets/106.jpg" alt="image-20220530160637842" style="zoom: 50%;" />  

在观察者模式中有如下角色：

* Subject：抽象主题（抽象被观察者），抽象主题角色把所有观察者对象保存在一个集合里，每个主题都可以有任意数量的观察者，抽象主题提供一个接口，可以增加和删除观察者对象。
* ConcreteSubject：具体主题（具体被观察者），该角色将有关状态存入具体观察者对象，在具体主题的内部状态发生改变时，给所有注册过的观察者发送通知。
* Observer：抽象观察者，是观察者的抽象类，它定义了一个更新接口，使得在得到主题更改通知时更新自己。
* ConcrereObserver：具体观察者，实现抽象观察者定义的更新接口，以便在得到主题更改通知时更新自身的状态。在具体观察者中维护一个指向具体目标对象的引用,它存储具体观察者的有关状态,这些状态需要与具体目标保持一致.



#### 6.1.3 观察者模式实现

- **观察者**

```java
/**
 * 抽象观察者
 * @author spikeCong
 * @date 2022/10/11
 **/
public interface Observer {

    //update方法: 为不同观察者的更新(响应)行为定义相同的接口,不同的观察者对该方法有不同的实现
    public void update();
}

/**
 * 具体观察者
 * @author spikeCong
 * @date 2022/10/11
 **/
public class ConcreteObserverOne implements Observer {

    @Override
    public void update() {
        //获取消息通知,执行业务代码
        System.out.println("ConcreteObserverOne 得到通知!");
    }
}

/**
 * 具体观察者
 * @author spikeCong
 * @date 2022/10/11
 **/
public class ConcreteObserverTwo implements Observer {

    @Override
    public void update() {
        //获取消息通知,执行业务代码
        System.out.println("ConcreteObserverTwo 得到通知!");
    }
}
```

- **被观察者**

```java
/**
 * 抽象目标类
 * @author spikeCong
 * @date 2022/10/11
 **/
public interface Subject {

     void attach(Observer observer);
     void detach(Observer observer);
     void notifyObservers();
}

/**
 * 具体目标类
 * @author spikeCong
 * @date 2022/10/11
 **/
public class ConcreteSubject implements Subject {

    //定义集合,存储所有观察者对象
    private ArrayList<Observer> observers = new ArrayList<>();


    //注册方法,向观察者集合中增加一个观察者
    @Override
    public void attach(Observer observer) {
        observers.add(observer);
    }

    //注销方法,用于从观察者集合中删除一个观察者
    @Override
    public void detach(Observer observer) {
        observers.remove(observer);
    }

    //通知方法
    @Override
    public void notifyObservers() {
        //遍历观察者集合,调用每一个观察者的响应方法
        for (Observer obs : observers) {
            obs.update();
        }
    }
}
```

- **测试类**

```java
public class Client {

    public static void main(String[] args) {
        //创建目标类(被观察者)
        ConcreteSubject subject = new ConcreteSubject();

        //注册观察者类,可以注册多个
        subject.attach(new ConcreteObserverOne());
        subject.attach(new ConcreteObserverTwo());

        //具体主题的内部状态发生改变时，给所有注册过的观察者发送通知。
        subject.notifyObservers();
    }
}
```

#### 6.1.4 观察者模式应用实例

接下来我们使用观察模式,来实现一个买房摇号的程序.摇号结束,需要通过短信告知用户摇号结果,还需要想MQ中保存用户本次摇号的信息.

**1 ) 未使用设计模式**

```java
/**
 * 模拟买房摇号服务
 * @author spikeCong
 * @date 2022/10/11
 **/
public class DrawHouseService {

    //摇号抽签
    public String lots(String uId){
        if(uId.hashCode() % 2 == 0){
            return "恭喜ID为: " + uId + " 的用户,在本次摇号中中签! !";
        }else{
            return "很遗憾,ID为: " + uId + "的用户,您本次未中签! !";
        }
    }
}

public class LotteryResult {

    private String uId; // 用户id
    private String msg; // 摇号信息
    private Date dataTime; // 业务时间
    
    
	//get&set.....
}

/**
 * 开奖服务接口
 * @author spikeCong
 * @date 2022/10/11
 **/
public interface LotteryService {

    //摇号相关业务
    public LotteryResult lottery(String uId);
}


/**
 * 开奖服务
 * @author spikeCong
 * @date 2022/10/11
 **/
public class LotteryServiceImpl implements LotteryService {

    //注入摇号服务
    private DrawHouseService houseService = new DrawHouseService();

    @Override
    public LotteryResult lottery(String uId) {
        //摇号
        String result = houseService.lots(uId);

        //发短信
        System.out.println("发送短信通知用户ID为: " + uId + ",您的摇号结果如下: " + result);

        //发送MQ消息
        System.out.println("记录用户摇号结果(MQ), 用户ID:" +  uId + ",摇号结果:" + result);

       	return new LotteryResult(uId,result,new Date());
    }
}

@Test
public void test1(){
    LotteryService ls = new LotteryServiceImpl();
    String result  = ls.lottery("1234567887654322");
    System.out.println(result);
}
```

**1 ) 使用观察者模式进行优化**

上面的摇号业务中,摇号、发短信、发MQ消息是一个顺序调用的过程,但是除了摇号这个核心功能以外, 发短信与记录信息到MQ的操作都不是主链路的功能,需要单独抽取出来,这样才能保证在后面的开发过程中保证代码的可扩展性和可维护性.

<img src="马士兵-学习笔记-沈俊杰.assets/107.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

- 事件监听

```java
/**
 * 事件监听接口
 * @author spikeCong
 * @date 2022/10/11
 **/
public interface EventListener {

    void doEvent(LotteryResult result);
}

/**
 * 短信发送事件
 * @author spikeCong
 * @date 2022/10/11
 **/
public class MessageEventListener implements EventListener {

    @Override
    public void doEvent(LotteryResult result) {
        System.out.println("发送短信通知用户ID为: " + result.getuId() +
                ",您的摇号结果如下: " + result.getMsg());
    }
}

/**
 * MQ消息发送事件
 * @author spikeCong
 * @date 2022/10/11
 **/
public class MQEventListener implements EventListener {

    @Override
    public void doEvent(LotteryResult result) {
        System.out.println("记录用户摇号结果(MQ), 用户ID:" +  result.getuId() +
                ",摇号结果:" + result.getMsg());
    }
}
```

事件处理

```java
/**
 * 事件处理类
 * @author spikeCong
 * @date 2022/10/11
 **/
public class EventManager {

    public enum EventType{
        MQ,Message
    }

    //监听器集合
    Map<Enum<EventType>, List<EventListener>> listeners = new HashMap<>();

    public EventManager(Enum<EventType>... operations) {
        for (Enum<EventType> operation : operations) {
            this.listeners.put(operation,new ArrayList<>());
        }
    }

    /**
     * 订阅
     * @param eventType 事件类型
     * @param listener  监听
     */
    public void subscribe(Enum<EventType> eventType, EventListener listener){
        List<EventListener> users = listeners.get(eventType);
        users.add(listener);
    }

    /**
     * 取消订阅
     * @param eventType 事件类型
     * @param listener  监听
     */
    public void unsubscribe(Enum<EventType> eventType,EventListener listener){
        List<EventListener> users = listeners.get(eventType);
        users.remove(listener);
    }

    /**
     * 通知
     * @param eventType 事件类型
     * @param result    结果
     */
    public void notify(Enum<EventType> eventType, LotteryResult result){
        List<EventListener> users = listeners.get(eventType);
        for (EventListener listener : users) {
            listener.doEvent(result);
        }
    }
}
```

摇号业务处理

```java
/**
 * 开奖服务接口
 * @author spikeCong
 * @date 2022/10/11
 **/
public abstract class LotteryService{

    private EventManager eventManager;

    public LotteryService(){
        //设置事件类型
        eventManager = new EventManager(EventManager.EventType.MQ, EventManager.EventType.Message);
        //订阅
        eventManager.subscribe(EventManager.EventType.Message,new MessageEventListener());
        eventManager.subscribe(EventManager.EventType.MQ,new MQEventListener());
    }

    public LotteryResult lotteryAndMsg(String uId){
        LotteryResult result = lottery(uId);
        //发送通知
        eventManager.notify(EventManager.EventType.Message,result);
        eventManager.notify(EventManager.EventType.MQ,result);

        return result;
    }

    public abstract LotteryResult lottery(String uId);
}

/**
 * 开奖服务
 * @author spikeCong
 * @date 2022/10/11
 **/
public class LotteryServiceImpl extends LotteryService {

    //注入摇号服务
    private DrawHouseService houseService = new DrawHouseService();

    @Override
    public LotteryResult lottery(String uId) {
        //摇号
        String result = houseService.lots(uId);

        return new LotteryResult(uId,result,new Date());
    }
}
```

测试

```java
@Test
public void test2(){
    LotteryService ls = new LotteryServiceImpl();
    LotteryResult result  = ls.lotteryAndMsg("1234567887654322");
    System.out.println(result);
}
```



#### 6.1.5 观察者模式总结

**1) 观察者模式的优点**

* 降低了目标与观察者之间的耦合关系，两者之间是抽象耦合关系。
* 被观察者发送通知，所有注册的观察者都会收到信息【可以实现广播机制】

**2) 观察者模式的缺点** 

* 如果观察者非常多的话，那么所有的观察者收到被观察者发送的通知会耗时
* 如果被观察者有循环依赖的话，那么被观察者发送通知会使观察者循环调用，会导致系统崩溃

**3 ) 观察者模式常见的使用场景**

- 当一个对象状态的改变需要改变其他对象时。比如，商品库存数量发生变化时，需要通知商品详情页、购物车等系统改变数量。
- 一个对象发生改变时只想要发送通知，而不需要知道接收者是谁。比如，订阅微信公众号的文章，发送者通过公众号发送，订阅者并不知道哪些用户订阅了公众号。
- 需要创建一种链式触发机制时。比如，在系统中创建一个触发链，A 对象的行为将影响 B 对象，B 对象的行为将影响 C 对象……这样通过观察者模式能够很好地实现。
- 微博或微信朋友圈发送的场景。这是观察者模式的典型应用场景，一个人发微博或朋友圈，只要是关联的朋友都会收到通知；一旦取消关注，此人以后将不会收到相关通知。
- 需要建立基于事件触发的场景。比如，基于 Java UI 的编程，所有键盘和鼠标事件都由它的侦听器对象和指定函数处理。当用户单击鼠标时，订阅鼠标单击事件的函数将被调用，并将所有上下文数据作为方法参数传递给它。

 **4 ) JDK 中对观察者模式的支持**

JDK中提供了Observable类以及Observer接口,它们构成了JDK对观察者模式的支持.

- `java.util.Observer` 接口: 该接口中声明了一个方法,它充当**抽象观察者**,其中声明了一个update方法.

  ```java
  void update(Observable o, Object arg);
  ```

- `java.util.Observable` 类: 充当观察目标类(被观察类) , 在该类中定义了一个Vector集合来存储观察者对象.下面是它最重要的 3 个方法。

  - void addObserver(Observer o) 方法：用于将新的观察者对象添加到集合中。

  * void notifyObservers(Object arg) 方法：调用集合中的所有观察者对象的 update方法，通知它们数据发生改变。通常越晚加入集合的观察者越先得到通知。


  * void setChange() 方法：用来设置一个 boolean 类型的内部标志，注明目标对象发生了变化。当它为true时，notifyObservers() 才会通知观察者。

用户可以直接使用Observer接口和Observable类作为观察者模式的抽象层,再自定义具体观察者类和具体观察目标类,使用JDK中提供的这两个类可以更加方便的实现观察者模式.



### 6.2 模板方法模式

#### 6.2.1 模板方法模式介绍

**模板方法模式(template method pattern)原始定义是：在操作中定义算法的框架，将一些步骤推迟到子类中。模板方法让子类在不改变算法结构的情况下重新定义算法的某些步骤。**

模板方法中的算法可以理解为广义上的业务逻辑,并不是特指某一个实际的算法.定义中所说的算法的框架就是模板, 包含算法框架的方法就是模板方法.

> 例如: 我们去医院看病一般要经过以下4个流程：挂号、取号、排队、医生问诊等，其中挂号、 取号 、排队对每个病人是一样的，可以在父类中实现，但是具体医生如何根据病情开药每个人都是不一样的，所以开药这个操作可以延迟到子类中实现。

​														<img src="马士兵-学习笔记-沈俊杰.assets/108.jpg" alt="image-20220530160637842" style="zoom: 70%;" />	

模板方法模式是一种基于继承的代码复用技术,它是一种类行为模式. 模板方法模式其结构中只存在父类与子类之间的继承关系.

模板方法的作用主要是提高程序的复用性和扩展性:

- 复用指的是,所有的子类可以复用父类中提供的模板方法代码
- 扩展指的是,框架通过模板模式提供功能扩展点,让框架用户可以在不修改框架源码的情况下,基于扩展点定制化框架的功能.

#### 6.2.2 模板方法模式原理

模板方法模式的定位很清楚，就是为了解决算法框架这类特定的问题，同时明确表示需要使用继承的结构。

<img src="马士兵-学习笔记-沈俊杰.assets/109.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

模板方法（Template Method）模式包含以下主要角色：

- 抽象父类：定义一个算法所包含的所有步骤，并提供一些通用的方法逻辑。
- 具体子类：继承自抽象父类，根据需要重写父类提供的算法步骤中的某些步骤。

抽象类（Abstract Class）：负责给出一个算法的轮廓和骨架。它由一个模板方法和若干个基本方法构成。

* 模板方法：定义了算法的骨架，按某种顺序调用其包含的基本方法。

* 基本方法：是实现算法各个步骤的方法，是模板方法的组成部分。基本方法又可以分为三种：

  * 抽象方法(Abstract Method) ：一个抽象方法由抽象类声明、由其具体子类实现。

  * 具体方法(Concrete Method) ：一个具体方法由一个抽象类或具体类声明并实现，其子类可以进行覆盖也可以直接继承。

  * 钩子方法(Hook Method) ：在抽象类中已经实现，包括用于判断的逻辑方法和需要子类重写的空方法两种。

    一般钩子方法是用于判断的逻辑方法，这类方法名一般为isXxx，返回值类型为boolean类型。

#### 6.2.3 模板方法模式实现

UML类图对应的代码实现

```java
/**
 * 抽象父类
 * @author spikeCong
 * @date 2022/10/12
 **/
public abstract class AbstractClassTemplate {

    void step1(String key){
        System.out.println("在模板类中 -> 执行步骤1");
        if(step2(key)){
            step3();
        }else{
            step4();
        }

        step5();
    }

    boolean step2(String key){
        System.out.println("在模板类中 -> 执行步骤2");
        if("x".equals(key)){
            return true;
        }
        return false;
    }

    abstract void step3();
    abstract void step4();

    void step5(){
        System.out.println("在模板类中 -> 执行步骤5");
    }

    void run(String key){
        step1(key);
    }

}

public class ConcreteClassA extends AbstractClassTemplate{


    @Override
    void step3() {
        System.out.println("在子类A中 -> 执行步骤 3");
    }

    @Override
    void step4() {
        System.out.println("在子类A中 -> 执行步骤 4");
    }
}

public class ConcreteClassB extends AbstractClassTemplate {

    @Override
    void step3() {
        System.out.println("在子类B中 -> 执行步骤 3");
    }

    @Override
    void step4() {
        System.out.println("在子类B中 -> 执行步骤 4");
    }
}

public class Test01 {

    public static void main(String[] args) {
        AbstractClassTemplate concreteClassA = new ConcreteClassA();
        concreteClassA.run("");

        System.out.println("===========");

        AbstractClassTemplate concreteClassB = new ConcreteClassB();
        concreteClassB.run("x");
    }
}

// 输出结果
在模板类中 -> 执行步骤1
在模板类中 -> 执行步骤2
在子类A中 -> 执行步骤 4
在模板类中 -> 执行步骤5
===========
在模板类中 -> 执行步骤1
在模板类中 -> 执行步骤2
在子类B中 -> 执行步骤 3
在模板类中 -> 执行步骤5
```

#### 6.2.4 模板方法模式应用实例

P2P公司的借款系统中有一个利息计算模块,利息的计算流程是这样的:

1. 用户登录系统,登录时需要输入账号密码,如果登录失败(比如用户密码错误),系统需要给出提示
2. 如果用户登录成功,则根据用户的借款的类型不同,使用不同的利息计算方式进行计算
3. 系统需要显示利息.

```java
/**
 * 账户抽象类
 * @author spikeCong
 * @date 2022/10/12
 **/
public abstract class Account {

    //step1 具体方法-验证用户信息是否正确
    public boolean validate(String account,String password){
        System.out.println("账号: " + account + ",密码: " + password);
        if(account.equalsIgnoreCase("tom") &&
        password.equalsIgnoreCase("123456")){
            return true;
        }else{
            return false;
        }
    }

    //step2 抽象方法-计算利息
    public abstract void calculate();

    //step3 具体方法-显示利息
    public void display(){
        System.out.println("显示利息!");
    }

    //模板方法
    public void handle(String account,String password){
        if(!validate(account,password)){
            System.out.println("账户或密码错误!!");
            return;
        }
        calculate();
        display();
    }
}


/**
 * 借款一个月
 * @author spikeCong
 * @date 2022/10/12
 **/
public class LoanOneMonth extends Account{

    @Override
    public void calculate() {
        System.out.println("借款周期30天,利率为10%!");
    }
}

/**
 * 借款七天
 * @author spikeCong
 * @date 2022/10/12
 **/
public class LoanSevenDays extends Account{

    @Override
    public void calculate() {
        System.out.println("借款周期7天,无利息!仅收取贷款金额1%的服务费!");
    }

    @Override
    public void display() {
        System.out.println("七日内借款无利息!");
    }

}


public class Client {

    public static void main(String[] args) {

        Account a1 = new LoanSevenDays();
        a1.handle("tom","12345");

        System.out.println("==========================");

        Account a2 = new LoanOneMonth();
        a2.handle("tom","123456");
    }
}
```



#### 6.2.5 模板方法模式总结

**优点：**

* 在父类中形式化的定义一个算法,而由它的子类来实现细节处理,在子类实现详细的处理代码时,并不会改变父类算法中步骤的执行顺序.

* 模板方法可以实现一种反向的控制结构,通过子类覆盖父类的钩子方法,来决定某一个特定步骤是否需要执行

* 在模板方法模式中可以通过子类来覆盖父类的基本方法,不同的子类可以提供基本方法的不同实现,更换和增加新的子类很方便,符合单一职责原则和开闭原则.

  

**缺点：**

* 对每个不同的实现都需要定义一个子类，这会导致类的个数增加，系统更加庞大，设计也更加抽象。
* 父类中的抽象方法由子类实现，子类执行的结果会影响父类的结果，这导致一种反向的控制结构，它提高了代码阅读的难度。

**模板方法模式的使用场景一般有：**

- 多个类有相同的方法并且逻辑可以共用时；
- 将通用的算法或固定流程设计为模板，在每一个具体的子类中再继续优化算法步骤或流程步骤时；
- 重构超长代码时，发现某一个经常使用的公有方法。



### 6.3 策略模式

#### 6.3.1 策略模式概述

**策略模式(strategy pattern)的原始定义是：定义一系列算法，将每一个算法封装起来，并使它们可以相互替换。策略模式让算法可以独立于使用它的客户端而变化。这里的算法也可以理解成实现方式**

其实我们在现实生活中常常遇到实现某种目标存在多种策略可供选择的情况，例如，出行旅游可以乘坐飞机、乘坐火车、骑自行车或自己开私家车等。

<img src="马士兵-学习笔记-沈俊杰.assets/111.jpg" alt="image-20220530160637842" style="zoom: 100%;" /> 

在软件开发中,经常会遇到这种情况,开发一个功能可以通过多个算法去实现,我们可以将所有的算法集中在一个类中,在这个类中提供多个方法,每个方法对应一个算法, 或者我们也可以将这些算法都封装在一个统一的方法中,使用if...else...等条件判断语句进行选择.但是这两种方式都存在硬编码的问题,后期需要增加算法就需要修改源代码,这会导致代码的维护变得困难.

**比如网购，你可以选择工商银行、农业银行、建设银行等等，但是它们提供的算法都是一致的，就是帮你付款。**

<img src="马士兵-学习笔记-沈俊杰.assets/110.jpg" alt="image-20220530160637842" style="zoom: 50%;" />

在软件开发中也会遇到相似的情况，当实现某一个功能存在多种算法或者策略，我们可以根据环境或者条件的不同选择不同的算法或者策略来完成该功能。

#### 6.3.2 策略模式原理

在策略模式中可以定义一些独立的类来封装不同的算法,每一个类封装一种具体的算法,在这里每一个封装算法的类都可以被称为一种策略,为了保证这些策略在使用时具有一致性,一般会提供一个抽象的策略类来做算法的声明.而每种算法对应一个具体的策略类.

![image-20230809150027453](沈俊杰-马士兵-架构设计.assets/image-20230809150027453.png) 



策略模式的主要角色如下：

* 抽象策略（Strategy）类：这是一个抽象角色，通常由一个接口或抽象类实现。此角色给出所有的具体策略类所需的接口。
* 具体策略（Concrete Strategy）类：实现了抽象策略定义的接口，提供具体的算法实现或行为。
* 环境或上下文（Context）类：是使用算法的角色,  持有一个策略类的引用，最终给客户端调用。

#### 6.3.3 策略模式实现

策略模式的本质是通过Context类来作为中心控制单元，对不同的策略进行调度分配。

```java
/**
 * 抽象策略（Strategy）类
 **/
public interface Strategy {

    void algorithm();
}


/**
 * 具体策略（Concrete Strategy）类<br>
 */
public class ConcreteStrategyA implements Strategy {

    @Override
    public void algorithm() {
        System.out.println("执行策略B");
    }
}

/**
 * 具体策略（Concrete Strategy）类<br>
 */
public class ConcreteStrategyB implements Strategy {

    @Override
    public void algorithm() {
        System.out.println("执行策略B");
    }
}

/**
 * 环境或上下文（Context）类
 **/
public class Context {

    //维持一个对抽象策略类的引用
    private Strategy strategy;

    public Context(Strategy strategy) {
        this.strategy = strategy;
    }

    //调用策略类中的算法
    public void algorithm(){
        strategy.algorithm();
    }
}

public class Client {
    public static void main(String[] args) {
        Strategy strategyA  = new ConcreteStrategyA();
        Context context = new Context(strategyA); //可以在运行时指定类型,通过配置文件+反射机制实现
        context.algorithm();
    }
}
```

#### 6.3.4 策略模式应用实例

面试问题: 如何用设计模式消除代码中的if-else

物流行业中，通常会涉及到EDI报文(XML格式文件)传输和回执接收，每发送一份EDI报文，后续都会收到与之关联的回执（标识该数据在第三方系统中的流转状态）。

这里列举几种回执类型：MT1101、MT2101、MT4101、MT8104，系统在收到不同的回执报文后，会执行对应的业务逻辑处理。我们就业回执处理为演示案例

**1 ) 不使用设计模式** 

- 回执类

```java
/**
 * 回执信息
 * @author spikeCong
 * @date 2022/10/13
 **/
public class Receipt {

    private String message; //回执信息

    private String type; //回执类型(MT1101、MT2101、MT4101、MT8104)

    public Receipt() {
    }

    public Receipt(String message, String type) {
        this.message = message;
        this.type = type;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
```

- 回执生成器

```java
public class ReceiptBuilder {

    public static List<Receipt> genReceiptList(){
        //模拟回执信息
        List<Receipt> receiptList = new ArrayList<>();
        receiptList.add(new Receipt("MT1101回执","MT1011"));
        receiptList.add(new Receipt("MT2101回执","MT2101"));
        receiptList.add(new Receipt("MT4101回执","MT4101"));
        receiptList.add(new Receipt("MT8104回执","MT8104"));

        //......
        return receiptList;
    }

}
```

- 客户端

```java
public class Client {

    public static void main(String[] args) {

        List<Receipt> receiptList = ReceiptBuilder.genReceiptList();

        //循环判断
        for (Receipt receipt : receiptList) {
            if("MT1011".equals(receipt.getType())){
                System.out.println("接收到MT1011回执!");
                System.out.println("解析回执内容");
                System.out.println("执行业务逻辑A"+"\n");
            }else if("MT2101".equals(receipt.getType())){
                System.out.println("接收到MT2101回执!");
                System.out.println("解析回执内容");
                System.out.println("执行业务逻辑B"+"\n");
            }else if("MT4101".equals(receipt.getType())) {
                System.out.println("接收到MT4101回执!");
                System.out.println("解析回执内容");
                System.out.println("执行业务逻辑C"+"\n");
            }else if("MT8104".equals(receipt.getType())) {
                System.out.println("接收到MT8104回执!");
                System.out.println("解析回执内容");
                System.out.println("执行业务逻辑D");
            }

            //......
        }
    }
}
```

**2 ) 使用策略模式进行优化**

通过策略模式, 将所有的if-else分支的业务逻辑抽取为各种策略类,让客户端去依赖策略接口,保证具体策略类的改变不影响客户端.

- 策略接口

```java
/**
 * 回执处理策略接口
 * @author spikeCong
 * @date 2022/10/13
 **/
public interface ReceiptHandleStrategy {

    void handleReceipt(Receipt receipt);
}

```

- 具体策略类

```java
public class Mt1011ReceiptHandleStrategy implements ReceiptHandleStrategy {

    @Override
    public void handleReceipt(Receipt receipt) {
        System.out.println("解析报文MT1011: " + receipt.getMessage());
    }
}

public class Mt2101ReceiptHandleStrategy implements ReceiptHandleStrategy {

    @Override
    public void handleReceipt(Receipt receipt) {
        System.out.println("解析报文MT2101: " + receipt.getMessage());
    }
}

......
```

- 策略上下文类(策略接口的持有者)

```java
/**
 * 上下文类,持有策略接口
 * @author spikeCong
 * @date 2022/10/13
 **/
public class ReceiptStrategyContext {

    private ReceiptHandleStrategy receiptHandleStrategy;

    public void setReceiptHandleStrategy(ReceiptHandleStrategy receiptHandleStrategy) {
        this.receiptHandleStrategy = receiptHandleStrategy;
    }

    //调用策略类中的方法
    public void handleReceipt(Receipt receipt){
        if(receipt != null){
            receiptHandleStrategy.handleReceipt(receipt);
        }
    }
}
```

- 策略工厂

```java
public class ReceiptHandleStrategyFactory {

    public ReceiptHandleStrategyFactory() {
    }

    //使用Map集合存储策略信息,彻底消除if...else
    private static Map<String,ReceiptHandleStrategy> strategyMap;

    //初始化具体策略,保存到map集合
    public static void init(){
        strategyMap = new HashMap<>();
        strategyMap.put("MT1011",new Mt1011ReceiptHandleStrategy());
        strategyMap.put("MT2101",new Mt2101ReceiptHandleStrategy());
    }

    //根据回执类型获取对应策略类对象
    public static ReceiptHandleStrategy getReceiptHandleStrategy(String receiptType){
        return strategyMap.get(receiptType);
    }
}
```

- 客户端

```java
public class Client {

    public static void main(String[] args) {

        //模拟回执
        List<Receipt> receiptList = ReceiptBuilder.genReceiptList();
        //策略上下文
        ReceiptStrategyContext context = new ReceiptStrategyContext();
        //策略模式将策略的 定义、创建、使用这三部分进行了解耦
        for (Receipt receipt : receiptList) {
            //获取置策略
            ReceiptHandleStrategyFactory.init();
            ReceiptHandleStrategy strategy = ReceiptHandleStrategyFactory.getReceiptHandleStrategy(receipt.getType());
            //设置策略
            context.setReceiptHandleStrategy(strategy);
            //执行策略
            context.handleReceipt(receipt);
        }
    }
}
```

经过上面的改造，我们已经消除了if-else的结构，每当新来了一种回执，只需要添加新的回执处理策略，并修改ReceiptHandleStrategyFactory中的Map集合。如果要使得程序符合开闭原则，则需要调整ReceiptHandleStrategyFactory中处理策略的获取方式，通过反射的方式，获取指定包下的所有IReceiptHandleStrategy实现类，然后放到字典Map中去.

#### 6.3.5 策略模式总结

**1) 策略模式优点：**

* 策略类之间可以自由切换

  由于策略类都实现同一个接口，所以使它们之间可以自由切换。

* 易于扩展

  增加一个新的策略只需要添加一个具体的策略类即可，基本不需要改变原有的代码，符合“开闭原则“

* 避免使用多重条件选择语句（if else），充分体现面向对象设计思想。

**2) 策略模式缺点：** 

* 客户端必须知道所有的策略类，并自行决定使用哪一个策略类。
* 策略模式将造成产生很多策略类，可以通过使用享元模式在一定程度上减少对象的数量。

**3) 策略模式使用场景**

* 一个系统需要动态地在几种算法中选择一种时，可将每个算法封装到策略类中。

  > 策略模式最大的作用在于分离使用算法的逻辑和算法自身实现的逻辑，这样就意味着当我们想要优化算法自身的实现逻辑时就变得非常便捷，一方面可以采用最新的算法实现逻辑，另一方面可以直接弃用旧算法而采用新算法。使用策略模式能够很方便地进行替换。

* 一个类定义了多种行为，并且这些行为在这个类的操作中以多个条件语句的形式出现，可将每个条件分支移入它们各自的策略类中以代替这些条件语句。

  > 在实际开发中，有许多算法可以实现某一功能，如查找、排序等，通过 if-else 等条件判断语句来进行选择非常方便。但是这就会带来一个问题：当在这个算法类中封装了大量查找算法时，该类的代码就会变得非常复杂，维护也会突然就变得非常困难。虽然策略模式看上去比较笨重，但实际上在每一次新增策略时都通过新增类来进行隔离，短期虽然不如直接写 if-else 来得效率高，但长期来看，维护单一的简单类耗费的时间其实远远低于维护一个超大的复杂类。

* 系统要求使用算法的客户不应该知道其操作的数据时，可使用策略模式来隐藏与算法相关的数据结构。

  > 如果我们不希望客户知道复杂的、与算法相关的数据结构,在具体策略类中封装算法与相关数据结构,可以提高算法的保密性与安全性.

**设计原则和思想其实比设计模式更加的普适和重要,掌握了代码的设计原则和思想,我们自然而然的就可以使用到设计模式,还有可能自己创建出一种新的设计模式.**



### 6.4 职责链模式

#### 6.4.1 职责链模式介绍

**职责链模式(chain of responsibility pattern) 定义: 避免将一个请求的发送者与接收者耦合在一起,让多个对象都有机会处理请求.将接收请求的对象连接成一条链,并且沿着这条链传递请求,直到有一个对象能够处理它为止.**

在职责链模式中，多个处理器（也就是刚刚定义中说的“接收对象”）依次处理同一个请 求。一个请求先经过 A 处理器处理，然后再把请求传递给 B 处理器，B 处理器处理完后再 传递给 C 处理器，以此类推，形成一个链条。链条上的每个处理器各自承担各自的处理职 责，所以叫作职责链模式。

<img src="马士兵-学习笔记-沈俊杰.assets/113.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

#### 6.4.2 职责链模式原理

职责链模式结构

<img src="马士兵-学习笔记-沈俊杰.assets/114.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

职责链模式主要包含以下角色:

* 抽象处理者（Handler）角色：定义一个处理请求的抽象类，包含抽象处理方法和一个后继连接(链上的每个处理者都有一个成员变量来保存对于下一处理者的引用,比如上图中的successor) 。
* 具体处理者（Concrete Handler）角色：实现抽象处理者的处理方法，判断能否处理本次请求，如果可以处理请求则处理，否则将该请求转给它的后继者。
* 客户类（Client）角色：创建处理链，并向链头的具体处理者对象提交请求，它不关心处理细节和请求的传递过程。

#### 6.4.3 职责链模式实现

责任链模式的实现非常简单，每一个具体的处理类都会保存在它之后的下一个处理类。当处理完成后，就会调用设置好的下一个处理类，直到最后一个处理类不再设置下一个处理类，这时处理链条全部完成。

```java
/**
 * 处理者要处理的数据
 **/
public class RequestData {
    private String data;

    public RequestData(String data) {
        this.data = data;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }
}


/**
 * 抽象处理者类（Handler）
 **/
public abstract class Handler {

    protected Handler successor = null;

    public void setSuccessor(Handler successor){
        this.successor = successor;
    }

    public abstract void handle(RequestData requestData);
}

/**
 * 具体处理者（Concrete Handler）
 **/
public class HandlerA extends Handler {

    @Override
    public void handle(RequestData requestData) {
        System.out.println("HandlerA 执行代码逻辑! 处理: " + requestData.getData());

        requestData.setData(requestData.getData().replace("A", ""));
        if (successor != null) {
            successor.handle(requestData);
        } else {
            System.out.println("执行中止!");
        }
    }
}

/**
 * 具体处理者（Concrete Handler）
 **/
public class HandlerB extends Handler {

    @Override
    public void handle(RequestData requestData) {
        System.out.println("HandlerB 执行代码逻辑! 处理: " + requestData.getData());

        requestData.setData(requestData.getData().replace("B", ""));
        if (successor != null) {
            successor.handle(requestData);
        } else {
            System.out.println("执行中止!");
        }
    }
}

public class HandlerC extends Handler {

    @Override
    public void handle(RequestData requestData) {
        System.out.println("HandlerC 执行代码逻辑! 处理: " + requestData.getData());

        requestData.setData(requestData.getData());
        if (successor != null) {
            successor.handle(requestData);
        } else {
            System.out.println("执行中止!");
        }
    }
}

public class Client {

    public static void main(String[] args) {
        Handler h1 = new HandlerA();
        Handler h2 = new HandlerB();
        Handler h3 = new HandlerC();
        h1.setSuccessor(h2);
        h2.setSuccessor(h3);
        RequestData requestData = new RequestData("请求数据ABCDE");
        h1.handle(requestData);
    }
}
```

#### 6.4.4 职责链模式应用实例

接下来我们模拟有一个双11期间,业务系统审批的流程,临近双十一公司会有陆续有一些新的需求上线,为了保证线上系统的稳定,我们对上线的审批流畅做了严格的控制.审批的过程会有不同级别的负责人加入进行审批(平常系统上线只需三级负责人审批即可,双十一前后需要二级或一级审核人参与审批),接下来我们就使用职责链模式来设计一下此功能.

<img src="马士兵-学习笔记-沈俊杰.assets/116.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

**1) 不使用设计模式**

```java
/**
 * 审核信息
 * @author spikeCong
 * @date 2022/10/14
 **/
public class AuthInfo {

    private String code;

    private String info ="";

    public AuthInfo(String code, String... infos) {
        this.code = code;
        for (String str : infos) {
            info = this.info.concat(str +" ");
        }
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

    @Override
    public String toString() {
        return "AuthInfo{" +
                "code='" + code + '\'' +
                ", info='" + info + '\'' +
                '}';
    }
}

/**
 * 模拟审核服务
 * @author spikeCong
 * @date 2022/10/14
 **/
public class AuthService {

    //审批信息 审批人Id+申请单Id
    private static Map<String,Date> authMap = new HashMap<String, Date>();

    /**
     * 审核流程
     * @param uId    审核人id
     * @param orderId  审核单id
     */
    public static void auth(String uId, String orderId){
        System.out.println("进入审批流程,审批人ID: " + uId);
        authMap.put(uId.concat(orderId),new Date());
    }

    //查询审核结果
    public static Date queryAuthInfo(String uId, String orderId){
        return authMap.get(uId.concat(orderId)); //key=审核人id+审核单子id
    }
}

public class AuthController {

    
    //审核接口
    public AuthInfo doAuth(String name, String orderId, Date authDate) throws ParseException {

        //三级审批
        Date date = null;
        //查询是否存在审核信息,查询条件: 审核人ID+订单ID,返回Map集合中的Date
        date = AuthService.queryAuthInfo("1000013", orderId);

        //如果为空,封装AuthInfo信息(待审核)返回
        if(date == null){
            return new AuthInfo("0001","单号: "+orderId,"状态: 等待三级审批负责人进行审批");
        }

        //二级审批
        SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 时间格式化
        //二级审核人主要审核双十一之前, 11-01 ~ 11-10号的请求,所以要对传入的审核时间进行判断
        //审核时间 大于 2022-11-01 并且  小于 2022-11-10,Date1.after(Date2),当Date1大于Date2时，返回TRUE,Date1.before(Date2)，当Date1小于Date2时，返回TRUE
        if(authDate.after(f.parse("2022-11-01 00:00:00")) && authDate.before(f.parse("2022-11-10 00:00:00"))){
            //条件成立,查询二级审核的审核信息
            date = AuthService.queryAuthInfo("1000012",orderId);
            
            //如果为空,还是待二级审核人审核状态
            if(date == null){
                return new AuthInfo("0001","单号: "+orderId,"状态: 等待二级审批负责人进行审批");
            }
        }

        //一级审批
        //审核范围是在11-11日 ~ 11-31日
        if(authDate.after(f.parse("2022-11-11 00:00:00")) && authDate.before(f.parse("2022-11-31 00:00:00"))){
            date = AuthService.queryAuthInfo("1000011",orderId);
            if(date == null){
                return new AuthInfo("0001","单号: "+orderId,"状态: 等待一级审批负责人进行审批");
            }
        }

        
       return new AuthInfo("0001","单号: "+orderId,"申请人:"+ name +", 状态: 审批完成!");
    }
}

public class Client {

    public static void main(String[] args) throws ParseException {

        AuthController controller = new AuthController();

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = sdf.parse("2022-11-12 00:00:00");

        //设置申请流程

        //三级审核
        //1.调用doAuth方法,模拟发送申请人相关信息
        AuthInfo info1 = controller.doAuth("研发小周", "100001000010000", date);
        System.out.println("当前审核状态:  " + info1.getInfo());

        /**
         * 2.模拟进行审核操作, 虚拟审核人ID: 1000013
         * 调用auth() 方法进行审核操作, 就是向Map中添加一个 审核人ID和申请单ID
         */
        AuthService.auth("1000013", "100001000010000");
        System.out.println("三级负责人审批完成,审批人: 王工");

        System.out.println("===========================================================================");

        //二级审核
        //1.调用doAuth方法,模拟发送申请人相关信息
        AuthInfo info2 = controller.doAuth("研发小周", "100001000010000", date);
        System.out.println("当前审核状态:  " + info2.getInfo());

        /**
         * 2.模拟进行审核操作, 虚拟审核人ID: 1000012
         * 调用auth() 方法进行审核操作, 就是向Map中添加一个 审核人ID和申请单ID
         */
        AuthService.auth("1000012", "100001000010000");
        System.out.println("二级负责人审批完成,审批人: 张经理");

        System.out.println("===========================================================================");

        //一级审核
        //1.调用doAuth方法,模拟发送申请人相关信息
        AuthInfo info3 = controller.doAuth("研发小周", "100001000010000", date);
        System.out.println("当前审核状态:  " + info3.getInfo());

        /**
         * 2.模拟进行审核操作, 虚拟审核人ID: 1000012
         * 调用auth() 方法进行审核操作, 就是向Map中添加一个 审核人ID和申请单ID
         */
        AuthService.auth("1000011", "100001000010000");
        System.out.println("一级负责人审批完成,审批人: 罗总");
    }
}
```

**2 ) 职责链模式重构代码**

下图是为当前业务设计的责任链结构,统一抽象类AuthLink 下 有三个子类,将三个子类的执行通过编排,模拟出一条链路,这个链路就是业务中的责任链.

<img src="马士兵-学习笔记-沈俊杰.assets/115.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

```java
/**
 * 抽象审核链类
 */
public abstract class AuthLink {

    protected Logger logger = LoggerFactory.getLogger(AuthLink.class);

    protected SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    protected String levelUserId;      //审核人ID
    protected String levelUserName;   //审核人姓名
    protected AuthLink next;          //持有下一个处理类的引用

    public AuthLink(String levelUserId, String levelUserName) {
        this.levelUserId = levelUserId;
        this.levelUserName = levelUserName;
    }

    //获取下一个处理类
    public AuthLink getNext() {
        return next;
    }

    //责任链中添加处理类
    public AuthLink appendNext(AuthLink next) {
        this.next = next;
        return this;
    }

    //抽象审核方法
    public abstract AuthInfo doAuth(String uId, String orderId, Date authDate);
}

/*
 * 一级负责人
 */
public class Level1AuthLink extends AuthLink {

    private Date beginDate = f.parse("2020-11-11 00:00:00");
    private Date endDate = f.parse("2020-11-31 23:59:59");

    public Level1AuthLink(String levelUserId, String levelUserName) throws ParseException {
        super(levelUserId, levelUserName);
    }

    @Override
    public AuthInfo doAuth(String uId, String orderId, Date authDate) {
        Date date = AuthService.queryAuthInfo(levelUserId, orderId);
        if (null == date) {
            return new AuthInfo("0001", "单号：", orderId, " 状态：待一级审批负责人 ", levelUserName);
        }
        AuthLink next = super.getNext();
        if (null == next) {
            return new AuthInfo("0000", "单号：", orderId, " 状态：一级审批完成", " 时间：", f.format(date), " 审批人：", levelUserName);
        }
        if (authDate.before(beginDate) || authDate.after(endDate)) {
            return new AuthInfo("0000", "单号：", orderId, " 状态：一级审批完成", " 时间：", f.format(date), " 审批人：", levelUserName);
        }
        return next.doAuth(uId, orderId, authDate);
    }
}

/**
 * 二级负责人
 */
public class Level2AuthLink extends AuthLink {

    private Date beginDate = f.parse("2020-11-11 00:00:00");
    private Date endDate = f.parse("2020-11-31 23:59:59");

    public Level2AuthLink(String levelUserId, String levelUserName) throws ParseException {
        super(levelUserId, levelUserName);
    }

    public AuthInfo doAuth(String uId, String orderId, Date authDate) {
        Date date = AuthService.queryAuthInfo(levelUserId, orderId);
        if (null == date) {
            return new AuthInfo("0001", "单号：", orderId, " 状态：待二级审批负责人 ", levelUserName);
        }
        AuthLink next = super.getNext();
        if (null == next) {
            return new AuthInfo("0000", "单号：", orderId, " 状态：二级审批完成", " 时间：", f.format(date), " 审批人：", levelUserName);
        }

        if (authDate.before(beginDate) || authDate.after(endDate) ) {
            return new AuthInfo("0000", "单号：", orderId, " 状态：二级审批完成", " 时间：", f.format(date), " 审批人：", levelUserName);
        }

        return next.doAuth(uId, orderId, authDate);
    }

}

/**
 * 三级负责人
 */
public class Level3AuthLink extends AuthLink {

    public Level3AuthLink(String levelUserId, String levelUserName) {
        super(levelUserId, levelUserName);
    }

    public AuthInfo doAuth(String uId, String orderId, Date authDate) {
        Date date = AuthService.queryAuthInfo(levelUserId, orderId);
        if (null == date) {
            return new AuthInfo("0001", "单号：", orderId, " 状态：待三级审批负责人 ", levelUserName);
        }
        AuthLink next = super.getNext();
        if (null == next) {
            return new AuthInfo("0000", "单号：", orderId, " 状态：三级审批完成", " 时间：", f.format(date), " 审批人：", levelUserName);
        }

        return next.doAuth(uId, orderId, authDate);
    }

}


```

测试

```java
public class Client {

    private Logger logger = LoggerFactory.getLogger(ApiTest.class);

    @Test
    public void test_AuthLink() throws ParseException {

        AuthLink authLink = new Level3AuthLink("1000013", "王工")
                .appendNext(new Level2AuthLink("1000012", "张经理")
                        .appendNext(new Level1AuthLink("1000011", "段总")));

        SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date currentDate = f.parse("2020-11-18 23:49:46");

        logger.info("测试结果：{}", JSON.toJSONString(authLink.doAuth("研发牛马", "1000998004813441", currentDate)));

        // 模拟三级负责人审批
        AuthService.auth("1000013", "1000998004813441");
        logger.info("测试结果：{}", "模拟三级负责人审批，王工");
        logger.info("测试结果：{}", JSON.toJSONString(authLink.doAuth("研发牛马", "1000998004813441", currentDate)));

        // 模拟二级负责人审批
        AuthService.auth("1000012", "1000998004813441");
        logger.info("测试结果：{}", "模拟二级负责人审批，张经理");
        logger.info("测试结果：{}", JSON.toJSONString(authLink.doAuth("研发牛马", "1000998004813441", currentDate)));

        // 模拟一级负责人审批
        AuthService.auth("1000011", "1000998004813441");
        logger.info("测试结果：{}", "模拟一级负责人审批，段总");
        logger.info("测试结果：{}", JSON.toJSONString(authLink.doAuth("研发牛马", "1000998004813441", currentDate)));

    }
}
```

从上面的代码结果看,我们的责任链已经生效,按照责任链的结构一层一层审批.当工作流程发生变化，可以动态地改变链内的成员或者修改它们的次序，也可动态地新增或者删除责任。并且每个类只需要处理自己该处理的工作，不能处理的传递给下一个对象完成，明确各类的责任范围，符合类的单一职责原则。

#### 6.4.5 职责链模式总结

**1) 职责链模式的优点：**

* 降低了对象之间的耦合度

  该模式降低了请求发送者和接收者的耦合度。

* 增强了系统的可扩展性

  可以根据需要增加新的请求处理类，满足开闭原则。

* 增强了给对象指派职责的灵活性

  当工作流程发生变化，可以动态地改变链内的成员或者修改它们的次序，也可动态地新增或者删除责任。

* 责任链简化了对象之间的连接

  一个对象只需保持一个指向其后继者的引用，不需保持其他所有处理者的引用，这避免了使用众多的 if 或者 if···else 语句。

* 责任分担

  每个类只需要处理自己该处理的工作，不能处理的传递给下一个对象完成，明确各类的责任范围，符合类的单一职责原则。

**2) 职责链模式的缺点:** 

* 不能保证每个请求一定被处理。由于一个请求没有明确的接收者，所以不能保证它一定会被处理，该请求可能一直传到链的末端都得不到处理。
* 对比较长的职责链，请求的处理可能涉及多个处理对象，系统性能将受到一定影响。
* 职责链建立的合理性要靠客户端来保证，增加了客户端的复杂性，可能会由于职责链的错误设置而导致系统出错，如可能会造成循环调用。

**3) 使用场景分析**

责任链模式常见的使用场景有以下几种情况。

- 在运行时需要动态使用多个关联对象来处理同一次请求时。比如，请假流程、员工入职流程、编译打包发布上线流程等。
- 不想让使用者知道具体的处理逻辑时。比如，做权限校验的登录拦截器。
- 需要动态更换处理对象时。比如，工单处理系统、网关 API 过滤规则系统等。
- 职责链模式常被用在框架开发中,用来实现框架的过滤器、拦截器功能,让框架的使用者在不修改源码的情况下,添加新的过滤拦截功能. 



### 6.5 状态模式

#### 6.5.1 状态模式介绍

自然界很多事物都有多种状态,而且不同状态下会具有不同的行为,这些状态在特定条件下还会发生相互转换,比如水

​								<img src="马士兵-学习笔记-沈俊杰.assets/117.jpg" alt="image-20220530160637842" style="zoom: 100%;" /> 

在软件系统中,有些对象也像水一样具有多种状态,这些状态在某些情况下能够相互转换,而且对象在不同状态下也将具有不同的行为.

**状态模式(state pattern)的定义:  允许一个对象在其内部状态改变时改变它的行为. 对象看起来似乎修改了它的类.**

**状态模式**就是用于解决系统中复杂对象的状态转换以及不同状态下行为的封装问题. 状态模式将一个对象的状态从该对象中分离出来,封装到专门的状态类中(用类来表示状态) ,使得对象状态可以灵活变化.

#### 6.5.2 状态模式结构

状态模式结构图:

<img src="马士兵-学习笔记-沈俊杰.assets/118.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

从这个 UML 图中，我们能看出状态模式包含的关键角色有三个。

- 上下文信息类（Context）：实际上就是存储当前状态的类，对外提供更新状态的操作。在该类中维护着一个抽象状态接口State实例,这个实例定义当前状态.

- 抽象状态类（State）：可以是一个接口或抽象类，用于定义声明状态更新的操作方法有哪些,具体实现由子类完成。

- 具体状态类（StateA 等）：实现抽象状态类定义的方法，根据具体的场景来指定对应状态改变后的代码实现逻辑。

#### 6.5.3 状态模式实现

代码示例

```java
/**
 * 抽象状态接口
 **/
public interface State {
    //声明抽象方法,不同具体状态类可以有不同实现
    void handle(Context context);
}

/**
 * 上下文类
 **/
public class Context {

    private State currentState; //维持一个对状态对象的引用

    public Context() {
        this.currentState = null;
    }

    public State getCurrentState() {
        return currentState;
    }

    public void setCurrentState(State currentState) {
        this.currentState = currentState;
    }

    @Override
    public String toString() {
        return "Context{" +
                "currentState=" + currentState +
                '}';
    }
}

public class ConcreteStateA implements State {

    @Override
    public void handle(Context context) {
        System.out.println("进入状态模式A......");
        context.setCurrentState(this);
    }

    @Override
    public String toString() {
        return "当前状态: ConcreteStateA";
    }
}

public class ConcreteStateB implements State{

    @Override
    public void handle(Context context) {
        System.out.println("进入状态模式B......");
        context.setCurrentState(this);
    }

    @Override
    public String toString() {
        return "当前状态: ConcreteStateB";
    }
}


public class Client {
    public static void main(String[] args) {
        Context context = new Context();
        State state1 = new ConcreteStateA();
        state1.handle(context);
        System.out.println(context.getCurrentState().toString());
        System.out.println("========================");

        State state2 = new ConcreteStateB();
        state2.handle(context);
        System.out.println(context.getCurrentState().toString());
    }
}
```

#### 6.5.4 状态模式应用实例

模拟交通信号灯的状态转换. 交通信号灯一般包括了红、黄、绿3种颜色状态,不同状态之间的切换逻辑为: 红灯只能切换为黄灯,黄灯可以切换为绿灯或红灯,绿灯只能切换为黄灯.

​                                                              <img src="马士兵-学习笔记-沈俊杰.assets/119.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

**1) 不使用设计模式** 

```java
/**
 * 交通信号灯切换-不用设计模式实现<br>
 * 红灯(禁行) ,黄灯(警示),绿灯(通行) 三种状态.<br>
 */
public class TrafficLight {
    //初始状态红灯
    private String state = "红";

    //切换为绿灯(通行)状态
    public void switchToGreen() {
        if ("绿".equals(state)) {//当前是绿灯
            System.out.println("当前为绿灯状态,无需切换!");
        } else if ("红".equals(state)) {
            System.out.println("红灯不能切换为绿灯!");
        } else if ("黄".equals(state)) {
            state = "绿";
            System.out.println("绿灯亮起...时长: 60秒");
        }
    }

    //切换为黄灯(警示)状态
    public void switchToYellow() {
        if ("黄".equals(state)) {//当前是黄灯
            System.out.println("当前为黄灯状态,无需切换!");
        } else if ("红".equals(state) || "绿".equals(state)) {
            state = "黄";
            System.out.println("黄灯亮起...时长:10秒");
        }
    }

    //切换为黄灯(警示)状态
    public void switchToRed() {
        if ("红".equals(state)) {//当前是绿灯
            System.out.println("当前为红灯状态,无需切换!");
        } else if ("绿".equals(state)) {
            System.out.println("绿灯不能切换为红灯!");
        } else if ("黄".equals(state)) {
            state = "红";
            System.out.println("红灯亮起...时长: 90秒");
        }
    }
}
```

问题：状态切换的操作全部在一个类中。如果有很多的交通灯进行联动，这个程序的逻辑就会变得非常复杂,难以维护.

**2) 使用状态模式,将交通灯的切换逻辑组织起来,把跟状态有关的内容从交通灯类里抽离出来,使用类来表示不同的状态.**

```java
/**
 * 上下文信息类-交通灯类 <br>
 *    红灯(禁行) ,黄灯(警示),绿灯(通行) 三种状态.<br>
 **/
public class TrafficLight {

    //初始状态红灯
    State state = new Red();

    public void setState(State state) {
        this.state = state;
    }

    //切换为绿灯状态
    public void switchToGreen(){
        state.switchToGreen(this);
    }

    //切换为黄灯状态
    public void switchToYellow(){
        state.switchToYellow(this);
    }

    //切换为红灯状态
    public void switchToRed(){
        state.switchToRed(this);
    }
}

/**
 * 抽象状态类-交通灯状态接口
 **/
public interface State {

    void switchToGreen(TrafficLight trafficLight); //切换为绿灯

    void switchToYellow(TrafficLight trafficLight); //切换为黄灯

    void switchToRed(TrafficLight trafficLight); //切换为红灯
}

/**
 * 红灯状态类
 **/
public class Red implements State {

    @Override
    public void switchToGreen(TrafficLight trafficLight) {
        System.out.println("红灯不能切换为绿灯!");
    }

    @Override
    public void switchToYellow(TrafficLight trafficLight) {
        System.out.println("黄灯亮起...时长:10秒!");
    }

    @Override
    public void switchToRed(TrafficLight trafficLight) {
        System.out.println("已是红灯状态无须再切换!");
    }
}

/**
 * 绿灯状态类
 **/
public class Green implements State {

    @Override
    public void switchToGreen(TrafficLight trafficLight) {
        System.out.println("已是绿灯无须切换!");
    }

    @Override
    public void switchToYellow(TrafficLight trafficLight) {
        System.out.println("黄灯亮起...时长:10秒!");
    }

    @Override
    public void switchToRed(TrafficLight trafficLight) {
        System.out.println("绿灯不能切换为红灯!");
    }
}

/**
 * 黄灯状态类
 **/
public class Yellow implements State {

    @Override
    public void switchToGreen(TrafficLight trafficLight) {
        System.out.println("绿灯亮起...时长:60秒!");
    }

    @Override
    public void switchToYellow(TrafficLight trafficLight) {
        System.out.println("已是黄灯无须切换!");
    }

    @Override
    public void switchToRed(TrafficLight trafficLight) {
        System.out.println("红灯亮起...时长:90秒!");
    }
}

public class Client {

    public static void main(String[] args) {
        TrafficLight trafficLight = new TrafficLight();
        trafficLight.switchToYellow();
        trafficLight.switchToGreen();
        trafficLight.switchToRed();
    }
}
```

通过代码重构，将"状态" 接口化、模块化。最终将它们从臃肿的交通类中抽了出来，消除了原来TrafficLight类中的if...else。代码看起来干净而优雅。

#### 6.5.5 状态模式总结

**1) 状态模式的优点：**

* 将所有与某个状态有关的行为放到一个类中，并且可以方便地增加新的状态，只需要改变对象状态即可改变对象的行为。
* 允许状态转换逻辑与状态对象合成一体，而不是某一个巨大的条件语句块。

**2) 状态模式的缺点:**

* 状态模式的使用必然会增加系统类和对象的个数。 
* 状态模式的结构与实现都较为复杂，如果使用不当将导致程序结构和代码的混乱。
* 状态模式对"开闭原则"的支持并不太好 (添加新的状态类需要修改那些负责状态转换的源代码)。

**3) 状态模式常见的使用场景:**

- 对象根据自身状态的变化来进行不同行为的操作时， 比如，购物订单状态。
- 对象需要根据自身变量的当前值改变行为，不期望使用大量 if-else 语句时， 比如，商品库存状态。
- 对于某些确定的状态和行为，不想使用重复代码时， 比如，某一个会员当天的购物浏览记录。



### 6.6 迭代器模式

#### 6.6.1 迭代器模式介绍

迭代器模式是我们学习一个设计时很少用到的、但编码实现时却经常使用到的行为型设计模式。在绝大多数编程语言中，迭代器已经成为一个基础的类库，直接用来遍历集合对象。在平时开发中，我们更多的是直接使用它，很少会从零去实现一个迭代器。

**迭代器模式(Iterator pattern)又叫游标（Cursor）模式，它的原始定义是：迭代器提供一种对容器对象中的各个元素进行访问的方法，而又不需要暴露该对象的内部细节。**

<img src="马士兵-学习笔记-沈俊杰.assets/120.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

在软件系统中,容器对象拥有两个职责: 一是存储数据,而是遍历数据.从依赖性上看,前者是聚合对象的基本职责.而后者是可变化的,又是可分离的.因此可以将遍历数据的行为从容器中抽取出来,封装到迭代器对象中,由迭代器来提供遍历数据的行为,这将简化聚合对象的设计,更加符合单一职责原则

#### 6.6.2 迭代器模式原理

**迭代器模式结构图**

<img src="马士兵-学习笔记-沈俊杰.assets/121.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

迭代器模式主要包含以下角色：

* 抽象集合（Aggregate）角色：用于存储和管理元素对象, 定义存储、添加、删除集合元素的功能,并且声明了一个createIterator()方法用于创建迭代器对象。
* 具体集合（ConcreteAggregate）角色：实现抽象集合类，返回一个具体迭代器的实例。
* 抽象迭代器（Iterator）角色：定义访问和遍历聚合元素的接口，通常包含 hasNext()、next() 等方法。
  * hasNext()函数用于判断集合中是否还有下一个元素
  * next() 函数用于将游标后移一位元素
  * currentItem() 函数,用来返回当前游标指向的元素
* 具体迭代器（Concretelterator）角色：实现抽象迭代器接口中所定义的方法，完成对集合对象的遍历，同时记录遍历的当前位置。

#### 6.6.3 迭代器模式实现

```java
/**
 * 迭代器接口
 * @author spikeCong
 * @date 2022/10/18
 **/
public interface Iterator<E> {

    //判断集合中是否有下一个元素
    boolean hasNext();

    //将游标后移一位元素
    void next();

    //返回当前游标指定的元素
    E currentItem();
}

/**
 * 具体迭代器
 * @author spikeCong
 * @date 2022/10/18
 **/
public class ConcreteIterator<E> implements Iterator<E>{

    private int cursor; //游标

    private ArrayList<E> arrayList; //容器

    public ConcreteIterator(ArrayList<E> arrayList) {
        this.cursor = 0;
        this.arrayList = arrayList;
    }

    @Override
    public boolean hasNext() {
        return cursor != arrayList.size();
    }

    @Override
    public void next() {
        cursor++;
    }

    @Override
    public E currentItem() {
        if(cursor >= arrayList.size()){
            throw new NoSuchElementException();
        }
        return arrayList.get(cursor);
    }
}

public class Test01 {


    public static void main(String[] args) {

        ArrayList<String> names = new ArrayList<>();
        names.add("lisi");
        names.add("zhangsan");
        names.add("wangwu");

        Iterator<String> iterator = new ConcreteIterator(names);
        while(iterator.hasNext()){
            System.out.println(iterator.currentItem());
            iterator.next();
        }

        /**
         * 使用ArrayList集合中的iterator()方法获取迭代器
         * 将创建迭代器的方法放入集合容器中,这样做的好处是对客户端封装了迭代器的实现细节.
         */
        java.util.Iterator<String> iterator1 = names.iterator();
        while(iterator1.hasNext()){
            System.out.println(iterator1.next());
            iterator.next();
        }
    }
}
```

#### 6.6.4 迭代器模式应用实例

为了帮助你更好地理解迭代器模式，下面我们还是通过一个简单的例子给大家演示一下

```java
/**
 * 抽象迭代器 IteratorIterator
 * @author spikeCong
 * @date 2022/10/18
 **/
public interface IteratorIterator<E> {

    void reset();   //重置为第一个元素
    E next();   //获取下一个元素
    E currentItem();    //检索当前元素
    boolean hasNext();  //判断是否还有下一个元素存在
}


/**
 * 抽象集合 ListList
 * @author spikeCong
 * @date 2022/10/18
 **/
public interface ListList<E> {

    //获取迭代器对象的抽象方法(面向接口编程)
    IteratorIterator<E> Iterator();
}

/**
 * 主题类
 * @author spikeCong
 * @date 2022/10/18
 **/
public class Topic {

    private String name;

    public Topic(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}

/**
 * 具体迭代器
 * @author spikeCong
 * @date 2022/10/18
 **/
public class TopicIterator implements IteratorIterator<Topic> {

    //Topic数组
    private Topic[] topics;

    //记录存储位置
    private int position;

    public TopicIterator(Topic[] topics) {
        this.topics = topics;
        position = 0;
    }

    @Override
    public void reset() {
        position = 0;
    }

    @Override
    public Topic next() {
        return topics[position++];
    }

    @Override
    public Topic currentItem() {
        return topics[position];
    }

    @Override
    public boolean hasNext() {
        if(position >= topics.length){
            return false;
        }
        return true;
    }
}

/**
 * 具体集合类
 * @author spikeCong
 * @date 2022/10/18
 **/
public class TopicList implements ListList<Topic> {

    private Topic[] topics;

    public TopicList(Topic[] topics) {
        this.topics = topics;
    }

    @Override
    public IteratorIterator<Topic> Iterator() {
        return new TopicIterator(topics);
    }
}

public class Client {

    public static void main(String[] args) {

        Topic[] topics = new Topic[4];
        topics[0] = new Topic("topic1");
        topics[1] = new Topic("topic2");
        topics[2] = new Topic("topic3");
        topics[3] = new Topic("topic4");

        TopicList topicList = new TopicList(topics);
        IteratorIterator<Topic> iterator = topicList.Iterator();

        while(iterator.hasNext()){
            Topic t = iterator.next();
            System.out.println(t.getName());
        }
    }
}
```

#### 6.6.5 迭代器模式总结

**1) 迭代器的优点:**

* 迭代器模式支持以不同方式遍历一个集合对象,在同一个集合对象上可以定义多种遍历方式. 在迭代器模式中只需要用一个不同的迭代器来替换原有的迭代器,即可改变遍历算法,也可以自己定义迭代器的子类以支持新的遍历方式.
* 迭代器简化了集合类。由于引入了迭代器，在原有的集合对象中不需要再自行提供数据遍历等方法，这样可以简化集合类的设计。
* 在迭代器模式中，由于引入了抽象层，增加新的集合类和迭代器类都很方便，无须修改原有代码，满足 "基于接口编程而非实现" 和 "开闭原则" 的要求。

**2) 迭代器的缺点：**

- 迭代器模式将存储数据和遍历数据的职责分离，增加新的聚合类需要对应增加新的迭代器类，类的个数成对增加，这在一定程度上增加了系统的复杂性。
- 对于比较简单的遍历，使用迭代器模式显得较为繁琐，比如ArrayList直接就可以用for循环+get() 方法来遍历；
- 抽象迭代器的设计难度较大，需要充分考虑到系统将来的扩展，例如JDK内置迭代器Iterator就无法实现逆向遍历，如果需要实现逆向遍历，只能通过其子类ListIterator等来实现，而ListIterator迭代器无法用于操作Set类型的聚合对象。在自定义迭代器时，创建一个考虑全面的抽象迭代器并不是件很容易的事情。

**3) 使用场景**

* 访问一个集合对象的内容而无须暴露它的内部表示

* 需要为集合对象提供多种遍历方式

* 为遍历不同的聚合结构提供一个统一的接口。

  > 由于容器与迭代器的关系太密切了，所以大多数语言在实现容器的时候都给提供了迭代器，并且这些语言提供的容器和迭代器在绝大多数情况下就可以满足我们的需要，所以现在需要我们自己去实践迭代器模式的场景还是比较少见的，我们只需要使用语言中已有的容器和迭代器就可以了



### 6.7 访问者模式

#### 6.7.1 访问者模式介绍

访问者模式的目的是封装一些施加于某种数据结构元素之上的操作。一旦这些操作需要修改的话，接受这个操作的数据结构则可以保持不变。

访问者模式在实际开发中使用的非常少，因为它比较难以实现并且应用该模式肯能会导致代码的可读性变差，可维护性变差，在没有特别必要的情况下，不建议使用访问者模式。

访问者模式，重点在于访问二字。说到访问，我们脑海中必定会想起新闻访谈，两个人面对面坐在一起。从字面上的意思理解：其实就相当于被访问者（某个公众人物）把访问者（记者）当成了外人，不想你随便动。你想要什么，我先准备好弄好之后再给你（调用你的方法）。

**什么是访问者模式？**

访问者模式的定义如下所示，说的是在不改变数据结构的提前下，定义新操作。

- 封装一些作用于某种数据结构中的各元素的操作，它可以在不改变数据结构的前提下定义作用于这些元素的新的操作。

但在实际的应用中，有些例子并不是如此。有些例子中并没有稳定的数据结构，而是稳定的算法。访问者模式应该是：把不变的固定起来，变化的开放出去。

#### 6.7.2 访问者模式原理

<img src="马士兵-学习笔记-沈俊杰.assets/122.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

访问者模式包含以下主要角色:

* 抽象访问者（Visitor）角色：定义了对每一个元素（Element）访问的行为，它的参数就是可以访问的元素，它的方法个数理论上来讲与元素类个数（Element的实现类个数）是一样的，从这点不难看出，访问者模式要求元素类的个数不能改变。
* 具体访问者（ConcreteVisitor）角色： 具体访问者实现了每个由抽象访问者声明的操作，每一个操作用于访问对象结构中一种类型的元素。
* 抽象元素（Element）角色：定义了一个接受访问者的方法（accept），其意义是指，每一个元素都要可以被访问者访问。
* 具体元素（ConcreteElement）角色： 提供接受访问方法的具体实现，而这个具体的实现，通常情况下是使用访问者提供的访问该元素类的方法。
* 对象结构（ObjectStructure）角色： 对象结构是一个元素的集合，它用于存放元素对象，并且提供了遍历其内部元素的方法。它可以结合组合模式来实现，也可以是一个简单的集合对象，如一个List对象或一个Set对象。

对于访问者模式来说，最重要的莫过于 Visitor、ConcreteVisitor、Element 这三个类了。Visitor、ConcreteVisitor 定义访问者具体能做的事情，被访问者的参数通过参数传递给访问者。Element  则通过各种方法拿到被访问者对象，常用的是通过 accept () 方法，但这并不是绝对的。

*需要注意的是，我们学习设计模式重点是理解类与类之间的关系，以及他们传递的信息。至于是通过什么方式传递的，是通过 accept () 方法，还是通过构造函数，都不是重点。*



#### 6.7.3 访问者模式实现

##### 标准代码示例

```java
/**
 * 抽象元素有两类方法，
 * 一是本身的业务逻辑，也就是元素作为一个业务处理单元必须完成的职责;
 * 另外一个是允许哪一个访问者来访问。这里只声明的第二类即accept方法。
 */
public interface Element {
    void accept(Visitor visitor);
}


//具体元素A类
public class ConcreteElementA implements Element {
    @Override
    public void accept(Visitor visitor) {
        visitor.visit(this);
    }

    public String operationA() {
        return "具体元素A的操作。";
    }
}


//具体元素B类
public class ConcreteElementB implements Element {
    @Override
    public void accept(Visitor visitor) {
        visitor.visit(this);
    }

    public String operationB() {
        return "具体元素B的操作。";
    }
}


/**
 * 此处可为抽象类或接口，用于声明访问者可以访问哪些元素。
 * 具体到程序中就是visit方法的参数定义哪些对象是可以被访问的。
 */
public interface Visitor {
    void visit(ConcreteElementA element);
    void visit(ConcreteElementB element);
}

/**
 * 具体访问者，当访问到一个类后该干什么、怎么千。
 */
public class ConcreteVisitorA implements Visitor {
    @Override
    public void visit(ConcreteElementA element) {
        System.out.println("具体访问者A访问-->" + element.operationA());
    }
    @Override
    public void visit(ConcreteElementB element) {
        System.out.println("具体访问者A访问-->" + element.operationB());
    }
}


//具体访问者B类
public class ConcreteVisitorB implements Visitor {
    @Override
    public void visit(ConcreteElementA element) {
        System.out.println("具体访问者B访问-->" + element.operationA());
    }
    @Override
    public void visit(ConcreteElementB element) {
        System.out.println("具体访问者B访问-->" + element.operationB());
    }
}

/**
 * 元素生产者，一般容纳在多个不同类、不同接口的容器，如List、Set、Map等，在项目中一般很少抽象出这个角色。
 */
public class ObjectStructure {
    private List<Element> list = new ArrayList<Element>();

    public void accept(Visitor visitor) {
        Iterator<Element> i = list.iterator();
        while (i.hasNext()) {
            ((Element) i.next()).accept(visitor);
        }
    }

    public void add(Element element) {
        list.add(element);
    }
    
    public void remove(Element element) {
        list.remove(element);
    }
}


//客户端
public class Client {
    public static void main(String[] args) {
        ObjectStructure os = new ObjectStructure();
        os.add(new ConcreteElementA());
        os.add(new ConcreteElementB());
        Visitor visitor = new ConcreteVisitorA();
        os.accept(visitor);
        System.out.println("------------------------");
        visitor = new ConcreteVisitorB();
        os.accept(visitor);
    }
}
```

##### 案例一：老板考核员工

在人事管理系统中，有多个工种的员工和多个老板，不同的老板对同一个员工的关注点是不同的，CTO可能关注的就是技术，CEO可能更注重绩效。

员工就是一个稳定的元素，老板就是变化的，对应概念就是：封装员工的一些操作，可以在不改变员工类的前提下，增加新的老板访问同一个员工。

在访问者模式中包含五个角色，抽象元素、具体元素、抽象访问者、具体访问者、结构元素。

抽象元素：定义一个接受访问的方法accept，参数为访问者对象。

具体元素：提供接受访问者访问的具体实现调用访问者的访问visit，并定义额外的数据操作方法。

抽象访问者：这个角色主要是定义对具体元素的访问方法visit，理论上来说方法数等于元素(固定类型的对象，也就是被访问者)个数。

具体访问者：实现对具体元素的访问visit方法，参数就是具体元素。

结构对象：创建一个数组用来维护元素，并提供一个方法访问所有的元素。

**案例实现**

在一个公司有干活的工程师和管理者，也有抓技术的CTO和管绩效的CEO，CTO和CEO都会访问管理员和工程师，当公司来了新的老板，只需要增加访问者即可。

工程师和管理者就是元素、公司就是结构体、CEO、CTO就是访问者。

抽象元素：

```java
/**
 *  员工 抽象元素 被访问者
 * @author tcy
 * @Date 29-09-2022
 */
public interface ElementAbstract {
    void accept(VisitorAbstract visitor);
}
```

具体元素-工程师：

```typescript
/**
 * 工程师 具体元素 被访问者
 * @author tcy
 * @Date 29-09-2022
 */
public class ElementEngineer implements ElementAbstract {

    private String name;

    private int kpi;

    ElementEngineer(String name){
        this.name = name;
        this.kpi = new Random().nextInt(10);
    }

    public String getName() {
        return name;
    }

    public int getKpi() {
        return kpi;
    }


    @Override
    public void accept(VisitorAbstract visitor) {
        visitor.visit(this);
    }

    public int getCodeLineTotal(){
        return this.kpi * 1000000;
    }
}
```

具体元素-管理者：

```typescript
/**
 * 管理者 具体元素 被访问者
 * @author tcy
 * @Date 29-09-2022
 */
public class ElementManager implements ElementAbstract {
    private String name;

    private int kpi;

    ElementManager(String name){
        this.name = name;
        this.kpi = new Random().nextInt(10);
    }

    public String getName() {
        return name;
    }

    public int getKpi() {
        return kpi;
    }

    @Override
    public void accept(VisitorAbstract visitor) {
        visitor.visit(this);
    }

    public int getProductNum(){
        return this.kpi * 10;
    }

}
```

抽象访问者：

```java
/**
 * 抽象访问者
 * @author tcy
 * @Date 29-09-2022
 */
public interface VisitorAbstract {
    void visit(ElementEngineer engineer);

    void visit(ElementManager manager);
}
```

具体访问者-CEO

```typescript
/**
 * 具体访问者CEO
 * @author tcy
 * @Date 29-09-2022
 */
public class VisitorCEO implements VisitorAbstract {
    @Override
    public void visit(ElementEngineer engineer) {
        System.out.println("工程师：" + engineer.getName() + "KPI:" + engineer.getKpi());
    }

    @Override
    public void visit(ElementManager manager) {
        System.out.println("经理：" + manager.getName() + "KPI:" + manager.getKpi() + " 今年共完成项目：" + manager.getProductNum() + "个");
    }
}
```

具体访问者-CTO

```typescript
/**
 * 具体访问者CTO
 * @author tcy
 * @Date 29-09-2022
 */
public class VisitorCTO implements VisitorAbstract {
    @Override
    public void visit(ElementEngineer engineer) {
        System.out.println("工程师：" + engineer.getName() + " 今年代码量" + engineer.getCodeLineTotal() + "行");
    }

    @Override
    public void visit(ElementManager manager) {
        System.out.println("经理：" + manager.getName() + " 今年共完成项目：" + manager.getProductNum() + "个");
    }
}
```

结构体：

```typescript
/**
 * 结构对象
 * @author tcy
 * @Date 29-09-2022
 */
public class Structure {
    List<ElementAbstract> list = new ArrayList<>();

    public Structure addEmployee(ElementAbstract employee){
        list.add(employee);
        return this;
    }

    public void report(VisitorAbstract visitor){
        list.forEach(employee -> {
            employee.accept(visitor);
        });
    }

}
```

客户端：

```java
/**
 * @author tcy
 * @Date 29-09-2022
 */
public class Client {
    public static void main(String[] args) {
        //元素对象
        ElementEngineer engineerZ = new ElementEngineer("小张");
        ElementEngineer engineerW = new ElementEngineer("小王");
        ElementEngineer engineerL = new ElementEngineer("小李");

        ElementManager managerZ = new ElementManager("张总");
        ElementManager managerW = new ElementManager("王总");
        ElementManager managerL = new ElementManager("李总");

        //结构体对象
        Structure structure = new Structure();
        structure.addEmployee(engineerZ).addEmployee(engineerW).addEmployee(engineerL).addEmployee(managerZ).addEmployee(managerW).addEmployee(managerL);
        structure.report(new VisitorCTO());
        System.out.println("---------------------------------------");
        structure.report(new VisitorCEO());


    }
}
```



##### 案例二-记者访问名人

我们举生活中一个例子来聊聊：某科学家接受记着访谈。我们都知道科学家接受访问，肯定是有流程上的限制的，不会让记者随便问。我们假设这个过程是：先问科学家的学校经历，再聊你的工作经历，最后聊你的科研成果。那么在这个过程中，固定的是什么东西呢？固定的是接受采访的流程。变化的是什么呢？变化的是不同的记者，针对学校经历，可能会提不同的问题。

根据我们之前的理解，访问者模式其实就是要把不变的东西固定起来，变化的开放出去。那么对于科学家接受访谈这个事情，我们可以这么将其抽象化。

首先，我们需要有一个 Visitor 类，这里定义了一些外部（记者）可以做的事情（提学校经历、工作经历、科研成就的问题）。

```java
public interface Visitor {
    public void askSchoolExperience(String name);
    public void askWorkExperience(String name);
    public void askScienceAchievement(String name);
}
```

接着声明一个 XinhuaVisitor 类去实现 Visitor 类，这表示是新华社的一个记者（访问者）想去访问科学家。

```java
public class XinhuaVisitor implements Visitor{
    @Override
    public void askSchoolExperience(String name) {
        System.out.printf("请问%s：在学校取得的最大成就是什么？\n", name);
    }

    @Override
    public void askWorkExperience(String name) {
        System.out.printf("请问%s：工作上最难忘的事情是什么？\n", name);
    }

    @Override
    public void askScienceAchievement(String name) {
        System.out.printf("请问%s：最大的科研成果是什么？", name);
    }
}
```

接着声明一个 Scientist 类，表明是一个科学家。科学家通过一个 accept () 方法接收记者（访问者）的访问申请，将其存储起来。科学家定义了一个 interview 方法，将访问的流程固定死了，只有教你问什么的时候，我才会让你（记者）提问。

```java
public class Scientist {

    private Visitor visitor;

    private String name;

    private Scientist(){}

    public Scientist(String name) {
        this.name = name;
    }

    public void accept(Visitor visitor) {
        this.visitor = visitor;
    }

    public void interview(){
        System.out.println("------------访问开始------------");
        System.out.println("---开始聊学校经历---");
        visitor.askSchoolExperience(name);
        System.out.println("---开始聊工作经历---");
        visitor.askWorkExperience(name);
        System.out.println("---开始聊科研成果---");
        visitor.askScienceAchievement(name);
    }
}
```

最后我们声明一个场景类 Client，来模拟访谈这一过程。

```java
public class Client {
    public static void main(String[] args) {
        Scientist yang = new Scientist("杨振宁");
        yang.accept(new XinhuaVisitor());
        yang.interview();
    }
}
```

运行的结果为：

```text
------------访问开始------------
---开始聊学校经历---
请问杨振宁：在学校取得的最大成就是什么？
---开始聊工作经历---
请问杨振宁：工作上最难忘的意见事情是什么？
---开始聊科研成果---
请问杨振宁：最大的科研成果是什么？
```

看到这里，大家对于访问者模式是否有了更感性的认识（把不变的固定起来，变化的开放出去）。在这个例子中，不变的固定的就是访谈流程，变化的就是不同的记者可以提不同的问题。



#### 6.7.4 访问者模式总结

**1) 访问者模式优点：**

* 扩展性好

  在不修改对象结构中的元素的情况下，为对象结构中的元素添加新的功能。

* 复用性好

  通过访问者来定义整个对象结构通用的功能，从而提高复用程度。

* 分离无关行为

  通过访问者来分离无关的行为，把相关的行为封装在一起，构成一个访问者，这样每一个访问者的功能都比较单一。

**2) 访问者模式缺点：** 

* 对象结构变化很困难

  在访问者模式中，每增加一个新的元素类，都要在每一个具体访问者类中增加相应的具体操作，这违背了“开闭原则”。

* 违反了依赖倒置原则

  访问者模式依赖了具体类，而没有依赖抽象类。

**3) 使用场景**

* 当对象的数据结构相对稳定，而操作却经常变化的时候。 比如，上面例子中路由器本身的内部构造（也就是数据结构）不会怎么变化，但是在不同操作系统下的操作可能会经常变化，比如，发送数据、接收数据等。
* 需要将数据结构与不常用的操作进行分离的时候。 比如，扫描文件内容这个动作通常不是文件常用的操作，但是对于文件夹和文件来说，和数据结构本身没有太大关系（树形结构的遍历操作），扫描是一个额外的动作，如果给每个文件都添加一个扫描操作会太过于重复，这时采用访问者模式是非常合适的，能够很好分离文件自身的遍历操作和外部的扫描操作。

* 需要在运行时动态决定使用哪些对象和方法的时候。 比如，对于监控系统来说，很多时候需要监控运行时的程序状态，但大多数时候又无法预知对象编译时的状态和参数，这时使用访问者模式就可以动态增加监控行为。

#### 6.7.5 源码案例

**文件树遍历**

JDK 中有文件操作，我们自然是清楚的。有文件操作，那自然就会有文件夹的遍历操作，即访问某个文件夹下面的所有文件或文件夹。试想一下，如果我们想要打印出某个文件夹下所有文件及文件夹的名字，我们需要怎么做？

很简单的做法，其实就是直接做一个树的遍历，然后将名字打印出来呀！

没错，这确实是正确答案！

那么如果我希望统计一下所有文件及文件夹的个数呢？

那就再遍历一次，然后用一个计数器去一直加一呗！

没错，这也是正确答案！

但你是否发现了这两个过程中，我们有一个相同的操作：遍历文件树。无论是打印文件名，还是计算文件树，我们都需要去遍历文件树。而无论哪一个过程，我们最终要的其实就是访问文件。

还记得我们说过设计模式的本质是什么吗？**设计模式的本质是找出不变的东西，再找出变化的东西，然后找到合适的数据结构（设计模式）去承载这种变化。**

在这个例子里，不变的东西是文件树的遍历，变化的是对于文件的不同访问操作。很显然，访问者模式是比较适合承载这种变化的。我们可以把这种不变的东西（文件树的遍历）固定起来，把变化的东西（文件的具体操作）开放出去。JDK 对于文件树的遍历，其实就是使用访问者模式实现的。

JDK 中声明了一个 FileVisitor 接口，定义了遍历者可以做的操作。

```java
public interface FileVisitor<T> {
    FileVisitResult preVisitDirectory(T dir, BasicFileAttributes attrs);
    FileVisitResult visitFile(T file, BasicFileAttributes attrs)
        throws IOException;
    FileVisitResult visitFileFailed(T file, IOException exc)
        throws IOException;
    FileVisitResult postVisitDirectory(T dir, IOException exc)
        throws IOException;
}
```

FileVisitor 中定义的 visitFile () 方法，其实就是对于文件的访问。被访问者（文件）的信息通过第一个参数 file 传递过来。这样遍历者就可以访问文件的内容了。

SimpleFileVisitor 则是对于 FileVisitor 接口的实现，该类中仅仅是做了简单的参数校验，并没有太过的逻辑。

```java
public class SimpleFileVisitor<T> implements FileVisitor<T> {
    @Override
    public FileVisitResult preVisitDirectory(T dir, BasicFileAttributes attrs)
        throws IOException
    {
        Objects.requireNonNull(dir);
        Objects.requireNonNull(attrs);
        return FileVisitResult.CONTINUE;
    }
    
    @Override
    public FileVisitResult visitFile(T file, BasicFileAttributes attrs)
        throws IOException
    {
        Objects.requireNonNull(file);
        Objects.requireNonNull(attrs);
        return FileVisitResult.CONTINUE;
    }
    //....其他省略
}
```

FileVisitor 类和 SimpleFileVisitor 类对应的就是 UML 类图中的 Visitor 和 ConcreteVisitor 类。而 Element 元素，对应的其实是 JDK 中的 Files 类。

![img](https://pic4.zhimg.com/80/v2-6e0d91146e6f96104847cdc9d1ad39e7_720w.webp)

Files 文件中遍历文件树是通过 walkFileTree () 方法实现的。在 walkFileTree ()  方法中实现了树的遍历，在遍历到文件的时候会通过 visitor 类的 visitFile  方法调用遍历者的方法，将遍历到的文件传递给遍历者，从而达到分离变化的目的。

**ASM 修改字节码**

ASM 是 Java 的字节码增强技术，这里面就用到了访问者模式，主要是用来进行字节码的修改。在 ASM 中于此相关的三个类分别是：ClassReader、ClassVisitor、ClassWriter。

ClassReader 类相当于访问者模式中的 Element 元素。它将字节数组或 class 文件读入内存中，并以树的数据结构表示。该类定义了一个 accept 方法用来和 visitor 交互。

![img](https://pic2.zhimg.com/80/v2-35d05f5ed1168956571921ec3784b095_720w.webp)

ClassVisitor 相当于抽象访问者接口。ClassReader 对象创建之后，需要调用 accept () 方法，传入一个 ClassVisitor 对象。在  ClassReader 的不同时期会调用 ClassVisitor 对象中不同的 visit () 方法，从而实现对字节码的修改。

![img](https://pic2.zhimg.com/80/v2-6d5ea6e0a79371a1123da9a62a29bd59_720w.webp)

ClassWriter 是 ClassVisitor 的是实现类，它负责将修改后的字节码输出为字节数组。

![img](https://pic2.zhimg.com/80/v2-01320043458d34da3f67ff333ee20429_720w.webp)

**对于 ASM 这种场景而言，字节码规范是非常严格且稳定的，如果随便更改可能出问题。但我们又需要对字节码进行动态修改，从而达到某些目的。在这种情况下，ASM 的设计者采用了访问者模式将变化的部分隔离开来，将不变的部分固定下来，从而达到了灵活扩展的目的。**

另外还有如下案例：

1. Java编译器中的AST（Abstract Syntax Tree）遍历就是访问者模式的典型应用，每个节点用一个访问者来遍历。
2. 在spring framework中，spring expression语言使用了访问者模式来解析表达式。
3. 在MyBatis ORM框架中，Ognl表达式解析就采用了访问者模式。
4. 在Google的guava框架中，TypeVisitor类使用了访问者模式来遍历类型。



### 6.8 备忘录模式

#### 6.8.1 备忘录模式介绍

备忘录模式就是通过一个对象记录另一个的状态，也可以恢复记录的状态

备忘录模式的本质：保存和恢复内部状态。

保存是手段，恢复才是目的，备忘录模式备忘些什么东西呢?

备忘录模式备忘的就是原发器对象的内部状态，这些内部状态是不对外的，只有原发器对象才能够进行操作。

标准的备忘录模式保存数据的手段是，通过内存缓存，广义的备忘录模式实现的时候，可以采用离线存储的方式，把这些数据保存到文件或者数据库等地方。

备忘录模式为何要保存数据呢?目的就是为了在有需要的时候，恢复原发器对象的内部状态。所以恢复是备忘录模式的目的。

​									<img src="马士兵-学习笔记-沈俊杰.assets/123.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

> 很多软件都提供了撤销（Undo）操作，如 Word、记事本、Photoshop、IDEA等软件在编辑时按 Ctrl+Z 组合键时能撤销当前操作，使文档恢复到之前的状态；还有在 浏览器 中的后退键、数据库事务管理中的回滚操作、玩游戏时的中间结果存档功能、数据库与操作系统的备份操作、棋类游戏中的悔棋功能等都属于这类。

#### 6.8.2 备忘录模式原理

<img src="马士兵-学习笔记-沈俊杰.assets/125.jpg" alt="image-20220530160637842" style="zoom: 50%;" />  

备忘录模式的主要角色如下：

* 发起人（Originator）角色：状态需要被记录的元对象类, 记录当前时刻的内部状态信息，提供创建备忘录和恢复备忘录数据的功能，实现其他业务功能，它可以访问备忘录里的所有信息。
* 备忘录（Memento）角色：负责存储发起人的内部状态，在需要的时候提供这些内部状态给发起人。
* 看护人（Caretaker）角色：对备忘录进行管理，提供保存与获取备忘录的功能，但其不能对备忘录的内容进行访问与修改。

#### 6.8.3 备忘录模式实现

下面我们再来看看 UML 对应的代码实现。首先，我们创建原始对象 Originator，对象中有四个属性，分别是 state 用于显示当前对象状态，id、name、phone 用来模拟业务属性，并添加 get、set 方法、create() 方法用于创建备份对象，restore(memento) 用于恢复对象状态。

```java
/**
 * 发起人类
 **/
public class Originator {

    private String state = "原始对象";
    private String id;
    private String name;
    private String phone;

    public Originator() {
    }

    //创建备忘录对象
    public Memento create(){
        return new Memento(id,name,phone);
    }

    //恢复对象状态
    public void restore(Memento m){
        this.state = m.getState();
        this.id = m.getId();
        this.name = m.getName();
        this.phone = m.getPhone();
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Override
    public String toString() {
        return "Originator{" +
                "state='" + state + '\'' +
                ", id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", phone='" + phone + '\'' +
                '}';
    }
}

/**
 * 备忘录对象
 *     访问权限为: 默认,也就是同包下可见(保证只有发起者类可以访问备忘录类)
 **/
class Memento {

    private String state = "从备份对象恢复为原始对象";
    private String id;
    private String name;
    private String phone;

    public Memento() {
    }

    public Memento(String id, String name, String phone) {
        this.id = id;
        this.name = name;
        this.phone = phone;
    }

	//get、set、toString......
}

/**
 * 负责人类-保存备忘录对象
 **/
public class Caretaker {
    private Memento memento;

    public Memento getMemento() {
        return memento;
    }

    public void setMemento(Memento memento) {
        this.memento = memento;
    }
}

public class Client {
    public static void main(String[] args) {
        //创建发起人对象
        Originator originator = new Originator();
        originator.setId("1");
        originator.setName("spike");
        originator.setPhone("13512341234");
        System.out.println("=============" + originator);

        //创建负责人对象,并保存备忘录对象
        Caretaker caretaker = new Caretaker();
        caretaker.setMemento(originator.create());

        //修改
        originator.setName("update");
        System.out.println("=============" + originator);

        //从负责人对象中获取备忘录对象,实现撤销
        originator.restore(caretaker.getMemento());
        System.out.println("=============" + originator);
    }
}
```

#### 6.8.4 备忘录模式应用实例

设计一个收集水果和获取金钱数的掷骰子游戏,游戏规则如下

1. 游戏玩家通过扔骰子来决定下一个状态
2. 当点数为1,玩家金钱增加
3. 当点数为2,玩家金钱减少
4. 当点数为6,玩家会得到水果
5. 当钱消耗到一定程度,就恢复到初始状态



- Memento类: 表示玩家的状态

```java
/**
 * Memento 表示状态
 * @author spikeCong
 * @date 2022/10/19
 **/
public class Memento {

    int money;    //所持金钱
    ArrayList fruits; //获得的水果

    //构造函数
    Memento(int money) {
        this.money = money;
        this.fruits = new ArrayList();
    }

    //获取当前玩家所有的金钱
    int getMoney() {
        return money;
    }

    //获取当前玩家所有的水果
    List getFruits() {
        return (List)fruits.clone();
    }

    //添加水果
    void addFruit(String fruit){
        fruits.add(fruit);
    }
}
```

- Player玩家类,只要玩家的金币还够,就会一直进行游戏,在该类中会设置一个createMemento方法,其作用是保存当前玩家状态.还会包含一个restore撤销方法,相当于复活操作.

```java
package com.mashibing.memento.example02;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

/**
 * @author spikeCong
 * @date 2022/10/19
 **/
public class Player {

    private int money;      //所持金钱
    private List<String> fruits = new ArrayList();  //获得的水果
    private Random random = new Random();   //随机数对象
    private static String[] fruitsName={    //表示水果种类的数组
      "苹果","葡萄","香蕉","橘子"
    };

    //构造方法
    public Player(int money) {
        this.money = money;
    }

    //获取当前所持有的金钱
    public int getMoney() {
        return money;
    }

    //获取一个水果
    public String getFruit() {
        String prefix = "";
        if (random.nextBoolean()) {
            prefix = "好吃的";
        }

        //从数组中获取水果
        String f = fruitsName[random.nextInt(fruitsName.length)];
        return prefix + f;
    }

    //掷骰子游戏
    public void yacht(){

        int dice = random.nextInt(6) + 1;   //掷骰子
        if(dice == 1){
            money += 100;
            System.out.println("所持有的金钱增加了..");
        }else if(dice == 2){
            money /= 2;
            System.out.println("所持有的金钱减半..");
        }else if(dice == 6){   //获取水果
            String fruit = getFruit();
            System.out.println("获得了水果: " + fruit);
            fruits.add(fruit);
        }else{
            //骰子结果为3、4、5
            System.out.println("无效数字,继续投掷");
        }
    }

    //拍摄快照
    public Memento createMemento(){
        Memento memento = new Memento(money);
        for (String fruit : fruits) {
            if(fruit.startsWith("好吃的")){
                memento.addFruit(fruit);
            }
        }

        return memento;
    }

    //撤销方法
    public void restore(Memento memento){
        this.money = memento.money;
        this.fruits = memento.getFruits();
    }

    @Override
    public String toString() {
        return "Player{" +
                "money=" + money +
                ", fruits=" + fruits +
                '}';
    }
}
```

- 测试: 由于引入了备忘录模式,可以保存某个时间点的玩家状态,这样就可以对玩家进行复活操作.

```java
public class MainApp {

    public static void main(String[] args) throws InterruptedException {

        Player player = new Player(100);        //最初所持的金钱数
        Memento memento = player.createMemento();       //保存最初状态

        for (int i = 0; i < 100; i++) {
            //显示扔骰子的次数
            System.out.println("=====" + i);

            //显示当前状态
            System.out.println("当前状态: " + player);

            //开启游戏
            player.yacht();
            System.out.println("所持有的金钱为: " + player.getMoney() + " 元");

            //决定如何操作Memento
            if(player.getMoney() > memento.getMoney()){
                System.out.println("赚到金币,保存当前状态,继续游戏!");
                memento = player.createMemento();
            }else if(player.getMoney() < memento.getMoney() / 2){
                System.out.println("所持金币不多了,将游戏恢复到初始状态!");
                player.restore(memento);
            }

            Thread.sleep(1000);
            System.out.println("");
        }

    }
}
```



#### 6.8.5 备忘录模式总结

**1 ) 备忘录模式的优点**

更好的封装性
备忘录模式通过使用备忘录对象，来封装原发器对象的内部状态，虽然这个对象是保存在原发器对象的外部，但是由于备忘录对象的窄接口并不提供任何方法。这样有效地保证了对原发器对象内部状态的封装，不把原发器对象的内部实现细节暴露给外部。

简化了原发器
备忘录模式中，备忘录对象被保存到原发器对象之外，让客户来管理他们请求的状态,从而让原发器对象得到简化。

窄接口和宽接口
备忘录模式，通过引入窄接口和宽接口，使得不同的地方，对备忘录对象的访问是不一样的。窄接口保证了只有原发器才可以访问备忘录对象的状态。

**2 ) 备忘录模式的缺点** 

-  可能会导致高开销。备忘录模式基本的功能，就是对备忘录对象的存储和恢复，它的基本实现方式就是缓存备忘录对象。这样一来，如果需要缓存的数据量很大，或者是特别频繁地创建备忘录对象，开销是很大的。

**3) 备忘录模式使用场景**

1. 如果必须保存一个对象在某一个时刻的全部或者部分状态，方便在以后需要的时候，可以把该对象恢复到先前的状态，可以使用备忘录模式。使用备忘录对象来封装和保存需要保存的内部状态，然后把备忘录对象保存到管理者对象中，在需要的时候，再从管理者对象中获取备忘录对象，来恢复对象的状态。
2. 如果需要保存一个对象的内部状态，但是如果用接口来让其他对象直接得到这些需要保存的状态，将会暴露对象的实现细节并破坏对象的封装性，这时可以使用备忘录模式，把备忘录对象实现成为原发器对象的内部类，而且还是私有的，从而保证只有原发器对象才能访问该备忘录对象。这样既保存了需要保存的状态，又不会暴露原发器对象的内部实现细节。



#### 6.8.5 源码案例

在Java常用框架中，备忘录模式常常用于实现Spring框架中的AOP（面向切面编程）功能，即通过“切面”拦截方法调用并采取相应的操作，而备忘录模式则可用于保存和恢复方法的状态。此外，在Java Swing框架中，备忘录模式也常用于实现撤销和恢复操作。



### 6.9 命令模式

#### 6.9.1 命令模式介绍

**命令模式(command pattern)的定义: 命令模式将请求（命令）封装为一个对象，这样可以使用不同的请求参数化其他对象（将不同请求依赖注入到其他对象），并且能够支持请求（命令）的排队执行、记录日志、撤销等 （附加控制）功能。**

命令模式的核心是将指令信息封装成一个对象，并将此对象作为参数发送给接收方去执行。达到使命令的请求与执行方解耦，双方只通过传递各种命令对象来完成任务。

在实际的开发中，如果你用到的编程语言并不支持用函数作为参数来传递，那么就可以借助命令模式将函数封装为对象来使用。

> 我们知道，C 语言支持函数指针。我们可以把函数当作变量传递来传递去。但是，在大部分编程语言中，函数没法作为参数传递给其他函数，也没法赋值给变量。借助命令模式，我们可以将函数封装成对象。具体来说就是，设计一个包含这个函数的类，实例化一个对象传来传去，这样就可以实现把函数像对象一样使用。

#### 6.9.2 命令模式原理

<img src="马士兵-学习笔记-沈俊杰.assets/126.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

命令模式包含以下主要角色：

* 抽象命令类角色（Command）： 定义命令的接口，声明执行的方法。
* 具体命令角色（ConcreteCommand）：具体的命令，实现命令接口；通常会持有接收者，并调用接收者的功能来完成命令要执行的操作。
* 实现者/接收者角色（Receiver）： 接收者，真正执行命令的对象。任何类都可能成为一个接收者，只要它能够实现命令要求实现的相应功能。
* 调用者/请求者角色（Invoker）： 要求命令对象执行请求，通常会持有命令对象，可以持有很多的命令对象。这个是客户端真正触发命令并要求命令执行相应操作的地方，也就是说相当于使用命令对象的入口。

#### 6.9.3 命令模式实现

##### 案例一 AudioPlayer系统

　　小女孩茱丽(Julia)有一个盒式录音机，此录音机有播音(Play)、倒带(Rewind)和停止(Stop)功能，录音机的键盘便是请求者(Invoker)角色；茱丽(Julia)是客户端角色，而录音机便是接收者角色。Command类扮演抽象命令角色，而PlayCommand、StopCommand和RewindCommand便是具体命令类。茱丽(Julia)不需要知道播音(play)、倒带(rewind)和停止(stop)功能是怎么具体执行的，这些命令执行的细节全都由键盘(Keypad)具体实施。茱丽(Julia)只需要在键盘上按下相应的键便可以了。

录音机是典型的命令模式。录音机按键把客户端与录音机的操作细节分割开来。

![image-20230410162223882](马士兵-学习笔记-沈俊杰.assets/image-20230410162223882.png)

参考代码

```java
/**
* 实现者/接收者角色 录音机
*/
public class AudioPlayer {
    
    public void play(){
        System.out.println("播放...");
    }
    
    public void rewind(){
        System.out.println("倒带...");
    }
    
    public void stop(){
        System.out.println("停止...");
    }
}

/**
* 抽象命令类角色
*/
public interface Command {
    /**
     * 执行方法
     */
    public void execute();
}

/**
* 具体命令角色-播放命令
*/
public class PlayCommand implements Command {

    private AudioPlayer myAudio;
    
    public PlayCommand(AudioPlayer audioPlayer){
        myAudio = audioPlayer;
    }
    /**
     * 执行方法
     */
    @Override
    public void execute() {
        myAudio.play();
    }
}

/**
* 具体命令角色-倒带命令
*/
public class RewindCommand implements Command {

    private AudioPlayer myAudio;
    
    public RewindCommand(AudioPlayer audioPlayer){
        myAudio = audioPlayer;
    }
    @Override
    public void execute() {
        myAudio.rewind();
    }

}

/**
* 具体命令角色-倒带命令
*/
public class StopCommand implements Command {
    private AudioPlayer myAudio;
    
    public StopCommand(AudioPlayer audioPlayer){
        myAudio = audioPlayer;
    }
    @Override
    public void execute() {
        myAudio.stop();
    }
}

/**
* 调用者/请求者角色-键区
*/
public class Keypad {
    private Command playCommand;
    private Command rewindCommand;
    private Command stopCommand;
    
    public void setPlayCommand(Command playCommand) {
        this.playCommand = playCommand;
    }
    public void setRewindCommand(Command rewindCommand) {
        this.rewindCommand = rewindCommand;
    }
    public void setStopCommand(Command stopCommand) {
        this.stopCommand = stopCommand;
    }
    /**
     * 执行播放方法
     */
    public void play(){
        playCommand.execute();
    }
    /**
     * 执行倒带方法
     */
    public void rewind(){
        rewindCommand.execute();
    }
    /**
     * 执行播放方法
     */
    public void stop(){
        stopCommand.execute();
    }
}

public class Julia {
    public static void main(String[]args){
        //创建接收者对象
        AudioPlayer audioPlayer = new AudioPlayer();
        //创建命令对象
        Command playCommand = new PlayCommand(audioPlayer);
        Command rewindCommand = new RewindCommand(audioPlayer);
        Command stopCommand = new StopCommand(audioPlayer);
        //创建请求者对象
        Keypad keypad = new Keypad();
        keypad.setPlayCommand(playCommand);
        keypad.setRewindCommand(rewindCommand);
        keypad.setStopCommand(stopCommand);
        //测试
        keypad.play();
        keypad.rewind();
        keypad.stop();
        keypad.play();
        keypad.stop();
    }
}
```



##### 案例二 电视机遥控器

电视机是请求的接收者，遥控器是请求的发送者，遥控器上有一些按钮，不同的按钮对应电视机的不同操作。抽象命令角色由一个命令接口来扮演，有三个具体的命令类实现了抽象命令接口，这三个具体命令类分别代表三种操作：打开电视机、关闭电视机和切换频道。显然，电视机遥控器就是一个典型的命令模式应用实例。
其中:
        接受者--Televison
        请求者--Controller
        抽象命令--AbstractCommand
        具体命令--TCOpenCommand、TVChangeCommand、TVCloseCommand
![img](https://img-blog.csdn.net/20130512005324620)



##### 案例三 酒店后厨出餐流程

模拟酒店后厨的出餐流程，来对命令模式进行一个演示。命令模式的角色与案例中角色的对应关系如下:

- 服务员：即调用者角色，由她来发起命令。
- 厨师：接收者，真正执行命令的对象。
- 订单：命令中包含订单。

```java
/**
 * 订单类
 **/
public class Order {

    private int diningTable;  //餐桌号码

    //存储菜名与份数
    private Map<String,Integer> foodMenu = new HashMap<>();

    public int getDiningTable() {
        return diningTable;
    }

    public void setDiningTable(int diningTable) {
        this.diningTable = diningTable;
    }

    public Map<String, Integer> getFoodMenu() {
        return foodMenu;
    }

    public void setFoodDic(Map<String, Integer> foodMenu) {
        this.foodMenu = foodMenu;
    }
}

/**
 * 厨师类 -> Receiver角色
 **/
public class Chef {
    public void makeFood(int num, String foodName) {
        System.out.println(num + "份," + foodName);
    }
}


/**
 * 抽象命令接口
 **/
public interface Command {

    void execute(); //只需要定义一个统一的执行方法
}

/**
 * 具体命令
 **/
public class OrderCommand implements Command {

    //持有接收者对象
    private Chef receiver;

    private Order order;

    public OrderCommand(Chef receiver, Order order) {
        this.receiver = receiver;
        this.order = order;
    }

    @Override
    public void execute() {
        System.out.println(order.getDiningTable() + "桌的订单: ");
        Set<String> keys = order.getFoodMenu().keySet();
        for (String key : keys) {
            receiver.makeFood(order.getFoodMenu().get(key),key);
        }

        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        System.out.println(order.getDiningTable() + "桌的菜已上齐.");
    }
}

/**
 * 服务员-> Invoker调用者
 * @author spikeCong
 * @date 2022/10/19
 **/
public class Waiter {

    //可以持有很多的命令对象
    private ArrayList<Command> commands;

    public Waiter() {
        commands = new ArrayList();
    }

    public Waiter(ArrayList<Command> commands) {
        this.commands = commands;
    }

    public void setCommands(Command command) {
        commands.add(command);
    }

    //发出命令 ,指挥厨师工作
    public void orderUp(){
        System.out.println("服务员: 叮咚,有新的订单,请厨师开始制作......");
        for (Command cmd : commands) {
            if(cmd != null){
                cmd.execute();
            }
        }
    }
}

public class Client {

    public static void main(String[] args) {

        Order order1 = new Order();
        order1.setDiningTable(1);
        order1.getFoodMenu().put("鲍鱼炒饭",1);
        order1.getFoodMenu().put("茅台迎宾",1);

        Order order2 = new Order();
        order2.setDiningTable(3);
        order2.getFoodMenu().put("海参炒面",1);
        order2.getFoodMenu().put("五粮液",1);

        //创建接收者
        Chef receiver = new Chef();

        //将订单和接收者封装成命令对象
        OrderCommand cmd1 = new OrderCommand(receiver,order1);
        OrderCommand cmd2 = new OrderCommand(receiver,order2);

        //创建调用者
        Waiter invoke = new Waiter();
        invoke.setCommands(cmd1);
        invoke.setCommands(cmd2);

        //将订单发送到后厨
        invoke.orderUp();
    }
}
```



#### 6.9.4 命令模式总结

**1) 命令模式优点：**

* 降低系统的耦合度。命令模式能将调用操作的对象与实现该操作的对象解耦。
* 增加或删除命令非常方便。采用命令模式增加与删除命令不会影响其他类，它满足“开闭原则”，对扩展比较灵活。
* 可以实现宏命令。命令模式可以与组合模式结合，将多个命令装配成一个组合命令，即宏命令。

**2) 命令模式缺点：** 

* 使用命令模式可能会导致某些系统有过多的具体命令类。
* 系统结构更加复杂。

**3) 使用场景**

* 系统需要将请求调用者和请求接收者解耦，使得调用者和接收者不直接交互。
* 系统需要在不同的时间指定请求、将请求排队和执行请求。
* 系统需要支持命令的撤销(Undo)操作和恢复(Redo)操作。



### 6.10 解释器模式

#### 6.10.1 解释器模式介绍

当想解析一个文件或者其他内容时，可以根据规律自己定义一种文法，并定义一个解释器，然后解析这种文法，以达到解析文件或其他内容的效果

解释器模式的本质：分离实现，解释执行

解释器模式通过一个解释器对象处理一个语法规则的方式，把复杂的功能分离开;然后选择需要被执行的功能，并把这些功能组合成为需要被解释执行的抽象语法树;再按照抽象语法树来解释执行，实现相应的功能。



#### 6.10.2 解释器模式原理

![在这里插入图片描述](https://img-blog.csdnimg.cn/344dac7b86324aecafc4ebf38b072a48.png#pic_center) 

解释器模式包含以下主要角色。

* 抽象表达式（Abstract Expression）角色：定义解释器的接口，约定解释器的解释操作，主要包含解释方法 interpret()。
* 终结符表达式（Terminal  Expression）角色：是抽象表达式的子类，用来实现文法中与终结符相关的操作，文法中的每一个终结符都有一个具体终结表达式与之相对应。上例中的value 是终结符表达式.
* 非终结符表达式（Nonterminal Expression）角色：也是抽象表达式的子类，用来实现文法中与非终结符相关的操作，文法中的每条规则都对应于一个非终结符表达式。上例中的 plus , minus 都是非终结符表达式
* 环境（Context）角色：通常包含各个解释器需要的数据或是公共的功能，一般用来传递被所有解释器共享的数据，后面的解释器可以从这里获取这些值。
* 客户端（Client）：主要任务是将需要分析的句子或表达式转换成使用解释器对象描述的抽象语法树，然后调用解释器的解释方法，当然也可以通过环境角色间接访问解释器的解释方法。

#### 6.10.3 解释器模式实现

**案例一：计算器加减操作**

实现一个计算器的加减操作

**代码示例:**  

- 用户按照上 面的规则书写表达式，传递给 interpret() 函数，就可以得到最终的计算结果。

```java
/**
 * @description:解释器接口
 */
public interface Expression {

    /**
     * 解析表达式
     * @return
     */
    int interpret();
}

/**
 * @description:数值解释器
 */
public class NumExpression implements Expression {

    private int value;

    public NumExpression(int value) {
        this.value = value;
    }
    
    @Override
    public int interpret() {
        return this.value;
    }
}

/**
 * @description:加法解释器
 */
public class AddExpression implements Expression {

    public Expression left;
    public Expression right;

    public AddExpression(Expression left, Expression right) {
        this.left = left;
        this.right = right;
    }

    @Override
    public int interpret() {
        return this.left.interpret() + this.right.interpret();
    }
}

/**
 * @description:减法解释器
 */
public class SubExpression implements Expression {

    public Expression left;
    public Expression right;

    public SubExpression(Expression left, Expression right) {
        this.left = left;
        this.right = right;
    }

    @Override
    public int interpret() {
        return this.left.interpret() - this.right.interpret();
    }
}

/**
 * @description:计算器类（上下文）
 */
public class Calculator {

    //栈
    private Stack<Expression> stack = new Stack<>();

    /**
     * @description:解释文法方法
     */
    public int parse(String expression) {
        String[] elements = expression.split(" ");
        Expression leftExpr, rightExpr;

        for (int i = 0; i < elements.length; i++) {
            String operator = elements[i];
            if (("+".equals(operator) || "-".equals(operator))) {
                leftExpr = this.stack.pop();
                rightExpr = new NumExpression(Integer.valueOf(elements[++i]));
                if ("+".equals(operator)) {
                    this.stack.push(new AddExpression(leftExpr, rightExpr));
                } else if ("-".equals(operator)) {
                    this.stack.push(new SubExpression(leftExpr, rightExpr));
                }
            } else {
                NumExpression numInterpreter = new NumExpression(Integer.valueOf(elements[i]));
                this.stack.push(numInterpreter);
            }
        }
        //等价于new SubExpression(new AddExpression(new NumExpression(10), new NumExpression(30)), new NumExpression(20)).interpret()
        return this.stack.pop().interpret();
    }
}

/**
 * @description:测试类
 */
public class Client {

    public static void main(String[] args) {
        System.out.println("result: " + new Calculator().parse("10 + 30 - 20"));
        System.out.println("result: " + new SubExpression(new AddExpression(new NumExpression(10), new NumExpression(30)), new NumExpression(20)).interpret());
    }
}
```



#### 6.10.4 解释器模式总结

**1) 解释器优点**

- 易于改变和扩展文法

  因为在解释器模式中使用类来表示语言的文法规则的,因此就可以通过继承等机制改变或者扩展文法.每一个文法规则都可以表示为一个类,因此我们可以快速的实现一个迷你的语言

- 实现文法比较容易

  在抽象语法树中每一个表达式节点类的实现方式都是相似的,这些类的代码编写都不会特别复杂

- 增加新的解释表达式比较方便

  如果用户需要增加新的解释表达式,只需要对应增加一个新的表达式类就可以了.原有的表达式类不需要修改,符合开闭原则

**2) 解释器缺点**

- 可利用场景比较少。

- 对于复杂的文法比较难维护。
- 解释器模式会引起类膨胀。
- 解释器模式采用递归调用方法。

**3) 使用场景**

- 当语言的文法比较简单,并且执行效率不是关键问题.
- 当问题重复出现且可以用一种简单的语言来进行表达
- 当一个语言需要解释执行,并且语言中的句子可以表示为一个抽象的语法树的时候



### 6.11 中介者模式

#### 6.11.1 中介者模式介绍

提到中介模式，有一个比较经典的例子就是航空管制。 为了让飞机在飞行的时候互不干扰，每架飞机都需要知道其他飞机每时每刻的位置，这就需要时刻跟其他飞机通信。飞机通信形成的通信网络就会无比复杂。这个时候，我们通过引 入“塔台”这样一个中介，让每架飞机只跟塔台来通信，发送自己的位置给塔台，由塔台来 负责每架飞机的航线调度。这样就大大简化了通信网络。

​													<img src="马士兵-学习笔记-沈俊杰.assets/129.jpg" alt="image-20220530160637842" style="zoom: 50%;" />

**中介模式(mediator pattern)的定义: 定义一个单独的(中介)对象,来封装一组对象之间的交互,将这组对象之间的交互委派给予中介对象交互,来避免对象之间的交互.**

中介者对象就是用于处理对象与对象之间的直接交互，封装了多个对象之间的交互细节。中介模式的设计跟中间层很像，通过引入中介这个中间层，将一组对象之间的交互关系从多对多的网状关系转换为一对多的星状关系。原来一个对象要跟N个对象交互,现在只需要跟一个中介对象交互。从而最小化对象之间的交互关系，降低代码的复杂度，提高代码的可读性和可维护性。

#### 6.11.2 中介者模式原理

<img src="马士兵-学习笔记-沈俊杰.assets/132.jpg" alt="image-20220530160637842" style="zoom: 50%;" />  

中介者模式包含以下主要角色：

* 抽象中介者（Mediator）角色：它是中介者的接口，提供了同事对象注册与转发同事对象信息的抽象方法。

* 具体中介者（ConcreteMediator）角色：实现中介者接口，定义一个 List 来管理同事对象，协调各个同事角色之间的交互关系，因此它依赖于同事角色。
* 抽象同事类（Colleague）角色：定义同事类的接口，保存中介者对象，提供同事对象交互的抽象方法，实现所有相互影响的同事类的公共功能。
* 具体同事类（Concrete Colleague）角色：是抽象同事类的实现者，当需要与其他同事对象交互时，由中介者对象负责后续的交互。

#### 6.11.3 中介者模式实现

代码示例

```java
/**
 * 抽象中介者
 **/
public interface Mediator {

    void apply(String key);
}

/**
 * 具体中介者
 **/
public class MediatorImpl implements Mediator {

    @Override
    public void apply(String key) {
        System.out.println("最终中介者执行操作,key为: " + key);
    }
}

/**
 * 抽象同事类
 **/
public abstract class Colleague {
    private Mediator mediator;

    public Colleague(Mediator mediator) {
        this.mediator = mediator;
    }

    public Mediator getMediator() {
        return mediator;
    }

    public abstract void exec(String key);
}

/**
 * 具体同事类
 **/
public class ConcreteColleagueA extends Colleague {

    public ConcreteColleagueA(Mediator mediator) {
        super(mediator);
    }

    @Override
    public void exec(String key) {
        System.out.println("====在组件A中,通过中介者执行!");
        getMediator().apply(key);
    }
}

public class ConcreteColleagueB extends Colleague {

    public ConcreteColleagueB(Mediator mediator) {
        super(mediator);
    }

    @Override
    public void exec(String key) {
        System.out.println("====在组件B中,通过中介者执行!");
        getMediator().apply(key);
    }
}

public class Client {

    public static void main(String[] args) {
        //创建中介者
        MediatorImpl mediator = new MediatorImpl();
        //创建同事对象
        Colleague c1 = new ConcreteColleagueA(mediator);
        c1.exec("key-A");
        Colleague c2 = new ConcreteColleagueB(mediator);
        c2.exec("key-B");
    }
}


====在组件A中,通过中介者执行!
最终中介者执行操作,key为: key-A
====在组件B中,通过中介者执行!
最终中介者执行操作,key为: key-B
```

#### 6.11.4 中介者模式应用实例

【例】租房

现在租房基本都是通过房屋中介，房主将房屋托管给房屋中介，而租房者从房屋中介获取房屋信息。房屋中介充当租房者与房屋所有者之间的中介者。

```java
/**
 * 抽象中介者
 **/
public abstract class Mediator {
    //申明一个联络方法
    public abstract void contact(String message,Person person);
}

/**
 * 抽象同事类
 * @author spikeCong
 * @date 2022/10/20
 **/
public abstract class Person {

    protected String name;

    protected Mediator mediator;

    public Person(String name, Mediator mediator) {
        this.name = name;
        this.mediator = mediator;
    }
}

/**
 * 中介机构
 * @author spikeCong
 * @date 2022/10/20
 **/
public class MediatorStructure extends Mediator {

    //中介要知晓房主和租房者的信息
    private HouseOwner houseOwner;
    private Tenant tenant;

    public HouseOwner getHouseOwner() {
        return houseOwner;
    }

    public void setHouseOwner(HouseOwner houseOwner) {
        this.houseOwner = houseOwner;
    }

    public Tenant getTenant() {
        return tenant;
    }

    public void setTenant(Tenant tenant) {
        this.tenant = tenant;
    }

    @Override
    public void contact(String message, Person person) {
        if(person == houseOwner){  //如果是房主,则租房者获得信息
            tenant.getMessage(message);
        }else { //如果是租房者则获取房主信息
            houseOwner.getMessage(message);
        }
    }
}

/**
 * 具体同事类-房屋拥有者
 **/
public class HouseOwner extends Person{

    public HouseOwner(String name, Mediator mediator) {
        super(name, mediator);
    }

    //与中介者联系
    public void contact(String message){
        mediator.contact(message,this);
    }

    //获取信息
    public void getMessage(String message){
        System.out.println("房主" + name + "获取到的信息: " + message);
    }
}

/**
 * 具体同事类-承租人
 **/
public class Tenant extends Person{

    public Tenant(String name, Mediator mediator) {
        super(name, mediator);
    }

    //与中介者联系
    public void contact(String message){
        mediator.contact(message,this);
    }

    //获取信息
    public void getMessage(String message){
        System.out.println("租房者" + name + "获取到的信息: " + message);
    }
}

public class Client {
    public static void main(String[] args) {
        //一个房主 一个租房者 一个中介机构
        MediatorStructure mediator = new MediatorStructure();
        //房主和租房者只需要知道中介机构即可
        HouseOwner houseOwner = new HouseOwner("路飞", mediator);
        Tenant tenant = new Tenant("娜美", mediator);
        //中介收集房租和租房者信息
        mediator.setHouseOwner(houseOwner);
        mediator.setTenant(tenant);

        tenant.contact("需要一个两室一厅的房子,一家人住");
        houseOwner.contact("出租一套两室一厅带电梯,月租5000");
    }
}

房主路飞获取到的信息: 需要一个两室一厅的房子,一家人住
租房者娜美获取到的信息: 出租一套两室一厅带电梯,月租5000
```

#### 6.11.5 中介者模式总结 

**1) 中介者模式的优点**

- 中介者模式简化了对象之间的交互,他用中介者和同事的一对多代替了原来的同事之间的多对多的交互,一对多关系更好理解 易于维护和扩展,将原本难以理解的网状结构转换成习相对简单的星型结构.
- 可以将各个同事就对象进行解耦.中介者有利于各个同事之间的松耦合,可以独立的改变或者复用每一个同事或者中介者,增加新的中介者类和新的同事类都比较方便,更符合开闭原则
- 可以减少子类生成,中介者将原本分布与多个对象的行为集中在了一起,改变这些行为只需要生成新的中介者的子类即可,使得同事类可以被重用,无需直接对同事类进行扩展.

**2) 中介者模式的缺点**

- 在具体中介者类中包含了大量同事之间的交互细节,可能会导致中介者类变得非常的复杂,使得系统不好维护.

**3) 中介者模式使用场景**

- 系统中对象之间存在复杂的引用关系，系统结构混乱且难以理解。
- 一个对象由于引用了其他的很多对象并且直接和这些对象进行通信，导致难以复用该对象。
- 想要通过一个中间类来封装多个类中的行为，而又不想生成太多的子类，此时可以通过引用中介者类来实现，在中介者类中定义对象的交互的公共行为，如果需要改变行为则可以在增加新的中介类。

#### 6.11.6 源码案例

[设计模式学习笔记（十七）中介者模式及其应用场景 - 归斯君 - 博客园 (cnblogs.com)](https://www.cnblogs.com/EthanWong/p/16114898.html)



## 7 开源实战

### 7.1 剖析Spring框架中用到的经典设计模式

#### 7.1.1 Spring中工厂模式的应用

**Spring的设计理念**

- Spring是面向Bean的编程（BOP：Bean Oriented Programming），Bean在Spring中才是真正的主角。Bean在Spring中作用就像Object对OOP的意义一样，没有对象的概念就像没有面向对象编程，Spring中没有Bean也就没有Spring存在的意义。Spring提供了IoC 容器通过配置文件或者注解的方式来管理对象之间的依赖关系。
- 控制反转（Inversion of Control，缩写为IoC），是面向对象编程中的一种设计原则，可以用来减低代码之间的耦合度。其中最常见的方式叫做依赖注入（Dependency Injection，简称DI），还有一种方式叫“依赖查找”（Dependency Lookup）。通过控制反转，对象在被创建的时候，由一个调控系统内所有对象的外界实体，将其所依赖的对象的引用传递给它。

#### 7.1.1.1 Spring中的Bean组件

Bean组件定义在Spring的**org.springframework.beans**包下，解决了以下几个问题：

这个包下的所有类主要解决了三件事：

- Bean的定义
- Bean的创建
- Bean的解析

Spring Bean的创建是典型的工厂模式，它的顶级接口是BeanFactory。

<img src="马士兵-学习笔记-沈俊杰.assets/137.jpg" alt="image-20220530160637842" style="zoom: 100%;" />  



BeanFactory有三个子类：ListableBeanFactory、HierarchicalBeanFactory和AutowireCapableBeanFactory。目的是为了**区分Spring内部对象处理和转化的数据限制**。

但是从图中可以发现最终的默认实现类是DefaultListableBeanFactory，它实现了所有的接口

#### 7.1.1.2 Spring中的BeanFactory

Spring中的BeanFactory就是简单工厂模式的体现，根据传入一个唯一的标识来获得Bean对象

BeanFactory，以Factory结尾，表示它是一个工厂(接口)， 它负责生产和管理bean的一个工厂。在Spring中，BeanFactory是工厂的顶层接口，也是IOC容器的核心接口，因此BeanFactory中定义了**管理Bean的通用方法**，如 **getBean** 和 **containsBean** 等.

它的职责包括：实例化、定位、配置应用程序中的对象及建立这些对象间的依赖。

BeanFactory只是个接口，并不是IOC容器的具体实现，所以Spring容器给出了很多种实现，如 **DefaultListableBeanFactory**、**XmlBeanFactory**、**ApplicationContext**等，其中XmlBeanFactory就是常用的一个，该实现将以XML方式描述组成应用的对象及对象间的依赖关系。



**1) BeanFactory源码解析** 

```java
public interface BeanFactory {
    
    /**
    	对FactoryBean的转移定义,因为如果使用bean的名字来检索FactoryBean得到的是对象是工厂生成的对象,
    	如果想得到工厂本身就需要转移
    */
    String FACTORY_BEAN_PREFIX = "&";

    //根据Bean的名字 获取IOC容器中对应的实例
    Object getBean(String var1) throws BeansException;

    
    //根据Bean的名字和class类型得到bean实例,增加了类型安全验证机制
    <T> T getBean(String var1, Class<T> var2) throws BeansException;

    Object getBean(String var1, Object... var2) throws BeansException;

    <T> T getBean(Class<T> var1) throws BeansException;

    <T> T getBean(Class<T> var1, Object... var2) throws BeansException;

    <T> ObjectProvider<T> getBeanProvider(Class<T> var1);

    <T> ObjectProvider<T> getBeanProvider(ResolvableType var1);

    
   //查看Bean容器中是否存在对应的实例,存在返回true 否则返回false
    boolean containsBean(String var1);

    //根据Bean的名字 判断这个bean是不是单例
    boolean isSingleton(String var1) throws NoSuchBeanDefinitionException;

    boolean isPrototype(String var1) throws NoSuchBeanDefinitionException;

    boolean isTypeMatch(String var1, ResolvableType var2) throws NoSuchBeanDefinitionException;

    boolean isTypeMatch(String var1, Class<?> var2) throws NoSuchBeanDefinitionException;

    //得到bean实例的class类型
    @Nullable
    Class<?> getType(String var1) throws NoSuchBeanDefinitionException;

    @Nullable
    Class<?> getType(String var1, boolean var2) throws NoSuchBeanDefinitionException;

    
    //得到bean的别名
    String[] getAliases(String var1);
}

```

BeanFactory的使用场景

1. 从IOC容器中获取Bean(Name or Type)
2. 检索IOC容器中是否包含了指定的对象
3. 判断Bean是否为单例

**2) BeanFactory的使用**

```java
public class User {

    private int id;

    private String name;

    private Friends friends;

    public User() {
    }

    public User(Friends friends) {
        this.friends = friends;
    }

 	//get set......
}

public class Friends {

    private List<String> names;

    public Friends() {
    }

    public List<String> getNames() {
        return names;
    }

    public void setNames(List<String> names) {
        this.names = names;
    }
}
```

配置文件

```xml
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:p="http://www.springframework.org/schema/p"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:mvc="http://www.springframework.org/schema/mvc"
       xmlns:task="http://www.springframework.org/schema/task"
       xsi:schemaLocation="
        http://www.springframework.org/schema/beans
        http://www.springframework.org/schema/beans/spring-beans-4.2.xsd
        http://www.springframework.org/schema/context
        http://www.springframework.org/schema/context/spring-context-4.2.xsd
        http://www.springframework.org/schema/mvc
        http://www.springframework.org/schema/mvc/spring-mvc-4.2.xsd
        http://www.springframework.org/schema/task
        http://www.springframework.org/schema/task/spring-task-4.2.xsd">
    
    <bean id="User" class="com.example.factory.User">
        <property name="friends" ref="UserFriends" />
    </bean>
    <bean id="UserFriends" class="com.example.factory.Friends">
        <property name="names">
            <list>
                <value>"LiLi"</value>
                <value>"LuLu"</value>
            </list>
        </property>
    </bean>
</beans>
```

测试

```java
public class SpringFactoryTest {

    public static void main(String[] args) {
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("bean.xml");
        User user = ctx.getBean("User", User.class);

        List<String> names = user.getFriends().getNames();
        for (String name : names) {
            System.out.println("FriendName: " + name);
        }

        ctx.close();
    }
}
```

#### 7.1.1.3 Spring中的FactoryBean

首先FactoryBean是一个Bean，但又不仅仅是一个Bean，这样听起来矛盾，但为啥又这样说呢？其实在Spring中，所有的Bean都是由BeanFactory（也就是IOC容器）来进行管理的。但对FactoryBean而言，**这个FactoryBean不是简单的Bean，而是一个能生产或者修饰对象生成的工厂Bean,它的实现与设计模式中的工厂方法模式和修饰器模式类似** 

**1) 为什么需要FactoryBean?**

1. 在某些情况下，实例化Bean过程比较复杂，如果按照传统的方式，则需要在中提供大量的配置信息。配置方式的灵活性是受限的，这时采用编码的方式可能会得到一个简单的方案。Spring为此提供了一个`org.springframework.bean.factory.FactoryBean`的工厂类接口，用户可以通过实现该接口定制实例化Bean的逻辑。FactoryBean接口对于Spring框架来说占用重要的地位，Spring自身就提供了70多个FactoryBean的实现。它们隐藏了实例化一些复杂Bean的细节，给上层应用带来了便利。
2. 由于第三方库不能直接注册到spring容器，于是可以实现`org.springframework.bean.factory.FactoryBean`接口，然后给出自己对象的实例化代码即可。

**2 ) FactoryBean的使用特点**

1. 当用户使用容器本身时，可以使用转义字符"&"来得到FactoryBean本身，以区别通过FactoryBean产生的实例对象和FactoryBean对象本身。

2. 在BeanFactory中通过如下代码定义了该转义字符：

   ```
    StringFACTORY_BEAN_PREFIX = "&";
   ```

3. 举例

   ```
   如果MyObject是一个FactoryBean，则使用&MyObject得到的是MyObject对象，而不是MyObject产生出来的对象。
   ```

**3) FactoryBean的代码示例**

```java
@Configuration
@ComponentScan("com.example.factory_bean")
public class AppConfig {
}

@Component("studentBean")
public class StudentBean implements FactoryBean {

    //返回工厂中的实例
    @Override
    public Object getObject() throws Exception {
        //这里并不一定要返回MyBean自身的实例，可以是其他任何对象的实例。
        return new TeacherBean();
    }

    //该方法返回的类型是在IOC容器中getBean所匹配的类型
    @Override
    public Class<?> getObjectType() {
        return StudentBean.class;
    }

    public void study(){
        System.out.println("学生学习......");
    }
}

public class TeacherBean {

    public void teach(){
        System.out.println("老师教书......");
    }
}

public class Test01 {

    public static void main(String[] args) {

        AnnotationConfigApplicationContext context = new AnnotationConfigApplicationContext(AppConfig.class);
        //StudentBean studentBean = (StudentBean)context.getBean("studentBean");

        //加上&符号,返回工厂中的实例
//        StudentBean studentBean = (StudentBean)context.getBean("&studentBean");
//        studentBean.study();

        TeacherBean teacherBean = (TeacherBean) context.getBean("studentBean");
        teacherBean.teach();
    }
}
```

**3) FactoryBean源码分析** 

```java
public interface FactoryBean<T> {
    String OBJECT_TYPE_ATTRIBUTE = "factoryBeanObjectType";

    /**
    getObject()方法: 会返回该FactoryBean生产的对象实例,我们需要实现该方法,以给出自己的对象实例化逻辑
    这个方法也是FactoryBean的核心.
    */
    @Nullable
    T getObject() throws Exception;

    /**
    getObjectType()方法: 仅返回getObject() 方法所返回的对象类型,如果预先无法确定,返回NULL,
    这个方法返回类型是在IOC容器中getBean所匹配的类型
    */
    @Nullable
    Class<?> getObjectType();

    //该方法的结果用于表明 工厂方法getObject() 所生产的 对象是否要以单例形式存储在容器中如果以单例存在就返回true,否则返回false
    default boolean isSingleton() {
        return true;
    }
}
```

FactoryBean表现的是一个工厂的职责,如果一个BeanA 是实现FactoryBean接口,那么A就是变成了一个工厂,根据A的名称获取到的实际上是工厂调用getObject()方法返回的对象,而不是对象本身,如果想获取工厂对象本身,需要在名称前面加上 '&'符号

- getObject('name') 返回的是工厂中工厂方法生产的实例
- getObject('&name') 返回的是工厂本身实例

**使用场景**

- FactoryBean的最为经典的使用场景,就是用来创建AOP代理对象,这个对象在Spring中就是 ProxyFactoryBean

**BeanFactory与FactoryBean区别**

- 他们两个都是工厂,但是FactoryBean本质还是一个Bean,也归BeanFactory管理
- BeanFactory是Spring容器的顶层接口,FactoryBean更类似于用户自定义的工厂接口

**BeanFactory和ApplicationContext的区别**

- BeanFactory是Spring容器的顶层接口,而ApplicationContext应用上下文类 他是BeanFactory的子类,他是Spring中更高级的容器,提供了更多的功能
  - 国际化
  - 访问资源
  - 载入多个上下文
  - 消息发送 响应机制
- 两者的装载bean的时机不同
  - BeanFactory: 在系统启动的时候不会去实例化bean,只有从容器中拿bean的时候才会去实例化(懒加载)
    - 优点: 应用启动的时候占用的资源比较少,对资源的使用要求比较高的应用 ,比较有优势
  - ApplicationContext:在启动的时候就把所有的Bean全部实例化.
    - lazy-init= true 可以使bean延时实例化
    - 优点: 所有的Bean在启动的时候就加载,系统运行的速度快,还可以及时的发现系统中配置的问题.



#### 7.1.2 Spring中观察者模式的应用

##### 7.1.2.1 观察者模式与发布订阅模式的异同

**观察者模式它是用于建立一种对象与对象之间的依赖关系,一个对象发生改变时将自动通知其他对象,其他对象将相应的作出反应.** 

> 在观察者模式中发生改变的对象称为**观察目标**,而被通知的对象称为**观察者**,一个观察目标可以应对多个观察者,而且这些观察者之间可以没有任何相互联系,可以根据需要增加和删除观察者,使得系统更易于扩展.

观察者模式的别名有发布-订阅(Publish/Subscribe)模式, 我们来看一下观察者模式与发布订阅模式结构上的区别

- 在设计模式结构上，发布订阅模式**继承**自观察者模式，是观察者模式的一种实现的变体。
- 在设计模式意图上，两者**关注点**不同，一个关心数据源，一个关心的是事件消息。

<img src="马士兵-学习笔记-沈俊杰.assets/134.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

> 观察者模式里，只有两个角色 —— 观察者 + 被观察者; 而发布订阅模式里，却不仅仅只有发布者和订阅者两个角色，还有一个管理并执行消息队列的 “经纪人Broker”
>
> 观察者和被观察者，是松耦合的关系;发布者和订阅者，则完全不存在耦合

- 观察者模式：**数据源直接通知订阅者发生改变。**

- 发布订阅模式：**数据源告诉第三方（事件通道）发生了改变，第三方再通知订阅者发生了改变。**

#### 7.1.2.2 Spring中的观察者模式

Spring 基于观察者模式，实现了自身的事件机制也就是事件驱动模型，事件驱动模型通常也被理解成观察者或者发布/订阅模型。

spring事件模型提供如下几个角色

- **ApplicationEvent**
- **ApplicationListener**
- **ApplicationEventPublisher**
- **ApplicationEventMulticaster** 



**1) 事件：ApplicationEvent** 

- 是所有事件对象的父类。ApplicationEvent 继承自 jdk 的 EventObject, 所有的事件都需要继承 ApplicationEvent, 并且通过 source 得到事件源。

  ```java
  public abstract class ApplicationEvent extends EventObject {
      private static final long serialVersionUID = 7099057708183571937L;
      private final long timestamp = System.currentTimeMillis();
  
      public ApplicationEvent(Object source) {
          super(source);
      }
  
      public final long getTimestamp() {
          return this.timestamp;
      }
  }
  ```

- Spring 也为我们提供了很多内置事件:

  - ContextRefreshEvent，当ApplicationContext容器初始化完成或者被刷新的时候，就会发布该事件。

  - ContextStartedEvent，当ApplicationContext启动的时候发布事件.

  - ContextStoppedEvent，当ApplicationContext容器停止的时候发布事件.

  - RequestHandledEvent，只能用于DispatcherServlet的web应用，Spring处理用户请求结束后，系统会触发该事件。

​		 <img src="马士兵-学习笔记-沈俊杰.assets/133.jpg" alt="image-20220530160637842" style="zoom: 50%;" />

**2) 事件监听：ApplicationListener** 

- ApplicationListener(应用程序事件监听器) 继承自jdk的EventListener,所有的监听器都要实现这个接口,这个接口只有一个onApplicationEvent()方法,该方法接受一个ApplicationEvent或其子类对象作为参数

- 在方法体中,可以通过不同对Event类的判断来进行相应的处理.当事件触发时所有的监听器都会收到消息,如果你需要对监听器的接收顺序有要求,可是实现该接口的一个实现SmartApplicationListener,通过这个接口可以指定监听器接收事件的顺序.

  ```java
  @FunctionalInterface
  public interface ApplicationListener<E extends ApplicationEvent> extends EventListener {
      void onApplicationEvent(E var1);
  }
  ```

- 实现了ApplicationListener接口之后，需要实现方法onApplicationEvent()，在容器将所有的Bean都初始化完成之后，就会执行该方法。

**3) 事件源：ApplicationEventPublisher** 

- 事件的发布者，封装了事件发布功能方法接口，是Applicationcontext接口的超类

  > 事件机制的实现需要三个部分,事件源,事件,事件监听器,在上面介绍的ApplicationEvent就相当于事件,ApplicationListener相当于事件监听器,这里的事件源说的就是ApplicationEventPublisher.

  ```java
  public interface ApplicationEventPublisher {
      default void publishEvent(ApplicationEvent event) {
          this.publishEvent((Object)event);
      }
  	//调用publishEvent方法,传入一个ApplicationEvent的实现类对象作为参数,每当ApplicationContext发布ApplicationEvent时,所有的ApplicationListener就会被自动的触发.
      void publishEvent(Object var1);
  }
  ```

- 我们常用的ApplicationContext都继承了AbstractApplicationContext,像我们平时常见ClassPathXmlApplicationContext、XmlWebApplicationContex也都是继承了它,AbstractApplicationcontext是ApplicationContext接口的抽象实现类,在该类中实现了publishEvent方法:

  ```java
     protected void publishEvent(Object event, @Nullable ResolvableType eventType) {
          Assert.notNull(event, "Event must not be null");
  
          if (this.earlyApplicationEvents != null) {
              this.earlyApplicationEvents.add(applicationEvent);
          } else {
            //事件发布委托给applicationEventMulticaster
            this.getApplicationEventMulticaster().multicastEvent((ApplicationEvent)applicationEvent, eventType);
          }
      }
  ```

  在这个方法中,我们看到了一个getApplicationEventMulticaster().这就要牵扯到另一个类ApplicationEventMulticaster.

**4) 事件管理：ApplicationEventMulticaster**

- 用于事件监听器的注册和事件的广播。监听器的注册就是通过它来实现的，它的作用是把 Applicationcontext 发布的 Event 广播给它的监听器列表。

  ```java
  public interface ApplicationEventMulticaster {
      
      //添加事件监听器
      void addApplicationListener(ApplicationListener<?> var1);
  
      //添加事件监听器,使用容器中的bean
      void addApplicationListenerBean(String var1);
  
      //移除事件监听器
      void removeApplicationListener(ApplicationListener<?> var1);
  
      void removeApplicationListenerBean(String var1);
  
      //移除所有
      void removeAllListeners();
  
      //发布事件
      void multicastEvent(ApplicationEvent var1);
  
      void multicastEvent(ApplicationEvent var1, @Nullable ResolvableType var2);
  }
  ```

- 在AbstractApplicationcontext中有一个applicationEventMulticaster的成员变量,提供了监听器Listener的注册方法.

  ```java
  public abstract class AbstractApplicationContext extends DefaultResourceLoader
          implements ConfigurableApplicationContext, DisposableBean {
  
  　　private ApplicationEventMulticaster applicationEventMulticaster;
      
  　　protected void registerListeners() {
          // Register statically specified listeners first.
          for (ApplicationListener<?> listener : getApplicationListeners()) {
              getApplicationEventMulticaster().addApplicationListener(listener);
          }
          // Do not initialize FactoryBeans here: We need to leave all regular beans
          // uninitialized to let post-processors apply to them!
          String[] listenerBeanNames = getBeanNamesForType(ApplicationListener.class, true, false);
          for (String lisName : listenerBeanNames) {
              getApplicationEventMulticaster().addApplicationListenerBean(lisName);
          }
      }
  }
  ```

#### 7.1.2.3 事件监听案例

实现一个需求：当调用一个类的方法完成时，该类发布事件，事件监听器监听该类的事件并执行的自己的方法逻辑

假设这个类是Request、发布的事件是ReuqestEvent、事件监听者是ReuqestListener。当调用Request的doRequest方法时，发布事件。

代码如下

```java
/**
 * 定义事件
 * @author spikeCong
 * @date 2022/10/24
 **/
public class RequestEvent  extends ApplicationEvent {

    public RequestEvent(Object source) {
        super(source);
    }
}

/**
 * 发布事件
 * @author spikeCong
 * @date 2022/10/24
 **/
@Component
public class Request {

    @Autowired
    private ApplicationContext applicationContext;

    public void doRequest(){
        System.out.println("调用Request类的doRequest方法发送一个请求......");
        applicationContext.publishEvent(new RequestEvent(this));
    }
}

/**
 * 监听事件
 * @author spikeCong
 * @date 2022/10/24
 **/
@Component
public class RequestListener implements ApplicationListener<RequestEvent> {

    @Override
    public void onApplicationEvent(RequestEvent requestEvent) {
        System.out.println("监听到RequestEvent事件,执行本方法");
    }
}

public class SpringEventTest {

    public static void main(String[] args) {
        ApplicationContext context =
                new AnnotationConfigApplicationContext("com.mashibing.pubsub");

        Request request = (Request) context.getBean("request");

        //调用方法发布事件
        request.doRequest();
    }
}

//打印日志
调用Request类的doRequest方法发送一个请求......
监听到RequestEvent事件,执行本方法
```

#### 7.1.2.4 事件机制工作流程

上面代码的执行流程

<img src="马士兵-学习笔记-沈俊杰.assets/146.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

1. 监听器什么时候注册到IOC容器

   注册的开始逻辑是在AbstractApplicationContext类的refresh方法，该方法包含了整个IOC容器初始化所有方法。其中有一个registerListeners()方法就是注册系统监听者(spring自带的)和自定义监听器的。

   ```java
   public void refresh() throws BeansException, IllegalStateException {
       			//BeanFactory准备工作完成后进行的后置处理工作
                   this.postProcessBeanFactory(beanFactory);
       
       			//执行BeanFactoryPostProcessor的方法；
                   this.invokeBeanFactoryPostProcessors(beanFactory);
       
       			//注册BeanPostProcessor（Bean的后置处理器），在创建bean的前后等执行
                   this.registerBeanPostProcessors(beanFactory);
       	
       			//初始化MessageSource组件（做国际化功能；消息绑定，消息解析）；
                   this.initMessageSource();
       
       			//初始化事件派发器
                   this.initApplicationEventMulticaster();
       
       			////子类重写这个方法，在容器刷新的时候可以自定义逻辑；如创建Tomcat，Jetty等WEB服务器
                   this.onRefresh();
       
                       //注册应用的监听器。就是注册实现了ApplicationListener接口的监听器bean，这些监听器是注册到ApplicationEventMulticaster中的
                   this.registerListeners();
       
       			//初始化所有剩下的非懒加载的单例bean
                   this.finishBeanFactoryInitialization(beanFactory);
       
       			//完成context的刷新
                   this.finishRefresh();
       }
   ```

   看registerListeners的关键方法体，其中的两个方法`addApplicationListener和addApplicationListenerBean`，从方法可以看出是添加监听者。

   ```java
   protected void registerListeners() {
       Iterator var1 = this.getApplicationListeners().iterator();
   
       while(var1.hasNext()) {
           ApplicationListener<?> listener = (ApplicationListener)var1.next();
           this.getApplicationEventMulticaster().addApplicationListener(listener);
       }
   
       String[] listenerBeanNames = this.getBeanNamesForType(ApplicationListener.class, true, false);
       String[] var7 = listenerBeanNames;
       int var3 = listenerBeanNames.length;
   
       for(int var4 = 0; var4 < var3; ++var4) {
           String listenerBeanName = var7[var4];
           this.getApplicationEventMulticaster().addApplicationListenerBean(listenerBeanName);
       }
   }
   ```

   那么最后将监听者放到哪里了呢？就是ApplicationEventMulticaster接口的子类

   <img src="马士兵-学习笔记-沈俊杰.assets/135.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

   该接口主要两个职责，维护ApplicationListener相关类和发布事件。

   实现在默认实现类AbstractApplicationEventMulticaster，`最后将Listener放到了内部类ListenerRetriever两个set集合中`

   ```java
   private class ListenerRetriever {
           public final Set<ApplicationListener<?>> applicationListeners = new LinkedHashSet();
           public final Set<String> applicationListenerBeans = new LinkedHashSet();
   }
   ```

​		ListenerRetriever被称为监听器注册表。

2. Spring如何发布的事件并通知监听者

   **这个注意的有两个方法**

   **1) publishEvent方法**

   - `AbstractApplicationContext`实现了`ApplicationEventPublisher` 接口的`publishEvent`方法

   ```java
   protected void publishEvent(Object event, @Nullable ResolvableType eventType) {
       Assert.notNull(event, "Event must not be null");
       Object applicationEvent;
       
       //尝试转换为ApplicationEvent或者PayloadApplicationEvent，如果是PayloadApplicationEvent则获取eventType
       if (event instanceof ApplicationEvent) {
           applicationEvent = (ApplicationEvent)event;
       } else {
           applicationEvent = new PayloadApplicationEvent(this, event);
           if (eventType == null) {
               eventType = ((PayloadApplicationEvent)applicationEvent).getResolvableType();
           }
       }
   
      
       if (this.earlyApplicationEvents != null) {
            //判断earlyApplicationEvents是否为空(也就是早期事件还没有被发布-说明广播器还没有实例化好)，如果不为空则将当前事件放入集合
           this.earlyApplicationEvents.add(applicationEvent);
       } else {
           //否则获取ApplicationEventMulticaster调用其multicastEvent将事件广播出去。本文这里获取到的广播器实例是SimpleApplicationEventMulticaster。
           this.getApplicationEventMulticaster().multicastEvent((ApplicationEvent)applicationEvent, eventType);
       }
   	
       //将事件交给父类处理
       if (this.parent != null) {
           if (this.parent instanceof AbstractApplicationContext) {
               ((AbstractApplicationContext)this.parent).publishEvent(event, eventType);
           } else {
               this.parent.publishEvent(event);
           }
       }
   
   }
   ```

    **2) multicastEvent方法**

   继续进入到`multicastEvent方法`，该方法有两种方式调用invokeListener，通过线程池和直接调用，进一步说就是通过异步和同步两种方式调用.

   ```java
   public void multicastEvent(ApplicationEvent event, @Nullable ResolvableType eventType) {
       
       //解析事件类型
       ResolvableType type = eventType != null ? eventType : this.resolveDefaultEventType(event);
       
       //获取执行器
       Executor executor = this.getTaskExecutor();
       
       // 获取合适的ApplicationListener，循环调用监听器的onApplicationEvent方法
       Iterator var5 = this.getApplicationListeners(event, type).iterator();
   
       while(var5.hasNext()) {
           ApplicationListener<?> listener = (ApplicationListener)var5.next();
           if (executor != null) {
               //如果executor不为null，则交给executor去调用监听器
               executor.execute(() -> {
                   this.invokeListener(listener, event);
               });
           } else {
               //否则，使用当前主线程直接调用监听器；
               this.invokeListener(listener, event);
           }
       }
   
   }
   ```

   

   **3) invokeListener方法**

   ```java
   // 该方法增加了错误处理逻辑，然后调用doInvokeListener
   protected void invokeListener(ApplicationListener<?> listener, ApplicationEvent event) {
       ErrorHandler errorHandler = this.getErrorHandler();
       if (errorHandler != null) {
           try {
               this.doInvokeListener(listener, event);
           } catch (Throwable var5) {
               errorHandler.handleError(var5);
           }
       } else {
           this.doInvokeListener(listener, event);
       }
   
   }
   
   private void doInvokeListener(ApplicationListener listener, ApplicationEvent event) {
       //直接调用了listener接口的onApplicationEvent方法
       listener.onApplicationEvent(event);  
   }
   ```

#### 7.1.3 结合设计模式自定义SpringIOC

##### 7.1.3.1 Spring IOC核心组件

**1) BeanFactory**  

BeanFactory作为最顶层的一个接口，定义了IoC容器的基本功能规范

<img src="马士兵-学习笔记-沈俊杰.assets/137.jpg" alt="image-20220530160637842" style="zoom: 100%;" /> 

从类图中我们可以发现最终的默认实现类是DefaultListableBeanFactory，它实现了所有的接口。那么为何要定义这么多层次的接口呢？
每个接口都有它的使用场合，主要是为了区分在Spring内部操作过程中对象的传递和转化，对对象的数据访问所做的限制。

例如，

- ListableBeanFactory接口表示这些Bean可列表化。
- HierarchicalBeanFactory表示这些Bean 是有继承关系的，也就是每个 Bean 可能有父 Bean
- AutowireCapableBeanFactory 接口定义Bean的自动装配规则。

这三个接口共同定义了Bean的集合、Bean之间的关系及Bean行为。

在BeanFactory里只对IoC容器的基本行为做了定义，根本不关心你的Bean是如何定义及怎样加载的。正如我们只关心能从工厂里得到什么产品，不关心工厂是怎么生产这些产品的。



**2 ) ApplicationContext** 

BeanFactory有一个很重要的子接口，就是ApplicationContext接口，该接口主要来规范容器中的bean对象是非延时加载，即在创建容器对象的时候就对象bean进行初始化，并存储到一个容器中。

```java
//延时加载
BeanFactory factory = new XmlBeanFactory(new ClassPathResource("bean.xml"));

//立即加载
ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("bean.xml");
User user = context.getBean("user", User.class);
```

 ApplicationContext 的子类主要包含两个方面：

- ConfigurableApplicationContext 表示该 Context 是可修改的，也就是在构建 Context 中用户可以动态添加或修改已有的配置信息

- WebApplicationContext 顾名思义，就是为 web 准备的 Context 他可以直接访问到 ServletContext，通常情况下，这个接口使用少

要知道工厂是如何产生对象的，我们需要看具体的IoC容器实现，Spring提供了许多IoC容器实现，比如：

- ClasspathXmlApplicationContext : 根据类路径加载xml配置文件，并创建IOC容器对象。
- FileSystemXmlApplicationContext ：根据系统路径加载xml配置文件，并创建IOC容器对象。
- AnnotationConfigApplicationContext ：加载注解类配置，并创建IOC容器。


总体来说 ApplicationContext 必须要完成以下几件事：

- 标识一个应用环境
- 利用 BeanFactory 创建 Bean 对象
- 保存对象关系表
- 能够捕获各种事件



**3) Bean定义：BeanDefinition** 

这里的 BeanDefinition 就是我们所说的 Spring 的 Bean，我们自己定义的各个 Bean 其实会转换成一个个 BeanDefinition 存在于 Spring 的 BeanFactory 中

```java
public class DefaultListableBeanFactory extends AbstractAutowireCapableBeanFactory
        implements ConfigurableListableBeanFactory, BeanDefinitionRegistry, Serializable {
	//DefaultListableBeanFactory 中使用 Map 结构保存所有的 BeanDefinition 信息
    private final Map<String, BeanDefinition> beanDefinitionMap = new ConcurrentHashMap<>(256); 
}   
```

**BeanDefinition** 中保存了我们的 Bean 信息，比如这个 Bean 指向的是哪个类、是否是单例的、是否懒加载、这个 Bean 依赖了哪些 Bean 等等。



**4) BeanDefinitionReader**

Bean的解析过程非常复杂，功能被分得很细，因为这里需要被扩展的地方很多，必须保证足够的灵活性，以应对可能的变化。Bean的解析主要就是对Spring配置文件的解析。

这个解析过程主要通过BeanDefinitionReader来完成，看看Spring中BeanDefinitionReader的类结构图，如下图所示。

​                       <img src="马士兵-学习笔记-沈俊杰.assets/140.jpg" alt="image-20220530160637842" style="zoom: 100%;" /> 

BeanDefinitionReader接口定义的功能

```java
public interface BeanDefinitionReader {

	/*
		下面的loadBeanDefinitions都是加载bean定义，从指定的资源中
	*/
	int loadBeanDefinitions(Resource resource) throws BeanDefinitionStoreException;
	int loadBeanDefinitions(Resource... resources) throws BeanDefinitionStoreException;
	int loadBeanDefinitions(String location) throws BeanDefinitionStoreException;
	int loadBeanDefinitions(String... locations) throws BeanDefinitionStoreException;
}
```



**5) BeanFactory后置处理器**

后置处理器是一种拓展机制，贯穿Spring Bean的生命周期

后置处理器分为两类：

**BeanFactory后置处理器：BeanFactoryPostProcessor**

实现该接口，可以在spring的bean创建之前，修改bean的定义属性

<img src="马士兵-学习笔记-沈俊杰.assets/141.jpg" alt="image-20220530160637842" style="zoom: 100%;" /> 

 

```java
public interface BeanFactoryPostProcessor {

    /*
     *  该接口只有一个方法postProcessBeanFactory，方法参数是ConfigurableListableBeanFactory，通过该
        参数，可以获取BeanDefinition
    */
    void postProcessBeanFactory(ConfigurableListableBeanFactory beanFactory) throws BeansException;
}
```



**6) Bean后置处理器：BeanPostProcessor**

BeanPostProcessor是Spring IOC容器给我们提供的一个扩展接口

实现该接口，可以在spring容器实例化bean之后，在执行bean的初始化方法前后，添加一些处理逻辑

<img src="马士兵-学习笔记-沈俊杰.assets/143.jpg" alt="image-20220530160637842" style="zoom: 100%;" /> 

 

```java
public interface BeanPostProcessor {
    //bean初始化方法调用前被调用
    Object postProcessBeforeInitialization(Object bean, String beanName) throws BeansException;
    //bean初始化方法调用后被调用
    Object postProcessAfterInitialization(Object bean, String beanName) throws BeansException;
}
```

#### 7.1.3.2 IOC流程图

<img src="马士兵-学习笔记-沈俊杰.assets/145.jpg" alt="image-20220530160637842" style="zoom: 100%;" />

1. 容器环境的初始化(系统、JVM 、解析器、类加载器等等)
2. Bean工厂的初始化(IOC容器首先会销毁旧工厂,旧Bean、创建新的工厂)
3. 读取：通过BeanDefinitonReader读取我们项目中的配置（application.xml）
4. 定义：通过解析xml文件内容，将里面的Bean解析成BeanDefinition（未实例化、未初始化）
5. 将解析得到的BeanDefinition,存储到工厂类的Map容器中
6. 调用 BeanFactoryPostProcessor 该方法是一种功能增强，可以在这个步骤对已经完成初始化的 BeanFactory 进行属性覆盖，或是修改已经注册到 BeanFactory 的 BeanDefinition
7. 通过反射实例化bean对象
8. 进入到Bean实例化流程,首先设置对象属性
9. 检查Aware相关接口,并设置相关依赖
10. 前置处理器,执行BeanPostProcesser的before方法对bean进行扩展
11. 检查是否有实现initializingBean 回调接口,如果实现就要回调其中的AftpropertiesSet() 方法,(通过可以完成一些配置的加载)
12. 检查是否有配置自定义的init-method ,
13. 后置处理器执行BeanPostProcesser 的after方法 -->  AOP就是在这个阶段完成的, 在这里判断bean对象是否实现接口,实现就使用JDK代理,否则选择CGLIB
14. 对象创建完成,添加到BeanFactory的单例池中

#### 7.1.3.3 自定义SpringIOC

对下面的配置文件进行解析，并自定义SpringIOC, 对涉及到的对象进行管理。

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans>
    <bean id="courseService" class="com.mashibing.service.impl.CourseServiceImpl">
        <property name="courseDao" ref="courseDao"></property>
    </bean>
    <bean id="courseDao" class="com.mashibing.dao.impl.CourseDaoImpl"></bean>
</beans>
```

##### 1) 创建与Bean相关的pojo类

- **PropertyValue类**: 用于封装bean的属性，体现到上面的配置文件就是封装bean标签的子标签property标签数据。

```java
package com.mashibing.framework.beans;

/**
 * 该类用来封装bean标签下的property子标签的属性
 *      1.name属性
 *      2.ref属性
 *      3.value属性: 给基本数据类型及string类型数据赋的值
 * @author spikeCong
 * @date 2022/10/26
 **/
public class PropertyValue {

    private String name;

    private String ref;

    private String value;

    public PropertyValue() {
    }

    public PropertyValue(String name, String ref, String value) {
        this.name = name;
        this.ref = ref;
        this.value = value;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRef() {
        return ref;
    }

    public void setRef(String ref) {
        this.ref = ref;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
```

- **MutablePropertyValues类**: 一个bean标签可以有多个property子标签，所以再定义一个MutablePropertyValues类，用来存储并管理多个PropertyValue对象。

```java
package com.mashibing.framework.beans;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

/**
 * 该类用来存储和遍历多个PropertyValue对象
 * @author spikeCong
 * @date 2022/10/26
 **/
public class MutablePropertyValues implements Iterable<PropertyValue>{

    //定义List集合,存储PropertyValue的容器
    private final List<PropertyValue> propertyValueList;

    //空参构造中 初始化一个list
    public MutablePropertyValues() {
        this.propertyValueList = new ArrayList<PropertyValue>();
    }

    //有参构造 接收一个外部传入的list,赋值propertyValueList属性
    public MutablePropertyValues(List<PropertyValue> propertyValueList) {
        if(propertyValueList == null){
            this.propertyValueList = new ArrayList<PropertyValue>();
        }else{
            this.propertyValueList = propertyValueList;
        }
    }

    //获取当前容器对应的迭代器对象
    @Override
    public Iterator<PropertyValue> iterator() {

        //直接获取List集合中的迭代器
        return propertyValueList.iterator();
    }

    //获取所有的PropertyValue
    public PropertyValue[] getPropertyValues(){
        //将集合转换为数组并返回
        return propertyValueList.toArray(new PropertyValue[0]); //new PropertyValue[0]声明返回的数组类型
    }

    //根据name属性值获取PropertyValue
    public PropertyValue getPropertyValue(String propertyName){
        //遍历集合对象
        for (PropertyValue propertyValue : propertyValueList) {
            if(propertyValue.getName().equals(propertyName)){
                return propertyValue;
            }
        }

        return null;
    }

    //判断集合是否为空,是否存储PropertyValue
    public boolean isEmpty(){
        return propertyValueList.isEmpty();
    }

    //向集合中添加
    public MutablePropertyValues addPropertyValue(PropertyValue value){
        //判断集合中存储的propertyvalue对象.是否重复,重复就进行覆盖
        for (int i = 0; i < propertyValueList.size(); i++) {
            //获取集合中每一个 PropertyValue
            PropertyValue currentPv = propertyValueList.get(i);

            //判断当前的pv的name属性 是否与传入的相同,如果相同就覆盖
            if(currentPv.getName().equals(value.getName())){
                propertyValueList.set(i,value);
                return this;
            }
        }

        //没有重复
        this.propertyValueList.add(value);
        return this;  //目的是实现链式编程
    }

    //判断是否有指定name属性值的对象
    public boolean contains(String propertyName){
        return getPropertyValue(propertyName) != null;
    }
}
```

- **BeanDefinition类**: 用来封装bean信息的，主要包含id（即bean对象的名称）、class（需要交由spring管理的类的全类名）及子标签property数据。

```java
/**
 * 封装Bean标签数据的类,包括id与class以及子标签的数据
 * @author spikeCong
 * @date 2022/10/27
 **/
public class BeanDefinition {

    private String id;

    private String className;

    private MutablePropertyValues propertyValues;

    public BeanDefinition() {
        propertyValues = new MutablePropertyValues();
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public MutablePropertyValues getPropertyValues() {
        return propertyValues;
    }

    public void setPropertyValues(MutablePropertyValues propertyValues) {
        this.propertyValues = propertyValues;
    }
}
```

##### 2) 创建注册表相关的类

BeanDefinition对象存取的操作, 其实是在BeanDefinitionRegistry接口中定义的,它被称为是BeanDefinition的注册中心.

```java
//源码
public interface BeanDefinitionRegistry extends AliasRegistry {

	void registerBeanDefinition(String beanName, BeanDefinition beanDefinition)
			throws BeanDefinitionStoreException;

	void removeBeanDefinition(String beanName) throws NoSuchBeanDefinitionException;

	BeanDefinition getBeanDefinition(String beanName) throws NoSuchBeanDefinitionException;

	boolean containsBeanDefinition(String beanName);

	String[] getBeanDefinitionNames();
    
	int getBeanDefinitionCount();
    
	boolean isBeanNameInUse(String beanName);
}
```

BeanDefinitionRegistry继承结构图如下：

<img src="马士兵-学习笔记-沈俊杰.assets/147.jpg" alt="image-20220530160637842" style="zoom: 100%;" /> 

BeanDefinitionRegistry接口的子实现类主要有以下两个：

* DefaultListableBeanFactory

  在该类中定义了如下代码，就是用来注册bean

  ```java
  private final Map<String, BeanDefinition> beanDefinitionMap = new ConcurrentHashMap<>(256);
  ```

* SimpleBeanDefinitionRegistry

  在该类中定义了如下代码，就是用来注册bean

  ```java
  private final Map<String, BeanDefinition> beanDefinitionMap = new ConcurrentHashMap<>(64);
  ```



- 自定义BeanDefinitionRegistry接口定义了注册表的相关操作，定义如下功能：

```java
public interface BeanDefinitionRegistry {

    //注册BeanDefinition对象到注册表中
    void registerBeanDefinition(String beanName, BeanDefinition beanDefinition);

    //从注册表中删除指定名称的BeanDefinition对象
    void removeBeanDefinition(String beanName) throws Exception;

    //根据名称从注册表中获取BeanDefinition对象
    BeanDefinition getBeanDefinition(String beanName) throws Exception;

    //判断注册表中是否包含指定名称的BeanDefinition对象
    boolean containsBeanDefinition(String beanName);

    //获取注册表中BeanDefinition对象的个数
    int getBeanDefinitionCount();

    //获取注册表中所有的BeanDefinition的名称
    String[] getBeanDefinitionNames();
}
```

- SimpleBeanDefinitionRegistry类, 该类实现了BeanDefinitionRegistry接口，定义了Map集合作为注册表容器。

```java
public class SimpleBeanDefinitionRegistry implements BeanDefinitionRegistry {

    private Map<String, BeanDefinition> beanDefinitionMap = new HashMap<String, BeanDefinition>();

    @Override
    public void registerBeanDefinition(String beanName, BeanDefinition beanDefinition) {
        beanDefinitionMap.put(beanName,beanDefinition);
    }

    @Override
    public void removeBeanDefinition(String beanName) throws Exception {
        beanDefinitionMap.remove(beanName);
    }

    @Override
    public BeanDefinition getBeanDefinition(String beanName) throws Exception {
        return beanDefinitionMap.get(beanName);
    }

    @Override
    public boolean containsBeanDefinition(String beanName) {
        return beanDefinitionMap.containsKey(beanName);
    }

    @Override
    public int getBeanDefinitionCount() {
        return beanDefinitionMap.size();
    }

    @Override
    public String[] getBeanDefinitionNames() {
        return beanDefinitionMap.keySet().toArray(new String[1]);
    }
}
```



##### 3) 创建解析器相关的类

BeanDefinitionReader接口

- BeanDefinitionReader用来解析配置文件并在注册表中注册bean的信息。定义了两个规范：
  * 获取注册表的功能,让外界可以通过该对象获取注册表对象
  * 加载配置文件,并注册bean数据

```java
/**
 * 该类定义解析配置文件规则的接口
 * @author spikeCong
 * @date 2022/10/28
 **/
public interface BeanDefinitionReader {

    //获取注册表对象
    BeanDefinitionRegistry getRegistry();

    //加载配置文件并在注册表中进行注册
    void loadBeanDefinitions(String configLocation) throws Exception;
}
```

XmlBeanDefinitionReader类

- XmlBeanDefinitionReader是专门用来解析xml配置文件的。该类实现BeanDefinitionReader接口并实现接口中的两个功能。

```java
/**
 * 该类是对XML文件进行解析的类
 * @author spikeCong
 * @date 2022/10/28
 **/
public class XmlBeanDefinitionReader implements BeanDefinitionReader {

    //声明注册表对象(将配置文件与注册表解耦,通过Reader降低耦合性)
    private BeanDefinitionRegistry registry;

    public XmlBeanDefinitionReader() {
        registry = new SimpleBeanDefinitionRegistry();
    }

    @Override
    public BeanDefinitionRegistry getRegistry() {
        return registry;
    }

    //加载配置文件
    @Override
    public void loadBeanDefinitions(String configLocation) throws Exception {
        //使用dom4j解析xml
        SAXReader reader = new SAXReader();

        //获取配置文件,类路径下
        InputStream is = XmlBeanDefinitionReader.class.getClassLoader().getResourceAsStream(configLocation);

        //获取document文档对象
        Document document = reader.read(is);

        Element rootElement = document.getRootElement();
        //解析bean标签
        parseBean(rootElement);
    }

    private void parseBean(Element rootElement) {

        //获取所有的bean标签
        List<Element> elements = rootElement.elements();

        //遍历获取每个bean标签的属性值和子标签property
        for (Element element : elements) {

            String id = element.attributeValue("id");
            String className = element.attributeValue("class");

            //封装到beanDefinition
            BeanDefinition beanDefinition = new BeanDefinition();
            beanDefinition.setId(id);
            beanDefinition.setClassName(className);

            //获取property
            List<Element> list = element.elements("property");

            MutablePropertyValues mutablePropertyValues = new MutablePropertyValues();

            //遍历,封装propertyValue,并保存到mutablePropertyValues
            for (Element element1 : list) {
                String name = element1.attributeValue("name");
                String ref = element1.attributeValue("ref");
                String value = element1.attributeValue("value");
                PropertyValue propertyValue = new PropertyValue(name,ref,value);
                mutablePropertyValues.addPropertyValue(propertyValue);
            }

            //将mutablePropertyValues封装到beanDefinition
            beanDefinition.setPropertyValues(mutablePropertyValues);

            System.out.println(beanDefinition);
            //将beanDefinition注册到注册表
            registry.registerBeanDefinition(id,beanDefinition);
        }
    }
}
```



##### 4) 创建IOC容器相关的类

**1) BeanFactory接口**

在该接口中定义IOC容器的统一规范和获取bean对象的方法。

```java
/**
 * IOC容器父接口
 * @author spikeCong
 * @date 2022/10/28
 **/
public interface BeanFactory {

    Object getBean(String name)throws Exception;

    //泛型方法,传入当前类或者其子类
    <T> T getBean(String name ,Class<? extends T> clazz)throws Exception;
}

```

**2) ApplicationContext接口**

该接口的所有的子实现类对bean对象的创建都是非延时的，所以在该接口中定义 `refresh()` 方法，该方法主要完成以下两个功能：

* 加载配置文件。
* 根据注册表中的BeanDefinition对象封装的数据进行bean对象的创建。

```java
/**
 * 定义非延时加载功能
 * @author spikeCong
 * @date 2022/10/28
 **/
public interface ApplicationContext extends BeanFactory {

    //进行配置文件加载,并进行对象创建
    void refresh();
}
```

**3) AbstractApplicationContext类**

* 作为ApplicationContext接口的子类，所以该类也是非延时加载，所以需要在该类中定义一个Map集合，作为bean对象存储的容器。
* 声明BeanDefinitionReader类型的变量，用来进行xml配置文件的解析，符合单一职责原则。
* BeanDefinitionReader类型的对象创建交由子类实现，因为只有子类明确到底创建BeanDefinitionReader哪儿个子实现类对象。

```java
/**
 * ApplicationContext接口的子实现类
 *      创建容器对象时,加载配置文件,对bean进行初始化
 * @author spikeCong
 * @date 2022/10/28
 **/
public abstract class AbstractApplicationContext implements ApplicationContext {

    //声明解析器变量
    protected BeanDefinitionReader beanDefinitionReader;

    //定义存储bean对象的Map集合
    protected Map<String,Object> singletonObjects = new HashMap<>();

    //声明配置文件类路径的变量
    protected String configLocation;

    @Override
    public void refresh() {

        //加载beanDefinition对象
        try {
            beanDefinitionReader.loadBeanDefinitions(configLocation);
            //初始化bean
            finishBeanInitialization();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    //bean初始化
    protected  void finishBeanInitialization() throws Exception {
        //获取对应的注册表对象
        BeanDefinitionRegistry registry = beanDefinitionReader.getRegistry();

        //获取beanDefinition对象
        String[] beanNames = registry.getBeanDefinitionNames();
        for (String beanName : beanNames) {
            //进行bean的初始化
            getBean(beanName);
        }
    };
}
```

**4) ClassPathXmlApplicationContext类** 

该类主要是加载类路径下的配置文件，并进行bean对象的创建，主要完成以下功能：

* 在构造方法中，创建BeanDefinitionReader对象。
* 在构造方法中，调用refresh()方法，用于进行配置文件加载、创建bean对象并存储到容器中。
* 重写父接口中的getBean()方法，并实现依赖注入操作。

```java
/**
 * IOC容器具体的子实现类,加载XML格式配置文件
 * @author spikeCong
 * @date 2022/10/28
 **/
public class ClassPathXmlApplicationContext extends AbstractApplicationContext{

    public ClassPathXmlApplicationContext(String configLocation) {
        this.configLocation = configLocation;
        //构建解析器对象
        this.beanDefinitionReader = new XmlBeanDefinitionReader();

        this.refresh();
    }

    //跟据bean的对象名称获取bean对象
    @Override
    public Object getBean(String name) throws Exception {
        //判断对象容器中是否包含指定名称的bean对象,如果包含就返回,否则自行创建
        Object obj = singletonObjects.get(name);
        if(obj != null){
            return obj;
        }

        //自行创建,获取beanDefinition对象
        BeanDefinitionRegistry registry = beanDefinitionReader.getRegistry();
        BeanDefinition beanDefinition = registry.getBeanDefinition(name);

        //通过反射创建对象
        String className = beanDefinition.getClassName();
        Class<?> clazz = Class.forName(className);
        Object beanObj = clazz.newInstance();

        //CourseService与UserDao存依赖,所以要将UserDao一同初始化,进行依赖注入
        MutablePropertyValues propertyValues = beanDefinition.getPropertyValues();
        for (PropertyValue propertyValue : propertyValues) {
            //获取name属性值
            String propertyName = propertyValue.getName();
            //获取Value属性
            String value = propertyValue.getValue();
            //获取ref属性
            String ref = propertyValue.getRef();

            //ref与value只能存在一个
            if(ref != null && !"".equals(ref)){
                //获取依赖的bean对象,拼接set set+Course
                Object bean = getBean(ref);
                String methodName = StringUtils.getSetterMethodFieldName(propertyName);

                //获取所有方法对象
                Method[] methods = clazz.getMethods();
                for (Method method : methods) {
                    if(methodName.equals(method.getName())){
                        //执行该set方法
                        method.invoke(beanObj,bean);
                    }
                }
            }

            if(value != null && !"".equals(value)){
                String methodName = StringUtils.getSetterMethodFieldName(propertyName);
                //获取method
                Method method = clazz.getMethod(methodName, String.class);
                method.invoke(beanObj,value);
            }
        }

        //在返回beanObj之前 ,需要将对象存储到Map容器中
        this.singletonObjects.put(name,beanObj);


        return beanObj;
    }

    @Override
    public <T> T getBean(String name, Class<? extends T> clazz) throws Exception {
        Object bean = getBean(name);
        if(bean == null){
            return null;
        }

       return clazz.cast(bean);
    }
}
```

##### 5) 自定义IOC容器测试

第一步: 将我们写好的自定义IOC容器项目,安装到maven仓库中,使其他项目可以引入其依赖

```xml
//依赖信息
<dependencies>
    <dependency>
        <groupId>com.mashibing</groupId>
        <artifactId>user_defined_springioc</artifactId>
        <version>1.0-SNAPSHOT</version>
    </dependency>
</dependencies>
```

第二步: 创建一个新的maven项目,引入上面的依赖,项目结构如下



第三步: 完成代码编写

- dao

```java
public interface CourseDao {
    public void add();
}

public class CourseDaoImpl implements CourseDao {

    //value注入
    private String courseName;

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public CourseDaoImpl() {
        System.out.println("CourseDaoImpl创建了......");
    }

    @Override
    public void add() {
        System.out.println("CourseDaoImpl的add方法执行了......" + courseName);
    }
}
```

- service

```java
public interface CourseService {

    public void add();
}

public class CourseServiceImpl implements CourseService {

    public CourseServiceImpl() {
        System.out.println("CourseServiceImpl创建了......");
    }

    private CourseDao courseDao;

    public void setCourseDao(CourseDao courseDao) {
        this.courseDao = courseDao;
    }

    @Override
    public void add() {
        System.out.println("CourseServiceImpl的add方法执行了......");
        courseDao.add();
    }
}
```

- applicationContext.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans>
    <bean id="courseService" class="com.mashibing.test_springioc.service.impl.CourseServiceImpl">
        <property name="courseDao" ref="courseDao"></property>
    </bean>
    <bean id="courseDao" class="com.mashibing.test_springioc.dao.impl.CourseDaoImpl">
        <property name="courseName" value="java"></property>
    </bean>
</beans>
```

- Controller

```java
public class CourseController{

    public static void main(String[] args) {
        //1.创建Spring的容器对象
        ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");

        //2.从容器对象中获取CourseService对象
        CourseService courseService = context.getBean("courseService", CourseService.class);

        //3.调用UserService的add方法
        courseService.add();
    }
}
```

##### 6) 案例中使用到的设计模式

* 工厂模式。这个使用工厂模式 + 配置文件的方式。
* 单例模式。Spring IOC管理的bean对象都是单例的，此处的单例不是通过构造器进行单例的控制的，而是spring框架对每一个bean只创建了一个对象。
* 模板方法模式。AbstractApplicationContext类中的finishBeanInitialization()方法调用了子类的getBean()方法，因为getBean()的实现和环境息息相关。
* 迭代器模式。对于MutablePropertyValues类定义使用到了迭代器模式，因为此类存储并管理PropertyValue对象，也属于一个容器，所以给该容器提供一个遍历方式。

### 7.2 剖析MyBatis框架中用到的经典设计模式

#### 7.2.1 MyBatis回顾

##### 7.2.1.1 MyBatis与ORM框架

MyBatis 是一个 ORM（Object Relational Mapping，对象 - 关系映射）框架。ORM 框架主要是根据类和数据库表之间的映射关系，帮助程序员自动实现对象与数据库中数据之间的互相转化。

> ORM 负责将程序中的对象 存储到数据库中、将数据库中的数据转化为程序中的对象

<img src="马士兵-学习笔记-沈俊杰.assets/149.jpg" alt="image-20220530160637842" style="zoom: 100%;" />
**Mybatis架构** 

<img src="马士兵-学习笔记-沈俊杰.assets/150.jpg" alt="image-20220530160637842" style="zoom: 50%;" />   

```txt
1、mybatis配置

SqlMapConfig.xml，此文件作为mybatis的全局配置文件，配置了mybatis的运行环境等信息。

mapper.xml文件即sql映射文件，文件中配置了操作数据库的sql语句。此文件需要在SqlMapConfig.xml中加载。

2、通过mybatis环境等配置信息构造SqlSessionFactory即会话工厂

3、由会话工厂创建sqlSession即会话，操作数据库需要通过sqlSession进行。

4、mybatis底层自定义了Executor执行器接口操作数据库，Executor接口有两个实现，一个是基本执行器、一个是缓存执行器。

5、Mapped Statement也是mybatis一个底层封装对象，它包装了mybatis配置信息及sql映射信息等。mapper.xml文件中一个sql对应一个Mapped Statement对象，sql的id即是Mapped statement的id。

6、Mapped Statement对sql执行输入参数进行定义，包括HashMap、基本类型、pojo，Executor通过Mapped Statement在执行sql前将输入的java对象映射至sql中，输入参数映射就是jdbc编程中对preparedStatement设置参数。

7、Mapped Statement对sql执行输出结果进行定义，包括HashMap、基本类型、pojo，Executor通过Mapped Statement在执行sql后将输出结果映射至java对象中，输出结果映射过程相当于jdbc编程中对结果的解析处理过程。
```



#### 7.2.1.1 MyBatis的基础使用

因为 MyBatis 依赖 JDBC 驱动，所以，在项目中使用 MyBatis，除了需要引入 MyBatis 框 架本身（mybatis.jar）之外，还需要引入 JDBC 驱动（比如，访问 MySQL 的 JDBC 驱动 实现类库 mysql-connector-java.jar）。

1) 导入MyBatis的坐标和其他相关坐标

```xml
<!--mybatis坐标-->
<dependency>
    <groupId>org.mybatis</groupId>
    <artifactId>mybatis</artifactId>
    <version>3.5.4</version>
</dependency>
<!--mysql驱动坐标-->
<dependency>    
    <groupId>mysql</groupId>   
    <artifactId>mysql-connector-java</artifactId>    
    <version>5.1.6</version>    
    <scope>runtime</scope>
</dependency>
<!--单元测试坐标-->
<dependency>    
    <groupId>junit</groupId>    
    <artifactId>junit</artifactId>    
    <version>4.12</version>    
    <scope>test</scope>
</dependency>
<!--日志坐标-->
<dependency>    
    <groupId>log4j</groupId>    
    <artifactId>log4j</artifactId>    
    <version>1.2.17</version>
</dependency>
```

2) 创建user数据表

```sql
CREATE DATABASE `mybatis_db`;
USE `mybatis_db`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL auto_increment,
  `username` varchar(32) NOT NULL COMMENT '用户名称',
  `birthday` datetime default NULL COMMENT '生日',
  `sex` char(1) default NULL COMMENT '性别',
  `address` varchar(256) default NULL COMMENT '地址',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- insert.... 略
```

3. 编写User实体

```java
public class User {
    private Integer id;
    private String username;
    private Date birthday;
    private String sex;
    private String address;
    // getter/setter 略
}
```

4)  编写UserMapper映射文件

```java
public interface UserMapper {

    public List<User> findAll();
}
```

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.mashibing.mapper.UserMapper">
    <!--查询所有-->
    <select id="findAll" resultType="com.mashibing.domain.User">
        select * from user
    </select>
</mapper>
```

5. 编写MyBatis核心文件

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE configuration
        PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
    <!--环境配置-->
    <environments default="mysql">
        <!--使用MySQL环境-->
        <environment id="mysql">
            <!--使用JDBC类型事务管理器-->
            <transactionManager type="JDBC"></transactionManager>
            <!--使用连接池-->
            <dataSource type="POOLED">
                <property name="driver" value="com.mysql.jdbc.Driver"></property>
                <property name="url" value="jdbc:mysql:///mybatis_test"></property>
                <property name="username" value="root"></property>
                <property name="password" value="123456"></property>
            </dataSource>
        </environment>
    </environments>

    <!--加载映射配置-->
    <mappers>
        <mapper resource="com/mashibing/mapper/UserMapper.xml"></mapper>
    </mappers>
</configuration>
```

6. 编写测试类

```java
public class MainApp {

    public static void main(String[] args) throws IOException {

        // 加载核心配置文件
        InputStream is = Resources.getResourceAsStream("SqlMapConfig.xml");
        // 获取SqlSessionFactory工厂对象
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
        // 获取SqlSession会话对象
        SqlSession sqlSession = sqlSessionFactory.openSession();
        // 执行sql
        List<User> list = sqlSession.selectList("com.mashibing.mapper.UserMapper.findAll");
        for (User user : list) {
            System.out.println(user);
        }
        // 释放资源
        sqlSession.close();
    }
}
```

#### 7.2.2 MyBatis中使用到的设计模式

##### 7.2.2.1 Builder模式

Builder模式的定义是“将一个复杂对象的构建与它的表示分离，使得同样的构建过程可以创建不同的表示。”，它属于创建类模式，建造者模式可以将部件和其组装过程分开，一步一步创建一个复杂的对象。用户只需要指定复杂对象的类型就可以得到该对象，而无须知道其内部的具体构造细节。

《effective-java》中第2条也提到：**遇到多个构造器参数时，考虑用构建者(Builder)模式**。

<img src="马士兵-学习笔记-沈俊杰.assets/52.jpg" alt="image-20220530160637842" style="zoom: 50%;" />

在Mybatis环境的初始化过程中，`SqlSessionFactoryBuilder`会调用`XMLConfigBuilder`读取所有的`MybatisMapConfig.xml`和所有的`*Mapper.xml`文件，构建Mybatis运行的核心对象`Configuration`对象，然后将该`Configuration`对象作为参数构建一个`SqlSessionFactory`对象。

<img src="马士兵-学习笔记-沈俊杰.assets/154.jpg" alt="image-20220530160637842" style="zoom: 100%;" />  

其中`XMLConfigBuilder`在构建`Configuration`对象时，也会调用`XMLMapperBuilder`用于读取`*.Mapper`文件，而`XMLMapperBuilder`会使用`XMLStatementBuilder`来读取和build所有的SQL语句。

<img src="马士兵-学习笔记-沈俊杰.assets/155.jpg" alt="image-20220530160637842" style="zoom: 100%;" /> 

<img src="马士兵-学习笔记-沈俊杰.assets/156.jpg" alt="image-20220530160637842" style="zoom: 100%;" />

<img src="马士兵-学习笔记-沈俊杰.assets/157.jpg" alt="image-20220530160637842" style="zoom: 100%;" /> 

在这个过程中，有一个相似的特点，就是这些Builder会读取文件或者配置，然后做大量的XpathParser解析、配置或语法的解析、反射生成对象、存入结果缓存等步骤，这么多的工作都不是一个构造函数所能包括的，因此大量采用了Builder模式来解决。

对于builder的具体类，方法都大都用`build*`开头，比如`SqlSessionFactoryBuilder`为例，它包含以下方法：

<img src="马士兵-学习笔记-沈俊杰.assets/151.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

从建造者模式的设计初衷上来看，SqlSessionFactoryBuilder 虽然带有 Builder 后缀，但 不要被它的名字所迷惑，它并不是标准的建造者模式。一方面，原始类 SqlSessionFactory 的构建只需要一个参数，并不复杂。

另一方面，Builder 类SqlSessionFactoryBuilder 仍然定义了多包含不同参数列表的构造函数。 实际上，SqlSessionFactoryBuilder 设计的初衷只不过是为了简化开发。因为构建 SqlSessionFactory 需要先构建 Configuration，而构建 Configuration 是非常复杂的，需 要做很多工作，比如配置的读取、解析、创建 n 多对象等。为了将构建 SqlSessionFactory 的过程隐藏起来，对程序员透明，MyBatis 就设计了 SqlSessionFactoryBuilder 类封装这些构建细节。

#### 7.2.2.2 工厂模式

在Mybatis中比如`SqlSessionFactory`使用的是工厂模式，该工厂没有那么复杂的逻辑，是一个简单工厂模式。

简单工厂模式(Simple Factory Pattern)：又称为静态工厂方法(Static Factory Method)模式，它属于类创建型模式。在简单工厂模式中，可以根据参数的不同返回不同类的实例。简单工厂模式专门定义一个类来负责创建其他类的实例，被创建的实例通常都具有共同的父类。

<img src="马士兵-学习笔记-沈俊杰.assets/158.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

`SqlSession`可以认为是一个Mybatis工作的核心的接口，通过这个接口可以执行执行SQL语句、获取Mappers、管理事务。类似于连接MySQL的`Connection`对象。

<img src="马士兵-学习笔记-沈俊杰.assets/159.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

可以看到，该Factory的`openSession（）`方法重载了很多个，分别支持`autoCommit`、`Executor`、`Transaction` 等参数的输入，来构建核心的`SqlSession`对象。

在`DefaultSqlSessionFactory`的默认工厂实现里，有一个方法可以看出工厂怎么产出一个产品：

<img src="马士兵-学习笔记-沈俊杰.assets/160.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

openSessionFromDataSource方法,

<img src="马士兵-学习笔记-沈俊杰.assets/161.jpg" alt="image-20220530160637842" style="zoom: 50%;" />

这是一个openSession调用的底层方法，该方法先从configuration读取对应的环境配置，然后初始化`TransactionFactory`获得一个`Transaction`对象，然后通过`Transaction`获取一个`Executor`对象，最后通过configuration、Executor、是否autoCommit三个参数构建了`SqlSession`。

#### 7.2.2.3 单例模式

单例模式(Singleton Pattern)：单例模式确保某一个类只有一个实例，而且自行实例化并向整个系统提供这个实例，这个类称为单例类，它提供全局访问的方法。

单例模式的要点有三个：一是某个类只能有一个实例；二是它必须自行创建这个实例；三是它必须自行向整个系统提供这个实例。单例模式是一种对象创建型模式。单例模式又名单件模式或单态模式。

在Mybatis中有两个地方用到单例模式，`ErrorContext`和`LogFactory`，其中`ErrorContext`是用在每个线程范围内的单例，用于记录该线程的执行环境错误信息，而`LogFactory`则是提供给整个Mybatis使用的日志工厂，用于获得针对项目配置好的日志对象。

```java
public class ErrorContext {

    private static final ThreadLocal<ErrorContext> LOCAL = new ThreadLocal<>();

    private ErrorContext() {
    }

    public static ErrorContext instance() {
        ErrorContext context = LOCAL.get();
        if (context == null) {
            context = new ErrorContext();
            LOCAL.set(context);
        }
        return context;
    }

}
```

构造函数是private修饰，具有一个static的局部instance变量和一个获取instance变量的方法，在获取实例的方法中，先判断是否为空如果是的话就先创建，然后返回构造好的对象。

只是这里有个有趣的地方是，LOCAL的静态实例变量使用了`ThreadLocal`修饰，也就是说它属于每个线程各自的数据，而在`instance()`方法中，先获取本线程的该实例，如果没有就创建该线程独有的`ErrorContext`。

#### 7.2.2.4 代理模式

代理模式可以认为是Mybatis的核心使用的模式，正是由于这个模式，我们只需要编写`Mapper.java`接口，不需要实现，由Mybatis后台帮我们完成具体SQL的执行。

代理模式(Proxy Pattern) ：给某一个对象提供一个代 理，并由代理对象控制对原对象的引用。代理模式的英 文叫做Proxy，它是一种对象结构型模式。

<img src="马士兵-学习笔记-沈俊杰.assets/66.jpg" alt="image-20220530160637842" style="zoom: 80%;" /> 

这里有两个步骤，第一个是提前创建一个Proxy，第二个是使用的时候会自动请求Proxy，然后由Proxy来执行具体事务；

当我们使用`Configuration`的`getMapper`方法时，会调用`mapperRegistry.getMapper`方法，而该方法又会调用`mapperProxyFactory.newInstance(sqlSession)`来生成一个具体的代理：

<img src="马士兵-学习笔记-沈俊杰.assets/162.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

<img src="马士兵-学习笔记-沈俊杰.assets/163.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

```java
/**
 * Mapper Proxy 工厂类
 *
 * @author Lasse Voss
 */
public class MapperProxyFactory<T> {

    /**
     * Mapper 接口
     */
    private final Class<T> mapperInterface;
    /**
     * 方法与 MapperMethod 的映射
     */
    private final Map<Method, MapperMethod> methodCache = new ConcurrentHashMap<>();

    public MapperProxyFactory(Class<T> mapperInterface) {
        this.mapperInterface = mapperInterface;
    }

    public Class<T> getMapperInterface() {
        return mapperInterface;
    }

    public Map<Method, MapperMethod> getMethodCache() {
        return methodCache;
    }

    @SuppressWarnings("unchecked")
    protected T newInstance(MapperProxy<T> mapperProxy) {

        return (T) Proxy.newProxyInstance(mapperInterface.getClassLoader(), new Class[]{mapperInterface}, mapperProxy);
    }

   //MapperProxyFactory类中的newInstance方法
    public T newInstance(SqlSession sqlSession) {
        // 创建了JDK动态代理的invocationHandler接口的实现类mapperProxy
        final MapperProxy<T> mapperProxy = new MapperProxy<>(sqlSession, mapperInterface, methodCache);
        // 调用了重载方法
        return newInstance(mapperProxy);
    }

}
```

在这里，先通过`T newInstance(SqlSession sqlSession)`方法会得到一个`MapperProxy`对象，然后调用`T newInstance(MapperProxy<T> mapperProxy)`生成代理对象然后返回。

而查看`MapperProxy`的代码，可以看到如下内容：

```java
public class MapperProxy<T> implements InvocationHandler, Serializable {

    private static final long serialVersionUID = -6424540398559729838L;

    /**
     * SqlSession 对象
     */
    private final SqlSession sqlSession;
    /**
     * Mapper 接口
     */
    private final Class<T> mapperInterface;
    /**
     * 方法与 MapperMethod 的映射
     *
     * 从 {@link MapperProxyFactory#methodCache} 传递过来
     */
    private final Map<Method, MapperMethod> methodCache;

    // 构造，传入了SqlSession，说明每个session中的代理对象的不同的！
    public MapperProxy(SqlSession sqlSession, Class<T> mapperInterface, Map<Method, MapperMethod> methodCache) {
        this.sqlSession = sqlSession;
        this.mapperInterface = mapperInterface;
        this.methodCache = methodCache;
    }

    @Override
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
        try {
            // 如果是 Object 定义的方法，直接调用
            if (Object.class.equals(method.getDeclaringClass())) {
                return method.invoke(this, args);

            } else if (isDefaultMethod(method)) {
                return invokeDefaultMethod(proxy, method, args);
            }
        } catch (Throwable t) {
            throw ExceptionUtil.unwrapThrowable(t);
        }
        // 获得 MapperMethod 对象
        final MapperMethod mapperMethod = cachedMapperMethod(method);
        // 重点在这：MapperMethod最终调用了执行的方法
        return mapperMethod.execute(sqlSession, args);
    }

}
```

非常典型的，该`MapperProxy`类实现了`InvocationHandler`接口，并且实现了该接口的`invoke`方法。

通过这种方式，我们只需要编写`Mapper.java`接口类，当真正执行一个`Mapper`接口的时候，就会转发给`MapperProxy.invoke`方法，而该方法则会调用后续的`sqlSession.cud>executor.execute>prepareStatement`等一系列方法，完成SQL的执行和返回。

#### 7.2.2.5 组合模式

组合模式(Composite Pattern) 的定义是：将对象组合成树形结构以表示整个部分的层次结构.组合模式可以让用户统一对待单个对象和对象的组合.

组合模式其实就是将一组对象(文件夹和文件)组织成树形结构,以表示一种'部分-整体' 的层次结构,(目录与子目录的嵌套结构). 组合模式让客户端可以统一单个对象(文件)和组合对象(文件夹)的处理逻辑(递归遍历).

<img src="马士兵-学习笔记-沈俊杰.assets/96.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

Mybatis支持动态SQL的强大功能，比如下面的这个SQL：

```xml
<update id="update" parameterType="org.format.dynamicproxy.mybatis.bean.User">
    UPDATE users
    <trim prefix="SET" prefixOverrides=",">
        <if test="name != null and name != ''">
            name = #{name}
        </if>
        <if test="age != null and age != ''">
            , age = #{age}
        </if>
        <if test="birthday != null and birthday != ''">
            , birthday = #{birthday}
        </if>
    </trim>
    where id = ${id}
</update>
```

在这里面使用到了trim、if等动态元素，可以根据条件来生成不同情况下的SQL；

在`DynamicSqlSource.getBoundSql`方法里，调用了`rootSqlNode.apply(context)`方法，`apply`方法是所有的动态节点都实现的接口：

```java
/**
 * SQL Node 接口，每个 XML Node 会解析成对应的 SQL Node 对象
 * @author Clinton Begin
 */
public interface SqlNode {

    /**
     * 应用当前 SQL Node 节点
     *
     * @param context 上下文
     * @return 当前 SQL Node 节点是否应用成功。
     */
    boolean apply(DynamicContext context);
}
```

对于实现该`SqlSource`接口的所有节点，就是整个组合模式树的各个节点：

<img src="马士兵-学习笔记-沈俊杰.assets/164.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

组合模式的简单之处在于，所有的子节点都是同一类节点，可以递归的向下执行，比如对于TextSqlNode，因为它是最底层的叶子节点，所以直接将对应的内容append到SQL语句中：

<img src="马士兵-学习笔记-沈俊杰.assets/165.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

但是对于IfSqlNode，就需要先做判断，如果判断通过，仍然会调用子元素的SqlNode，即`contents.apply`方法，实现递归的解析。

<img src="马士兵-学习笔记-沈俊杰.assets/166.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

#### 7.2.2.6 模板方法模式

**模板方法模式(template method pattern)原始定义是：在操作中定义算法的框架，将一些步骤推迟到子类中。模板方法让子类在不改变算法结构的情况下重新定义算法的某些步骤。**

模板方法中的算法可以理解为广义上的业务逻辑,并不是特指某一个实际的算法.定义中所说的算法的框架就是模板, 包含算法框架的方法就是模板方法.

模板类定义一个操作中的算法的骨架，而将一些步骤延迟到子类中。使得子类可以不改变一个算法的结构即可重定义该算法的某些特定步骤。

<img src="马士兵-学习笔记-沈俊杰.assets/109.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

在Mybatis中，sqlSession的SQL执行，都是委托给Executor实现的，Executor包含以下结构：

<img src="马士兵-学习笔记-沈俊杰.assets/167.jpg" alt="image-20220530160637842" style="zoom: 100%;" />  

其中的BaseExecutor就采用了模板方法模式，它实现了大部分的SQL执行逻辑，然后把以下几个方法交给子类定制化完成：

<img src="马士兵-学习笔记-沈俊杰.assets/177.jpg" alt="image-20220530160637842" style="zoom: 100%;" />  

```java
protected abstract int doUpdate(MappedStatement ms, Object parameter) throws SQLException;
```

该模板方法类有几个子类的具体实现，使用了不同的策略：

- 简单`SimpleExecutor`：每执行一次`update`或`select`，就开启一个`Statement`对象，用完立刻关闭`Statement`对象。（可以是`Statement`或`PrepareStatement`对象）
- 重用`ReuseExecutor`：执行`update`或`select`，以sql作为key查找`Statement`对象，存在就使用，不存在就创建，用完后，不关闭`Statement`对象，而是放置于`Map`内，供下一次使用。（可以是`Statement`或`PrepareStatement`对象）
- 批量`BatchExecutor`：执行update（没有select，JDBC批处理不支持select），将所有sql都添加到批处理中（`addBatch()`），等待统一执行（`executeBatch()`），它缓存了多个Statement对象，每个Statement对象都是`addBatch()`完毕后，等待逐一执行`executeBatch()`批处理的；`BatchExecutor`相当于维护了多个桶，每个桶里都装了很多属于自己的SQL，就像苹果蓝里装了很多苹果，番茄蓝里装了很多番茄，最后，再统一倒进仓库。（可以是Statement或PrepareStatement对象）

比如在SimpleExecutor中这样实现doUpdate方法：

<img src="马士兵-学习笔记-沈俊杰.assets/168.jpg" alt="image-20220530160637842" style="zoom: 100%;" /> 

模板模式基于继承来实现代码复用。如果抽象类中包含模板方法，模板方法调用有待子类实 现的抽象方法，那这一般就是模板模式的代码实现。而且，在命名上，模板方法与抽象方法 一般是一一对应的，抽象方法在模板方法前面多一个“do”，比如，在 BaseExecutor 类 中，其中一个模板方法叫 update()，那对应的抽象方法就叫 doUpdate()。

#### 7.2.2.7 适配器模式

适配器模式(Adapter Pattern) ：将一个接口转换成客户希望的另一个接口，适配器模式使接口不兼容的那些类可以一起工作，其别名为包装器(Wrapper)。适配器模式既可以作为类结构型模式，也可以作为对象结构型模式。

<img src="马士兵-学习笔记-沈俊杰.assets/88.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

在Mybatsi的logging包中，有一个Log接口：

<img src="马士兵-学习笔记-沈俊杰.assets/169.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

该接口定义了Mybatis直接使用的日志方法，而Log接口具体由谁来实现呢？Mybatis提供了多种日志框架的实现，这些实现都匹配这个Log接口所定义的接口方法，最终实现了所有外部日志框架到Mybatis日志包的适配：

<img src="马士兵-学习笔记-沈俊杰.assets/170.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

比如对于`Log4jImpl`的实现来说，该实现持有了`org.apache.log4j.Logger`的实例，然后所有的日志方法，均委托该实例来实现。

```java
/**
 * Copyright 2009-2017 the original author or authors.
 * <p>
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * <p>
 * http://www.apache.org/licenses/LICENSE-2.0
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.apache.ibatis.logging.log4j;

import org.apache.ibatis.logging.Log;
import org.apache.log4j.Level;
import org.apache.log4j.Logger;

/**
 * @author Eduardo Macarron
 */
public class Log4jImpl implements Log {

    private static final String FQCN = Log4jImpl.class.getName();

    private final Logger log;

    public Log4jImpl(String clazz) {
        log = Logger.getLogger(clazz);
    }

    @Override
    public boolean isDebugEnabled() {
        return log.isDebugEnabled();
    }

    @Override
    public boolean isTraceEnabled() {
        return log.isTraceEnabled();
    }

    @Override
    public void error(String s, Throwable e) {
        log.log(FQCN, Level.ERROR, s, e);
    }

    @Override
    public void error(String s) {
        log.log(FQCN, Level.ERROR, s, null);
    }

    @Override
    public void debug(String s) {
        log.log(FQCN, Level.DEBUG, s, null);
    }

    @Override
    public void trace(String s) {
        log.log(FQCN, Level.TRACE, s, null);
    }

    @Override
    public void warn(String s) {
        log.log(FQCN, Level.WARN, s, null);
    }
}
```

在适配器模式中，传递给适配器构造函数的是被适配的类对象，而这里是 clazz（相当于日志名称 name），所以，从代码实现上来讲，它并非标准的适配器模式。但是，从应用 场景上来看，这里确实又起到了适配的作用，是典型的适配器模式的应用场景。

#### 7.2.2.8 装饰者模式

装饰模式(Decorator Pattern) ：动态地给一个对象增加一些额外的职责(Responsibility)，就增加对象功能来说，装饰模式比生成子类实现更为灵活。其别名也可以称为包装器(Wrapper)，与适配器模式的别名相同，但它们适用于不同的场合。根据翻译的不同，装饰模式也有人称之为“油漆工模式”，它是一种对象结构型模式。

<img src="马士兵-学习笔记-沈俊杰.assets/82.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

在mybatis中，缓存的功能由根接口`Cache（org.apache.ibatis.cache.Cache）`定义。整个体系采用装饰器设计模式，数据存储和缓存的基本功能由`PerpetualCache（org.apache.ibatis.cache.impl.PerpetualCache）`永久缓存实现，然后通过一系列的装饰器来对`PerpetualCache`永久缓存进行缓存策略等方面的控制。如下图：

<img src="马士兵-学习笔记-沈俊杰.assets/171.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

用于装饰PerpetualCache的标准装饰器共有8个（全部在org.apache.ibatis.cache.decorators包中）：

<img src="马士兵-学习笔记-沈俊杰.assets/172.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

1. `FifoCache`：先进先出算法，缓存回收策略
2. `LoggingCache`：输出缓存命中的日志信息
3. `LruCache`：最近最少使用算法，缓存回收策略
4. `ScheduledCache`：调度缓存，负责定时清空缓存
5. `SerializedCache`：缓存序列化和反序列化存储
6. `SoftCache`：基于软引用实现的缓存管理策略
7. `SynchronizedCache`：同步的缓存装饰器，用于防止多线程并发访问
8. `WeakCache`：基于弱引用实现的缓存管理策略

之所以 MyBatis 采用装饰器模式来实现缓存功能，是因为装饰器模式采用了组合，而非继 承，更加灵活，能够有效地避免继承关系的组合爆炸。



##### MyBatis一级缓存

缓存就是内存中的数据，常常来自对数据库查询结果的保存。使用缓存，我们可以避免频繁的与数据库进行交互，进而提高响应速度MyBatis也提供了对缓存的支持，分为一级缓存和二级缓存，可以通过下图来理解：

<img src="马士兵-学习笔记-沈俊杰.assets/179.jpg" alt="image-20220530160637842" style="zoom: 100%;" /> 

①、一级缓存是SqlSession级别的缓存。在操作数据库时需要构造sqlSession对象，在对象中有一个数据结构（HashMap）用于存储缓存数据。不同的sqlSession之间的缓存数据区域（HashMap）是互相不影响的。

②、二级缓存是mapper级别的缓存，多个SqlSession去操作同一个Mapper的sql语句，多个SqlSession可以共用二级缓存，二级缓存是跨SqlSession的



**一级缓存默认是开启的**

①、我们使用同一个sqlSession，对User表根据相同id进行两次查询，查看他们发出sql语句的情况

```java
   public static void main(String[] args) throws IOException {

        // 加载核心配置文件
        InputStream is = Resources.getResourceAsStream("SqlMapConfig.xml");

        // 获取SqlSessionFactory工厂对象
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);

        // 获取SqlSession会话对象
        SqlSession sqlSession = sqlSessionFactory.openSession();

        User user1 = sqlSession.selectOne("com.mashibing.mapper.UserMapper.findById",1);

        User user2 = sqlSession.selectOne("com.mashibing.mapper.UserMapper.findById",1);
        System.out.println(user1);
        System.out.println(user2);

        System.out.println(user1 == user2);

        // 释放资源
        sqlSession.close();
    }


//打印结果
User{id=1, username='tom', birthday=Sat Oct 01 17:27:27 CST 2022, sex='0', address='北京'}
User{id=1, username='tom', birthday=Sat Oct 01 17:27:27 CST 2022, sex='0', address='北京'}
true
```

②  同样是对user表进行两次查询，只不过两次查询之间进行了一次update操作。

```java
public static void main(String[] args) throws IOException {

    // 加载核心配置文件
    InputStream is = Resources.getResourceAsStream("SqlMapConfig.xml");

    // 获取SqlSessionFactory工厂对象
    SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);

    // 获取SqlSession会话对象
    SqlSession sqlSession = sqlSessionFactory.openSession();


    User user1 = sqlSession.selectOne("com.mashibing.mapper.UserMapper.findById",1);
    System.out.println(user1);

    sqlSession.delete("com.mashibing.mapper.UserMapper.deleteById",3);
    sqlSession.commit();

    User user2 = sqlSession.selectOne("com.mashibing.mapper.UserMapper.findById",1);

    System.out.println(user2);

    System.out.println(user1 == user2);

    // 释放资源
    sqlSession.close();
}

//结果
User{id=1, username='tom', birthday=Sat Oct 01 17:27:27 CST 2022, sex='0', address='北京'}
User{id=1, username='tom', birthday=Sat Oct 01 17:27:27 CST 2022, sex='0', address='北京'}
false
```

③、**总结**

1、第一次发起查询用户id为1的用户信息，先去找缓存中是否有id为1的用户信息，如果没有，从 数据库查询用户信息。得到用户信息，将用户信息存储到一级缓存中。

2、 如果中间sqlSession去执行commit操作（执行插入、更新、删除），则会清空SqlSession中的 一级缓存，这样做的目的为了让缓存中存储的是最新的信息，避免脏读。

3、 第二次发起查询用户id为1的用户信息，先去找缓存中是否有id为1的用户信息，缓存中有，直 接从缓存中获取用户信息



**1. 一级缓存 底层数据结构到底是什么？**

之前说`不同SqlSession的一级缓存互不影响`,所以我从SqlSession这个类入手

<img src="马士兵-学习笔记-沈俊杰.assets/180.jpg" alt="image-20220530160637842" style="zoom: 100%;" /> 

可以看到，`org.apache.ibatis.session.SqlSession`中有一个和缓存有关的方法——`clearCache()`刷新缓存的方法，点进去，找到它的实现类`DefaultSqlSession`

```java
  @Override
  public void clearCache() {
    executor.clearLocalCache();
  }
```

再次点进去`executor.clearLocalCache()`,再次点进去并找到其实现类`BaseExecutor`，

```java
  @Override
  public void clearLocalCache() {
    if (!closed) {
      localCache.clear();
      localOutputParameterCache.clear();
    }
  
```

进入`localCache.clear()`方法。进入到了`org.apache.ibatis.cache.impl.PerpetualCache`类中

```java
package org.apache.ibatis.cache.impl;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.locks.ReadWriteLock;
import org.apache.ibatis.cache.Cache;
import org.apache.ibatis.cache.CacheException;
/**
 * @author Clinton Begin
 */
public class PerpetualCache implements Cache {
  private final String id;

  private Map<Object, Object> cache = new HashMap<Object, Object>();

  public PerpetualCache(String id) {
    this.id = id;
  }

  //省略部分...
  @Override
  public void clear() {
    cache.clear();
  }
  //省略部分...
}

```

我们看到了`PerpetualCache`类中有一个属性`private Map<Object, Object> cache = new HashMap<Object, Object>()`，很明显它是一个HashMap，我们所调用的`.clear()`方法，**实际上就是调用的Map的clear方法**

<img src="马士兵-学习笔记-沈俊杰.assets/181.jpg" alt="image-20220530160637842" style="zoom: 100%;" /> 

**得出结论：**

一级缓存的数据结构确实是HashMap

<img src="马士兵-学习笔记-沈俊杰.assets/182.jpg" alt="image-20220530160637842" style="zoom: 100%;" /> 

##### 一级缓存的执行流程 

我们进入到`org.apache.ibatis.executor.Executor`中
看到一个方法`CacheKey createCacheKey(MappedStatement ms, Object parameterObject, RowBounds rowBounds, BoundSql boundSql)` ，见名思意是一个创建CacheKey的方法
找到它的实现类和方法`org.apache.ibatis.executor.BaseExecuto.createCacheKey`

<img src="马士兵-学习笔记-沈俊杰.assets/183.jpg" alt="image-20220530160637842" style="zoom: 100%;" /> 

我们分析一下创建CacheKey的这块代码：

```java
public CacheKey createCacheKey(MappedStatement ms, Object parameterObject, RowBounds rowBounds, BoundSql boundSql) {
    if (closed) {
      throw new ExecutorException("Executor was closed.");
    }
    //初始化CacheKey
    CacheKey cacheKey = new CacheKey();
    //存入statementId
    cacheKey.update(ms.getId());
    //分别存入分页需要的Offset和Limit
    cacheKey.update(rowBounds.getOffset());
    cacheKey.update(rowBounds.getLimit());
    //把从BoundSql中封装的sql取出并存入到cacheKey对象中
    cacheKey.update(boundSql.getSql());
    //下面这一块就是封装参数
    List<ParameterMapping> parameterMappings = boundSql.getParameterMappings();
    TypeHandlerRegistry typeHandlerRegistry = ms.getConfiguration().getTypeHandlerRegistry();

    for (ParameterMapping parameterMapping : parameterMappings) {
      if (parameterMapping.getMode() != ParameterMode.OUT) {
        Object value;
        String propertyName = parameterMapping.getProperty();
        if (boundSql.hasAdditionalParameter(propertyName)) {
          value = boundSql.getAdditionalParameter(propertyName);
        } else if (parameterObject == null) {
          value = null;
        } else if (typeHandlerRegistry.hasTypeHandler(parameterObject.getClass())) {
          value = parameterObject;
        } else {
          MetaObject metaObject = configuration.newMetaObject(parameterObject);
          value = metaObject.getValue(propertyName);
        }
        cacheKey.update(value);
      }
    }
    //从configuration对象中（也就是载入配置文件后存放的对象）把EnvironmentId存入
        /**
     *     <environments default="development">
     *         <environment id="development"> //就是这个id
     *             <!--当前事务交由JDBC进行管理-->
     *             <transactionManager type="JDBC"></transactionManager>
     *             <!--当前使用mybatis提供的连接池-->
     *             <dataSource type="POOLED">
     *                 <property name="driver" value="${jdbc.driver}"/>
     *                 <property name="url" value="${jdbc.url}"/>
     *                 <property name="username" value="${jdbc.username}"/>
     *                 <property name="password" value="${jdbc.password}"/>
     *             </dataSource>
     *         </environment>
     *     </environments>
     */
    if (configuration.getEnvironment() != null) {
      // issue #176
      cacheKey.update(configuration.getEnvironment().getId());
    }
    //返回
    return cacheKey;
  }
```

我们再点进去`cacheKey.update()`方法看一看

```java
public class CacheKey implements Cloneable, Serializable {
  private static final long serialVersionUID = 1146682552656046210L;
  public static final CacheKey NULL_CACHE_KEY = new NullCacheKey();
  private static final int DEFAULT_MULTIPLYER = 37;
  private static final int DEFAULT_HASHCODE = 17;

  private final int multiplier;
  private int hashcode;
  private long checksum;
  private int count;
  //值存入的地方
  private transient List<Object> updateList;
  //省略部分方法......
  //省略部分方法......
  public void update(Object object) {
    int baseHashCode = object == null ? 1 : ArrayUtil.hashCode(object); 
    count++;
    checksum += baseHashCode;
    baseHashCode *= count;
    hashcode = multiplier * hashcode + baseHashCode;
    //看到把值传入到了一个list中
    updateList.add(object);
  }
 
  //省略部分方法......
}
```

我们知道了那些数据是在CacheKey对象中如何存储的了。下面我们返回`createCacheKey()`方法。

<img src="马士兵-学习笔记-沈俊杰.assets/1.jpg" alt="image-20220530160637842" style="zoom: 100%;" /> 

我们可以看到，创建CacheKey后调用了query()方法，我们再次点进去：

<img src="马士兵-学习笔记-沈俊杰.assets/2.jpg" alt="image-20220530160637842" style="zoom: 100%;" />

在执行SQL前如何在一级缓存中找不到Key，那么将会执行sql，我们来看一下执行sql前后会做些什么，进入`list = queryFromDatabase(ms, parameter, rowBounds, resultHandler, key, boundSql);`

```java
 private <E> List<E> queryFromDatabase(MappedStatement ms, Object parameter, RowBounds rowBounds, ResultHandler resultHandler, CacheKey key, BoundSql boundSql) throws SQLException {
    List<E> list;
    //1. 把key存入缓存，value放一个占位符
	localCache.putObject(key, EXECUTION_PLACEHOLDER);
    try {
      //2. 与数据库交互
      list = doQuery(ms, parameter, rowBounds, resultHandler, boundSql);
    } finally {
      //3. 如果第2步出了什么异常，把第1步存入的key删除
      localCache.removeObject(key);
    }
      //4. 把结果存入缓存
    localCache.putObject(key, list);
    if (ms.getStatementType() == StatementType.CALLABLE) {
      localOutputParameterCache.putObject(key, parameter);
    }
    return list;
  }
```

总结

1. 一级缓存的数据结构是一个`HashMap<Object,Object>`，它的value就是查询结果，它的key是`CacheKey`，`CacheKey`中有一个**list**属性，`statementId,params,rowbounds,sql`等参数都存入到了这个**list**中
2. 先创建`CacheKey`，会首先根据`CacheKey`查询缓存中有没有，如果有，就处理缓存中的参数，如果没有，就执行sql，执行sql后执行sql后把结果存入缓存

#### 7.2.2.9 迭代器模式

迭代器（Iterator）模式，又叫做游标（Cursor）模式。GOF给出的定义为：提供一种方法访问一个容器（container）对象中各个元素，而又不需暴露该对象的内部细节。

<img src="马士兵-学习笔记-沈俊杰.assets/121.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

在软件系统中,容器对象拥有两个职责: 一是存储数据,而是遍历数据.从依赖性上看,前者是聚合对象的基本职责.而后者是可变化的,又是可分离的.因此可以将遍历数据的行为从容器中抽取出来,封装到迭代器对象中,由迭代器来提供遍历数据的行为,这将简化聚合对象的设计,更加符合单一职责原则.

Java的`Iterator`就是迭代器模式的接口，只要实现了该接口，就相当于应用了迭代器模式：

<img src="马士兵-学习笔记-沈俊杰.assets/174.jpg" alt="image-20220530160637842" style="zoom: 50%;" /> 

比如Mybatis的`PropertyTokenizer`是property包中的重量级类，该类会被reflection包中其他的类频繁的引用到。这个类实现了`Iterator`接口，在使用时经常被用到的是`Iterator`接口中的`hasNext`这个函数。

```java
/**
 * 属性分词器
 *
 * @author Clinton Begin
 */
public class PropertyTokenizer implements Iterator<PropertyTokenizer> {

    /**
     * 当前字符串
     */
    private String name;
    /**
     * 索引的 {@link #name} ，因为 {@link #name} 如果存在 {@link #index} 会被更改
     */
    private final String indexedName;
    /**
     * 编号。
     *
     * 对于数组 name[0] ，则 index = 0
     * 对于 Map map[key] ，则 index = key
     */
    private String index;
    /**
     * 剩余字符串
     */
    private final String children;

    public PropertyTokenizer(String fullname) {
        // 初始化 name、children 字符串，使用 . 作为分隔
        int delim = fullname.indexOf('.');
        if (delim > -1) {
            name = fullname.substring(0, delim);
            children = fullname.substring(delim + 1);
        } else {
            name = fullname;
            children = null;
        }
        // 记录当前 name
        indexedName = name;
        // 若存在 [ ，则获得 index ，并修改 name 。
        delim = name.indexOf('[');
        if (delim > -1) {
            index = name.substring(delim + 1, name.length() - 1);
            name = name.substring(0, delim);
        }
    }

    public String getName() {
        return name;
    }

    public String getIndex() {
        return index;
    }

    public String getIndexedName() {
        return indexedName;
    }

    public String getChildren() {
        return children;
    }

    @Override
    public boolean hasNext() {
        return children != null;
    }

    @Override
    public PropertyTokenizer next() {
        return new PropertyTokenizer(children);
    }

    @Override
    public void remove() {
        throw new UnsupportedOperationException("Remove is not supported, as it has no meaning in the context of properties.");
    }

}
```

可以看到，这个类传入一个字符串到构造函数，然后提供了iterator方法对解析后的子串进行遍历，是一个很常用的方法类。

实际上，PropertyTokenizer 类也并非标准的迭代器类。它将配置的解析、解析之后的元 素、迭代器，这三部分本该放到三个类中的代码，都耦合在一个类中，所以看起来稍微有点 难懂。不过，这样做的好处是能够做到惰性解析。我们不需要事先将整个配置，解析成多个 PropertyTokenizer 对象。只有当我们在调用 next() 函数的时候，才会解析其中部分配 置。

### 7.3 总结

上面给大家讲解的就是Spring和MyBatis框架中所使用到的设计模式. 要再次强调的是, 对于同学们来说不需要去记忆哪个类用到了哪个模式, 死记硬背是没有意义的,同学们最好是下载一些优秀框架的源码,比如Spring或者MyBatis,然后抽出时间好好的阅读一下源码,锻炼自己阅读理解源码的能力.

除此之外同学们应该也有发现,其实框架对很多设计模式的实 现，都并非标准的代码实现，都做了比较多的自我改进。实际上，这就是所谓的灵活应用, 只借鉴不照搬, 根据具体问题针对性地去解决。



# 坦克大战

## 参考说明

本文内容主要来源于马士兵老师的视频教程（[Java经典实战项目-坦克大战](https://www.mashibing.com/study?courseNo=406&sectionNo=13324&systemId=1&courseVersionId=1307)），结合了老师的笔记以及根据自己的实践做了一些修改。



## 项目目的

坦克大战项目通过一个联机对战游戏的手把手，一行一行，从0到1的开发过程，让开发者精准的理解和运用JavaSE，设计模式，TCP/IP，多线程，NIO等基础知识。真正理解项目的开发过程，并体会项目开发的难点和痛点。只有做项目，才是对所学知识的真正检验。



## 环境配置

开发工具：idea，jdk：1.8

### maven依赖

```xml
	<dependencies>
        <dependency>
            <groupId>io.netty</groupId>
            <artifactId>netty-all</artifactId>
            <version>4.1.96.Final</version>
        </dependency>

        <dependency>
            <groupId>log4j</groupId>
            <artifactId>log4j</artifactId>
            <version>1.2.17</version>
        </dependency>

        <dependency>
            <groupId>org.slf4j</groupId>
            <artifactId>slf4j-api</artifactId>
            <version>1.7.25</version>
        </dependency>

        <dependency>
            <groupId>org.slf4j</groupId>
            <artifactId>slf4j-log4j12</artifactId>
            <version>1.7.25</version>
        </dependency>
    </dependencies>
```

### 日志配置

```properties
#Log4j configure
log4j.rootLogger=INFO,file,console

log4j.appender.file = org.apache.log4j.DailyRollingFileAppender
log4j.appender.file.Threshold=DEBUG
log4j.appender.file.Append=true
log4j.appender.file.DatePattern='_'yyyy-MM-dd'.log'
log4j.appender.file.File =log/tank-battle.log
log4j.appender.file.layout = org.apache.log4j.PatternLayout
log4j.appender.file.layout.ConversionPattern=%d{yyyy-MM-dd HH:mm:ss}[%-5p][%t]%M(%F:%L) %m%n

log4j.appender.console=org.apache.log4j.ConsoleAppender
log4j.appender.console.Threshold=DEBUG
log4j.appender.console.Target=System.out
log4j.appender.console.layout=org.apache.log4j.PatternLayout
log4j.appender.console.layout.ConversionPattern=%d{yyyy-MM-dd HH:mm:ss}[%-5p][%t]%M(%F:%L) %m%n
```



### 单元测试

给项目加入Maven的Junit5依赖

```xml
        <dependency>
            <groupId>org.junit.jupiter</groupId>
            <artifactId>junit-jupiter-engine</artifactId>
            <version>5.9.3</version>
            <scope>test</scope>
        </dependency>
```

新建单元测试类的步骤。

1. 在要创建单元测试的功能类上，依次点Code > generate > Test
2. 然后在弹出的窗口中，选择Junit版本为5，测试类名，测试方法等。然后点确定。
3. ![image-20230801224701278](沈俊杰-马士兵-架构设计.assets/image-20230801224701278.png)
4. IDEA会自动根据功能类的路径在test目录中创建相同路径但以Test结尾的测试类。并且会自动生成勾选方法的默认测试代码。
5. 根据程序的输入和输出，编写单元测试代码。
6. 点击方法左边的绿色三角形就可以执行单元测试用例了。

为什么要进行单元测试？

1. 方法内部可以很复杂，如果靠肉眼观察，比较耗时间。单元测试可以根据入参和返回值测试方法是否达到要求。
2. 代码是开发人员写的，最了解代码逻辑的还是开发人员。测试人员测试不到代码细节。
3. 在一个大的功能中，可能会有很多方法，每个方法都要写Main方法来一个个测试比较复杂，而且也不知道测了哪些场景。

为什么有的公司不做单元测试。

1. 代码业务可能比较简单，程序员读代码不是很费力。
2. 写单元测试需要额外花时间，程序员工作比较忙，没时间写。



## 开发说明

### 环境说明

开发工具为idea，jdk：1.8



### 总体流程

1. 使用awt实现一个简易版单机坦克大战。
2. 使用设计模式优化简易版
3. 使用Netty实现联机版坦克大战。




### bug分级

1. 编译错误
2. 运行时异常
   1. 同步日志中的异常，定位到错误代码行。
3. 运行没异常，结果不对（不符合预期）。
   1. 需要分析代码，分析日志。必要时还需要增加日志打印关键值。
4. 运行没异常，结果有时对有时不对。
   1. 需要比对正常情况和异常情况的日志的区别。
   2. 最好能找到必然重现条件。



## 单机简易版

1. 创建项目主Frame并显示

2. 绘制矩形方块

   1. 覆盖paint方法

3. 模拟动画效果，每隔一定时间重新绘制一个新的

   1. 循环调用repaint方法。
   2. repaint方法内部会调用update和paint方法，先更新绘制参数，然后重新绘制。

4. 让方块可以响应键盘操作。

   1. Frame.addKeyListener()方法，参数用内部类
   2. 为什么用内部类？高内聚，低耦合。
   3. 这种用法属于[观察者模式](#6.1 观察者模式)。
   4. 为什么不使用方法内部类（匿名内部类）？
      1. 类内部使用更加方便，例如：内部类访问更加方便的访问包装类的变量。
      2. 一种设计习惯，并不是绝对不能用。
   5. 内部类继承KeyAdapter，实现keyPressed方法。
      1. 为什么不实现KeyListener接口？实现接口要实现接口的所有方法，但其实并不是所有方法都有必要去实现。继承的这个类已经实现了接口方法。所以继承这个类之后只要实现自己想要的方法即可。
      2. 虽然叫KeyAdapter，但并不属于[适配器模式](#5.4 适配器模式)。

5. 根据不同的键盘响应，向不同的方向移动。

   1. 截止目前的代码，一共2个类：

   2. ```java
      @Slf4j
      public class Main {
          public static void newFrame() {
              Frame f = new Frame("tank war");
              f.setLocation(400,100);
              f.setSize(800,600);
              f.setVisible(true);
          }
      
          public static void main(String[] args) {
              log.info("tank war starting ...");
              Frame f = new TankFrame();
      
              for (; ; ) {
                  try {
                      TimeUnit.MILLISECONDS.sleep(25);
                      f.repaint();
                  } catch (InterruptedException e) {
                      log.error("paint-InterruptedException:", e);
                  }
              }
          }
      }
      
      @Slf4j
      public class TankFrame extends Frame {
          private int x = 100;
          private int y = 100;
          private final int SPEED = 5;
      
          public TankFrame() throws HeadlessException {
              this.setTitle("tank war");
              this.setLocation(400, 100);
              this.setSize(800, 600);
              this.setVisible(true);
              this.addKeyListener(new TankKeyListener());
          }
      
          /**
           * 覆盖此方法后，会在frame创建时就执行。
           * @param g
           */
          @Override
          public void paint(Graphics g) {
              g.fillRect(x, y, 50, 50);
          }
      
          /**
           * 继承的这个类已经实现了接口方法。所以继承这个类之后只要实现自己想要的方法即可
           */
          private class TankKeyListener extends KeyAdapter {
              @Override
              public void keyPressed(KeyEvent e) {
                  int keycode = e.getKeyCode();
                  switch (keycode) {
                      case KeyEvent.VK_LEFT:
                          x -= SPEED;
                          break;
                      case KeyEvent.VK_RIGHT:
                          x += SPEED;
                          break;
                      case KeyEvent.VK_UP:
                          y -= SPEED;
                          break;
                      case KeyEvent.VK_DOWN:
                          y += SPEED;
                          break;
                      default:
                          break;
                  }
              }
          }
      }
      ```

6. 考虑如果有多辆坦克怎么办？基于面向对象思想重新设计。

   1. 名词，抽象成类
   2. 动词，抽象成方法。
   3. 抽象出坦克类，封装坐标，速度，键盘响应事件。

7. 考虑坦克的炮筒和子弹要和行进方向一致？

   1. 设计一个坦克方向属性，当按下键盘是改变这个值。方向使用枚举类。
   2. 为什么不用int？使用int，例如：4个方向，1，2，3，4。但是阻止不了调用方set一个5。
   3. 这种错误，如果方法考虑不周，要等到运行时，才能发现。
   4. 如果使用枚举，编译的时候，就无法set第5个值。
   5. 和界面上的字段为什么有的要使用下拉框而不全部使用文本框是一个道理。

8. 给坦克指定图片，不再使用黑色长方形。

   1. 使用之前可以用单元测试，测试读取图片方法是否正确。

   2. 测试坦克的图片是否可以随着方向键自动旋转。（炮管要朝着运行方向）

   3. 将之前的绘制黑色长方形方法替换成绘制坦克图片。

   4. ```java
      private final static String tankNormal = "images/GoodTank1.png";
      
      public void paint(Graphics g) throws IOException {
              //g.fillRect(x, y, 50, 50);
              //使用坦克图片，绘制坦克
              BufferedImage tankL = ImageIO.read(this.getClass().getClassLoader().getResourceAsStream(tankNormal));
              g.drawImage(tankL, x, y, null);
          }
      ```

   1. 

9. 优化坦克图片加载

   1. 目前坦克的paint方法是每隔25ms调用一次，也就是说坦克图片的加载每秒中要加载40次
   2. 这里面存在性能问题，因为实际上坦克图片一旦加载成功了，后面一般情况下是不会变的。所以不需要加载这么多次。
   3. 考虑新建一个资源管理类，统一的维护坦克的上下左右的图片。其他三个方向的也只需要加载一次，然后旋转3次就可以了

### 解决图形闪烁问题

1. 闪烁的原因是图形数据是一点点传给显卡的显存然后显示的，由于显示器本身存在刷新频率，所以会将图形一点点的刷新显示

2. 解决方法是使用双缓冲覆盖update方法，repaint方法会先调用update然后调用paint方法。

3. 在调用paint方法让其显示到屏幕上之前，可以通过update方法将图形先在内存中画好。

```java
  /**
    * 用于解决图形闪烁问题。现在内存中画好图形，再让显卡一次性加载到现存中显示。
    * 如果把图形一点点传给显存，就会出现图片一点点刷新，也就是闪烁问题。
    * @param g Graphics 显卡的画笔
    */
   @Override
   public void update(Graphics g) {
       if (offScreenImage == null) {
           //创建一个和窗口一样大的Image对象（内存中）
           offScreenImage = this.createImage(GAME_WIDTH, GAME_HEIGHT);
       }
       //得到内存中的画笔（Graphics对象）
       Graphics gOffScreen = offScreenImage.getGraphics();
       Color c = gOffScreen.getColor();
       gOffScreen.setColor(Color.BLACK);
       gOffScreen.fillRect(0, 0, GAME_WIDTH, GAME_HEIGHT);
       gOffScreen.setColor(c);
       //在内存中先把这个图形画好
       paint(gOffScreen);
       //传给显卡显存的画笔，让图形显示到显示器上
       g.drawImage(offScreenImage, 0, 0, null);
   }
```



### 加入敌方坦克，让坦克发射子弹

1. 定义Group枚举类，区分我方（good），敌方（bad）
2. 创建一个子弹类，定义属性：坐标，长宽，方向等等
3. 在资源管理器中预加载子弹的图片。
4. 定义子弹绘制方法paint，并且在主窗口绘制时调用。
5. 定义子弹的移动方法，在绘制完了之后调用移动方法，移动方向和坦克方向一致。
6. 当按下ctrl键之后才让坦克发射子弹。

   1. 新建坦克的发射子弹方法（fire），创建子弹并加入到主窗口中。
   2. 在坦克的ctrl键释放事件中，调用刚刚创建的发射子弹方法。（避免按着键不松，一直不停的发射子弹）
   3. 在主窗口的绘制方法（paint）中加入子弹的绘制方法。
   4. 流程：主窗口显示>按下ctrl键>触发键盘事件>调用子弹发射方法>创建子弹对象>加入到主窗口的子弹列表中>每秒40次调用主窗口的paint方法>调用子弹的paint方法>不断改变子弹坐标方向>出现子弹发射出去的效果。

7. 降低主窗口和坦克子弹之间的耦合度

   1. 耦合度排行：继承最强 > 接口实现 > 成员变量 > 方法局部变量
   2. 将主窗口改成成为单例模式，其他对象需要时可以在方法中调用。

   

### 子弹性能问题解决

1. 打出的子弹都放在list中，没有销毁只是超出屏幕边界看不见，会越来越多直至内存溢出。
2. 在子弹中新增属性living，用于标记子弹是否已超出边界。
3. ```java
       /**
        * 检查子弹是否超出窗口边界
        */
       public void boundCheck() {
           if (x < 0 || x > TankFrame.GAME_WIDTH || y < 30 || y > TankFrame.GAME_HEIGHT) {
               living = false;
           }
       }
   ```
4. 在坦克的移动move方法中可以做边界检查，超出边界后就将living改成false。
5. 在主窗口的paint方法中做出判断，如果子弹living=false就不在绘制且从list中移除。
6. ```java
       public void paint(Graphics g) {
           try {
               Color c = g.getColor();
               g.setColor(Color.WHITE);
               g.drawString("bullets: " + bullets.size(), 10, 50);
               g.setColor(c);
   
               mytank.paint(g);
               enemy.paint(g);
               for (int i = 0; i < bullets.size(); i++) {
                   Bullet b = bullets.get(i);
                   if (b.isLiving()) {
                       bullets.get(i).paint(g);
                   } else {
                       //如果子弹超出边界则不在打印，且需要移除。否则可能内存泄露。
                       bullets.remove(i);
                   }
               }
           } catch (IOException e) {
               log.error("坦克绘制异常：", e);
           }
       }
   ```
7. 


### 当子弹打到坦克时出现中弹效果。

1. 需要判断出子弹是否触碰到了坦克的边缘，这个在游戏中叫碰撞检测。涉及很多形状不规则物体。
2. 在这个游戏里可以简单把坦克和子弹当成长方形，需要判断2个长方形是否相交。
3. 还需要考虑子弹的发出方，自己坦克，盟友，敌人。只有被敌人的子弹打中才会出现爆炸效果。
4. 在子弹和坦克的类中增加长方形rect属性，用于判断是否相撞。
5. 当绘制子弹时加入碰撞方法，检查子弹是否和坦克相撞，如果相撞则清除坦克和子弹


### 让敌方坦克自己动

1. 将玩家控制的坦克和敌方坦克分成2个类。
2. 敌方坦克不需要响应键盘事件，移动完了之后随机切换移动方向，同时随机发射子弹。
3. 坦克移动超出边界问题。使用临时变量记录新的坐标，校验新坐标是否超出边界，不超出在修改坐标。
4. ```java
       public void move() {
           int xNew = x;
           int yNew = y;
           switch (dir) {
               case LEFT:
                   xNew = x - SPEED;
                   break;
               case RIGHT:
                   xNew = x + SPEED;
                   break;
               case UP:
                   yNew = y- SPEED;
                   break;
               case DOWN:
                   yNew = y + SPEED;
                   break;
               default:
                   break;
           }
           if(boundCheck(xNew, yNew)){
               setX(xNew);
               setY(yNew);
           }
       }
   
   	/**
        * 检查对象是否超出窗口边界
        */
       public boolean boundCheck(int x, int y) {
           if (x < 0 || x > TankFrame.GAME_WIDTH - WIDTH || y < 30 || y > TankFrame.GAME_HEIGHT - HEIGHT) {
               log.info("坐标超出边界，x:{}，y:{}", x, y);
               return false;
           }
           return true;
       }
   ```

### 加入更多敌方坦克。

1. 将TankFrame中的敌方坦克改成List<Tank>，初始化时计算坐标循环加载
2. 循环子弹时，每一个子弹需要循环判断是否击中每一辆坦克。（也可以判断是否击中玩家坦克）
3. 为了防止多个敌方坦克互相残杀，在子弹的碰撞方法中需要考虑group，不一样时才算击中。


### 子弹打中坦克时出现爆炸效果

1. 新增一个类Explode，初始化加载16张爆炸图片。在TankFrame中也新增List<Explode>属性。
2. 在Explode中新增paint方法，每次调用都会按照顺序绘制1张爆炸图片，同时step+1
3. 当坦克被击中后就往TankFrame中，新增一个Explode的对象。
4. 在TankFrame的paint方法中，循环List<Explode>属性，调用explode的paint方法，
5. 当step达到数组的最大值时，爆炸效果绘制完毕，从List<Explode>中移除，下次就不会继续绘制了。


### 加入声音效果

1. Awt对于声音的支持并不是很好，所以声音播放仅做锦上添花只用。
2. 新增Audio类，用于加载和播放音乐。
3. 在Explode类的构造方法中，新建新的线程播放爆炸声"audio/explode.wav"
4. 在主窗口创建之前，新建线程循环播放背景音乐。"audio/war1.wav"
5. 在坦克移动和发射子弹时也新建线程，播放对应的音乐



## 设计模式优化版

将之前做好的保留，复制到一个新的包下，使用设计模式逐步优化代码。

### 使用策略模式切换开火策略

1. 将配置项放入到配置文件config-tank.properties中。新增配置读取类ConfigUtil来读取配置项。
2. 新增开火[策略模式](#6.3 策略模式)接口以及他的几个实现类：默认开火策略，往2个方向开火策略，往4个方向开火策略
3. 重构老的fire方法，读取配置文件中的配置项的值，使用反射反射出接口的实际实现类，调用实现类的fire方法。

```java
public void fire() {
   new Thread(() -> new Audio("audio/tank_fire.wav").play()).start();
   FireStrategy fs = ReflectUtil.newInstance(ConfigUtil.getStr("tank.player.fire.strategy"));
   fs.fire(this);
}
   
/**
* 往2个方向开火<br>
*
* @author namelessmyth
* @version 1.0
* @date 2023/8/8
*/
public class Fire2Dir implements FireStrategy{
    @Override
    public void fire(TankPlayer tank) {
        //根据坦克坐标计算子弹坐标，使子弹出现在坦克中部。
        int bX = tank.getX() + TankPlayer.WIDTH / 2 - Bullet.WIDTH / 2;
        int bY = tank.getY() + TankPlayer.HEIGHT / 2 - Bullet.HEIGHT / 2;
        TankFrame.INSTANCE.bullets.add(new Bullet(tank.getId(), bX, bY, tank.getDir(), tank.getGroup(), null));
        TankFrame.INSTANCE.bullets.add(new Bullet(tank.getId(), bX, bY, tank.getDir().getOpposite(), tank.getGroup(), null));
    }
}

/**
 * 往4个方向开火<br>
 *
 * @author namelessmyth
 * @version 1.0
 * @date 2023/8/8
 */
public class Fire4Dir implements FireStrategy{
    @Override
    public void fire(TankPlayer tank) {
        //根据坦克坐标计算子弹坐标，使子弹出现在坦克中部。
        int bX = tank.getX() + TankPlayer.WIDTH / 2 - Bullet.WIDTH / 2;
        int bY = tank.getY() + TankPlayer.HEIGHT / 2 - Bullet.HEIGHT / 2;
        for (Dir d : Dir.values()) {
            TankFrame.INSTANCE.bullets.add(new Bullet(tank.getId(), bX, bY, d, tank.getGroup(), null));
        }
    }
}
```



### 游戏对象公共抽象类

1. 目前tankFrame东西还比较少，后续考虑加入其他元素。例如：墙，河，草丛，地雷。

2. 他们每一个类都会有x，y坐标，长宽，paint方法等。然后还要考虑坦克撞墙了怎么办？子弹撞墙怎么办？

3. 考虑如下问题如何解决？

   1. 对于后续的元素加入如何能让代码更加优雅
   2. 参考开闭原则，如何能让后续元素的新增不修改TankFrame的代码，而是新增代码？
   3. 如何能让后续的功能新增对目前已经实现好的功能，影响最小化？

4. 设计一个公共抽象类游戏对象（AbstractGameObject），封装公共属性和方法

   1. 所有游戏对象都继承这个类。例如：坦克，子弹，爆炸，以及后续的游戏对象。

   2. ```java
      /**
       * 游戏对象的公共父类<br>
       *
       * @author namelessmyth
       * @version 1.0
       * @date 2023/8/9
       */
      @Data
      @ToString
      public abstract class AbstractGameObject {
          private UUID id = UUID.randomUUID();
          private UUID playerId;
          /** 坐标 */
          private int x, y;
      
          public abstract void paint(Graphics g) throws IOException;
      }
      ```

   3. 将原来的不同种类的List改成同一个list。初始化的时候都加入到这个list中。

   4. paint的时候，循环这个list，调用各自的paint方法。

   5. ```java
      @Slf4j
      public class TankFrame extends Frame {
          public static final int GAME_WIDTH = ConfigUtil.getInt("frame.main.width");
          public static final int GAME_HEIGHT = ConfigUtil.getInt("frame.main.height");
          public static final int ENEMY_SIZE = ConfigUtil.getInt("tank.enemy.size");
          Random r = new Random();
          Image offScreenImage = null;
          TankPlayer myTank;
          public List<AbstractGameObject> objects;
      
          public static final TankFrame INSTANCE = new TankFrame();
      
          private TankFrame() throws HeadlessException {
              //创建游戏的主Frame
              this.setTitle("tank war");
              this.setSize(GAME_WIDTH, GAME_HEIGHT);
              this.setLocation(400, 100);
              //加入主窗口的键盘事件监听，让键盘可以控制坦克
              this.addKeyListener(new TankKeyListener());
      
              initGameObjects();
              log.info("tank war Main frame initialization completed");
          }
      
          private void initGameObjects() {
              myTank = new TankPlayer(GAME_WIDTH / 2 - 100, GAME_HEIGHT - 70, Dir.UP, Group.GOOD, this);
      
              objects = new ArrayList<>();
              int gap = GAME_WIDTH / ENEMY_SIZE;
              for (int i = 0; i < ENEMY_SIZE; i++) {
                  Tank tank = new Tank(gap * i, 30, Dir.DOWN, Group.BAD, this);
                  add(tank);
              }
          }
      
          public void add(AbstractGameObject go){
              objects.add(go);
          }
      
          public void remove(AbstractGameObject go){
              objects.remove(go);
          }
      
          @Override
          public void paint(Graphics g) {
              try {
                  myTank.paint(g);
      
                  for (int i = 0; i < objects.size(); i++) {
                      objects.get(i).paint(g);
                  }
              } catch (IOException e) {
                  log.error("TankFrame绘制异常：", e);
              }
          }
      
          /**
           * 用于解决图形闪烁问题。现在内存中画好图形，再让显卡一次性加载到现存中显示。
           * 如果把图形一点点传给显存，就会出现图片一点点刷新，也就是闪烁问题。
           * @param g Graphics 显卡的画笔
           */
          @Override
          public void update(Graphics g) {
              if (offScreenImage == null) {
                  //创建一个和窗口一样大的Image对象（内存中）
                  offScreenImage = this.createImage(GAME_WIDTH, GAME_HEIGHT);
              }
              //得到内存中的画笔（Graphics对象）
              Graphics gOffScreen = offScreenImage.getGraphics();
              Color c = gOffScreen.getColor();
              gOffScreen.setColor(Color.BLACK);
              gOffScreen.fillRect(0, 0, GAME_WIDTH, GAME_HEIGHT);
              gOffScreen.setColor(c);
              //在内存中先把这个图形画好
              paint(gOffScreen);
              //传给显卡显存的画笔，让图形显示到显示器上
              g.drawImage(offScreenImage, 0, 0, null);
          }
      
          /**
           * 继承的这个类已经实现了接口方法。所以继承这个类之后只要实现自己想要的方法即可
           */
          private class TankKeyListener extends KeyAdapter {
              @Override
              public void keyPressed(KeyEvent e) {
                  myTank.keyPressed(e);
              }
      
              @Override
              public void keyReleased(KeyEvent e) {
                  myTank.keyReleased(e);
              }
          }
      }
      ```

5. 做到这里，新的问题产生了。对象和对象之间的碰撞要如何实现？

   1. 例如：子弹要和坦克、墙进行不同的碰撞，坦克要和地雷，墙进行不同的碰撞
   2. 如何实现比较好？使用2层循环将每个对象都调用一遍碰撞方法？



### 职责链模式-定义碰撞规则

1. 哪2个对象之间可以碰撞，后续会随着对象的增多而不断增多。

   1. 例如：目前已知子弹和坦克可以碰撞，后续如果新增了墙。那子弹也可以和墙碰撞。

2. 新增一个碰撞接口Collider，将任意2个对象之间的碰撞规则设计成接口方法。后续可以不断的新增实现类。

3. 已知子弹和坦克可以碰撞，那可以定义一个实现类BulletTankCollider实现Collider接口。

   1. ```java
      public class BulletTankCollider implements Collider{
          @Override
          public void collide(GameObject go1, GameObject go2) {
              if (go1 instanceof Tank && go2 instanceof Bullet) {
                  ((Bullet) go2).collideWith((Tank) go1);
              } else if (go1 instanceof Bullet && go2 instanceof Tank) {
                  ((Bullet) go1).collideWith((Tank) go2);
              }
          }
      }
      ```

   2. 

4. 在TankFrame中定义一个List<Collider> colliders属性，通过读取配置文件加载所有实现类。

5. ```java
       private void initColliders() {
           String collidersStr = ConfigUtil.getStr("object.collider.chain");
           if (StrUtil.isNotBlank(collidersStr)) {
               List<String> strs = StrUtil.split(collidersStr, ",");
               colliders = new ArrayList<>(strs.size());
               for (String str : strs) {
                   colliders.add(ReflectUtil.newInstance(str));
               }
           }
       }
   ```

6. 在循环所有游戏对象时，再加一层子循环，对于任意2个游戏对象都要调用所有的碰撞实现类。

7. ```java
       @Override
       public void paint(Graphics g) {
           try {
               myTank.paint(g);
   
               for (int i = 0; i < objects.size(); i++) {
                   GameObject go = objects.get(i);
                   if (CollUtil.isNotEmpty(colliders)) {
                       for (int i1 = i + 1; i1 < objects.size(); i1++) {
                           GameObject go1 = objects.get(i1);
                           for (Collider c : colliders) {
                               c.collide(go, go1);
                           }
                       }
                   }
                   go.paint(g);
               }
           } catch (IOException e) {
               log.error("TankFrame绘制异常：", e);
           }
       }
   ```

8. 





