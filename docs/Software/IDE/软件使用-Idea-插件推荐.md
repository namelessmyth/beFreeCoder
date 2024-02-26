# Idea常用配置&插件

## 下载安装

- [↗️IDEA所有版本官网下载](https://www.jetbrains.com/idea/download/other.html)
- [↗️IDEA免费激活教程和方法](https://blog.idejihuo.com/topics/jetbrains/idea)



# 配置

## Idea路径

IDEA默认会往C盘写入临时文件以及缓存，大小可以达到1G以上。如果想要把这些数据写入到安装目录下，可以按以下步骤操作。

1. 进入Idea安装目录。例如：D:\ProgramFiles\JetBrains\IntelliJ IDEA 2023\bin
2. 用记事本或notepad++打开：idea.properties，去掉如下配置项的注释
   1. idea.config.path，idea配置文件路径
   2. idea.system.path，idea系统文件路径
   3. idea.plugins.path，idea插件路径
   4. idea.log.path，idea日志路径
3. 按照如下参考文件内容，修改配置。注意：没有列出的不用修改。

```properties
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



## Spring

默认的Spring脚手架地址不支持Jdk8，可以改成阿里云：https://start.aliyun.com/



# AI类

## 通义灵码-阿里

推荐指数：★★★★☆

支持行级/函数级实时续写、自然语言生成代码、单元测试生成、代码优化、注释生成、代码解释、研发智能问答、异常报错排查等能力。

[↗️阿里-通义灵码-AI代码插件](https://help.aliyun.com/document_detail/2590613.html?spm=a2c4g.2590614.0.0.78134253xzhk3k)



# 代码编写

## Lombok

推荐指数：★★★★★

这是一个非常流行的插件，以致于高版本的IDEA直接内置，可以帮助开发人员消除大量冗长重复代码量。

使用时在项目引入Maven依赖，然后在类上或者方法上加入注解就行。常用的注解有：

@Data：自动生成setter/getter、equals、hashCode、toString等方法。（final属性无setter方法）

![](https://img2020.cnblogs.com/blog/2174081/202107/2174081-20210717212531749-1311974510.png)

@Slf4j：自动生成日志实例化代码，可以在方法中直接使用log.info打印。

![](https://img2020.cnblogs.com/blog/2174081/202107/2174081-20210717212641931-1557377663.png)

@NoArgsConstructor：自动生成类的无参构造方法。

@AllArgsConstructor：自动生成全参数构造函数。

@Cleanup：自动关闭资源，针对实现了java.io.Closeable接口的对象

![](https://img.jbzj.com/file_images/article/202212/2022122411070748.jpg)



## GenerateAllSetter

推荐指数：★★★★★

主要用在测试代码上，可以针对已有的实例对象自动生成 `set()` 方法代码。

选择实例，按 `Alt + Enter`，即可出现选项。

![](https://mmbiz.qpic.cn/mmbiz_png/jC8rtGdWScOnKt1yKmAD9Y4EaMjrVD4lyx1lRic3kHRV7oFy18DIXdR1icia6SfK7RqKxJO3dyUmsOagELJ8uibN3w/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

## Arthas Idea

推荐指数：★★★★★

可以自动帮我们生成 Arthas命令，选中类或方法右键点击 `Arthas Command` 即可生成。

![](https://mmbiz.qpic.cn/mmbiz_png/jC8rtGdWScOnKt1yKmAD9Y4EaMjrVD4lK1AHyuUziauDauWxjwQaOx8PqNeRA13rs42LdBk5xNKL75j3zArXo0A/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)



## MybatisX

推荐指数：★★★★

搭配 `Mybatis-Plus` 使用，最大的优点是可以快速生成，entity，dao，mapper 文件。

是idea连接数据库之后，右键对应的表，选择 `MybatiX-Generator` 选项即可生成。

![](https://mmbiz.qpic.cn/mmbiz_png/jC8rtGdWScOnKt1yKmAD9Y4EaMjrVD4lAL00Cjm8Ch40m1SrOL1ic3YZ3GXZicU38NrFWno6NicbIxFKhPtmHorSA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)



## Alibaba Java Code Guidelines

推荐指数：★★★★★

阿里巴巴的代码规范插件，可以帮助规范代码质量



## jclasslib Bytecode Viewer

推荐指数：★★★★

查看Java类的字节码的神器，还支持编辑字节码。

![](https://img-blog.csdnimg.cn/direct/6280d205c0ae469990954b2c59876745.png)



# 作图工具

## SequenceDiagram

推荐指数：★★★★

自动生成方法调用时序图，能够帮助快速梳理代码逻辑。免费版对方法层级有限制，日常使用基本也够了。




# Maven

## Maven Helper

推荐指数：★★★★★

可以解析Maven依赖，是排查jar包冲突问题的一大利器。

使用方法：安装之后，打开项目的pom.xml 文件，右下方会有个 `Dependency Analyzer` 的Tab选项。

![](https://img-blog.csdnimg.cn/0f0f4cba333f4a2395e401f62428e1bb.png)

