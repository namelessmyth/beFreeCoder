# 源码学习

## 为什么要学源码

- **源码是大厂面试的必要环节**。目前源码是很多大厂面试的必要环节。一些要求有自研产品的小厂也会问源码。所以如果不会源码的话，面试这关就无法加分了。大家也可以根据自己的职业规划自行判断。想不想进大厂或者去自研型企业？还是一直写CRUD代码？还是后续转业务或者转管理？
- **对源码的理解是一种加分项**。即使有的公司不一定会问源码，但只要简历上写了，面试的时候找机会表现出来，会是一种加分项。在公司内部工作，如果能向领导和同事很好的展现对源码的认知，也会加分。毕竟大家都知道要看懂源码比较难，所以能真正理解源码的人是少数。
- **工作中可以使用**。源码中有很多很好的设计思想，公共方法，学会了之后实际是可以在项目中运用的。看了源码之后会知道源码预留了哪些扩展点。具体是怎么用的。有很多技术很强的大厂，外面的开源框架不一定能符合自己公司的业务场景，例如：阿里。直接用源码扛不住双11的并发量，所以他们在老的微服务框架基础上修改，开发出了SpringCloudAlibaba，并重新开源给其他公司使用。在工作中实际是否能用到源码还取决于能力。大厂也不会让所有人都去写框架，而是会挑有能力的人去做这些事情。当然，不管大厂小厂，只要不严重影响任务进度，领导也不会强制员工不能使用。



## 学习思路

- 基础知识储备。
  - 设计模式。学习源码非常重要的基础知识。会了设计模式之后能够更好的理解源码的思想。否则，可能会觉得源码写的很乱，明明一个类能解决的事情，非得搞出几十个类。看着会反感，然后就看不下去了。
  - 数据结构与算法。
  - 反射。Java基础，源码中会有很多地方将类名写在配置中，然后通过反射得到实例。
  - 多线程。例如：AbstractAppicationContext.refresh()为什么要加锁？
  - JVM。
- 不要太关注细节。不要一上来就一个个方法点进去看。要先摸清流程脉络。
- 多看注释。源码不是每行代码都有注释，写了注释的尽量先看。看不懂可以用有道翻译。
- 见名知意。好的代码命名都是自注释的。
- 大胆猜测，小心验证。
- 多画图（总结图，时序图，结构图）。别人画的图，代表的是别人的收获。
- 坚持。看源码是一件很容易放弃的事情，一定要坚持。这也是大厂喜欢问源码的原因。因为他们想通过这件事来筛选能够坚持到底的人。



## 适合人群

适合任何阶段的开发人员学习。刚入行也适合。除非连Spring是啥都不知道的。



# Spring

## 参考说明

本文内容主要来源于马士兵教育视频教程（[Spring源码精讲-连鹏举](https://www.mashibing.com/study?courseNo=2154&sectionNo=13868&courseVersionId=1241)），结合了老师的笔记以及自己的实践做了一些修改。



## Spring基础概念

### IOC

什么是IOC？IOC的字面意思是控制反转。控制反转就是反转了依赖关系的满足方式，由之前的自己创建依赖对象，变为由SpringIOC容器推送。（变主动为被动，即反转）它解决了具有依赖关系的组件之间的强耦合。

#### IOC容器

可以理解为ApplicationContext，在Spring启动时，会根据配置和规则将所有的bean初始化在这里。

初始化大致流程如下，Spring在实现的时候还加入了很多扩展点。

~~~mermaid
flowchart LR
xml-->load
load[加载配置]-->parse
parse[解析配置]-->BeanDefinition
BeanDefinition[封装BeanDefinition]-->instantiation
instantiation[实例化]-->push
push[放入容器]-->pull
pull[从容器获取]
~~~

#### 配置加载

加载和解析配置文件的时候，考虑到后续配置格式可能增多，根据开闭原则为了方便后续的扩展，Spring定义了解析规范和接口。BeanDefinitionReader，通过IDEA的Type Hierarch看下他的类继承结构.

> BeanDefinitionReader (org.springframework.beans.factory.support)
> ⊦AbstractBeanDefinitionReader (org.springframework.beans.factory.support)
> ⊦⊦PropertiesBeanDefinitionReader (org.springframework.beans.factory.support)
> ⊦⊦GroovyBeanDefinitionReader (org.springframework.beans.factory.groovy)
> ⊦⊦XmlBeanDefinitionReader (org.springframework.beans.factory.xml)

所以流程扩充成这样：

```mermaid
flowchart LR
xml-->BeanDefinitionReader
properties-->BeanDefinitionReader
yaml-->BeanDefinitionReader
Annotation-->BeanDefinitionReader
BeanDefinitionReader["定义规范接口，方便扩展"]-->BeanDefinition
BeanDefinition["封装BeanDefinition"]-->instantiation
instantiation["实例化"]
```

#### BeanDefinition封装

在得到BeanDefinition之后，且在实例化之前，如果要动态修改Bean的信息怎么办？例如下面的配置：

```xml
<property name=url value="${jdbc.url}" />
```

于是Spring定义了Bean后置处理器，主要有2种后置处理器：

```mermaid
flowchart TB
PostProcessor-->BeanFactoryPostProcessor
PostProcessor-->BeanPostProcessor
```

案例：

在Spring中有这样一个类AbstractAutoProxyCreator，大家可以打开源码，然后查看一下类图。他就是BeanPostProcessor的实现类。

主要负责自动创建代理对象的类。我们在使用**AOP**的时候基本上都是用的这个类来进程**Bean**的拦截，创建代理对象。

还有一个类PlaceholderConfigurerSupport，他是BeanFactoryPostProcessor的实现类。主要用于解析**bean**定义中属性值里面的占位符。就是上文提到的案例。详细说明可以参考它的类注释。



#### 实例化流程

在上面的流程中，有一步是实例化，这个过程也分为很多步骤，见下图：

```mermaid
flowchart TB
instantiation["实例化-执行构造函数"]-->initValue[属性赋值-populate]
subgraph 初始化
initValue-->setAware[给Aware接口属性赋值]
-->postBefore[BeanPostProcessor:before]
-->initM["执行（init-method）方法"]
-->postAfter[BeanPostProcessor:after]
end
postAfter-->obj["完整对象，放入容器"]
-->getBean[可获取对象]

```

#### Aware接口

Spring中的Aware接口主要用于让当前bean对象获取到Spring容器中的其他Bean信息的。有如下子接口，分别用于获取不同的容器对象。

> Aware (org.springframework.beans.factory)
> ⊦ApplicationEventPublisherAware (org.springframework.context)
> ⊦ServletContextAware (org.springframework.web.context)
> ⊦MessageSourceAware (org.springframework.context)
> ⊦ResourceLoaderAware (org.springframework.context)
> ⊦SchedulerContextAware (org.springframework.scheduling.quartz)
> ⊦NotificationPublisherAware (org.springframework.jmx.export.notification)
> ⊦BeanFactoryAware (org.springframework.beans.factory)
> ⊦EnvironmentAware (org.springframework.context)
> ⊦EmbeddedValueResolverAware (org.springframework.context)
> ⊦ImportAware (org.springframework.context.annotation)
> ⊦BootstrapContextAware (org.springframework.jca.context)
> ⊦ServletConfigAware (org.springframework.web.context)
> ⊦LoadTimeWeaverAware (org.springframework.context.weaving)
> ⊦BeanNameAware (org.springframework.beans.factory)：用于获取当前Bean的名字。
> ⊦BeanClassLoaderAware (org.springframework.beans.factory)：用于获取bean的classload。
> ⊦ApplicationContextAware (org.springframework.context)：用于获取ApplicationContext

部分Aware实现类的方法是在下面的方法中调用的。可以通过ctrl+alt+H查看调用堆栈。

org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory#invokeAwareMethods

```java
private void invokeAwareMethods(String beanName, Object bean) {
		//如果 bean 是 Aware 实例
		if (bean instanceof Aware) {
			//如果bean是BeanNameAware实例
			if (bean instanceof BeanNameAware) {
				//调用 bean 的setBeanName方法
				((BeanNameAware) bean).setBeanName(beanName);
			}
			//如果bean是 BeanClassLoaderAware 实例
			if (bean instanceof BeanClassLoaderAware) {
				//获取此工厂的类加载器以加载Bean类(即使无法使用系统ClassLoader,也只能为null)
				ClassLoader bcl = getBeanClassLoader();
				if (bcl != null) {
					//调用 bean 的 setBeanClassLoader 方法
					((BeanClassLoaderAware) bean).setBeanClassLoader(bcl);
				}
			}
			//如果bean是 BeanFactoryAware 实例
			if (bean instanceof BeanFactoryAware) {
				// //调用 bean 的 setBeanFactory 方法
				((BeanFactoryAware) bean).setBeanFactory(AbstractAutowireCapableBeanFactory.this);
			}
		}
	}
```



在AbstractApplicationContext类的prepareBeanFactory方法中有如下代码：

```java
protected void prepareBeanFactory(ConfigurableListableBeanFactory beanFactory) {
		//省略一些代码
		......
            
		// Configure the bean factory with context callbacks.
		// 添加beanPostProcessor,ApplicationContextAwareProcessor此类用来完成某些Aware对象的注入
		beanFactory.addBeanPostProcessor(new ApplicationContextAwareProcessor(this));
		// 设置要忽略自动装配的接口。因为这些接口已经通过上面的ApplicationContextAwareProcessor相当于是容器负责赋值的。，
		// 所以在使用autowire进行注入的时候需要将这些接口进行忽略
		beanFactory.ignoreDependencyInterface(EnvironmentAware.class);
		beanFactory.ignoreDependencyInterface(EmbeddedValueResolverAware.class);
		beanFactory.ignoreDependencyInterface(ResourceLoaderAware.class);
		beanFactory.ignoreDependencyInterface(ApplicationEventPublisherAware.class);
		beanFactory.ignoreDependencyInterface(MessageSourceAware.class);
		beanFactory.ignoreDependencyInterface(ApplicationContextAware.class);

		//省略一些代码
		......
	}
```

#### AOP

上文提到了一个实现AOP的类AbstractAutoProxyCreator，它实现了BeanPostProcessor接口，在after方法中创建了对象的代理。

```java
/**
	 * 此处是真正创建aop代理的地方，在实例化之后，初始化之后就进行处理
	 * 首先查看是否在earlyProxyReferences里存在，如果有就说明处理过了，不存在就考虑是否要包装，也就是代理
	 *
	 * Create a proxy with the configured interceptors if the bean is
	 * identified as one to proxy by the subclass.
	 * @see #getAdvicesAndAdvisorsForBean
	 */
	@Override
	public Object postProcessAfterInitialization(@Nullable Object bean, String beanName) {
		if (bean != null) {
			// 获取当前bean的key：如果beanName不为空，则以beanName为key，如果为FactoryBean类型，
			// 前面还会添加&符号，如果beanName为空，则以当前bean对应的class为key
			Object cacheKey = getCacheKey(bean.getClass(), beanName);
			// 判断当前bean是否正在被代理，如果正在被代理则不进行封装
			if (this.earlyProxyReferences.remove(cacheKey) != bean) {
				// 如果它需要被代理，则需要封装指定的bean
				return wrapIfNecessary(bean, beanName, cacheKey);
			}
		}
		return bean;
	}
```



#### Bean分类

```mermaid
flowchart LR
bean[Spring Bean]-->normal[普通对象]-->我们自己定义的对象
bean-->context[容器对象]-->Spring自己需要的对象
```



Spring容器中的bean分2类，上述讲得其实都是普通对象，也就是我们自己定义的对象。在这些对象创建之前，Spring还有一些自身的对象需要它自己new的。

```java
	protected ConfigurableEnvironment createEnvironment() {
		return new StandardEnvironment();
	}
```



### DI



### AOP



### 监听器

主要体现了观察者模式，在Spring容器初始化到不同阶段时，触发不同的事件监听方法，来达到不同的目的。



## 类和接口

### 重要类和接口

```mermaid
flowchart LR
接口-->BeanFactory-->DefaultListableBeanFactory

BeanFactory-->ApplicationContext-->ClassPathXmlApplicationContext
ApplicationContext-->WebApplicationContext

接口-->BeanDefinition
接口-->BeanDefinitionReader
接口-->BeanDefinitionRegister

接口-->Aware
    Aware-->EnvironmentAware
    Aware-->BeanNameAware
    Aware-->BeanClassLoaderAware
    Aware-->ApplicationContextAware

接口-->BeanPostProcessor
接口-->BeanFactoryPostProcessor
接口-->Environment-->StandardEnvironment
    StandardEnvironment-->s2["System.getProperty()"]
    StandardEnvironment-->s1["System.getEnv()"]
接口-->FactoryBean
```

#### FactoryBean

当配置文件中<bean>的 class 属性配置的实现类是 FactoryBean 时，通过 getBean()方法返回的不是 FactoryBean 本身，而是 FactoryBean#getObject() 方法所返回的对象。相当于FactoryBean#getObject()代理了 getBean()方法。这种方式的Bean不需要遵守SpringBean的生命周期。

举例来说，一个类User，实现了FactoryBean接口，代码如下。

当在Spring容器（ApplicationContext）初始化的时候，没有自动初始化User这个类的，而是初始化FactoryBean这个类。

等到调用getBean("FactoryBean名字")方法时，User才被实例化。或者调用FactoryBean的getObject方法也可以实例化。

```java
public class MyFactoryBean implements FactoryBean<User> {

    @Override
    public User getObject() throws Exception {
        return new User("zhangsan");
    }

    @Override
    public Class<?> getObjectType() {
        return User.class;
    }

    @Override
    public boolean isSingleton() {
        return false;
    }
}

public class Test {
    public static void main(String[] args) {
        //此时User类没有初始化
        ApplicationContext ac = new ClassPathXmlApplicationContext("factoryBean.xml");
        
        //通过FactoryBean名字获取User实例
        User bean1 = (User) ac.getBean("myFactoryBean");
        System.out.println(bean1.getUsername());
        
        //通过&FactoryBean名字获取FactoryBean实例
        MyFactoryBean bean2 = (MyFactoryBean) ac.getBean( "&myFactoryBean");
        System.out.println(bean2.getObject());
	}
}

```

**Spring为什么使用FactoryBean**

一般情况下，Spring 通过反射机制利用 bean 的 class 属性指定实现类来实例化 bean。

在某些情况下，实例化 bean 过程比较复杂，如果按照传统的方式，则需要在中提供大量的配置信息，配置方式的灵活性是受限的，这时采用编码的方式可能会得到一个简单的方案。

FactoryBean接口对于 Spring 框架来说占有重要的地位，Spring 自身就提供了 70 多个FactoryBean 的实现。它们隐藏了实例化一些复杂 bean 的细节，给上层应用带来了便利。

[应用场景](https://blog.csdn.net/qq_44543508/article/details/130472391)







## 源码

### 设计思想

Spring源码针对同一种类型的类为什么要设计那么复杂的继承关系？

例如：BeanFactory接口有几十个子类，而我们平时自己开发的时候往往是一个类搞定所有。

回答：我们平时大部分做的是基于某一个特定业务场景的定制开发，而Spring作为通用的底层框架，他需要兼容所有可能出现的功能场景。将每一个类的功能设计的精细化，再通过两两组合能够灵活兼容更多的功能场景。如果只设计很少的类，那意味着每一个类将拥有更多的功能，而这些功能，我们在做某个功能场景下，可能是用不到的。但设计了就得去实现里面的方法。

例如：假设现在有10个独立的功能方法，如果分布在10个子类中，那我们某个具体业务场景如果要用其中的2个（A和B），那我们可以选择用1个类实现A和B接口即可。实现他们的方法即可。但如果10个方法全设计在一个子类中，那我们就得实现它10个方法。还得花时间去研究哪个方法是真正要实现的。哪个可以不实现。



### 源码载入

载入源码前一定要选择一个合适的Spring源码版本，因为它和Gradle版本，JDK版本是有对应关系的。

高版本的Spring源码，一般需要高版本的JDK版本和Gradle版本，配合使用。

如果你是通过视频教程在看Spring源码，那建议使用视频中老师用的那个Spring版本，老师一般也会提供给你配套的Spring，Gradle和JDK。

本文使用的是马士兵教育的视频教程（[Spring源码精讲](https://www.mashibing.com/study?courseNo=2154&sectionNo=13868)）课程资料中对应的Spring源码包以及对应的Gradle版本。



#### 版本说明

##### Spring

本文使用的Spring版本是5.3.2，如果想看更高版本的Spring源码的话，需要换更高版本的JDK。



##### Gradle

建议去Spring源码的这个文件（spring源码目录\gradle\wrapper\gradle-wrapper.properties）中查看对应的Gradle版本。然后去

[Gradle版本下载地址](https://services.gradle.org/distributions/)中下载。下载好Gradle的zip包之后，可以替换上面这个文件中的内容。不然后续构建的时候还会重复下载的。

```properties
#distributionUrl=https\://services.gradle.org/distributions/gradle-5.6.4-all.zip
distributionUrl=file:///D:/ProgramFiles/gradle/gradle-5.6.4-bin.zip
distributionBase=GRADLE_USER_HOME
distributionPath=wrapper/dists
zipStorePath=wrapper/dists
zipStoreBase=GRADLE_USER_HOME
```

Gradle解压之后，请添加2个环境变量，GRADLE_HOME，PATH。



##### JDK

java version "1.8.0_351"
Java(TM) SE Runtime Environment (build 1.8.0_351-b10)
Java HotSpot(TM) 64-Bit Server VM (build 25.351-b10, mixed mode)



##### IDE

我用的是IDEA 2023.01。IDEA版本尽量不要用太旧的。可能不兼容高版本Gradle。



#### IDEA载入

以上都准备好，就可以载入已经下载好的Spring源码了。Spring源码本地路径：D:\Workspace\idea\mashibing\lianpengju-spring

载入Spring源码后，记得修改“File | Settings | Build, Execution, Deployment | Build Tools | Gradle | Gradle User Home”这里面的路径。这个路径相当于是Maven的本地仓库地址。

载入后，IDEA会根据依赖下载依赖包，此过程根据网速会比较漫长。笔者至少用了好几个小时才下载完成。

如果报错：Error resolving plugin [id: ‘io.spring.gradle-enterprise-conventions’, version: ‘0.0.2’]

解决方法：去文件build.gradle中，注释id "io.spring.gradle-enterprise-conventions" version "0.0.2

代码编译成功后，可以按照下面的步骤写一个简单的测试类，看看是否能够debug。



### ClassPathXmlApplicationContext初始化

#### 起点

可以自己在Spring-debug模块中自己建一个main方法和xml配置文件，然后写好测试代码开始debug。

```java
public class TestPopulate {

    public static void main(String[] args) {
        ApplicationContext ac = new ClassPathXmlApplicationContext("populateBean.xml");
        ac.close();
    }
}
```

然后进入到ClassPathXmlApplicationContext的构造方法中。

```java
	public ClassPathXmlApplicationContext(
			String[] configLocations, boolean refresh, @Nullable ApplicationContext parent)
			throws BeansException {
		// 调用父类构造方法，对成员变量进行初始化，进行相关的对象创建等操作。
		super(parent);
        // 设置应用程序上下文的配置文件路径，解析多环境
		setConfigLocations(configLocations);
		if (refresh) {
			refresh();
		}
	}
```



#### super(parent)

调用父类构造方法，对成员变量进行初始化，进行相关的对象创建等操作。

- 创建资源模式解析器。用于xml等配置文件的加载
- 给上下文创建一个ID。ObjectUtils.identityToString(this)
- 初始化同步监视器，用于在refresh和destroy的时候，加锁。
- 合并环境信息(Environment)，如果存在父容器。SpringMVC时会存在父容器。
- 设置xml文件验证标识。默认为true。xml的文件格式由xsd和dtd规定。



#### setConfigLocations

设置应用程序上下文的配置文件路径，解析多环境。

- Spring支持通过spring.profiles.actvie多环境配置。程序需要读到正确的配置文件。
- Spring支持在配置文件中使用占位符。例如：application-${username}.xml。程序需要根据环境变量替换。
- 实例化Environment对象，并通过父类构造方法调用StandardEnvironment#customizePropertySources方法。
  - 将System.getProperties加载到systemProperties中。(jvm参数)
  - 将System.getEnv()加载到systemEnvironment中。(jvm所在的服务器的环境参数)
- 将解析到的配置文件路径放入实例变量中。configLocations



#### refresh()

AbstractApplicationContext#refresh()方法是IOC容器初始化的核心方法，它内部分成12个方法。

```java
	public void refresh() throws BeansException, IllegalStateException {
		synchronized (this.startupShutdownMonitor) {
			// Prepare this context for refreshing.
			/**
			 * 前戏，做容器刷新前的准备工作
			 * 1、设置容器的启动时间
			 * 2、设置活跃状态为true
			 * 3、设置关闭状态为false
			 * 4、获取Environment对象，并加载当前系统的属性值到Environment对象中
			 * 5、准备监听器和事件的集合对象，默认为空的集合
			 */
			prepareRefresh();

			// Tell the subclass to refresh the internal bean factory.
			// 创建BeanFactory容器对象：DefaultListableBeanFactory
			// 加载xml配置文件的属性值到当前工厂中，最重要的就是BeanDefinition
			ConfigurableListableBeanFactory beanFactory = obtainFreshBeanFactory();

			// Prepare the bean factory for use in this context.
			// beanFactory的准备工作，对他里面的BeanDefinition的各种属性进行填充，上一步只是初始化
			prepareBeanFactory(beanFactory);

			try {
				// Allows post-processing of the bean factory in context subclasses.
				// 子类覆盖方法做额外的处理，此处我们自己一般不做任何扩展工作，但是可以查看web中的代码，是有具体实现的
				postProcessBeanFactory(beanFactory);

				// Invoke factory processors registered as beans in the context.
				// 调用各种beanFactory处理器
				invokeBeanFactoryPostProcessors(beanFactory);

				// Register bean processors that intercept bean creation.
				// 注册bean处理器，这里只是注册功能，真正调用的是getBean方法
				registerBeanPostProcessors(beanFactory);

				// Initialize message source for this context.
				// 为上下文初始化message源，即不同语言的消息体，国际化处理,在springmvc的时候通过国际化的代码重点讲
				initMessageSource();

				// Initialize event multicaster for this context.
				// 初始化事件监听多路广播器
				initApplicationEventMulticaster();

				// Initialize other special beans in specific context subclasses.
				// 留给子类来初始化其他的bean，SpringBoot启动时，在这里会初始化Tomcat
				onRefresh();

				// Check for listener beans and register them.
				// 在所有注册的bean中查找listener bean,注册到消息广播器中
				registerListeners();

				// Instantiate all remaining (non-lazy-init) singletons.
				// 实例化剩下的单例模式对象（非懒加载的）
				finishBeanFactoryInitialization(beanFactory);

				// Last step: publish corresponding event.
				// 完成刷新过程，通知生命周期处理器lifecycleProcessor刷新过程，同时发出ContextRefreshEvent通知别人
				finishRefresh();
			}

			catch (BeansException ex) {
				if (logger.isWarnEnabled()) {
					logger.warn("Exception encountered during context initialization - " +
							"cancelling refresh attempt: " + ex);
				}

				// Destroy already created singletons to avoid dangling resources.
				// 为防止bean资源占用，在异常处理中，销毁已经在前面过程中生成的单件bean
				destroyBeans();

				// Reset 'active' flag.
				// 重置active标志
				cancelRefresh(ex);

				// Propagate exception to caller.
				throw ex;
			}

			finally {
				// Reset common introspection caches in Spring's core, since we
				// might not ever need metadata for singleton beans anymore...
				resetCommonCaches();
			}
		}
	}
```

##### 流程图

可以将12个方法继续归类：刷新前的准备 > BeanFactory相关 > Bean相关处理 > 结束刷新，中间穿插着一些国际化资源和事件的初始化工作。下面是详细的流程图：

```mermaid
flowchart TB
prepareRefresh[prepareRefresh刷新准备]-->bf1

subgraph BeanFactory
direction LR
bf1[ObtainBeanFactory初始化]-->bf2[prepareBeanFactory准备]-->bf3[[postProcessBeanFactory]]-->bf4[invokeBeanFactoryPostProcessors]
end

subgraph Bean
bf4-->bean1[registerBeanPostProcessors]-->message>initMessageSource初始化国际化资源]-->app[initApplicationEventMulticaster初始化事件多播器]-->onrefresh[[onRefresh留给子类实现]]-->regListen[registerListeners]-->finishBeanFactoryInitialization
end

finishBeanFactoryInitialization-->finishRefresh-->reset[resetCommonCaches]
```

##### prepareRefresh()

主要做容器刷新前的准备工作。

- 设置容器启动时间，活动标识，关闭标识。

- initPropertySources()，初始化资源文件（子类扩展点）

  - 应用场景，我们可以自己写一个类继承ClassPathXmlApplicationContext

  - 在自定义类中覆盖方法，实现如下功能。

  - 检查Properties中必须包含某个属性值，否则容器启动报错。

  - 往Properties中放入一个新的属性值。

  - ```java
    public class MyClassPathXmlApplicationContext extends ClassPathXmlApplicationContext {
    
        public MyClassPathXmlApplicationContext(String... configLocations){
            super(configLocations);
        }
    
        @Override
        protected void initPropertySources() {
            System.out.println("自定义initPropertySource");
            getEnvironment().getSystemProperties().put("name","gem");
            getEnvironment().setRequiredProperties("key");
        }
    
        public static void main(String[] args) {
            ApplicationContext context = new MyClassPathXmlApplicationContext("spring.xml");
            User user = (User)context.getBean("a");
        }
    }
    ```

  - 通过源码上的注解可以发现，有一个工具类*WebApplicationContextUtils#initServletPropertySources*，当在Web环境下启动时，会用ServletContext中解析到的参数替换原来的参数。 

- 获取 Environment 对象，校验属性值并赋值到 Environment 对象中

- 初始化Application监听器和事件。从Spring启动时这里为空，但从Springboot启动时，这里就不为空。

- ```java
  	protected void prepareRefresh() {
  		// Switch to active.
  		// 设置容器启动的时间
  		this.startupDate = System.currentTimeMillis();
  		// 容器的关闭标志位
  		this.closed.set(false);
  		// 容器的激活标志位
  		this.active.set(true);
  
  		// 记录日志
  		if (logger.isDebugEnabled()) {
  			if (logger.isTraceEnabled()) {
  				logger.trace("Refreshing " + this);
  			}
  			else {
  				logger.debug("Refreshing " + getDisplayName());
  			}
  		}
  
  		// Initialize any placeholder property sources in the context environment.
  		// 留给子类覆盖，初始化属性资源
  		initPropertySources();
  
  		// Validate that all properties marked as required are resolvable:
  		// see ConfigurablePropertyResolver#setRequiredProperties
  		// 创建并获取环境对象，验证必要的属性文件是否都已经放入环境中，验证不通过会抛异常
  		getEnvironment().validateRequiredProperties();
  
  		// Store pre-refresh ApplicationListeners...
  		// 判断刷新前的应用程序监听器集合是否为空，如果为空，则将监听器添加到此集合中
  		if (this.earlyApplicationListeners == null) {
  			// 从SpringBoot应用启动时这里就不为空。
  			this.earlyApplicationListeners = new LinkedHashSet<>(this.applicationListeners);
  		} else {
  			// Reset local application listeners to pre-refresh state.
  			// 如果不等于空，则清空集合元素对象
  			this.applicationListeners.clear();
  			this.applicationListeners.addAll(this.earlyApplicationListeners);
  		}
  
  		// Allow for the collection of early ApplicationEvents,
  		// to be published once the multicaster is available...
  		// 创建刷新前的监听事件集合
  		this.earlyApplicationEvents = new LinkedHashSet<>();
  	}
  ```
  
- 

  

##### obtainFreshBeanFactory()

关闭旧的BeanFactory (如果存在)，创建新的BeanFactory，解析xml配置文件加载BeanDefinition。

- refreshBeanFactory。调用的是父类AbstractRefreshableApplicationContext中的方法。

  - ```java
    	protected final void refreshBeanFactory() throws BeansException {
    		// 如果存在beanFactory，则销毁beanFactory
    		if (hasBeanFactory()) {
    			destroyBeans();
    			closeBeanFactory();
    		}
    		try {
    			// 创建DefaultListableBeanFactory对象
    			DefaultListableBeanFactory beanFactory = createBeanFactory();
    			// 为了序列化指定id，可以从id反序列化到beanFactory对象
    			beanFactory.setSerializationId(getId());
    			// 定制beanFactory，设置相关属性，包括是否允许覆盖同名称的不同定义的对象以及循环依赖
    			customizeBeanFactory(beanFactory);
    			// 初始化documentReader,并进行XML文件读取及解析,默认命名空间的解析，自定义标签的解析
    			loadBeanDefinitions(beanFactory);
    			this.beanFactory = beanFactory;
    		}
    		catch (IOException ex) {
    			throw new ApplicationContextException("I/O error parsing bean definition source for " + getDisplayName(), ex);
    		}
    	}
    ```

  - 如果BeanFactory已经存在，则先销毁里面的所有beans。再关闭BeanFactory。

  - 初始化BeanFactory，此时很多属性都是初始值。使用applicationContext的id，设置序列化id

  - customizeBeanFactory。定制BeanFactory。主要设置2个重要属性（allowBeanDefinitionOverriding：是否允许覆盖名称相同的BeanDefinition，allowCircularReferences：是否允许循环依赖）。
  
    - 如果想要覆盖初始值，可以写一个类继承ApplicationContext。这算是一个子类扩展点，参考代码如下：
  
    - ```java
      public class MyClassPathXmlApplicationContext extends ClassPathXmlApplicationContext {
      
          MyClassPathXmlApplicationContext(String... locations){
              super(locations);
          }
      
          @Override
          protected void customizeBeanFactory(DefaultListableBeanFactory beanFactory) {
              super.setAllowBeanDefinitionOverriding(true);
              super.setAllowCircularReferences(true);
              super.customizeBeanFactory(beanFactory);
          }
      }
      ```
  
    - 是否允许覆盖名称相同的BeanDefinition，这是用在replace-method和lookup-method上的。
  
  - loadBeanDefinitions。加载配置文件，解析BeanDefinitions。
  
    - 实例化XmlBeanDefinitionReader，这里用到了适配器模式。
      - 初始化dtd和xsd解析器。
    - 设置属性
      - environment，用于替换配置文件中的占位符。
      - resourceLoader，资源加载器，就是当前对象。
      - entityResolver，解析xml的，内部会读取dts或xsd
        - 本地schemas路径：spring-beans\src\main\resources\META-INF\spring.schemas
        - 即使断网也可以根据此文件中的映射，找到本地文件。
        - PluggableSchemaResolver的toString方法会读取spring.schemas中的文件内容。
    - initBeanDefinitionReader，设置是否使用XML校验，默认true。
    - 调用reader的loadBeanDefinitions方法，从之前读取到的configLocation中读取配置文件。
      - 配置文件可能有多个，循环读取。
      - 解析配置文件地址中的路径修饰字符。例如："classpath:xxx.xml"
      - doLoadBeanDefinitions。
        - doLoadDocument。使用SAX，从String[]到Resource[]，再将resource读取成Document文档对象（此步骤不建议深入研究）。并将其封装成BeanDefinition对象。
        - registerBeanDefinitions。解析并读取配置文件。区分不同的命名空间做不同的处理。对于非默认命名空间的配置通过resources\META-INF\spring.handlers文件中对应的类进行处理。基于此，我们也可以自定义标签的处理类。
      - 这里预留了一个扩展点，[自定义标签](#配置文件自定义标签)。
  
  - 



##### prepareBeanFactory

beanFactory的准备工作，对他里面的BeanDefinition的各种属性进行填充，配置工厂的标准上下文特征，后置处理器等

1. 设置beanFactory的classloader为当前context的classloader

2. 设置beanfactory的SpEL表达式语言的Resolver。内部还会创建SpelExpressionParser

   1. 创建Parser的时候还创建了一个配置类。SpelParserConfiguration
   2. 这里仅仅时注册，并没有正真开始解析。

3. 为beanFactory增加一个默认的PropertyEditorRegistrar，这个主要是对bean的属性等设置管理的一个工具类

   1. 这里是Spring预留的一个扩展点。可以[自定义属性编辑器](#自定义属性编辑器)。

4. 为beanFactory增加一个BeanPostProcessor，ApplicationContextAwareProcessor。

   1. 这个Aware接口是用来调用其他6个aware接口的。在他的before方法中

   2. ```java
      /**
      	 * 接口beanPostProcessor规定的方法，会在bean创建时，实例化后，初始化前，对bean对象应用
      	 * @param bean the new bean instance
      	 * @param beanName the name of the bean
      	 * @return
      	 * @throws BeansException
      	 */
      	@Override
      	@Nullable
      	public Object postProcessBeforeInitialization(Object bean, String beanName) throws BeansException {
      		if (!(bean instanceof EnvironmentAware || bean instanceof EmbeddedValueResolverAware ||
      				bean instanceof ResourceLoaderAware || bean instanceof ApplicationEventPublisherAware ||
      				bean instanceof MessageSourceAware || bean instanceof ApplicationContextAware)){
      			return bean;
      		}
      
      		AccessControlContext acc = null;
      
      		if (System.getSecurityManager() != null) {
      			acc = this.applicationContext.getBeanFactory().getAccessControlContext();
      		}
      
      		if (acc != null) {
      			AccessController.doPrivileged((PrivilegedAction<Object>) () -> {
      				// 检测bean上是否实现了某个aware接口，有的话进行相关的调用
      				invokeAwareInterfaces(bean);
      				return null;
      			}, acc);
      		}
      		else {
      			invokeAwareInterfaces(bean);
      		}
      
      		return bean;
      	}
      
      	/**
      	 * 如果某个bean实现了某个aware接口，给指定的bean设置相应的属性值
      	 *
      	 * @param bean
      	 */
      	private void invokeAwareInterfaces(Object bean) {
      		if (bean instanceof EnvironmentAware) {
      			((EnvironmentAware) bean).setEnvironment(this.applicationContext.getEnvironment());
      		}
      		if (bean instanceof EmbeddedValueResolverAware) {
      			((EmbeddedValueResolverAware) bean).setEmbeddedValueResolver(this.embeddedValueResolver);
      		}
      		if (bean instanceof ResourceLoaderAware) {
      			((ResourceLoaderAware) bean).setResourceLoader(this.applicationContext);
      		}
      		if (bean instanceof ApplicationEventPublisherAware) {
      			((ApplicationEventPublisherAware) bean).setApplicationEventPublisher(this.applicationContext);
      		}
      		if (bean instanceof MessageSourceAware) {
      			((MessageSourceAware) bean).setMessageSource(this.applicationContext);
      		}
      		if (bean instanceof ApplicationContextAware) {
      			((ApplicationContextAware) bean).setApplicationContext(this.applicationContext);
      		}
      	}
      ```

   3. 另有3个aware接口是在invokeAwareMethods方法中调用。BeanNameAware，BeanClassLoaderAware，BeanFactoryAware

5. 设置要忽略自动装配的接口。这6个接口已经通过上面的ApplicationContextAwareProcessor相当于是容器自动赋值的。所以需要在DI（autowired）的时候过滤掉他们。

6. 设置几个自动装配的特殊规则,当在进行自动注入的时候，如果某个类有多个实现，那么就使用指定的对象进行注入

7. 为beanFactory增加一个BeanPostProcessor，此类用来检测bean是否实现了ApplicationListener接口

   1. 实例化完成之后，如果bean为单例并且属于ApplicationListener接口，则加入到多播器中。
   2. bean销毁之前，如果bean是一个applicationListener，则从多播器中提前删除

8. 如果BeanFactory包含某个特殊的Bean（用于AOP）就做一些特殊处理

   1. 主要为了增加对AspectJ的支持，在java中织入分为三种方式，分为编译器织入，类加载器织入，运行期织入，编译器织入是指在java编译器，采用特殊的编译器，将切面织入到java类中
   2. 而类加载期织入则指通过特殊的类加载器，在类字节码加载到JVM时，织入切面，运行期织入则是采用cglib和jdk进行切面的织入
   3. aspectj提供了两种织入方式，第一种是通过特殊编译器，在编译器，将aspectj语言编写的切面类织入到java类中，第二种是类加载期织入，就是下面的load time weaving，此处后续讲

9. 注册默认的系统环境bean到一级缓存中。便于后续使用。



##### postProcessBeanFactory()

默认空。这个方法是留给子类实现的。也算是一个扩展点。可以参考AbstractRefreshableWebApplicationContext中的实现。



##### invokeBeanFactoryPostProcessors()

调用各种beanFactory的后置处理器（BFPP）。调用硬编码注册的BeanFactoryPostProcessors

```mermaid
flowchart TB
mbfpp[手动加入的BeanFactoryPostProcessor]
-->ibdrpp[实现了BeanDefinitionRegisterPostProcessor的类]
-->ibfpp[实现了BeanFactoryPostProcessor的类]

mi([通过方法入参传入])-.->mbfpp
sbr([通过类型在工厂中查找])-.->ibdrpp
sbb([通过类型在工厂中查找])-.->ibfpp

PriorityOrdered-->Ordered-->none
```



1. 使用委派类（PostProcessorRegistrationDelegate）来调用BeanFactoryPostProcessors
2. 判断beanFactory是否是BeanDefinitionRegistry类型，如果是
   1. 由于ConfigurableListableBeanFactory默认是继承BeanDefinitionRegistry接口的，所以会走这里。
   2. BeanDefinitionRegistry接口提供了对BeanDefinition进行增删改查的方法。
   3. 程序创建了2个list，分别处理2个父子接口BeanFactoryPostProcessor和BeanDefinitionRegistryPostProcessor
   4. 优先处理传进来的BFPP，如果不为空，则根据类型放入到上面的2个list中。
   5. 放的时候BeanDefinitionRegistryPostProcessor的实例会额外调用postProcessBeanDefinitionRegistry方法。
   6. 读取Spring中所有BeanDefinitionRegistryPostProcessor的Bean名称，如果定制实现了这个接口就会被读到。
   7. 循环处理读出来的所有Bean名字，判断这个bean是否实现了PriorityOrdered接口。
      1. 如果实现了，则将他的bean实例加入到当前正在处理的BeanDefinitionRegistryPostProcessor的list中。
      2. 同时将要被执行的BFPP名称添加到processedBeans，避免后续重复执行。
   8. 对当前正在处理的list按照优先级进行排序。
   9. 将排好序的list追加到上面那个BeanDefinitionRegistryPostProcessor的list中。
   10. 遍历currentRegistryProcessors，执行postProcessBeanDefinitionRegistry方法
   11. 执行完毕之后，清空currentRegistryProcessors
   12. 到这里程序只是处理了实现了PriorityOrdered接口的bean，后面还会有类似的程序处理Ordered接口和没实现接口的。
   13. 后面的程序执行逻辑和这部分大同小异，程序每次都要读出bean之后在处理的原因是。
       1. 因为每次在调用invokeBeanDefinitionRegistryPostProcessors方法后，是可能会创建新的BeanDefinitionRegistryPostProcessor实例的。
       2. postProcessBeanDefinitionRegistry(BeanDefinitionRegistry registry)方法会将BeanDefinitionRegistry传入
       3. BeanDefinitionRegistry有registerBeanDefinition方法可以动态加入BeanDefinitionRegistryPostProcessor实例
   14. 3段逻辑都会调用sortPostProcessors方法进行排序。排序规则如下
       1. 首先判断当前beanFactory是否是DefaultListableBeanFactory子类，是否存在依赖比较器。
       2. 如果依赖比较器为空则使用OrderComparator进行排序。
       3. OrderComparator会将实现了PriorityOrdered接口的实例排在前面。
       4. 如果2个实例都实现或者都没有实现PriorityOrdered接口，程序会调用getOrder方法获取Order值
          1. getOrder方法对于没有实现Ordered接口的实例，直接返回Integer最大值，确保其顺序排在最后。
          2. 对于实现了Ordered接口的实例，则调用Ordered接口的getOrder方法的值进行比较。
       5. 使用这个整型的Order值，进行比较。order值越小，优先级越高。
3. 如果beanFactory不是BeanDefinitionRegistry类型。
   1. 循环调用每一个实例的postProcessBeanFactory方法，无特殊处理。

4. 到这里，入参中的和容器中的所有BeanDefinitionRegistryPostProcessor已经全部处理完毕，下面开始处理容器中的所有的BeanFactoryPostProcessor
5. 读出所有BeanFactoryPostProcessor的Bean，接下来的处理逻辑同上面也是类似的。
6. 先处理PriorityOrdered和Ordered的实例，然后是普通的bean。对于已经处理过的会跳过。
7. 在处理BeanFactoryPostProcessor的bean时并没有像上面一样，重复的读取BeanFactoryPostProcessor的子类
   1. 原因是BeanFactoryPostProcessor的接口方法不能够动态新增BeanFactoryPostProcessor的实例。




Spring中比较重要的BeanDefinitionRegistryPostProcessor实例

- [ConfigurationClassPostProcessor](#ConfigurationClassPostProcessor)
- [EventListenerMethodProcessor](#EventListenerMethodProcessor)



##### registerBeanPostProcessors(beanFactory)

注册BeanPostProcessors，用于拦截 Bean 的创建。真正调用要到后面的**getBean**方法。



##### initMessageSource();

初始化国际化资源文件，用于解析消息，支持国际化。



##### initApplicationEventMulticaster();

初始化事件监听多路广播器。用于发布事件和监听器。



##### onRefresh()

刷新时需要触发的方法，留给子类自定义的。SpringBoot启动的时候就会在这个方法里启动Tomcat容器。



##### registerListeners()

将监听器注册到容器中。



##### finishBeanFactoryInitialization(beanFactory)

核心方法，在这里实例化BeanFactory中的所有Bean单例实例，确保所有非懒加载的 Bean 都被创建。



##### finishRefresh()

完成整个刷新过程。清理上下文资源，发布 `ContextRefreshedEvent`和通知。



##### resetCommonCaches()

重置公共缓存。



### 扩展点

#### 配置文件自定义标签

##### 说明

自定义标签的意思是，在Spring的配置文件中（例如：applicationContext.xml）加入自己定义的标签，同时加入处理类，让IOC容器启动时可以自动解析到beanFactory中。

##### 代码出处

在ioc容器初始化过程中，会调用类（XmlBeanDefinitionReader.java）的下面这个方法。在这个方法的（createReaderContext(resource)）中会初始化上下文。同时会确定配置文件地址。

```java
//org/springframework/beans/factory/xml/XmlBeanDefinitionReader.java
    public int registerBeanDefinitions(Document doc, Resource resource) throws BeanDefinitionStoreException {
        // 对xml的beanDefinition进行解析
        BeanDefinitionDocumentReader documentReader = createBeanDefinitionDocumentReader();
        int countBefore = getRegistry().getBeanDefinitionCount();
        // 完成具体的解析过程,createReaderContext这个方法会读取配置文件，读出不同命名空间对应的处理类
        documentReader.registerBeanDefinitions(doc, createReaderContext(resource));
        return getRegistry().getBeanDefinitionCount() - countBefore;
    }

	/**
	 * 接着进入getNamespaceHandlerResolver()这个方法
	 */
	public XmlReaderContext createReaderContext(Resource resource) {
		return new XmlReaderContext(resource, this.problemReporter, this.eventListener,
				this.sourceExtractor, this, getNamespaceHandlerResolver());
	}

	/**
	 * 第一次进来肯定为空，所以进入createDefaultNamespaceHandlerResolver()
	 */
	public NamespaceHandlerResolver getNamespaceHandlerResolver() {
		if (this.namespaceHandlerResolver == null) {
			this.namespaceHandlerResolver = createDefaultNamespaceHandlerResolver();
		}
		return this.namespaceHandlerResolver;
	}

	/**
	 * 进到这个方法后，配置文件路径确定
	 */
	protected NamespaceHandlerResolver createDefaultNamespaceHandlerResolver() {
		ClassLoader cl = (getResourceLoader() != null ? getResourceLoader().getClassLoader() : getBeanClassLoader());
		return new DefaultNamespaceHandlerResolver(cl);
	}
```

在下面的这个parseCustomElement方法，会解析非默认命名空间的配置项。这里面会使用上下文调用resolve方法找到命名空间对应的处理类。针对不同命名空间调用不同类的方法来解析。

```java
//org.springframework.beans.factory.xml.BeanDefinitionParserDelegate	
	public BeanDefinition parseCustomElement(Element ele, @Nullable BeanDefinition containingBd) {
		// 获取对应的命名空间
		String namespaceUri = getNamespaceURI(ele);
		if (namespaceUri == null) {
			return null;
		}
		// 根据命名空间找到对应的Namespace Handler
		NamespaceHandler handler = this.readerContext.getNamespaceHandlerResolver().resolve(namespaceUri);
		if (handler == null) {
			error("Unable to locate Spring NamespaceHandler for XML schema namespace [" + namespaceUri + "]", ele);
			return null;
		}
		// 调用自定义的NamespaceHandler进行解析
		return handler.parse(ele, new ParserContext(this.readerContext, this, containingBd));
	}

//org.springframework.beans.factory.xml.DefaultNamespaceHandlerResolver
	public NamespaceHandler resolve(String namespaceUri) {
		// 获取所有已经配置好的handler映射
		Map<String, Object> handlerMappings = getHandlerMappings();
		// 根据命名空间找到对应的信息
		Object handlerOrClassName = handlerMappings.get(namespaceUri);
		if (handlerOrClassName == null) {
			return null;
		}
		else if (handlerOrClassName instanceof NamespaceHandler) {
			// 如果已经做过解析，直接从缓存中读取
			return (NamespaceHandler) handlerOrClassName;
		}
		else {
			// 没有做过解析，则返回的是类路径
			String className = (String) handlerOrClassName;
			try {
				// 通过反射将类路径转化为类
				Class<?> handlerClass = ClassUtils.forName(className, this.classLoader);
				if (!NamespaceHandler.class.isAssignableFrom(handlerClass)) {
					throw new FatalBeanException("Class [" + className + "] for namespace [" + namespaceUri +
							"] does not implement the [" + NamespaceHandler.class.getName() + "] interface");
				}
				// 实例化类
				NamespaceHandler namespaceHandler = (NamespaceHandler) BeanUtils.instantiateClass(handlerClass);
				// 调用自定义的namespaceHandler的初始化方法
				namespaceHandler.init();
				// 讲结果记录在缓存中
				handlerMappings.put(namespaceUri, namespaceHandler);
				return namespaceHandler;
			}
			catch (ClassNotFoundException ex) {
				throw new FatalBeanException("Could not find NamespaceHandler class [" + className +
						"] for namespace [" + namespaceUri + "]", ex);
			}
			catch (LinkageError err) {
				throw new FatalBeanException("Unresolvable class definition for NamespaceHandler class [" +
						className + "] for namespace [" + namespaceUri + "]", err);
			}
		}
	}
```



##### 步骤

例如：我们自定义一个标签<test:user username="zhangsan" email="testEmail" password="test123456" />

1. 定义一个实体类User

2. 写一个类继承AbstractSingleBeanDefinitionParser，并覆盖父类方法。

3. 写一个类继承NamespaceHandlerSupport，覆盖父类方法。可参考ContextNamespaceHandler。

   1. 上述步骤参考代码

   2. ```java
      /**
      * 1.实体类，用于承载自定义标签中的信息
      */
      public class User {
          private String username;
          private String email;
          private String password;
      
          public String getUsername() {
              return username;
          }
      
          public void setUsername(String username) {
              this.username = username;
          }
      
          public String getEmail() {
              return email;
          }
      
          public void setEmail(String email) {
              this.email = email;
          }
      
          public String getPassword() {
              return password;
          }
      
          public void setPassword(String password) {
              this.password = password;
          }
      }
      
      /**
       * 自定义标签分析器。<br>
       * 不继承AbstractPropertyLoadingBeanDefinitionParser是因为，我们标签中暂时不需要location，properties-ref等等属性。
       */
      public class UserBeanDefinitionParser extends AbstractSingleBeanDefinitionParser {
      
          /**
           * 返回属性值所对应的对象
           *
           * @param element the {@code Element} that is being parsed
           * @return
           */
          @Override
          protected Class<?> getBeanClass(Element element) {
              return User.class;
          }
      
          /**
           * 标签解析方法。负责解析标签的自定义属性。
           *
           * @param element the XML element being parsed
           * @param builder used to define the {@code BeanDefinition}
           */
          @Override
          protected void doParse(Element element, BeanDefinitionBuilder builder) {
              String userName = element.getAttribute("userName");
              String email = element.getAttribute("email");
              String password = element.getAttribute("password");
      
              if (StringUtils.hasText(userName)) {
                  builder.addPropertyValue("username", userName);
              }
              if (StringUtils.hasText(email)) {
                  builder.addPropertyValue("email", email);
              }
              if (StringUtils.hasText(password)) {
                  builder.addPropertyValue("password", password);
              }
          }
      }
      
      /**
       * 3.自定义命名空间处理类。参考ContextNamespaceHandler
       */
      public class UserNamespaceHandler extends NamespaceHandlerSupport {
          @Override
          public void init() {
              registerBeanDefinitionParser("user",new UserBeanDefinitionParser());
          }
      }
      ```

4. 在项目配置文件目录（resources/META-INF/）中，新增文件spring.handlers，加入处理类的映射。

   1. 注意：在idea中创建这个文件时，要确保他是properties类型的。不能是txt类型的。
   2. `http\://www.test.com/schema/user=com.test.selftag.UserNamespaceHandler`

5. 在项目配置文件目录（resources/META-INF/）中，新增文件spring.schemas，加入命名空间和xsd的映射。

   1. 注意：在idea中创建这个文件时，要确保他是properties类型的。不能是txt类型的。
   2. `http\://www.test.com/schema/user.xsd=META-INF/user.xsd`

6. 在项目配置文件目录（resources/META-INF/）中，新增文件user.xsd。

   1. ```xml
      <?xml version="1.0" encoding="UTF-8"?>
      <schema xmlns="http://www.w3.org/2001/XMLSchema"
              targetNamespace="http://www.test.com/schema/user"
              xmlns:tns="http://www.test.com/schema/user"
              elementFormDefault="qualified">
          <element name="user">
              <complexType>
                  <attribute name ="id" type = "string"/>
                  <attribute name ="userName" type = "string"/>
                  <attribute name ="email" type = "string"/>
                  <attribute name ="password" type="string"/>
              </complexType>
          </element>
      </schema>
      ```

7. 在Spring配置文件中，使用我们的自定义标签。

   1. applicationContext.xml

   2. ```xml
      <?xml version="1.0" encoding="UTF-8"?>
      <beans xmlns="http://www.springframework.org/schema/beans"
             xmlns:context="http://www.springframework.org/schema/context"
             xmlns:test="http://www.test.com/schema/user"
             xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
             xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd
              http://www.springframework.org/schema/context  http://www.springframework.org/schema/context/spring-context.xsd
              http://www.test.com/schema/user http://www.test.com/schema/user.xsd">
      
      	<test:user id="testTag" username="lisi" email="lisi@163.com" password="123456"></test:user>
      
          <bean id="person"  class="com.test.Person" scope="prototype">
              <property name="id" value="1"></property>
              <property name="name" value="zhangsan"></property>
          </bean>
      </beans>
      ```

8. 写一个容器启动测试类。测试刚才的自定义标签。

   1. ```java
      public class Test {
          public static void main(String[] args) {
       		ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
              User user = (User) ac.getBean("testTag");
              System.out.println(user);
          }
      }
      ```

9. 问题排查。

   1. 如果报错assert short name !=key，可能是docs.gradle中的这段代码引起的，把它注释掉就行了。

   2. ```groovy
      task schemaZip(type: Zip) {
      	group = "Distribution"
      	archiveBaseName.set("spring-framework")
      	archiveClassifier.set("schema")
      	description = "Builds -${archiveClassifier} archive containing all " +
      			"XSDs for deployment at https://springframework.org/schema."
      	duplicatesStrategy DuplicatesStrategy.EXCLUDE
      	moduleProjects.each { module ->
      		def Properties schemas = new Properties();
      
      		module.sourceSets.main.resources.find {
      			(it.path.endsWith("META-INF/spring.schemas") || it.path.endsWith("META-INF\\spring.schemas"))
      		}?.withInputStream { schemas.load(it) }
      
      //把下面的代码注释。
      //		for (def key : schemas.keySet()) {
      //			def shortName = key.replaceAll(/http.*schema.(.*).spring-.*/, '$1')
      //			assert shortName != key
      //			File xsdFile = module.sourceSets.main.resources.find {
      //				(it.path.endsWith(schemas.get(key)) || it.path.endsWith(schemas.get(key).replaceAll('\\/','\\\\')))
      //			}
      //			assert xsdFile != null
      //			into (shortName) {
      //				from xsdFile.path
      //			}
      //		}
      	}
      }
      ```

   3. 

##### 应用场景

暂无。工作中很少用到。



#### 自定义属性编辑器

##### 说明

Spring允许用户自定义属性编辑器。当对象实例化后，可以对某一个字段进行定制化修改。例如：从某个对象的文本address字段中解析出，省市区3个字段。

##### 代码出处

1. 在ioc容器初始化过程中，在类（AbstractApplicationContext）的prepareBeanFactory方法中会初始化PropertyEditorRegistrar。

2. ```java
   	protected void prepareBeanFactory(ConfigurableListableBeanFactory beanFactory) {
   		// Tell the internal bean factory to use the context's class loader etc.
   		// 设置beanFactory的classloader为当前context的classloader
   		beanFactory.setBeanClassLoader(getClassLoader());
   		// 设置beanfactory的SpEL表达式语言的Resolver。内部还会创建SpelExpressionParser
   		beanFactory.setBeanExpressionResolver(new StandardBeanExpressionResolver(beanFactory.getBeanClassLoader()));
   		// 为beanFactory增加一个默认的PropertyEditorRegistrar，这个主要是对bean的属性等设置管理的一个工具类
   		beanFactory.addPropertyEditorRegistrar(new ResourceEditorRegistrar(this, getEnvironment()));
   		//上面就是PropertyEditorRegistrar初始化的地方，忽略其他不相关代码
   	}
   ```

3. invokeBeanFactoryPostProcessors()方法会调用CustomEditorConfigurer.postProcessBeanFactory()方法，会循环自身的数组属性propertyEditorRegistrar。将其添加到BeanFactory中。同时还会循环另一个属性customEditors也加入到BeanFactory中。

   1. 参考代码

   2. ```java
      	public void postProcessBeanFactory(ConfigurableListableBeanFactory beanFactory) throws BeansException {
      		// 如果属性编辑注册器不等于空
      		if (this.propertyEditorRegistrars != null) {
      			// 遍历属性编辑注册器的集合
      			for (PropertyEditorRegistrar propertyEditorRegistrar : this.propertyEditorRegistrars) {
      				// 将属性编辑注册器添加到beanFactory
      				beanFactory.addPropertyEditorRegistrar(propertyEditorRegistrar);
      			}
      		}
      		// 如果自定义编辑器不等于空
      		if (this.customEditors != null) {
      			// 遍历自定义编辑器集合将自定义编辑器添加到beanFactory中
      			this.customEditors.forEach(beanFactory::registerCustomEditor);
      		}
      	}
      ```

   3. 调用堆栈，可通过Idea的Call Hierarchy功能反查得到

   4. CustomEditorConfigurer.postProcessBeanFactory(ConfigurableListableBeanFactory)  (org.springframework.beans.factory.config)  

      - PostProcessorRegistrationDelegate.invokeBeanFactoryPostProcessors(Collection, ConfigurableListableBeanFactory)  (org.springframework.context.support)  
        - PostProcessorRegistrationDelegate.invokeBeanFactoryPostProcessors(ConfigurableListableBeanFactory, List)(6 usages)  (org.springframework.context.support)  
          - AbstractApplicationContext.invokeBeanFactoryPostProcessors(ConfigurableListableBeanFactory)  (org.springframework.context.support)  
            - AbstractApplicationContext.refresh()  (org.springframework.context.support)

4. 在AbstractBeanFactory.registerCustomEditors()方法中，会调用我们自定义的注册器，将属性和编辑器绑定。

   1. 源代码

   2. ```java
      	protected void initBeanWrapper(BeanWrapper bw) {
      		// 使用该工厂的ConversionService来作为bw的ConversionService，用于转换属性值，以替换JavaBeans PropertyEditor
      		bw.setConversionService(getConversionService());
      		// 将工厂中所有定制PropertyEditor注册到bw中
      		registerCustomEditors(bw);
      	}
      
      	protected void registerCustomEditors(PropertyEditorRegistry registry) {
      		// PropertyEditorRegistrySupport是PropertyEditorRegistry接口的默认实现
      		// 将registry强转成PropertyEditorRegistrySupport对象，如果registry不能强转则为null
      		PropertyEditorRegistrySupport registrySupport =
      				(registry instanceof PropertyEditorRegistrySupport ? (PropertyEditorRegistrySupport) registry : null);
      		// 如果成功获取PropertyEditorRegistrySupport对象
      		if (registrySupport != null) {
      			// 激活仅用于配置目的的配置值编辑器
      			registrySupport.useConfigValueEditors();
      		}
      		// PropertyEditorRegistrar：各种业务的PropertyEditorSupport一般都会先注册到PropertyEditorRegistrar中，再通过PropertyEditorRegistrar
      		// 将PropertyEditorSupport注册到PropertyEditorRegistry中
      		// 如果该工厂的propertyEditorRegistrar列表不为空
      		if (!this.propertyEditorRegistrars.isEmpty()) {
      			// propertyEditorRegistrars默认情况下只有一个元素对象，该对象为ResourceEditorRegistrar。
      			// 遍历propertyEditorRegistrars
      			for (PropertyEditorRegistrar registrar : this.propertyEditorRegistrars) {
      				try {
      					// ResourceEditorRegistrar会将ResourceEditor, InputStreamEditor, InputSourceEditor,
      					// FileEditor, URLEditor, URIEditor, ClassEditor, ClassArrayEditor注册到registry中，
      					// 如果registry已配置了ResourcePatternResolver,则还将注册ResourceArrayPropertyEditor
      					// 将registrar中的所有PropertyEditor注册到PropertyEditorRegistry中
      					registrar.registerCustomEditors(registry);
      				}
      				// 捕捉Bean创建异常
      				catch (BeanCreationException ex) {
      					Throwable rootCause = ex.getMostSpecificCause();
      					if (rootCause instanceof BeanCurrentlyInCreationException) {
      						BeanCreationException bce = (BeanCreationException) rootCause;
      						String bceBeanName = bce.getBeanName();
      						if (bceBeanName != null && isCurrentlyInCreation(bceBeanName)) {
      							if (logger.isDebugEnabled()) {
      								logger.debug("PropertyEditorRegistrar [" + registrar.getClass().getName() +
      										"] failed because it tried to obtain currently created bean '" +
      										ex.getBeanName() + "': " + ex.getMessage());
      							}
      							onSuppressedException(ex);
      							continue;
      						}
      					}
      					// 重写抛出ex
      					throw ex;
      				}
      			}
      		}
      		// 如果该工厂的自定义PropertyEditor集合有元素，在SpringBoot中，customEditors默认是空的
      		if (!this.customEditors.isEmpty()) {
      			// 遍历自定义PropertyEditor集合,将其元素注册到registry中
      			this.customEditors.forEach((requiredType, editorClass) ->
      					registry.registerCustomEditor(requiredType, BeanUtils.instantiateClass(editorClass)));
      		}
      	}
      ```

   3. 调用堆栈。是在实例化对象时调用进来的。

   4. AbstractBeanFactory.registerCustomEditors(PropertyEditorRegistry)  (org.springframework.beans.factory.support)

      - AbstractBeanFactory.initBeanWrapper(BeanWrapper)  (org.springframework.beans.factory.support)
        - AbstractAutowireCapableBeanFactory.instantiateBean(String, RootBeanDefinition)  (org.springframework.beans.factory.support)
          - AbstractAutowireCapableBeanFactory.createBeanInstance(String, RootBeanDefinition, Object[])(2 usages)  (org.springframework.beans.factory.support)
            - AbstractAutowireCapableBeanFactory.doCreateBean(String, RootBeanDefinition, Object[])  (org.springframework.beans.factory.support)

5. 在TypeConverterDelegate.convertIfNecessary()方法中，会根据属性类型去自定义属性编辑器中查找，如果找到就会对值进行转化和赋值操作

   1. 源代码。在第7行会进行查找，然后在第64行进行值的转换。并且在这个里面会调用我们自己写的编辑器。

   2. ```java
      public <T> T convertIfNecessary(@Nullable String propertyName, @Nullable Object oldValue, @Nullable Object newValue,
      			@Nullable Class<T> requiredType, @Nullable TypeDescriptor typeDescriptor) throws IllegalArgumentException {
      
      		// Custom editor for this type? 自定义编辑这个类型吗？
      		// PropertyEditor是属性编辑器的接口，它规定了将外部设置值转换为内部JavaBean属性值的转换接口方法。
      		// 为requiredType和propertyName找到一个自定义属性编辑器
      		PropertyEditor editor = this.propertyEditorRegistry.findCustomEditor(requiredType, propertyName);
      
      		// 尝试使用自定义ConversionService转换newValue转换失败后抛出的异常
      		ConversionFailedException conversionAttemptEx = null;
      
      		// No custom editor but custom ConversionService specified?
      		// 没有自定以编辑器，但自定以 ConversionService 指定了？
      		// ConversionService :  一个类型转换的服务接口。这个转换系统的入口。
      		// 获取类型转换服务
      		ConversionService conversionService = this.propertyEditorRegistry.getConversionService();
      		// 如果editor为null且cnversionService不为null&&新值不为null&&类型描述符不为null
      		if (editor == null && conversionService != null && newValue != null && typeDescriptor != null) {
      			// 将newValue封装成TypeDescriptor对象
      			TypeDescriptor sourceTypeDesc = TypeDescriptor.forObject(newValue);
      			// 如果sourceTypeDesc的对象能被转换成typeDescriptor.
      			if (conversionService.canConvert(sourceTypeDesc, typeDescriptor)) {
      				try {
      					// 从conversionService 中找到 sourceTypeDesc,typeDesriptor对于的转换器进行对newValue的转换成符合typeDesciptor类型的对象，并返回出去
      					return (T) conversionService.convert(newValue, sourceTypeDesc, typeDescriptor);
      				}
      				catch (ConversionFailedException ex) {
      					// fallback to default conversion logic below
      					// 返回到下面的默认转换逻辑
      					conversionAttemptEx = ex;
      				}
      			}
      		}
      
      		// 默认转换后的值为newValue
      		Object convertedValue = newValue;
      
      		// Value not of required type?
      		// 值不是必需的类型
      		// 如果editor不为null||(requiredType不为null&&convertedValue不是requiredType的实例)
      		if (editor != null || (requiredType != null && !ClassUtils.isAssignableValue(requiredType, convertedValue))) {
      			// 如果typeDescriptor不为null&&requiredType不为null&&requiredType是Collection的子类或实现&&conventedValue是String类型
      			if (typeDescriptor != null && requiredType != null && Collection.class.isAssignableFrom(requiredType) &&
      					convertedValue instanceof String) {
      				// 获取该typeDescriptor的元素TypeDescriptor
      				TypeDescriptor elementTypeDesc = typeDescriptor.getElementTypeDescriptor();
      				// 如果elementTypeDesc不为null
      				if (elementTypeDesc != null) {
      					// 获取elementTypeDesc的类型
      					Class<?> elementType = elementTypeDesc.getType();
      					// 如果elementType是Class类||elementType是Enum的子类或实现
      					if (Class.class == elementType || Enum.class.isAssignableFrom(elementType)) {
      						// 将convertedValue强转为String，以逗号分割convertedValue返回空字符串
      						convertedValue = StringUtils.commaDelimitedListToStringArray((String) convertedValue);
      					}
      				}
      			}
      			// 如果editor为null
      			if (editor == null) {
      				// 找到requiredType的默认编辑器
      				editor = findDefaultEditor(requiredType);
      			}
      			// 使用editor将convertedValue转换为requiredType
      			convertedValue = doConvertValue(oldValue, convertedValue, requiredType, editor);
      		}
      
      		// 标准转换标记，convertedValue是Collection类型，Map类型，数组类型，可转换成Enum类型的String对象，Number类型并成功进行转换后即为true
      		boolean standardConversion = false;
      
      		// 如果requiredType不为null
      		if (requiredType != null) {
      			// Try to apply some standard type conversion rules if appropriate.
      			// 如果合适，尝试应用一些标准类型转换规则
      			// convertedValue不为null
      			if (convertedValue != null) {
      				// 如果requiredType是Object类型
      				if (Object.class == requiredType) {
      					// 直接返回convertedValue
      					return (T) convertedValue;
      				}
      				// 如果requiredType是数组
      				else if (requiredType.isArray()) {
      					// Array required -> apply appropriate conversion of elements.
      					// 数组所需 -> 应用适当的元素转换
      					// 如果convertedValue是String的实例&&requiredType的元素类型是Enum的子类或实现
      					if (convertedValue instanceof String && Enum.class.isAssignableFrom(requiredType.getComponentType())) {
      						// 将逗号分割的列表(例如 csv 文件中的一行)转换为字符串数组
      						convertedValue = StringUtils.commaDelimitedListToStringArray((String) convertedValue);
      					}
      					// 将convertedValue转换为componentType类型数组对象
      					return (T) convertToTypedArray(convertedValue, propertyName, requiredType.getComponentType());
      				}
      				// 如果convertedValue是Collection对象
      				else if (convertedValue instanceof Collection) {
      					// Convert elements to target type, if determined.
      					// 如果确定，则将元素转换为目标类型
      					// 将convertedValue转换为Collection类型对象
      					convertedValue = convertToTypedCollection(
      							(Collection<?>) convertedValue, propertyName, requiredType, typeDescriptor);
      					// 更新standardConversion标记
      					standardConversion = true;
      				}
      				// 如果convertedValue是Map对象
      				else if (convertedValue instanceof Map) {
      					// Convert keys and values to respective target type, if determined.
      					// 如果确定了，则将建和值转换为相应的目标类型
      					convertedValue = convertToTypedMap(
      							(Map<?, ?>) convertedValue, propertyName, requiredType, typeDescriptor);
      					// 更新standardConversion标记
      					standardConversion = true;
      				}
      				// 如果convertedValue是数组类型，并且长度为1，那么就把get(0)赋值给本身
      				if (convertedValue.getClass().isArray() && Array.getLength(convertedValue) == 1) {
      					// 获取convertedValue的第一个元素对象
      					convertedValue = Array.get(convertedValue, 0);
      					// 更新standardConversion标记
      					standardConversion = true;
      				}
      				// 如果需要的类型是String，并且convertedValue的类型是基本类型或者装箱类型，那就直接toString 后强行转换
      				if (String.class == requiredType && ClassUtils.isPrimitiveOrWrapper(convertedValue.getClass())) {
      					// We can stringify any primitive value...
      					// 将convertedValue转换为字符转返回出去
      					return (T) convertedValue.toString();
      				}
      				// 如果convertedValue是String类型&& convertedValue不是requiredType类型
      				else if (convertedValue instanceof String && !requiredType.isInstance(convertedValue)) {
      					// conversionAttemptEx为null意味着自定义ConversionService转换newValue转换失败或者没有自定义ConversionService
      					// 如果conversionAttemptEx为null&&requiredType不是接口&&requireType不是枚举类
      					if (conversionAttemptEx == null && !requiredType.isInterface() && !requiredType.isEnum()) {
      						try {
      							// 获取requiredType的接收一个String类型参数的构造函数对象
      							Constructor<T> strCtor = requiredType.getConstructor(String.class);
      							// 使用strCtor构造函数，传入convertedValue实例化对象并返回出去
      							return BeanUtils.instantiateClass(strCtor, convertedValue);
      						}
      						catch (NoSuchMethodException ex) {
      							// proceed with field lookup
      							if (logger.isTraceEnabled()) {
      								logger.trace("No String constructor found on type [" + requiredType.getName() + "]", ex);
      							}
      						}
      						catch (Exception ex) {
      							if (logger.isDebugEnabled()) {
      								logger.debug("Construction via String failed for type [" + requiredType.getName() + "]", ex);
      							}
      						}
      					}
      					// 将convertedValue强转为字符串，并去掉前后的空格
      					String trimmedValue = ((String) convertedValue).trim();
      					// 如果requireType是枚举&&trimmedValue是空字符串
      					if (requiredType.isEnum() && trimmedValue.isEmpty()) {
      						// It's an empty enum identifier: reset the enum value to null.
      						// 这个一个空枚举标识符：重置枚举值为null
      						return null;
      					}
      					// 尝试转换String对象为Enum对象
      					convertedValue = attemptToConvertStringToEnum(requiredType, trimmedValue, convertedValue);
      					// 更新standardConversion标记
      					standardConversion = true;
      				}
      				// 如果convertedValue是Number实例&&requiredType是Number的实现或子类
      				else if (convertedValue instanceof Number && Number.class.isAssignableFrom(requiredType)) {
      					// NumberUtils.convertNumberToTargetClass：将convertedValue为requiredType的实例
      					convertedValue = NumberUtils.convertNumberToTargetClass(
      							(Number) convertedValue, (Class<Number>) requiredType);
      					// 更新standardConversion标记
      					standardConversion = true;
      				}
      			}
      			else {
      				// convertedValue == null
      				// 如果requiredType为Optional类
      				if (requiredType == Optional.class) {
      					// 将convertedValue设置Optional空对象
      					convertedValue = Optional.empty();
      				}
      			}
      
      			// 如果convertedValue不是requiredType的实例
      			if (!ClassUtils.isAssignableValue(requiredType, convertedValue)) {
      				// conversionAttemptEx：尝试使用自定义ConversionService转换newValue转换失败后抛出的异常
      				// conversionAttemptEx不为null
      				if (conversionAttemptEx != null) {
      					// Original exception from former ConversionService call above...
      					// 从前面的ConversionService调用的原始异常
      					// 重新抛出conversionAttemptEx
      					throw conversionAttemptEx;
      				}
      				// 如果conversionService不为null&&typeDescriptor不为null
      				else if (conversionService != null && typeDescriptor != null) {
      					// ConversionService not tried before, probably custom editor found
      					// but editor couldn't produce the required type...
      					// ConversionService之前没有尝试过，可能找到了自定义编辑器，但编辑器不能产生所需的类型获取newValue的类型描述符
      					TypeDescriptor sourceTypeDesc = TypeDescriptor.forObject(newValue);
      					// 如果sourceTypeDesc的对象能被转换成typeDescriptor
      					if (conversionService.canConvert(sourceTypeDesc, typeDescriptor)) {
      						// 将newValue转换为typeDescriptor对应类型的对象
      						return (T) conversionService.convert(newValue, sourceTypeDesc, typeDescriptor);
      					}
      				}
      
      				// Definitely doesn't match: throw IllegalArgumentException/IllegalStateException
      				// 绝对不匹配：抛出IllegalArgumentException/IllegalStateException
      				// 拼接异常信息
      				StringBuilder msg = new StringBuilder();
      				msg.append("Cannot convert value of type '").append(ClassUtils.getDescriptiveType(newValue));
      				msg.append("' to required type '").append(ClassUtils.getQualifiedName(requiredType)).append("'");
      				if (propertyName != null) {
      					msg.append(" for property '").append(propertyName).append("'");
      				}
      				if (editor != null) {
      					msg.append(": PropertyEditor [").append(editor.getClass().getName()).append(
      							"] returned inappropriate value of type '").append(
      							ClassUtils.getDescriptiveType(convertedValue)).append("'");
      					throw new IllegalArgumentException(msg.toString());
      				}
      				else {
      					msg.append(": no matching editors or conversion strategy found");
      					throw new IllegalStateException(msg.toString());
      				}
      			}
      		}
      
      		// conversionAttemptEx：尝试使用自定义ConversionService转换newValue转换失败后抛出的异常
      		// conversionAttemptEx不为null
      		if (conversionAttemptEx != null) {
      			// editor：requiredType和propertyName对应一个自定义属性编辑器
      			// standardConversion:标准转换标记，convertedValue是Collection类型，Map类型，数组类型，
      			// 可转换成Enum类型的String对象，Number类型并成功进行转换后即为true
      			// editor为null&&不是标准转换&&要转换的类型不为null&&requiedType不是Object类
      			if (editor == null && !standardConversion && requiredType != null && Object.class != requiredType) {
      				// 重新抛出conversionAttemptEx
      				throw conversionAttemptEx;
      			}
      			logger.debug("Original ConversionService attempt failed - ignored since " +
      					"PropertyEditor based conversion eventually succeeded", conversionAttemptEx);
      		}
      
      		// 返回转换后的值
      		return (T) convertedValue;
      	}
      ```

   3. 此方法的调用堆栈比较长，他是在AbstractApplicationContext.finishBeanFactoryInitialization()中调用的

6. 

##### 步骤

1. 定义2个实体类，一个是Customer，一个是Address

   1. ```java
      /**
       * 地址类：包含省市区。
       */
      public class Address {
          private String province;
          private String city;
          private String town;
      
          public String getProvince() {
              return province;
          }
      
          public void setProvince(String province) {
              this.province = province;
          }
      
          public String getCity() {
              return city;
          }
      
          public void setCity(String city) {
              this.city = city;
          }
      
          public String getTown() {
              return town;
          }
      
          public void setTown(String town) {
              this.town = town;
          }
      
          @Override
          public String toString() {
              return "Address{" +
                      "province='" + province + '\'' +
                      ", city='" + city + '\'' +
                      ", town='" + town + '\'' +
                      '}';
          }
      }
      
      /**
       * 客户类
       */
      public class Customer {
          private String name;
          private Address address;
      
          public String getName() {
              return name;
          }
      
          public void setName(String name) {
              this.name = name;
          }
      
          public Address getAddress() {
              return address;
          }
      
          public void setAddress(Address address) {
              this.address = address;
          }
      
          @Override
          public String toString() {
              return "Customer{" +
                      "name='" + name + '\'' +
                      ", address=" + address +
                      '}';
          }
      }
      ```

2. 写一个类继承PropertyEditorSupport。可参考FileEditor。

   1. ```java
      public class AddressPropertyEditor extends PropertyEditorSupport {
          /**
           * 将传入的String解析成省市区。按"_"分割
           * @param text The string to be parsed.
           * @throws IllegalArgumentException
           */
          @Override
          public void setAsText(String text) throws IllegalArgumentException {
              String[] s = text.split("_");
              Address address = new Address();
              address.setProvince(s[0]);
              address.setCity(s[1]);
              address.setTown(s[2]);
              //调用父类的setValue方法将address赋值到父对象上。
              this.setValue(address);
          }
      }
      ```

3. 写一个类实现PropertyEditorRegistrar接口

   1. ```java
      public class AddressPropertyEditorRegistrar implements PropertyEditorRegistrar {
          /**
           * 自定义属性编辑器注册。将Address类型和其绑定。
           * @param registry the {@code PropertyEditorRegistry} to register the
           * custom {@code PropertyEditors} with
           */
          @Override
          public void registerCustomEditors(PropertyEditorRegistry registry) {
              registry.registerCustomEditor(Address.class, new AddressPropertyEditor());
          }
      }
      ```

4. 在配置文件中配置customer类，并且将自定义编辑器加入到Spring内部。

   1. ```xml
      <?xml version="1.0" encoding="UTF-8"?>
      <beans xmlns="http://www.springframework.org/schema/beans"
             xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
             xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd">
      
          <bean id="customer" class="com.test.selfEditor.Customer">
              <property name="name" value="zhangsan"></property>
              <property name="address" value="江苏省_苏州市_唯亭镇"></property>
          </bean>
          
          <!-- 往Spring内部增加自定义属性注册器 -->
          <bean class="org.springframework.beans.factory.config.CustomEditorConfigurer">
              <property name="propertyEditorRegistrars">
                  <list>
                      <bean class="com.test.selfEditor.AddressPropertyEditorRegistrar"></bean>
                  </list>
              </property>
          </bean>
      </beans>
      ```

   2. 另一种配置方式。

      1. 上面是通过往propertyEditorRegistrars放入注册器实现的，通过看代码可以知道，其实这种方式Spring最终还是会customEditors写入属性编辑器。所以我们也可以直接在配置文件中新增属性编辑器。

      2. ```xml
         <?xml version="1.0" encoding="UTF-8"?>
         <beans xmlns="http://www.springframework.org/schema/beans"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd">
         
             <bean id="customer" class="com.test.selfEditor.Customer">
                 <property name="name" value="zhangsan"></property>
                 <property name="address" value="江苏省_苏州市_唯亭镇"></property>
             </bean>
             
             <!-- 往customEditors直接增加自定义属性编辑器 -->
             <bean class="org.springframework.beans.factory.config.CustomEditorConfigurer">
                 <property name="customEditors">
                     <map>
                         <entry key="com.test.selfEditor.Address">
                             <value>com.test.selfEditor.AddressPropertyEditor</value>
                         </entry>
                     </map>
                 </property>
             </bean>
         </beans>
         ```

5. 写一个容器启动的测试类。

   1. ```java
      public class Test {
          public static void main(String[] args) {
       		ApplicationContext ac = new ClassPathXmlApplicationContext("customPropertyEditor.xml");
              Customer c = (Customer)ac.getBean("customer");
              System.out.println(c);
          }
      }
      ```

   2. 控制台打印

      1. > Customer{name='zhangsan', address=Address{province='江苏省', city='苏州市', town='唯亭镇'}}

##### 应用场景

暂无。工作中很少用到。



### 工具类

https://blog.csdn.net/f641385712/article/details/89417895

#### AopUtils

Spring非常重要的一个AOP工具类。可以判断当前实例是否是aop代理对象、是jdk代理还是cglib代理的还可以拿到代理对象。

```java
   public static void main(String[] args) {
        HelloService helloService = getProxy(new HelloServiceImpl());
        //===============演示AopUtils==================

        // AopUtils.isAopProxy:是否是代理对象
        System.out.println(AopUtils.isAopProxy(helloService)); // true
        System.out.println(AopUtils.isJdkDynamicProxy(helloService)); // false
        System.out.println(AopUtils.isCglibProxy(helloService)); // true

        // 拿到目标对象
        System.out.println(AopUtils.getTargetClass(helloService)); //class com.fsx.service.HelloServiceImpl

        // selectInvocableMethod:方法@since 4.3  底层依赖于方法MethodIntrospector.selectInvocableMethod
        // 只是在他技术上做了一个判断： 必须是被代理的方法才行（targetType是SpringProxy的子类,且是private这种方法，且不是static的就不行）
        // Spring MVC的detectHandlerMethods对此方法有大量调用~~~~~
        Method method = ClassUtils.getMethod(HelloServiceImpl.class, "hello");
        System.out.println(AopUtils.selectInvocableMethod(method, HelloServiceImpl.class)); //public java.lang.Object com.fsx.service.HelloServiceImpl.hello()

        // 是否是equals方法
        // isToStringMethod、isHashCodeMethod、isFinalizeMethod  都是类似的
        System.out.println(AopUtils.isEqualsMethod(method)); //false

        // 它是对ClassUtils.getMostSpecificMethod,增加了对代理对象的特殊处理。。。
        System.out.println(AopUtils.getMostSpecificMethod(method,HelloService.class));
	｝
```

#### AopConfigUtils

AOP配置的工具类。配置AOP的方式有多种（比如xml、注解等），此工具类针对不同配置，提供不同的工具方法。

不管什么配置，最终走底层逻辑都统一了。

注意：请尽量不要自定义`自动代理创建器`，也不要轻易使用低级别的创建器，若你对原理不是非常懂的话，慎重

```java
public abstract class AopConfigUtils {

	// 这是注册自动代理创建器，默认的BeanName（若想覆盖，需要使用这个BeanName）
	public static final String AUTO_PROXY_CREATOR_BEAN_NAME = "org.springframework.aop.config.internalAutoProxyCreator";

	// 按照升级顺序 存储自动代理创建器（注意这里是升级的顺序 一个比一个强的）
	private static final List<Class<?>> APC_PRIORITY_LIST = new ArrayList<>();
	static {
		APC_PRIORITY_LIST.add(InfrastructureAdvisorAutoProxyCreator.class);
		APC_PRIORITY_LIST.add(AspectJAwareAdvisorAutoProxyCreator.class);
		APC_PRIORITY_LIST.add(AnnotationAwareAspectJAutoProxyCreator.class);
	}

	// 这两个：注册的是`InfrastructureAdvisorAutoProxyCreator`  
	// 调用处为：AutoProxyRegistrar#registerBeanDefinitions（它是一个ImportBeanDefinitionRegistrar实现类） 
	// 而AutoProxyRegistrar使用处为CachingConfigurationSelector，和`@EnableCaching`注解有关
	// 其次就是AopNamespaceUtils有点用，这个下面再分析
	@Nullable
	public static BeanDefinition registerAutoProxyCreatorIfNecessary(BeanDefinitionRegistry registry,
			@Nullable Object source) {
		return registerOrEscalateApcAsRequired(InfrastructureAdvisorAutoProxyCreator.class, registry, source);
	}
	@Nullable
	public static BeanDefinition registerAspectJAutoProxyCreatorIfNecessary(BeanDefinitionRegistry registry) {
		return registerAspectJAutoProxyCreatorIfNecessary(registry, null);
	}
	
	// 下面这两个是注入：AspectJAwareAdvisorAutoProxyCreator
	// 目前没有地方默认调用~~~~和Aop的xml配置方案有关的
	@Nullable
	public static BeanDefinition registerAspectJAutoProxyCreatorIfNecessary(BeanDefinitionRegistry registry) {
		return registerAspectJAutoProxyCreatorIfNecessary(registry, null);
	}
	@Nullable
	public static BeanDefinition registerAspectJAutoProxyCreatorIfNecessary(BeanDefinitionRegistry registry,
			@Nullable Object source) {
		return registerOrEscalateApcAsRequired(AspectJAwareAdvisorAutoProxyCreator.class, registry, source);
	}

	// 这个就是最常用的，注入的是：AnnotationAwareAspectJAutoProxyCreator  注解驱动的自动代理创建器
	// `@EnableAspectJAutoProxy`注入进来的就是它了
	@Nullable
	public static BeanDefinition registerAspectJAnnotationAutoProxyCreatorIfNecessary(BeanDefinitionRegistry registry) {
		return registerAspectJAnnotationAutoProxyCreatorIfNecessary(registry, null);
	}
	@Nullable
	public static BeanDefinition registerAspectJAnnotationAutoProxyCreatorIfNecessary(BeanDefinitionRegistry registry,
			@Nullable Object source) {
		return registerOrEscalateApcAsRequired(AnnotationAwareAspectJAutoProxyCreator.class, registry, source);
	}


	// 这两个方法，很显然，就是处理注解的两个属性值
	// proxyTargetClass：true表示强制使用CGLIB的动态代理
	// exposeProxy：true暴露当前代理对象到线程上绑定
	// 最终都会放到自动代理创建器得BeanDefinition 里面去~~~创建代理的时候会用到此属性值
	public static void forceAutoProxyCreatorToUseClassProxying(BeanDefinitionRegistry registry) {
		if (registry.containsBeanDefinition(AUTO_PROXY_CREATOR_BEAN_NAME)) {
			BeanDefinition definition = registry.getBeanDefinition(AUTO_PROXY_CREATOR_BEAN_NAME);
			definition.getPropertyValues().add("proxyTargetClass", Boolean.TRUE);
		}
	}
	public static void forceAutoProxyCreatorToExposeProxy(BeanDefinitionRegistry registry) {
		if (registry.containsBeanDefinition(AUTO_PROXY_CREATOR_BEAN_NAME)) {
			BeanDefinition definition = registry.getBeanDefinition(AUTO_PROXY_CREATOR_BEAN_NAME);
			definition.getPropertyValues().add("exposeProxy", Boolean.TRUE);
		}
	}

	//上面的注册自动代理创建器IfNecessary之类的方法，最终都是调用了这里========
	@Nullable
	private static BeanDefinition registerOrEscalateApcAsRequired(Class<?> cls, BeanDefinitionRegistry registry,
			@Nullable Object source) {
		
		// 这里相当于，如果你自己定义了一个名称为这个的自动代理创建器，那也是ok的（需要注意的是使用工厂方法@Bean的方式定义，这里是会报错的）
		if (registry.containsBeanDefinition(AUTO_PROXY_CREATOR_BEAN_NAME)) {
			BeanDefinition apcDefinition = registry.getBeanDefinition(AUTO_PROXY_CREATOR_BEAN_NAME);
			
			// 若使用@Bean的方法定义，这里apcDefinition.getBeanClassName()就是null，导致后面的findPriorityForClass(apcDefinition.getBeanClassName())就会报错~~~~~~~  需要特别的注意哦~~~~~
			if (!cls.getName().equals(apcDefinition.getBeanClassName())) {
				int currentPriority = findPriorityForClass(apcDefinition.getBeanClassName());
				int requiredPriority = findPriorityForClass(cls);
				if (currentPriority < requiredPriority) {
					apcDefinition.setBeanClassName(cls.getName());
				}
			}
			return null;
		}

		// 绝大部分情况下都会走这里，new一个Bean定义信息出来，然后order属性值为HIGHEST_PRECEDENCE
		// role是：ROLE_INFRASTRUCTURE属于Spring框架自己使用的Bean
		// BeanName为：AUTO_PROXY_CREATOR_BEAN_NAME
		RootBeanDefinition beanDefinition = new RootBeanDefinition(cls);
		beanDefinition.setSource(source);
		beanDefinition.getPropertyValues().add("order", Ordered.HIGHEST_PRECEDENCE);
		beanDefinition.setRole(BeanDefinition.ROLE_INFRASTRUCTURE);
		registry.registerBeanDefinition(AUTO_PROXY_CREATOR_BEAN_NAME, beanDefinition);
		return beanDefinition;
	}

	...findPriorityForClass的逻辑省略
}
```



#### ConfigurationClassPostProcessor

`ConfigurationClassPostProcessor`主要解决的问题就是去处理spring定义的一些配置注解，例如`@Configuration`，`@Import`，`@ComponentScan`，`@Bean`等。

- 实现了BeanDefinitionRegistryPostProcessor(BeanFactoryPostProcessor的子类)。
- PriorityOrdered，该类优先执行。
- ResourceLoaderAware，获取资源加载器。
- BeanClassLoaderAware，获取类加载器。
- EnviromentAware，获取环境信息。

##### postProcessBeanDefinitionRegistry()

通过注册器获取**当前**注册器中所有的注册信息。并且找到有@[Configuration](https://so.csdn.net/so/search?q=Configuration&spm=1001.2101.3001.7020)注解的类。

这里的时间节点非常重要。（这时候只有一些内置类和启动类在注册器中，因此`@SpringBootApplication`中必定有`@Configuration`注解）

```java
	public void postProcessBeanDefinitionRegistry(BeanDefinitionRegistry registry) {
		// 根据对应的registry对象生成hashcode值，此对象只会操作一次，如果之前处理过则抛出异常
		int registryId = System.identityHashCode(registry);
		if (this.registriesPostProcessed.contains(registryId)) {
			throw new IllegalStateException(
					"postProcessBeanDefinitionRegistry already called on this post-processor against " + registry);
		}
		if (this.factoriesPostProcessed.contains(registryId)) {
			throw new IllegalStateException(
					"postProcessBeanFactory already called on this post-processor against " + registry);
		}
		// 将马上要进行处理的registry对象的id值放到已经处理的集合对象中
		this.registriesPostProcessed.add(registryId);

		// 处理配置类的bean定义信息
		processConfigBeanDefinitions(registry);
	}
```



#### EventListenerMethodProcessor

此类用来对@EventListener提供支持 

1、解析@EventListener,获取拦截方法 

2、对拦截方法进行转换，编程ApplicationListener 

3、将转换的ApplicationListener放到Spring容器中 Registers




# SpringMVC

#### 什么是MVC？

MVC是指Model-View-Controller，是一种软件设计思想，它将应用程序分为三个部分: M是指模型，V是视图，C则是控制器。

MVC目的是使M和V分开，同一个应用程序可以有不同表现形式，同一个界面也可以有不同的数据模型。

模型(Model)：表示应用程序的核心业务逻和数据。模型通常包含一些数据结构和逻辑规则，用于处理数据的输入、输出、更新和存储等操作。模型并不关心数据的显示或用户的交互方式，它只关注数据本身以及对数据的操作作。

视图(View)：表示应用程序的用户界面，用于显示模型中的数据。视图通常包含一些控件和元素，用于展示数据，并且可以与用户进行交互。视图并不关心数据的处理或存储方式，它只关注如何呈现数据以及如何与用户进行交互。

控制器(Controller)：表示应用程序的处理逻辑，用于控制视图和模型之间的交互。控制器通常包含一些事生外理和动作钟发等操作，用于响应用户的输入或视图的变化，并对模型进行操作。控制器通过将用户的输入转化为对模型的操作，从而实现了视图和模型之间的解耦。



#### SpringMVC处理流程

![v2-62c917d3c5eaada5122746bf66e46f2d_1440w](https://pic2.zhimg.com/80/v2-62c917d3c5eaada5122746bf66e46f2d_1440w.jpg)

1. 用户发送请求给到前端控制器 `DispatchServlet` ；
2. `DispatchServlet` 收到请求后，调用`HandlerMapping` 处理器映射器查找对应负责处理请求的 Handler；
3. `HandlerMapping` 将找到的具体的处理器 Handler 生成处理器对象以及处理器拦截器（如果有则生成），一起返回给 `DispatchServlet`；
4. `DispatchServlet`调用`HandlerAdapter` 处理器适配器，请求执行具体的 Handler；
5. `HandlerAdapter` 将具体 Handler 执行返回的模型和视图返回给到 `DispatchServlet`；
6. 此时 `DispatchServlet` 已经得到具体的 视图名称了，然后向 `ViewResolver` 发起请求，请求解析视图，返回已经解析好的视图对象；
7. `DispatchServlet` 对视图进行渲染，将 model 与view 进行渲染；
8. `DispatchServlet` 返回响应给到用户浏览器；

>  前端控制器 `DispatcherServlet`：接收请求、响应结果，相当于转发器，有了`DispatcherServlet`能够减少了其它组件之间的耦合度。
> 处理器映射器 `HandlerMapping`：根据请求的URL来查找Handler
> 处理器适配器 `HandlerAdapter`：负责执行Handler
> 处理器 Handler：处理器，需要程序员开发
> 视图解析器 `ViewResolver`：进行视图的解析，根据视图逻辑名将ModelAndView解析成真正的视图（view）
> 视图View：View是一个接口， 它的实现类支持不同的视图类型，如jsp，freemarker，pdf等等



SpringMVC拦截器的应用场景



#### Controller的返回值有哪些





#### SpringMVC的常用注解

##### @RequestMapping

RequestMapping是一个用来处理请求地址映射的注解，可用于类或方法上。用于类上，表示类中的所有响应请求的方法都是以该地址作为父路径。

RequestMapping注解有六个属性，下面我们把她分成三类进行说明（下面有相应示例）。

value， method

value： 指定请求的实际地址，指定的地址可以是URI Template 模式（后面将会说明）；

method： 指定请求的method类型， GET、POST、PUT、DELETE等；

consumes： 指定处理请求的提交内容类型（Content-Type），例如application/json, text/html;

produces: 指定返回的内容类型，仅当request请求头中的(Accept)类型中包含该指定类型才返回；

params： 指定request中必须包含某些参数值是，才让该方法处理。

headers： 指定request中必须包含某些指定的header值，才能让该方法处理请求

##### @ResponseBody

该注解用于将Controller的方法返回的对象，通过适当的HttpMessageConverter转换为指定格式后，写入到Response对象的body数据区。

使用时机：返回的数据不是html标签的页面，而是其他某种格式的数据时（如json、xml等）使用；

##### @RequestBody

注解实现接收http请求的json数据，将json转换为java对象。默认的入参只能封装一层。

##### @PathVariable

##### @RequestParam





# SpringBoot

## 参考说明

本文内容主要来源于马士兵教育视频教程（[SpringBoot源码2022-邓鹏波](https://www.mashibing.com/study?courseNo=1288)），结合了老师的笔记以及自己的实践做了一些修改。



## Spring相关知识

为了更好的掌握SpringBoot的内容，需要先给大家介绍下Spring注解编程的发展过程，通过该过程的演变能够让大家更加清楚SpringBoot的由来。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641630185000/e06fd65367f24b3695fbaf0c814338d3.png)

### 1.1 Spring 1.x

  2004年3月24日，Spring1.0 正式发布，提供了IoC，AOP及XML配置的方式。

  在Spring1.x版本中提供的是纯XML配置的方式，也就是在该版本中我们必须要提供xml的配置文件，在该文件中我们通过 `<bean>` 标签来配置需要被IoC容器管理的Bean。

```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
       http://www.springframework.org/schema/beans/spring-beans.xsd">


    <bean class="com.bobo.demo01.UserService" />
</beans>
```

  调试代码

```
public static void main(String[] args) {
    ApplicationContext ac = new FileSystemXmlApplicationContext("classpath:applicationContext01.xml");
    System.out.println("ac.getBean(UserService.class) = " + ac.getBean(UserService.class));
}
```

  输出结果


![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641630185000/2587d0a070424034bbc9178df3001aa5.png)

  在Spring1.2版本的时候提供了@Transaction (org.springframework.transaction.annotation )注解。简化了事务的操作.

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641630185000/cd52767b42b44c3093f07e3252081be8.png)

### 1.2 Spring 2.x

  在2006年10月3日 Spring2.0问世了，在2.x版本中，比较重要的特点是增加了很多注解

#### Spring 2.5之前

  在2.5版本之前新增的有 `@Required` `@Repository` `@Aspect`,同时也扩展了XML的配置能力，提供了第三方的扩展标签，比如 `<dubbo>`

##### @Required

  如果你在某个java类的某个set方法上使用了该注释，那么该set方法对应的属性在xml配置文件中必须被设置，否则就会报错！！！

```
public class UserService {


    private String userName;

    public String getUserName() {
        return userName;
    }

    @Required
    public void setUserName(String userName) {
        this.userName = userName;
    }
}
```

  如果在xml文件中我们不设置对应的属性就会给出错误的提示。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641630185000/62ee46f0bd6348f7b7cb708c4542b7a1.png)

  设置好属性后就没有了错误提示了

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641630185000/c65ff21ea9db4d3390f5ac32e7818cbb.png)

  源码中可以看到 `@Required`从2.0开始提供

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641630185000/7ba48a400d0f40ac8abd9395288bfba7.png)

##### @Repository

@Repository 对应数据访问层Bean.这个注解在Spring2.0版本就提供的有哦，大家可能没有想到。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641630185000/6caab8fb772944cab8785d94d0af1ee6.png)


##### @Aspect

@Aspect是AOP相关的一个注解，用来标识配置类。

#### Spring2.5 之后

在2007年11月19日，Spring更新到了2.5版本，新增了很多常用注解，大大的简化配置操作。

| 注解            | 说明                   |
| --------------- | ---------------------- |
| @Autowired      | 依赖注入               |
| @Qualifier      | 配置@Autowired注解使用 |
| @Component      | 声明组件               |
| @Service        | 声明业务层组件         |
| @Controller     | 声明控制层组件         |
| @RequestMapping | 声明请求对应的处理方法 |

在这些注解的作用下，我们可以不用在xml文件中去注册没有bean，这时我们只需要指定扫码路径，然后在对应的Bean头部添加相关的注解即可，这大大的简化了我们的配置及维护工作。案例如下：

我们在配置文件中只需要配置扫码路径即可：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd
       http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context.xsd">

    <context:component-scan base-package="com.bobo" />

</beans>
```

持久层代码：

```java
@Repository
public class UserDao {

    public void query(){
        System.out.println("dao query ..." );
    }
}
```

业务逻辑层代码

```java
@Service
public class UserService {

    @Autowired
    private UserDao dao;

    public void query(){
        dao.query();
    }
}
```

控制层代码：

```java
@Controller
public class UserController {

    @Autowired
    private UserService service;

    public void query(){
        service.query();
    }
}
```

测试代码

```java
public class Demo02Main {
    public static void main(String[] args) {
        ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext02.xml");
        UserController acBean = ac.getBean(UserController.class);
        acBean.query();
    }
}
```

虽然在Spring的2.5版本提供了很多的注解，也大大的简化了我们的开发，但是任然没有摆脱XML配置驱动。

### 1.3 Spring 3.x

在2009年12月16日发布了Spring3.0版本，这是一个注解编程发展的里程碑版本，在该版本中全面拥抱Java5。提供了 `@Configuration`注解，目的就是去xml化。同时通过 `@ImportResource`来实现Java配置类和XML配置的混合使用来实现平稳过渡。

```java
/**
 * @Configuration 标注的Java类 相当于 application.xml 配置文件
 */
@Configuration
public class JavaConfig {

    /**
     * @Bean 注解 标注的方法就相当于 <bean></bean> 标签
              也是 Spring3.0 提供的注解
     * @return
     */
    @Bean
    public UserService userService(){
        return new UserService();
    }
}
```

在Spring3.1 版之前配置扫描路径我们还只能在 XML 配置文件中通过 `component-scan` 标签来实现，在3.1之前还不能够完全实现去XML配置，在3.1 版本到来的时候，提供了一个 `@ComponentScan`注解，该注解的作用是替换掉 `component-scan`标签，是注解编程很大的进步，也是Spring实现无配置话的坚实基础。

#### @ComponentScan

@ComponentScan的作用是指定扫码路径，用来替代在XML中的 `<component-scan>`标签，默认的扫码路径是当前注解标注的类所在的包及其子包。

定义UserService

```java
@Service
public class UserService {
}
```

创建对于的Java配置类

```java
@Configuration
@ComponentScan
public class JavaConfig {
    public static void main(String[] args) {
        ApplicationContext ac = new AnnotationConfigApplicationContext(JavaConfig.class);
        System.out.println("ac.getBean(UserService.class) = " + ac.getBean(UserService.class));
    }
}
```

输出的结果

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641630185000/5bb24770b5c44c9a8b4aab840400692c.png)

当然也可以指定特定的扫描路径

```java
@Configuration
// 指定特定的扫描路径
@ComponentScan(value = {"com.bobo.demo04"})
public class JavaConfig {

    public static void main(String[] args) {
        ApplicationContext ac = new AnnotationConfigApplicationContext(JavaConfig.class);
        System.out.println("ac.getBean(UserService.class) = " + ac.getBean(UserService.class));
    }
}
```

#### @Import

@Import注解只能用在类上，作用是快速的将实例导入到Spring的IoC容器中，将实例导入到IoC容器中的方式有很多种，比如 `@Bean`注解,@Import注解可以用于导入第三方包。具体的使用方式有三种。

##### 静态导入

静态导入的方式是直接将我们需要导入到IoC容器中的对象类型直接添加进去即可。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641630185000/b7d9be159a3a4290a736449ebca93a5f.png)

这种方式的好处是简单，直接，但是缺点是如果要导入的比较多，则不太方便，而且也不灵活。

##### ImportSelector

`@Import`注解中我们也可以添加一个实现了 `ImportSelector`接口的类型，这时不会将该类型导入IoC容器中，而是会调用 `ImportSelector`接口中定义的 `selectImports`方法，将该方法的返回的字符串数组的类型添加到容器中。

定义两个业务类

```java
public class Cache {
    
}
public class Logger {
    
}
```

定义ImportSelector接口的实现,方法返回的是需要添加到IoC容器中的对象对应的类型的全类路径的字符串数组，我们可以根据不同的业务需求而导入不同的类型，会更加的灵活些。

```java
public class MyImportSelector implements ImportSelector {
    @Override
    public String[] selectImports(AnnotationMetadata importingClassMetadata) {
        return new String[]{Logger.class.getName(),Cache.class.getName()};
    }
}
```

导入测试案例

```java
@Configuration
@Import(MyImportSelector.class)
public class JavaConfig {
    public static void main(String[] args) {
        ApplicationContext ac = new AnnotationConfigApplicationContext(JavaConfig.class);
        for (String beanDefinitionName : ac.getBeanDefinitionNames()) {
            System.out.println("beanDefinitionName = " + beanDefinitionName);
        }
    }
}
```

输出结果：

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641630185000/2211e2c7263141e5ac047441b8df7d4b.png)

##### ImportBeanDefinitionRegistrar

除了上面所介绍的ImportSelector方式灵活导入以外还提供了 `ImportBeanDefinitionRegistrar` 接口,也可以实现，相比 `ImportSelector` 接口的方式,ImportBeanDefinitionRegistrar 的方式是直接在定义的方法中提供了 `BeanDefinitionRegistry` ,自己在方法中实现注册。

```java
public class MyImportBeanDefinitionRegistrar implements ImportBeanDefinitionRegistrar {
    @Override
    public void registerBeanDefinitions(AnnotationMetadata importingClassMetadata, BeanDefinitionRegistry registry) {
        // 将需要注册的对象封装为 RootBeanDefinition 对象
        RootBeanDefinition cache = new RootBeanDefinition(Cache.class);
        registry.registerBeanDefinition("cache",cache);

        RootBeanDefinition logger = new RootBeanDefinition(Logger.class);
        registry.registerBeanDefinition("logger",logger);
    }
}
```

测试代码

```java
@Configuration
@Import(MyImportBeanDefinitionRegistrar.class)
public class JavaConfig {
    public static void main(String[] args) {
        ApplicationContext ac = new AnnotationConfigApplicationContext(JavaConfig.class);
        for (String beanDefinitionName : ac.getBeanDefinitionNames()) {
            System.out.println("beanDefinitionName = " + beanDefinitionName);
        }
    }
}
```

输出结果

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641630185000/4804551db48c426cab59a14db56c0556.png)


#### @EnableXXX

@Enable模块驱动，其实是在系统中我们先开发好各个功能独立的模块，比如 Web MVC 模块， AspectJ代理模块，Caching模块等。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641630185000/1d11f140967c438fa25433c1446eae49.png)

案例说明，先定义好功能模块

```java
/**
 * 定义一个Java配置类
 */
@Configuration
public class HelloWorldConfiguration {

    @Bean
    public String helloWorld(){
        return "Hello World";
    }
}
```

然后定义@Enable注解

```java
/**
 * 定义@Enable注解
 * 在该注解中通过 @Import 注解导入我们自定义的模块，使之生效。
 */
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Import(HelloWorldConfiguration.class)
public @interface EnableHelloWorld {
}
```

测试代码

```java
@Configuration
// 加载 自定义 模块
@EnableHelloWorld
public class JavaMian {

    public static void main(String[] args) {
        ApplicationContext ac = new AnnotationConfigApplicationContext(JavaMian.class);
        String helloWorld = ac.getBean("helloWorld", String.class);
        System.out.println("helloWorld = " + helloWorld);
    }
}
```

效果

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641630185000/faab2d9290394fe3afd1674ceb365aeb.png)

### 1.4 Spring 4.x

  2013年11月1 日更新的Spring 4.0 ，完全支持Java8.这是一个注解完善的时代，提供的核心注解是@Conditional条件注解。@Conditional 注解的作用是按照一定的条件进行判断，满足条件就给容器注册Bean实例。

  @Conditional的定义为：

```java
// 该注解可以在 类和方法中使用
@Target({ElementType.TYPE, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface Conditional {

    /**
     * 注解中添加的类型必须是 实现了 Condition 接口的类型
     */
    Class<? extends Condition>[] value();

}
```

Condition是个接口，需要实现matches方法，返回true则注入bean，false则不注入。

案例讲解，这个案例功能和SpringBoot的@ConditionalOnClass注解类似：

```java
/**
 * 定义一个 Condition 接口的是实现
 */
public class MyCondition implements Condition {
    @Override
    public boolean matches(ConditionContext context, AnnotatedTypeMetadata metadata) {
        try{
            //如果类路径中存在某个类就返回true。
            Class.forName("com.bobo.test.test666");
            return true;
        }catch(ClassNotFoundException e){
            e.printStackTrace();
        }
        return false; // 默认返回false
    }
}
```

创建Java配置类

```java
@Configuration
public class JavaConfig {

    @Bean
    // 条件注解，添加的类型必须是 实现了 Condition 接口的类型
    // MyCondition的 matches 方法返回true 则注入，返回false 则不注入
    @Conditional(MyCondition.class)
    public StudentService studentService(){
        return new StudentService();
    }

    public static void main(String[] args) {
        ApplicationContext ac = new AnnotationConfigApplicationContext(JavaConfig.class);
        for (String beanDefinitionName : ac.getBeanDefinitionNames()) {
            System.out.println("beanDefinitionName = " + beanDefinitionName);
        }
    }
}
```

  测试：

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641630185000/ead2c24971c34a9f91d0fc02895dc091.png)

  但是将 matchs方法的返回结果设置为 true 则效果不同

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641630185000/cdfebe29451242ee9d3b40ce6a410994.png)

  所以@Conditional的作用就是给我们提供了对象导入IoC容器的条件机制，这也是SpringBoot中的自动装配的核心关键。当然在4.x还提供一些其他的注解支持，比如 `@EventListener`,作为ApplicationListener接口编程的第二选择,`@AliasFor`解除注解派生的时候冲突限制。`@CrossOrigin`作为浏览器跨域资源的解决方案。

### 1.5 Spring 5.x

2017年9月28日，Spring来到了5.0版本。5.0同时也是SpringBoot2.0的底层。注解驱动的性能提升方面不是很明显。在Spring Boot应用场景中，大量使用@ComponentScan扫描，导致Spring模式的注解解析时间耗时增大，因此，Spring5.0引入@Indexed，为Spring模式注解添加索引。

当我们在项目中使用了 `@Indexed`之后，编译打包的时候会在项目中自动生成 `META-INT/spring.components`文件。当Spring应用上下文执行 `ComponentScan`扫描时，`META-INT/spring.components`将会被 `CandidateComponentsIndexLoader` 读取并加载，转换为 `CandidateComponentsIndex`对象，这样的话 `@ComponentScan`不在扫描指定的package，而是读取 `CandidateComponentsIndex`对象，从而达到提升性能的目的。

若要开启`@Indexed`索引功能，首先需要引入`spring-context-indexer`。

```xml
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-context-indexer</artifactId>
    <version>${spring.version}</version>
    <optional>true</optional>
</dependency>
```

使用@Indexed注解

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641630185000/cc1f8dd821e741b19b6c1ab23eb56abe.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641630185000/fc77363593f44366b507c358a18a6b6c.png)



### 2. 什么是SPI

  为什么要讲SPI呢？因为在SpringBoot的自动装配中其实有使用到SPI机制，所以掌握了这部分对于SpringBoot的学习还是很有帮助的。

  **SPI** ，全称为 Service Provider Interface，是一种服务发现机制。它通过在ClassPath路径下的META-INF/services文件夹查找文件，自动加载文件里所定义的类。这一机制为很多框架扩展提供了可能，比如在Dubbo、JDBC中都使用到了SPI机制。我们先通过一个很简单的例子来看下它是怎么用的。

### 案例介绍

  先定义接口项目

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641630185000/87f756e2b9f94db18330758d9e4962d6.png)

  然后创建一个扩展的实现，先导入上面接口项目的依赖

```xml
    <dependencies>
        <dependency>
            <groupId>com.bobo</groupId>
            <artifactId>JavaSPIBase</artifactId>
            <version>1.0-SNAPSHOT</version>
        </dependency>
    </dependencies>
```

  然后创建接口的实现

```java
/**
 * SPI：MySQL对于 baseURL 的一种实现
 */
public class MySQLData implements BaseData {
    @Override
    public void baseURL() {
        System.out.println("mysql 的扩展实现....");
    }
}
```

  然后在resources目录下创建 META-INF/services 目录，然后在目录中创建一个文件，名称必须是定义的接口的全类路径名称。然后在文件中写上接口的实现类的全类路径名称。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641630185000/4d4de748ad85471bbd70e13c0879bd26.png)

  同样的再创建一个案例

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641630185000/2d1abe3b6f2443f4911c6296761c6125.png)

  然后在测试的项目中测试

```java
    public static void main(String[] args) {
        ServiceLoader<BaseData> providers = ServiceLoader.load(BaseData.class);
        Iterator<BaseData> iterator = providers.iterator();
        while(iterator.hasNext()){
            BaseData next = iterator.next();
            next.baseURL();
        }
    }
```

  根据不同的导入，执行的逻辑会有不同

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641630185000/3a0825188653454f884d2895ddc6cba9.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641630185000/80db95bf1b5f44749fe87034675c78af.png)

### 源码查看

ServiceLoader

  首先来看下ServiceLoader的类结构

```java
   // 配置文件的路径
    private static final String PREFIX = "META-INF/services/";

    // 加载的服务  类或者接口
    private final Class<S> service;

    // 类加载器
    private final ClassLoader loader;

    // 访问权限的上下文对象
    private final AccessControlContext acc;

    // 保存已经加载的服务类
    private LinkedHashMap<String,S> providers = new LinkedHashMap<>();

    // 内部类，真正加载服务类
    private LazyIterator lookupIterator;
```

load

  load方法创建了一些属性，重要的是实例化了内部类，LazyIterator。

```java
public final class ServiceLoader<S> implements Iterable<S>
    private ServiceLoader(Class<S> svc, ClassLoader cl) {
        //要加载的接口
        service = Objects.requireNonNull(svc, "Service interface cannot be null");
        //类加载器
        loader = (cl == null) ? ClassLoader.getSystemClassLoader() : cl;
        //访问控制器
        acc = (System.getSecurityManager() != null) ? AccessController.getContext() : null;
         reload();
        
    }
    public void reload() {
        //先清空
        providers.clear();
        //实例化内部类 
        LazyIterator lookupIterator = new LazyIterator(service, loader);
    }
}
```

  查找实现类和创建实现类的过程，都在LazyIterator完成。当我们调用iterator.hasNext和iterator.next方法的时候，实际上调用的都是LazyIterator的相应方法。

```java
private class LazyIterator implements Iterator<S>{
    Class<S> service;
    ClassLoader loader;
    Enumeration<URL> configs = null;
    Iterator<String> pending = null;
    String nextName = null; 
    private boolean hasNextService() {
        //第二次调用的时候，已经解析完成了，直接返回
        if (nextName != null) {
            return true;
        }
        if (configs == null) {
            //META-INF/services/ 加上接口的全限定类名，就是文件服务类的文件
            //META-INF/services/com.viewscenes.netsupervisor.spi.SPIService
            String fullName = PREFIX + service.getName();
            //将文件路径转成URL对象
            configs = loader.getResources(fullName);
        }
        while ((pending == null) || !pending.hasNext()) {
            //解析URL文件对象，读取内容，最后返回
            pending = parse(service, configs.nextElement());
        }
        //拿到第一个实现类的类名
        nextName = pending.next();
        return true;
    }
}

```

  创建实例对象，当然，调用next方法的时候，实际调用到的是，lookupIterator.nextService。它通过反射的方式，创建实现类的实例并返回。

```java
private class LazyIterator implements Iterator<S>{
    private S nextService() {
        //全限定类名
        String cn = nextName;
        nextName = null;
        //创建类的Class对象
        Class<?> c = Class.forName(cn, false, loader);
        //通过newInstance实例化
        S p = service.cast(c.newInstance());
        //放入集合，返回实例
        providers.put(cn, p);
        return p; 
    }
}
```

  看到这儿，我想已经很清楚了。获取到类的实例，我们自然就可以对它为所欲为了！



## SpringBoot发展历史

```mermaid
timeline
title History of SpringBoot
2013 : 开始开发
2014-04 : 1.0版本发布
... : ...
2018-03 : 2.0版本发布
2022 : 3.0版本发布
```



## 自动装配

### 前言

什么是自动装配？用过Spring的应该都知道，虽然后期Spring引入了注解功能，但开启某些特性或者功能的时候，还是不能完全省略xml配置文件。下面这些配置用过Spring的应该都很熟悉，几乎每个项目都有。

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
       http://www.springframework.org/schema/beans/spring-beans.xsd
       http://www.springframework.org/schema/context
       http://www.springframework.org/schema/context/spring-context-3.0.xsd">
    <context:component-scan base-package="com.xxx" />
	<mvc:annotation-driven />
    <!-- 配置视图解析器 -->
    <bean id="viewResolver" class="org.springframework.web.servlet.view.InternalResourceViewResolver">
        <property name="prefix" value="/WEB-INF/jsp/"></property>
        <property name="suffix" value=".jsp"></property>
    </bean>
    
    <!--  文件模版引擎配置  -->
    <bean id="freemarkerConfiguration" class="org.springframework.ui.freemarker.FreeMarkerConfigurationFactoryBean">
        <property name="templateLoaderPath" value="classpath:tpl/"/>
        <property name="defaultEncoding" value="UTF-8"/>
    </bean>
    <bean id="freemarkEngine" class="com.kedacom.web.freemark.FreemarkEngine">
    	<property name="configuration" ref="freemarkerConfiguration"/>
    </bean>
    <!-- Spring RestTemplate config -->
    <bean id="httpClientFactory" class="org.springframework.http.client.SimpleClientHttpRequestFactory">
        <property name="connectTimeout" value="10000"/>
        <property name="readTimeout" value="10000"/>
    </bean>
    <bean id="restTemplate" class="org.springframework.web.client.RestTemplate">
    	<constructor-arg ref="httpClientFactory"/>
    </bean>
    
    <!-- 还会引入其他方面的配置，例如：数据库，事务，安全，邮件等等 -->
    <import resource="classpath*:/applicationContext-bean.xml"/>
    <import resource="classpath*:/applicationContext-orm.xml"/>
    <import resource="classpath*:/conf/application-security.xml"/>
    <import resource="classpath*:/conf/app-email.xml"/>
    <import resource="classpath*:/applicationContext-webservice.xml"/>
</beans>
```

而SpringBoot呢？只需要添加相关依赖，无需配置，通过 `main` 方法即可启动项目。如果要修改默认配置，可以局配置文件 `application.properties`或`application.yml`即可对项目进行定制化设置，比如：更换tomcat端口号，配置 JPA 属性等等。

而之所以如此简便就是得益于自动装配机制。

### 介绍

什么是自动装配？自动装配其实在Spring Framework的后期版本中就实现了。Spring Boot只是在此基础上，使用SPI做了进一步优化。

SPI，全称为 Service Provider Interface，是一种服务发现机制。在JDK的JDBC中就已经使用过。Spring也是模仿JDK设计的。Spring的SPI机制规定：SpringBoot在启动时会扫描第三方 jar 包中的`META-INF/spring.factories`文件，将文件中配置的类型信息加载到 Spring容器中，并执行类中定义的各种操作。对于第三方jar 来说，只需要按照SpringBoot定义的标准，就能将自己的功能自动装配进 SpringBoot中。

有了自动装配，在Spring Boot中如果要引入一些新功能，只需要在依赖中引入一个starter和做一些简单配置即可。例如：要在项目中使用redis的话，只需要引入下面的starter。

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-redis</artifactId>
</dependency>
```

引入 starter 之后，我们通过少量注解和一些简单的配置就能使用第三方组件提供的功能了。

```yaml
spring:
    redis:
      host: 127.0.0.1 
      port: 6379
```

```java
	@Autowired
    private RedisTemplate<String,String> redisTemplate;
```

因此自动装配可以简单理解为：**通过starter、注解、配置等方式大大简化了Spring实现某些功能的步骤。**

### 实现原理

#### @SpringBootApplication

那么SpringBoot是怎么实现自动装配的呢？我们在SpringBoot的启动类中基本都会用到这个注解`@SpringBootApplication`，我们可以看下他的源码：

```java
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Inherited
@SpringBootConfiguration
@EnableAutoConfiguration
@ComponentScan(excludeFilters = { @Filter(type = FilterType.CUSTOM, classes = TypeExcludeFilter.class),
		@Filter(type = FilterType.CUSTOM, classes = AutoConfigurationExcludeFilter.class) })
public @interface SpringBootApplication {
 
	@AliasFor(annotation = EnableAutoConfiguration.class)
	Class<?>[] exclude() default {};
 
	@AliasFor(annotation = EnableAutoConfiguration.class)
	String[] excludeName() default {};
 
	@AliasFor(annotation = ComponentScan.class, attribute = "basePackages")
	String[] scanBasePackages() default {};
 
	@AliasFor(annotation = ComponentScan.class, attribute = "basePackageClasses")
	Class<?>[] scanBasePackageClasses() default {};
 
	@AliasFor(annotation = ComponentScan.class, attribute = "nameGenerator")
	Class<? extends BeanNameGenerator> nameGenerator() default BeanNameGenerator.class;
 
	@AliasFor(annotation = Configuration.class)
	boolean proxyBeanMethods() default true;
}
```

在这个注解的上面几个注解中，其中上面4个是jdk的元注解，后面3个是重点：@SpringBootConfiguration，@EnableAutoConfiguration，@ComponentScan。

@ComponentScan：是Spring的注解，用来替换xml中的<context:component-scan />标签的。主要用于扫描被`@Component` `@Service`,`@Controller`注解的 bean的，这个注解默认会扫描启动类所在的包下所有的类。所以不指定basePackage也可以。

@SpringBootConfiguration：这个是Springboot的注解，我们可以把他看成优化版的@Configuration。看了它的源码就知道，它是在@Configuration注解的基础上加了一个@Indexed注解，用于优化Spring启动速度的。

@EnableAutoConfiguration这个注解就是自动装配的核心注解了。接下来，我们来详细分析下这个注解。

```java
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Inherited
@AutoConfigurationPackage
@Import(AutoConfigurationImportSelector.class)
public @interface EnableAutoConfiguration {
 
	String ENABLED_OVERRIDE_PROPERTY = "spring.boot.enableautoconfiguration";
 
	Class<?>[] exclude() default {};
 
	String[] excludeName() default {};

}
```

#### @EnableAutoConfiguration

@EnableAutoConfiguration的主要作用其实就是帮助springboot应用把所有符合条件的@Configuration配置都加载到当前SpringBoot的IoC容器中。

注解内部引用了@AutoConfigurationPackage注解以及导入了一个`AutoConfigurationImportSelector`类。

```java
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Inherited
@AutoConfigurationPackage
@Import(AutoConfigurationImportSelector.class)
public @interface EnableAutoConfiguration {
 
	String ENABLED_OVERRIDE_PROPERTY = "spring.boot.enableautoconfiguration";
 
	Class<?>[] exclude() default {};
 
	String[] excludeName() default {};

}
```

这个AutoConfigurationImportSelector类实现了DeferredImportSelector接口，是ImportSelector的子接口，所以根据[@Import注解的实现原理](#@Import注解的作用与原理)，实际会调用selectImports方法来实现导入。这个方法的返回值中的所有类都会被加入到IOC容器中，我们来看下方法源码：

```java
public String[] selectImports(AnnotationMetadata annotationMetadata) {
   if (!isEnabled(annotationMetadata)) {
      return NO_IMPORTS;
   }
	// 从配置文件（spring-autoconfigure-metadata.properties）中加载 AutoConfigurationMetadata
   AutoConfigurationMetadata autoConfigurationMetadata = AutoConfigurationMetadataLoader
         .loadMetadata(this.beanClassLoader);
	// 获取所有候选配置类EnableAutoConfiguration
   AutoConfigurationEntry autoConfigurationEntry = getAutoConfigurationEntry(
         autoConfigurationMetadata, annotationMetadata);
   return StringUtils.toStringArray(autoConfigurationEntry.getConfigurations());
}
```

重点关注第9行的getAutoConfigurationEntry方法。这个方法主要负责加载自动配置类。

```java
	protected AutoConfigurationEntry getAutoConfigurationEntry(AnnotationMetadata annotationMetadata) {
		//1.判断自动装配开关是否打开
        if (!isEnabled(annotationMetadata)) {
			return EMPTY_ENTRY;
		}
        //2.获取`EnableAutoConfiguration`注解中的属性
		AnnotationAttributes attributes = getAttributes(annotationMetadata);
        //3.加载当前项目类路径下 `META-INF/spring.factories` 文件中声明的配置类
		List<String> configurations = getCandidateConfigurations(annotationMetadata, attributes);
        //4.移除掉重复的
		configurations = removeDuplicates(configurations);
        //5.应用注解中的排除项
		Set<String> exclusions = getExclusions(annotationMetadata, attributes);
		checkExcludedClasses(configurations, exclusions);
		configurations.removeAll(exclusions);
        // 6.根据另一个配置文件中的配置，进一步过滤不符合条件的类
		configurations = getConfigurationClassFilter().filter(configurations);
		fireAutoConfigurationImportEvents(configurations, exclusions);
		return new AutoConfigurationEntry(configurations, exclusions);
	}
```

接下来详细分析一下这个方法的实现：

1. 判断自动装配开关是否打开。默认是打开的。`spring.boot.enableautoconfiguration=true`，可在 `application.properties` 或 `application.yml` 中设置。

2. 获取`EnableAutoConfiguration`注解中的属性，例如： `exclude` 和 `excludeName`。

3. 加载当前项目类路径下 `META-INF/spring.factories` 文件中声明的配置类。

   1. 注意：不光是SpringBoot自己的这个配置文件中的类，实际会加载项目中依赖的所有的这个文件。

   2. 如果你的项目引入了Mybatis-plus，可以清楚的看到，它的starter中也是有这个文件的。

   3. Maven: com.baomidou:mybatis-plus-boot-starter:3.5.1

   4. ```properties
      # Auto Configure
      org.springframework.boot.env.EnvironmentPostProcessor=\
        com.baomidou.mybatisplus.autoconfigure.SafetyEncryptProcessor
      org.springframework.boot.autoconfigure.EnableAutoConfiguration=\
        com.baomidou.mybatisplus.autoconfigure.IdentifierGeneratorAutoConfiguration,\
        com.baomidou.mybatisplus.autoconfigure.MybatisPlusLanguageDriverAutoConfiguration,\
        com.baomidou.mybatisplus.autoconfigure.MybatisPlusAutoConfiguration
      ```

4. 加载了这么多依赖包中的配置文件，肯定会有重复的。这部就是去重。

5. 在注解中会指定排除哪个类的，这一步就是应用排除项。例如：`@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class})`

6. 根据另一个配置文件中的配置，进一步过滤不符合条件的类。

   1. 通过前面的步骤过滤了不少类，但还剩下很多类需要加载。

   2. 例如：Spring自己的配置文件中就有130多个配置类。难道全部都要加载？

      1. Maven: org.springframework.boot:spring-boot-autoconfigure:2.5.15中的配置。

      2. spring-boot-autoconfigure-2.5.15.jar!\META-INF\spring.factories

      3. ```properties
         # Auto Configure
         org.springframework.boot.autoconfigure.EnableAutoConfiguration=\
         org.springframework.boot.autoconfigure.admin.SpringApplicationAdminJmxAutoConfiguration,\
         org.springframework.boot.autoconfigure.aop.AopAutoConfiguration,\
         org.springframework.boot.autoconfigure.amqp.RabbitAutoConfiguration,\
         org.springframework.boot.autoconfigure.batch.BatchAutoConfiguration,\
         org.springframework.boot.autoconfigure.cache.CacheAutoConfiguration,\
         org.springframework.boot.autoconfigure.cassandra.CassandraAutoConfiguration,\
         org.springframework.boot.autoconfigure.context.ConfigurationPropertiesAutoConfiguration,\
         org.springframework.boot.autoconfigure.context.LifecycleAutoConfiguration,\
         org.springframework.boot.autoconfigure.context.MessageSourceAutoConfiguration,\
         org.springframework.boot.autoconfigure.context.PropertyPlaceholderAutoConfiguration,\
         org.springframework.boot.autoconfigure.couchbase.CouchbaseAutoConfiguration,\
         org.springframework.boot.autoconfigure.dao.PersistenceExceptionTranslationAutoConfiguration,\
         org.springframework.boot.autoconfigure.data.cassandra.CassandraDataAutoConfiguration,\
         org.springframework.boot.autoconfigure.data.cassandra.CassandraReactiveDataAutoConfiguration,\
         org.springframework.boot.autoconfigure.data.cassandra.CassandraReactiveRepositoriesAutoConfiguration,\
         org.springframework.boot.autoconfigure.data.cassandra.CassandraRepositoriesAutoConfiguration,\
         org.springframework.boot.autoconfigure.data.couchbase.CouchbaseDataAutoConfiguration,\
         org.springframework.boot.autoconfigure.data.couchbase.CouchbaseReactiveDataAutoConfiguration,\
         org.springframework.boot.autoconfigure.data.couchbase.CouchbaseReactiveRepositoriesAutoConfiguration,\
         org.springframework.boot.autoconfigure.data.couchbase.CouchbaseRepositoriesAutoConfiguration,\
         org.springframework.boot.autoconfigure.data.elasticsearch.ElasticsearchDataAutoConfiguration,\
         org.springframework.boot.autoconfigure.data.elasticsearch.ElasticsearchRepositoriesAutoConfiguration,\
         org.springframework.boot.autoconfigure.data.elasticsearch.ReactiveElasticsearchRepositoriesAutoConfiguration,\
         org.springframework.boot.autoconfigure.data.elasticsearch.ReactiveElasticsearchRestClientAutoConfiguration,\
         org.springframework.boot.autoconfigure.data.jdbc.JdbcRepositoriesAutoConfiguration,\
         org.springframework.boot.autoconfigure.data.jpa.JpaRepositoriesAutoConfiguration,\
         org.springframework.boot.autoconfigure.data.ldap.LdapRepositoriesAutoConfiguration,\
         org.springframework.boot.autoconfigure.data.mongo.MongoDataAutoConfiguration,\
         org.springframework.boot.autoconfigure.data.mongo.MongoReactiveDataAutoConfiguration,\
         org.springframework.boot.autoconfigure.data.mongo.MongoReactiveRepositoriesAutoConfiguration,\
         org.springframework.boot.autoconfigure.data.mongo.MongoRepositoriesAutoConfiguration,\
         org.springframework.boot.autoconfigure.data.neo4j.Neo4jDataAutoConfiguration,\
         org.springframework.boot.autoconfigure.data.neo4j.Neo4jReactiveDataAutoConfiguration,\
         org.springframework.boot.autoconfigure.data.neo4j.Neo4jReactiveRepositoriesAutoConfiguration,\
         org.springframework.boot.autoconfigure.data.neo4j.Neo4jRepositoriesAutoConfiguration,\
         org.springframework.boot.autoconfigure.data.r2dbc.R2dbcDataAutoConfiguration,\
         org.springframework.boot.autoconfigure.data.r2dbc.R2dbcRepositoriesAutoConfiguration,\
         org.springframework.boot.autoconfigure.data.redis.RedisAutoConfiguration,\
         org.springframework.boot.autoconfigure.data.redis.RedisReactiveAutoConfiguration,\
         org.springframework.boot.autoconfigure.data.redis.RedisRepositoriesAutoConfiguration,\
         org.springframework.boot.autoconfigure.data.rest.RepositoryRestMvcAutoConfiguration,\
         org.springframework.boot.autoconfigure.data.web.SpringDataWebAutoConfiguration,\
         org.springframework.boot.autoconfigure.elasticsearch.ElasticsearchRestClientAutoConfiguration,\
         org.springframework.boot.autoconfigure.flyway.FlywayAutoConfiguration,\
         org.springframework.boot.autoconfigure.freemarker.FreeMarkerAutoConfiguration,\
         org.springframework.boot.autoconfigure.groovy.template.GroovyTemplateAutoConfiguration,\
         org.springframework.boot.autoconfigure.gson.GsonAutoConfiguration,\
         org.springframework.boot.autoconfigure.h2.H2ConsoleAutoConfiguration,\
         org.springframework.boot.autoconfigure.hateoas.HypermediaAutoConfiguration,\
         org.springframework.boot.autoconfigure.hazelcast.HazelcastAutoConfiguration,\
         org.springframework.boot.autoconfigure.hazelcast.HazelcastJpaDependencyAutoConfiguration,\
         org.springframework.boot.autoconfigure.http.HttpMessageConvertersAutoConfiguration,\
         org.springframework.boot.autoconfigure.http.codec.CodecsAutoConfiguration,\
         org.springframework.boot.autoconfigure.influx.InfluxDbAutoConfiguration,\
         org.springframework.boot.autoconfigure.info.ProjectInfoAutoConfiguration,\
         org.springframework.boot.autoconfigure.integration.IntegrationAutoConfiguration,\
         org.springframework.boot.autoconfigure.jackson.JacksonAutoConfiguration,\
         org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration,\
         org.springframework.boot.autoconfigure.jdbc.JdbcTemplateAutoConfiguration,\
         org.springframework.boot.autoconfigure.jdbc.JndiDataSourceAutoConfiguration,\
         org.springframework.boot.autoconfigure.jdbc.XADataSourceAutoConfiguration,\
         org.springframework.boot.autoconfigure.jdbc.DataSourceTransactionManagerAutoConfiguration,\
         org.springframework.boot.autoconfigure.jms.JmsAutoConfiguration,\
         org.springframework.boot.autoconfigure.jmx.JmxAutoConfiguration,\
         org.springframework.boot.autoconfigure.jms.JndiConnectionFactoryAutoConfiguration,\
         org.springframework.boot.autoconfigure.jms.activemq.ActiveMQAutoConfiguration,\
         org.springframework.boot.autoconfigure.jms.artemis.ArtemisAutoConfiguration,\
         org.springframework.boot.autoconfigure.jersey.JerseyAutoConfiguration,\
         org.springframework.boot.autoconfigure.jooq.JooqAutoConfiguration,\
         org.springframework.boot.autoconfigure.jsonb.JsonbAutoConfiguration,\
         org.springframework.boot.autoconfigure.kafka.KafkaAutoConfiguration,\
         org.springframework.boot.autoconfigure.availability.ApplicationAvailabilityAutoConfiguration,\
         org.springframework.boot.autoconfigure.ldap.embedded.EmbeddedLdapAutoConfiguration,\
         org.springframework.boot.autoconfigure.ldap.LdapAutoConfiguration,\
         org.springframework.boot.autoconfigure.liquibase.LiquibaseAutoConfiguration,\
         org.springframework.boot.autoconfigure.mail.MailSenderAutoConfiguration,\
         org.springframework.boot.autoconfigure.mail.MailSenderValidatorAutoConfiguration,\
         org.springframework.boot.autoconfigure.mongo.embedded.EmbeddedMongoAutoConfiguration,\
         org.springframework.boot.autoconfigure.mongo.MongoAutoConfiguration,\
         org.springframework.boot.autoconfigure.mongo.MongoReactiveAutoConfiguration,\
         org.springframework.boot.autoconfigure.mustache.MustacheAutoConfiguration,\
         org.springframework.boot.autoconfigure.neo4j.Neo4jAutoConfiguration,\
         org.springframework.boot.autoconfigure.netty.NettyAutoConfiguration,\
         org.springframework.boot.autoconfigure.orm.jpa.HibernateJpaAutoConfiguration,\
         org.springframework.boot.autoconfigure.quartz.QuartzAutoConfiguration,\
         org.springframework.boot.autoconfigure.r2dbc.R2dbcAutoConfiguration,\
         org.springframework.boot.autoconfigure.r2dbc.R2dbcTransactionManagerAutoConfiguration,\
         org.springframework.boot.autoconfigure.rsocket.RSocketMessagingAutoConfiguration,\
         org.springframework.boot.autoconfigure.rsocket.RSocketRequesterAutoConfiguration,\
         org.springframework.boot.autoconfigure.rsocket.RSocketServerAutoConfiguration,\
         org.springframework.boot.autoconfigure.rsocket.RSocketStrategiesAutoConfiguration,\
         org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration,\
         org.springframework.boot.autoconfigure.security.servlet.UserDetailsServiceAutoConfiguration,\
         org.springframework.boot.autoconfigure.security.servlet.SecurityFilterAutoConfiguration,\
         org.springframework.boot.autoconfigure.security.reactive.ReactiveSecurityAutoConfiguration,\
         org.springframework.boot.autoconfigure.security.reactive.ReactiveUserDetailsServiceAutoConfiguration,\
         org.springframework.boot.autoconfigure.security.rsocket.RSocketSecurityAutoConfiguration,\
         org.springframework.boot.autoconfigure.security.saml2.Saml2RelyingPartyAutoConfiguration,\
         org.springframework.boot.autoconfigure.sendgrid.SendGridAutoConfiguration,\
         org.springframework.boot.autoconfigure.session.SessionAutoConfiguration,\
         org.springframework.boot.autoconfigure.security.oauth2.client.servlet.OAuth2ClientAutoConfiguration,\
         org.springframework.boot.autoconfigure.security.oauth2.client.reactive.ReactiveOAuth2ClientAutoConfiguration,\
         org.springframework.boot.autoconfigure.security.oauth2.resource.servlet.OAuth2ResourceServerAutoConfiguration,\
         org.springframework.boot.autoconfigure.security.oauth2.resource.reactive.ReactiveOAuth2ResourceServerAutoConfiguration,\
         org.springframework.boot.autoconfigure.solr.SolrAutoConfiguration,\
         org.springframework.boot.autoconfigure.sql.init.SqlInitializationAutoConfiguration,\
         org.springframework.boot.autoconfigure.task.TaskExecutionAutoConfiguration,\
         org.springframework.boot.autoconfigure.task.TaskSchedulingAutoConfiguration,\
         org.springframework.boot.autoconfigure.thymeleaf.ThymeleafAutoConfiguration,\
         org.springframework.boot.autoconfigure.transaction.TransactionAutoConfiguration,\
         org.springframework.boot.autoconfigure.transaction.jta.JtaAutoConfiguration,\
         org.springframework.boot.autoconfigure.validation.ValidationAutoConfiguration,\
         org.springframework.boot.autoconfigure.web.client.RestTemplateAutoConfiguration,\
         org.springframework.boot.autoconfigure.web.embedded.EmbeddedWebServerFactoryCustomizerAutoConfiguration,\
         org.springframework.boot.autoconfigure.web.reactive.HttpHandlerAutoConfiguration,\
         org.springframework.boot.autoconfigure.web.reactive.ReactiveWebServerFactoryAutoConfiguration,\
         org.springframework.boot.autoconfigure.web.reactive.WebFluxAutoConfiguration,\
         org.springframework.boot.autoconfigure.web.reactive.error.ErrorWebFluxAutoConfiguration,\
         org.springframework.boot.autoconfigure.web.reactive.function.client.ClientHttpConnectorAutoConfiguration,\
         org.springframework.boot.autoconfigure.web.reactive.function.client.WebClientAutoConfiguration,\
         org.springframework.boot.autoconfigure.web.servlet.DispatcherServletAutoConfiguration,\
         org.springframework.boot.autoconfigure.web.servlet.ServletWebServerFactoryAutoConfiguration,\
         org.springframework.boot.autoconfigure.web.servlet.error.ErrorMvcAutoConfiguration,\
         org.springframework.boot.autoconfigure.web.servlet.HttpEncodingAutoConfiguration,\
         org.springframework.boot.autoconfigure.web.servlet.MultipartAutoConfiguration,\
         org.springframework.boot.autoconfigure.web.servlet.WebMvcAutoConfiguration,\
         org.springframework.boot.autoconfigure.websocket.reactive.WebSocketReactiveAutoConfiguration,\
         org.springframework.boot.autoconfigure.websocket.servlet.WebSocketServletAutoConfiguration,\
         org.springframework.boot.autoconfigure.websocket.servlet.WebSocketMessagingAutoConfiguration,\
         org.springframework.boot.autoconfigure.webservices.WebServicesAutoConfiguration,\
         org.springframework.boot.autoconfigure.webservices.client.WebServiceTemplateAutoConfiguration
         ```

      4. 可以看到这里面其实有很多我们暂时用不到的类。例如：WebSocket相关的，mongodb相关的，ES相关的。等等。

   3. SpringBoot会从另一个配置文件中，加载上述类的加载条件：spring-autoconfigure-metadata.properties

      1. 例如上文提到的ES配置类，在这个文件中，有如下配置：

      2. ```properties
         org.springframework.boot.autoconfigure.data.elasticsearch.ElasticsearchDataAutoConfiguration=
         org.springframework.boot.autoconfigure.data.elasticsearch.ElasticsearchDataAutoConfiguration.AutoConfigureAfter=org.springframework.boot.autoconfigure.elasticsearch.ElasticsearchRestClientAutoConfiguration,org.springframework.boot.autoconfigure.data.elasticsearch.ReactiveElasticsearchRestClientAutoConfiguration
         org.springframework.boot.autoconfigure.data.elasticsearch.ElasticsearchDataAutoConfiguration.ConditionalOnClass=org.springframework.data.elasticsearch.core.ElasticsearchRestTemplate
         ```

      3. 其中ConditionalOnClass的意思就是只有当Classpath中存在这个类才会加载。

   4. 有兴趣的童鞋可以了解下，SpringBoot的所有条件注解。

      1. `@ConditionalOnBean`：当容器里有指定 Bean 的条件下
      2. `@ConditionalOnMissingBean`：当容器里没有指定 Bean 的情况下
      3. `@ConditionalOnSingleCandidate`：当指定 Bean 在容器中只有一个，或者虽然有多个但是指定首选 Bean
      4. `@ConditionalOnClass`：当类路径下有指定类的条件下
      5. `@ConditionalOnMissingClass`：当类路径下没有指定类的条件下
      6. `@ConditionalOnProperty`：指定的属性是否有指定的值
      7. `@ConditionalOnResource`：类路径是否有指定的值
      8. `@ConditionalOnExpression`：基于 SpEL 表达式作为判断条件
      9. `@ConditionalOnJava`：基于 Java 版本作为判断条件
      10. `@ConditionalOnJndi`：在 JNDI 存在的条件下差在指定的位置
      11. `@ConditionalOnNotWebApplication`：当前项目不是 Web 项目的条件下
      12. `@ConditionalOnWebApplication`：当前项目是 Web 项 目的条件下

7. 分析结束



#### selectImports方法没有走？

参考文章：https://zhuanlan.zhihu.com/p/458533586

上面我们在分析自动装配实现原理的时候说过，`@EnableAutoConfiguration`注解通过 `@Import`注解导入了一个 `ImportSelector`接口的实现类 `AutoConfigurationImportSelector`。按照我们对 `@Import` 注解的理解，应该会执行 `selectImports` 接口方法，但调试的时候，执行的情况好像和我们期待的不一样哦，没有走 `selectImports()`方法中。但是实际确实能进到`getAutoConfigurationEntry()`方法中。那这是为什么呢？原因就在于AutoConfigurationImportSelector实现的这个接口DeferredImportSelector有点特殊。

##### DeferredImportSelector

```mermaid
classDiagram
AutoConfigurationImportSelector..|>DeferredImportSelector
DeferredImportSelector..|>ImportSelector

```

从上面的类图中可以看到。DeferredImportSelector接口是ImportSelector的子接口，所以他也具备ImportSelector的功能。

如果我们仅仅是实现了DeferredImportSelector接口，重写了selectImports方法，那么selectImports方法是会被执行的。

我们可以用代码测试一下。

```java
public class MyDeferredImportSelector implements DeferredImportSelector {

    @Override
    public String[] selectImports(AnnotationMetadata importingClassMetadata) {
        System.out.println("MyDeferredImportSelector.selectImports()方法执行...");
        return new String[0];
    }
}

/**
 * SpringBoot应用启动类
 */
@Import(MyDeferredImportSelector.class)
@SpringBootApplication
public class Application {

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

}

//启动执行效果：
2023-10-10 17:40:04.653  INFO 14304 --- [           main] c.sjj.mashibing.springboot.Application   : No active profile set, falling back to 1 default profile: "default"
MyDeferredImportSelector.selectImports()方法执行...
2023-10-10 17:40:05.257  INFO 14304 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat initialized with port(s): 8080 (http)
2023-10-10 17:40:05.262  INFO 14304 --- [           main] o.apache.catalina.core.StandardService   : Starting service [Tomcat]
2023-10-10 17:40:05.263  INFO 14304 --- [           main] org.apache.catalina.core.StandardEngine  : Starting Servlet engine: [Apache Tomcat/9.0.75]
    
```

所以AutoConfigurationImportSelector中应该是做了什么特殊处理导致的没进入selectImports()方法。进一步观察源码会发现，AutoConfigurationImportSelector类内部还覆盖了getImportGroup()方法，同时还返回了它自己内部的一个实现了Group接口的静态内部类的Class对象。然后我们在自己创建的类内部也模仿这覆盖一下这个方法试试。覆盖getImportGroup()方法，同时返回静态内部类。

```java
public class MyDeferredImportSelector implements DeferredImportSelector {
    @Override
    public String[] selectImports(AnnotationMetadata importingClassMetadata) {
        System.out.println("MyDeferredImportSelector.selectImports()方法执行...");
        return new String[0];
    }

    @Override
    public Class<? extends Group> getImportGroup() {
        System.out.println("MyDeferredImportSelector.getImportGroup()方法执行...");
        return MyDeferredImportSelectorGroup.class;
    }

    public static class MyDeferredImportSelectorGroup implements Group{
        private final List<Entry> imports = new ArrayList<>();
        @Override
        public void process(AnnotationMetadata metadata, DeferredImportSelector selector) {
            System.out.println("MyDeferredImportSelectorGroup.process()");
        }

        @Override
        public Iterable<Entry> selectImports() {
            System.out.println("MyDeferredImportSelectorGroup.selectImports()");
            return imports;
        }
    }
}
```

然后运行项目就会发现同样的现象出现了，MyDeferredImportSelector的selectImports方法没有执行。执行的是getImportGroup()方法和MyDeferredImportSelectorGroup中的process()和selectImports()方法。

```java
2023-10-10 17:56:20.711  INFO 16552 --- [           main] c.sjj.mashibing.springboot.Application   : No active profile set, falling back to 1 default profile: "default"
MyDeferredImportSelector.getImportGroup()方法执行...
MyDeferredImportSelectorGroup.process()
MyDeferredImportSelectorGroup.selectImports()
2023-10-10 17:56:21.286  INFO 16552 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat initialized with port(s): 8080 (http)
```

至此我们就可以推导出一个结论：

如果一个类实现了DeferredImportSelector接口，如果它没有实现getImportGroup()接口方法的话（这个接口方法有default实现，所以可以不实现），那就会走入getImportGroup()方法。

如果他实现了getImportGroup()方法，那就不会走自己的selectImports()方法。而是会走入getImportGroup()这个方法返回类型的内部类的实现方法中。

##### 源码分析

上文我们是通过现象推断出的结论，那么SpringBoot是在哪里对DeferredImportSelector接口做的特殊处理？又为什么要这么设计呢？

我们可以继续分析源码，这个就需要追溯到@Import注解的实现原理了。

有一个简单办法，可以快速追溯到调用路径，就是使用IDEA在进行debug的时候，在debug窗口是可以看到方法调用堆栈的。

我们可以将断点先设置在getAutoConfigurationEntry()方法中，然后当进入到断点看Debugger窗口，如下图：

![image-20231010230937488](沈俊杰-马士兵-spring.assets/image-20231010230937488.png)

从方法调用堆栈中可以看到@Import注解是在这里被处理：

1. 首先是启动项目的main方法，然后调用run方法。

2. 接着会调用AbstractApplicationContext.refresh()进行ioc容器的初始化

3. 然后进入到refresh的第四个方法invokeBeanFactoryPostProcessors()中，这里会调用所有的BeanFactory后处理器

4. 接着进入到负责处理@Configuration、@Import等注解的ConfigurationClassPostProcessor类中。

5. 然后重点关注的代码来了。ConfigurationClassParser.parse()方法。我们来看下这里面的代码：

6. ```java
   	public void parse(Set<BeanDefinitionHolder> configCandidates) {
   		// 循环遍历configCandidates
   		for (BeanDefinitionHolder holder : configCandidates) {
   			// 获取BeanDefinition
   			BeanDefinition bd = holder.getBeanDefinition();
   			// 根据BeanDefinition类型的不同，调用parse不同的重载方法，实际上最终都是调用processConfigurationClass()方法
   			try {
   				if (bd instanceof AnnotatedBeanDefinition) {
   					// 解析注解类型（@Import注解就在这里解析）
   					parse(((AnnotatedBeanDefinition) bd).getMetadata(), holder.getBeanName());
   				}
   				else if (bd instanceof AbstractBeanDefinition && ((AbstractBeanDefinition) bd).hasBeanClass()) {
   					// 解析有class对象的
   					parse(((AbstractBeanDefinition) bd).getBeanClass(), holder.getBeanName());
   				}
   				else {
   					parse(bd.getBeanClassName(), holder.getBeanName());
   				}
   			}
   			catch (BeanDefinitionStoreException ex) {
   				throw ex;
   			}
   			catch (Throwable ex) {
   				throw new BeanDefinitionStoreException(
   						"Failed to parse configuration class [" + bd.getBeanClassName() + "]", ex);
   			}
   		}
   
   		// 执行找到的DeferredImportSelector
   		// ImportSelector被设计成和@Import注解同样的效果，但是实现了ImportSelector的类可以条件性的决定导入某些配置
   		// DeferredImportSelector的设计是在所有其他的配置类被处理后才进行处理
   		this.deferredImportSelectorHandler.process();
   	}
   ```

7. 然后注解类的解析会进入到第一个if分支的parse方法中。最终都是调用processConfigurationClass方法

8. ```java
   protected void  processConfigurationClass(ConfigurationClass configClass, Predicate<String> filter) throws IOException {
   		// 判断是否跳过解析
   		if (this.conditionEvaluator.shouldSkip(configClass.getMetadata(), ConfigurationPhase.PARSE_CONFIGURATION)) {
   			return;
   		}
   
   		// 第一次进入的时候，configurationClass的size为0，existingClass肯定为null，在此处处理configuration重复import
   		// 如果同一个配置类被处理两次，两次都属于被import的则合并导入类，返回，如果配置类不是被导入的，则移除旧的使用新的配置类
   		ConfigurationClass existingClass = this.configurationClasses.get(configClass);
   		if (existingClass != null) {
   			if (configClass.isImported()) {
   				if (existingClass.isImported()) {
   					// 如果要处理的配置类configclass在已经分析处理的配置类记录中已存在，合并两者的importBy属性
   					existingClass.mergeImportedBy(configClass);
   				}
   				return;
   			}
   			else {
   				this.configurationClasses.remove(configClass);
   				this.knownSuperclasses.values().removeIf(configClass::equals);
   			}
   		}
   		// 处理配置类，由于配置类可能存在父类(若父类的全类名是以java开头的，则除外)，所有需要将configClass变成sourceClass去解析，然后返回sourceClass的父类。
   		// 如果此时父类为空，则不会进行while循环去解析，如果父类不为空，则会循环的去解析父类
   		// SourceClass的意义：简单的包装类，目的是为了以统一的方式去处理带有注解的类，不管这些类是如何加载的
   		// 如果无法理解，可以把它当做一个黑盒，不会影响看spring源码的主流程
   		SourceClass sourceClass = asSourceClass(configClass, filter);
   		do {
   			// 解析各种注解
   			sourceClass = doProcessConfigurationClass(configClass, sourceClass, filter);
   		}
   		while (sourceClass != null);
   
   		// 将解析的配置类存储起来，这样回到parse方法时，能取到值
   		this.configurationClasses.put(configClass, configClass);
   	}
   ```

9. 接下来就到处理各种配置注解的总方法doProcessConfigurationClass()了

10. ```java
    	protected final SourceClass doProcessConfigurationClass(
    			ConfigurationClass configClass, SourceClass sourceClass, Predicate<String> filter)
    			throws IOException {
    		// @Configuration继承了@Component
    		if (configClass.getMetadata().isAnnotated(Component.class.getName())) {
    			// Recursively process any member (nested) classes first
    			// 递归处理内部类，因为内部类也是一个配置类，配置类上有@configuration注解，该注解继承@Component，if判断为true，调用processMemberClasses方法，递归解析配置类中的内部类
    			processMemberClasses(configClass, sourceClass, filter);
    		}
    
    		// Process any @PropertySource annotations
    		// 如果配置类上加了@PropertySource注解，那么就解析加载properties文件，并将属性添加到spring上下文中
    		for (AnnotationAttributes propertySource : AnnotationConfigUtils.attributesForRepeatable(
    				sourceClass.getMetadata(), PropertySources.class,
    				org.springframework.context.annotation.PropertySource.class)) {
    			if (this.environment instanceof ConfigurableEnvironment) {
    				processPropertySource(propertySource);
    			}
    			else {
    				logger.info("Ignoring @PropertySource annotation on [" + sourceClass.getMetadata().getClassName() +
    						"]. Reason: Environment must implement ConfigurableEnvironment");
    			}
    		}
    
    		// Process any @ComponentScan annotations
    		// 处理@ComponentScan或者@ComponentScans注解，并将扫描包下的所有bean转换成填充后的ConfigurationClass
    		// 此处就是将自定义的bean加载到IOC容器，因为扫描到的类可能也添加了@ComponentScan和@ComponentScans注解，因此需要进行递归解析
    		Set<AnnotationAttributes> componentScans = AnnotationConfigUtils.attributesForRepeatable(
    				sourceClass.getMetadata(), ComponentScans.class, ComponentScan.class);
    		if (!componentScans.isEmpty() &&
    				!this.conditionEvaluator.shouldSkip(sourceClass.getMetadata(), ConfigurationPhase.REGISTER_BEAN)) {
    			for (AnnotationAttributes componentScan : componentScans) {
    				// The config class is annotated with @ComponentScan -> perform the scan immediately
    				// 解析@ComponentScan和@ComponentScans配置的扫描的包所包含的类
    				// 比如 basePackages = com.mashibing, 那么在这一步会扫描出这个包及子包下的class，然后将其解析成BeanDefinition
    				// (BeanDefinition可以理解为等价于BeanDefinitionHolder)
    				Set<BeanDefinitionHolder> scannedBeanDefinitions =
    						this.componentScanParser.parse(componentScan, sourceClass.getMetadata().getClassName());
    				// Check the set of scanned definitions for any further config classes and parse recursively if needed
    				// 通过上一步扫描包com.mashibing，有可能扫描出来的bean中可能也添加了ComponentScan或者ComponentScans注解.
    				//所以这里需要循环遍历一次，进行递归(parse)，继续解析，直到解析出的类上没有ComponentScan和ComponentScans
    				for (BeanDefinitionHolder holder : scannedBeanDefinitions) {
    					BeanDefinition bdCand = holder.getBeanDefinition().getOriginatingBeanDefinition();
    					if (bdCand == null) {
    						bdCand = holder.getBeanDefinition();
    					}
    					// 判断是否是一个配置类，并设置full或lite属性
    					if (ConfigurationClassUtils.checkConfigurationClassCandidate(bdCand, this.metadataReaderFactory)) {
    						// 通过递归方法进行解析
    						parse(bdCand.getBeanClassName(), holder.getBeanName());
    					}
    				}
    			}
    		}
    
    		// Process any @Import annotations
    		// 处理@Import注解
    		processImports(configClass, sourceClass, getImports(sourceClass), filter, true);
    
    		// Process any @ImportResource annotations
    		// 处理@ImportResource注解，导入spring的配置文件
    		AnnotationAttributes importResource =
    				AnnotationConfigUtils.attributesFor(sourceClass.getMetadata(), ImportResource.class);
    		if (importResource != null) {
    			String[] resources = importResource.getStringArray("locations");
    			Class<? extends BeanDefinitionReader> readerClass = importResource.getClass("reader");
    			for (String resource : resources) {
    				String resolvedResource = this.environment.resolveRequiredPlaceholders(resource);
    				configClass.addImportedResource(resolvedResource, readerClass);
    			}
    		}
    
    		// Process individual @Bean methods
    		// 处理加了@Bean注解的方法，将@Bean方法转化为BeanMethod对象，保存再集合中
    		Set<MethodMetadata> beanMethods = retrieveBeanMethodMetadata(sourceClass);
    		for (MethodMetadata methodMetadata : beanMethods) {
    			configClass.addBeanMethod(new BeanMethod(methodMetadata, configClass));
    		}
    
    		// Process default methods on interfaces
    		// 处理接口的默认方法实现，从jdk8开始，接口中的方法可以有自己的默认实现，因此如果这个接口的方法加了@Bean注解，也需要被解析
    		processInterfaces(configClass, sourceClass);
    
    		// Process superclass, if any
    		// 解析父类，如果被解析的配置类继承了某个类，那么配置类的父类也会被进行解析
    		if (sourceClass.getMetadata().hasSuperClass()) {
    			String superclass = sourceClass.getMetadata().getSuperClassName();
    			if (superclass != null && !superclass.startsWith("java") &&
    					!this.knownSuperclasses.containsKey(superclass)) {
    				this.knownSuperclasses.put(superclass, configClass);
    				// Superclass found, return its annotation metadata and recurse
    				return sourceClass.getSuperClass();
    			}
    		}
    
    		// No superclass -> processing is complete
    		return null;
    	}
    ```

11. 可以看到@Import注解是在processImports()方法中处理的。在这之前要先处理@Configuration,@ComponentScan等注解。

12. 然后我们进入到processImports()方法中。可以看到在处理时分成了3个部分。实现了ImportSelector接口的，实现ImportBeanDefinitionRegistrar接口的。else就是普通类。然后我们直接看本次讨论的重点代码就是ImportSelector接口部分。

13. ```java
    // 检验配置类Import引入的类是否是ImportSelector子类
    if (candidate.isAssignable(ImportSelector.class)) {
        // Candidate class is an ImportSelector -> delegate to it to determine imports
        // 候选类是一个导入选择器->委托来确定是否进行导入
        Class<?> candidateClass = candidate.loadClass();
        // 通过反射生成一个ImportSelect对象
        ImportSelector selector = ParserStrategyUtils.instantiateClass(candidateClass, ImportSelector.class,
                this.environment, this.resourceLoader, this.registry);
        // 获取选择器的额外过滤器
        Predicate<String> selectorFilter = selector.getExclusionFilter();
        if (selectorFilter != null) {
            exclusionFilter = exclusionFilter.or(selectorFilter);
        }
        // 判断引用选择器是否是DeferredImportSelector接口的实例
        // 如果是则应用选择器将会在所有的配置类都加载完毕后加载
        if (selector instanceof DeferredImportSelector) {
            // 将选择器添加到deferredImportSelectorHandler实例中，预留到所有的配置类加载完成后统一处理自动化配置类
            this.deferredImportSelectorHandler.handle(configClass, (DeferredImportSelector) selector);
        }
        else {
            // 获取引入的类，然后使用递归方式将这些类中同样添加了@Import注解引用的类
            String[] importClassNames = selector.selectImports(currentSourceClass.getMetadata());
            Collection<SourceClass> importSourceClasses = asSourceClasses(importClassNames, exclusionFilter);
            // 递归处理，被Import进来的类也有可能@Import注解
            processImports(configClass, currentSourceClass, importSourceClasses, exclusionFilter, false);
        }
    }
    ```

14. 如果是DeferredImportSelector实现类会进入到deferredImportSelectorHandler.handle方法中。这个方法只是注册和存储，并不会执行。但如果是非DeferredImportSelector实现类就会直接调用selectImports方法执行。

15. ```java
    public void handle(ConfigurationClass configClass, DeferredImportSelector importSelector) {
        DeferredImportSelectorHolder holder = new DeferredImportSelectorHolder(configClass, importSelector);
        if (this.deferredImportSelectors == null) {
            DeferredImportSelectorGroupingHandler handler = new DeferredImportSelectorGroupingHandler();
            handler.register(holder);
            handler.processGroupImports();
        }
        else {
            this.deferredImportSelectors.add(holder);
        }
    }
    ```

16. 那DeferredImportSelector的方法会在哪里调用呢？其实就是在我们刚刚分析过的parse方法的最后一行中。大家可以回过头去看步骤6，最后有一行：`this.deferredImportSelectorHandler.process();`

17. ```java
    public void process() {
        // 此处获取前面存储的deferredImportSelector实例
        List<DeferredImportSelectorHolder> deferredImports = this.deferredImportSelectors;
        this.deferredImportSelectors = null;
        try {
            if (deferredImports != null) {
                //获取处理器
                DeferredImportSelectorGroupingHandler handler = new DeferredImportSelectorGroupingHandler();
                deferredImports.sort(DEFERRED_IMPORT_COMPARATOR);
                //注册所有的import，关键方法，进入
                deferredImports.forEach(handler::register);
                // 核心处理类，此处完成自动配置功能
                handler.processGroupImports();
            }
        }
        finally {
            this.deferredImportSelectors = new ArrayList<>();
        }
    }
    ```

18. 先看register方法

19. ```java
        public void register(DeferredImportSelectorHolder deferredImport) {
            //获取我们重写的getImportGroup方法返回值
            Class<? extends Group> group = deferredImport.getImportSelector().getImportGroup();
            //如果为空就说明没有重写，使用原来的deferredImport对象
            DeferredImportSelectorGrouping grouping = this.groupings.computeIfAbsent(
                    (group != null ? group : deferredImport),
                    key -> new DeferredImportSelectorGrouping(createGroup(group)));
            //到这里放进去的要么是默认的，要么是我们自定义重写的类。
            grouping.add(deferredImport);
            this.configurationClasses.put(deferredImport.getConfigurationClass().getMetadata(),
                    deferredImport.getConfigurationClass());
        }
    ```

20. 再看processGroupImports方法，重点在getImports()方法。

21. ```java
    public void processGroupImports() {
        for (DeferredImportSelectorGrouping grouping : this.groupings.values()) {
            Predicate<String> exclusionFilter = grouping.getCandidateFilter();
            // getImports()方法内部会调用默认的或者我们覆盖过的process方法和selectImports方法
            grouping.getImports().forEach(entry -> {
                ConfigurationClass configurationClass = this.configurationClasses.get(entry.getMetadata());
                try {
                    // 配置类中可能会包含@Import注解引入的类，通过此方法将引入的类注入
                    processImports(configurationClass, asSourceClass(configurationClass, exclusionFilter),
                            Collections.singleton(asSourceClass(entry.getImportClassName(), exclusionFilter)),
                            exclusionFilter, false);
                }
                catch (BeanDefinitionStoreException ex) {
                    throw ex;
                }
                catch (Throwable ex) {
                    throw new BeanDefinitionStoreException(
                            "Failed to process import candidates for configuration class [" +
                                    configurationClass.getMetadata().getClassName() + "]", ex);
                }
            });
        }
    }
    ```

22. getImports()方法内部调用了process()方法，然后process()调用了getAutoConfigurationEntry()方法

23. ```java
    public void process(AnnotationMetadata annotationMetadata, DeferredImportSelector deferredImportSelector) {
        Assert.state(deferredImportSelector instanceof AutoConfigurationImportSelector,
                () -> String.format("Only %s implementations are supported, got %s",
                        AutoConfigurationImportSelector.class.getSimpleName(),
                        deferredImportSelector.getClass().getName()));
        AutoConfigurationEntry autoConfigurationEntry = ((AutoConfigurationImportSelector) deferredImportSelector)
            //这里调用了我们设置断点的地方
                .getAutoConfigurationEntry(annotationMetadata);
        this.autoConfigurationEntries.add(autoConfigurationEntry);
        for (String importClassName : autoConfigurationEntry.getConfigurations()) {
            this.entries.putIfAbsent(importClassName, annotationMetadata);
        }
    }
    ```

24. 至此，我们就应该知道为什么默认的selectImports没走，而是走的内部类的方法了。

##### 设计目的

可能有人会问，Spring设计这个DeferredImportSelector类的目的是什么？通过上面的分析可知DeferredImportSelector是在处理了所有配置注解之后才执行的，而ImportSelector是在处理完@Configuration,@ComponentScan就执行了。SpringBoot设计这个类，应该是为了某些特殊场景下，让DeferredImportSelector执行的时候可以配合后面的注解一起使用。例如：@Bean，@ImportResource，父类注解等等。但实际工作中，我也没遇到过必须要用DeferredImportSelector的场景。



### 总结

1. SpringBoot通过`@EnableAutoConfiguration`开启自动装配
2. SpringBoot会加载所有Starter中`META-INF/spring.factories`文件中配置加载配置类
3. 通过spring-autoconfigure-metadata.properties加载配置类的过滤条件。



## 源码环境

对于想要研究SpringBoot源码的小伙伴来说，在本地编译源码环境，然后在研究源码的时候可以添加对应的注释是必须的，本文就给大家来介绍下如何来搭建我们的源码环境。

### 1.官方源码下载

首先大家要注意SpringBoot项目在2.3.0之前是使用Maven构建项目的，在2.3.0之后是使用Gradle构建项目的。后面分析的源码以SpringBoot2.2.5为案例，所以本文就介绍下SpringBoot2.2.5的编译过程。

官网地址：https://github.com/spring-projects/spring-boot

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1639986555000/8ba6242338ba47359d42f49f02bf2c46.png)

直接下载对于的压缩文件即可

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1639986555000/a8bb863fd5554adca18462cbb7ce4637.png)

下载后直接解压缩即可

### 2.本地源码编译

把解压缩的源码直接导入到IDEA中，修改pom文件中的版本号。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1639986555000/83fc4aa579934ae0b49bbfc528a00536.png)

pom文件中提示 `disable.checks`属性找不到，我们添加一个即可。

```xml
	<properties>
		<revision>2.2.5.snapshot</revision>
		<main.basedir>${basedir}</main.basedir>
		<!-- 添加属性 -->
		<disable.checks>true</disable.checks>
	</properties>
```

然后执行编译命令

```cmd
mvn clean install -DskipTests
```

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1639986555000/cfe374e785e6464e9086c2eb8a726798.png)

然后控制台出现如下错误

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1639986555000/6c06bcd3d8504b1faa6c7eb0dff31c3a.png)

按照提示，执行下面的 命令 就好了：

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1639986555000/932f457fc6164771b04356cc125bd8e7.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1639986555000/a4dd313736b142f2bd1ebc60597bc26a.png)

在执行编译命令就可以了

mvn clean install -DskipTests

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1639986555000/77bf19e0829543b2990fe521e91f2a79.png)

### 3.源码环境使用

既然源码已经编译好之后我们就可以在这个项目中来创建我们自己的SpringBoot项目了，我们在 `spring-boot-project`项目下创建 `module`,

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1639986555000/f5c3299dc03a46b28f93f75c24d820d0.png)

然后在我们的module中添加对应的start依赖

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1639986555000/65b63c4b17b6414893cb65f2d1a87f2a.png)

然后添加我们的启动类

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1639986555000/e5c9b89e16fc4b678ae544a07ac1c43e.png)

项目能够正常启动

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1639986555000/4fb6b4805a7c4432a6dd9bbce48fc865.png)

同时点击run方法进去，我们可以添加注释了：

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1639986555000/803c18a45fbf473db24bf0088e07b0a2.png)

在其他项目使用我们编译的源码，这个可能是大家比较感兴趣的一个点了，我们也来介绍下，依赖我们还是可以使用官方的依赖即可，不过最好还是和我们编译的版本保持一致。

主要是关联上我们编译的源码。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1639986555000/ba46d4dee15d4b97a44ec0f10b40b331.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1639986555000/7b535d425f4a457fb3bdca937fe3af97.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1639986555000/b928eb29e7114392b9bb48f3864de917.png)

修改代码

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1639986555000/97e359f98c624052b3940a8b6b0e750f.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1639986555000/c2674eec4de9458d8f90fc4e3410e538.png)

好了到此我们就可以开启SpringBoot的源码探索之旅了哦。



### 问题解决

#### 执行命令mvn clean install报错

```shell
Run `spring-javaformat:apply` to fix.
```

执行命令：`mvn spring-javaformat:apply`



#### 执行命令`mvn spring-javaformat:apply`报错

```java
[ERROR] Build scan background action failed:
java.lang.RuntimeException: Process failed
    at io.spring.ge.conventions.maven.GradleEnterpriseMavenExtension$ProcessBuilderProcessRunner.run (GradleEnterpriseMavenExtension.java:91)
    at io.spring.ge.conventions.core.BuildScanConventions.run (BuildScanConventions.java:166)
    at io.spring.ge.conventions.core.BuildScanConventions.addGitMetadata (BuildScanConventions.java:113)
    at io.spring.ge.conventions.maven.MavenConfigurableBuildScan.lambda$background$0 (MavenConfigurableBuildScan.java:94)
    at com.gradle.maven.scan.extension.internal.a.b.a (SourceFile:87)
    at java.util.concurrent.Executors$RunnableAdapter.call (Executors.java:511)
    at java.util.concurrent.FutureTask.run (FutureTask.java:266)
    at java.util.concurrent.ThreadPoolExecutor.runWorker (ThreadPoolExecutor.java:1149)
    at java.util.concurrent.ThreadPoolExecutor$Worker.run (ThreadPoolExecutor.java:624)
    at java.lang.Thread.run (Thread.java:750)
Caused by: java.io.IOException: Cannot run program "git": CreateProcess error=2, 系统找不到指定的文件。
    at java.lang.ProcessBuilder.start (ProcessBuilder.java:1048)
    at io.spring.ge.conventions.maven.GradleEnterpriseMavenExtension$ProcessBuilderProcessRunner.run (GradleEnterpriseMavenExtension.java:87)
    at io.spring.ge.conventions.core.BuildScanConventions.run (BuildScanConventions.java:166)
    at io.spring.ge.conventions.core.BuildScanConventions.addGitMetadata (BuildScanConventions.java:113)
    at io.spring.ge.conventions.maven.MavenConfigurableBuildScan.lambda$background$0 (MavenConfigurableBuildScan.java:94)
    at com.gradle.maven.scan.extension.internal.a.b.a (SourceFile:87)
    at java.util.concurrent.Executors$RunnableAdapter.call (Executors.java:511)
    at java.util.concurrent.FutureTask.run (FutureTask.java:266)
    at java.util.concurrent.ThreadPoolExecutor.runWorker (ThreadPoolExecutor.java:1149)
    at java.util.concurrent.ThreadPoolExecutor$Worker.run (ThreadPoolExecutor.java:624)
    at java.lang.Thread.run (Thread.java:750)
Caused by: java.io.IOException: CreateProcess error=2, 系统找不到指定的文件。
    at java.lang.ProcessImpl.create (Native Method)
    at java.lang.ProcessImpl.<init> (ProcessImpl.java:453)
    at java.lang.ProcessImpl.start (ProcessImpl.java:140)
    at java.lang.ProcessBuilder.start (ProcessBuilder.java:1029)
    at io.spring.ge.conventions.maven.GradleEnterpriseMavenExtension$ProcessBuilderProcessRunner.run (GradleEnterpriseMavenExtension.java:87)
    at io.spring.ge.conventions.core.BuildScanConventions.run (BuildScanConventions.java:166)
    at io.spring.ge.conventions.core.BuildScanConventions.addGitMetadata (BuildScanConventions.java:113)
    at io.spring.ge.conventions.maven.MavenConfigurableBuildScan.lambda$background$0 (MavenConfigurableBuildScan.java:94)
    at com.gradle.maven.scan.extension.internal.a.b.a (SourceFile:87)
    at java.util.concurrent.Executors$RunnableAdapter.call (Executors.java:511)
    at java.util.concurrent.FutureTask.run (FutureTask.java:266)
    at java.util.concurrent.ThreadPoolExecutor.runWorker (ThreadPoolExecutor.java:1149)
    at java.util.concurrent.ThreadPoolExecutor$Worker.run (ThreadPoolExecutor.java:624)
    at java.lang.Thread.run (Thread.java:750)
[INFO] 
[INFO] A build scan was not published as you have not authenticated with server 'ge.spring.io'.

Process finished with exit code 0
```

将git.exe加入到path环境变量中，或者使用git安装包安装一下git。

如果还报错，重启idea再重新执行一下命令。

```java
[INFO] --- spring-javaformat-maven-plugin:0.0.26:apply (default-cli) @ spring-boot-starter-web-services ---
[INFO] 
[INFO] --------------< org.springframework.boot:spring-boot-cli >--------------
[INFO] Building Spring Boot CLI 2.2.13.RELEASE                          [80/89]
[INFO] --------------------------------[ jar ]---------------------------------
[INFO] 
[INFO] --- spring-javaformat-maven-plugin:0.0.26:apply (default-cli) @ spring-boot-cli ---
[INFO] 
[INFO] -------------< org.springframework.boot:spring-boot-docs >--------------
[INFO] Building Spring Boot Docs 2.2.13.RELEASE                         [81/89]
[INFO] --------------------------------[ jar ]---------------------------------
[INFO] 
[INFO] --- spring-javaformat-maven-plugin:0.0.26:apply (default-cli) @ spring-boot-docs ---
[INFO] 
[INFO] ------------< org.springframework.boot:spring-boot-project >------------
[INFO] Building Spring Boot Project 2.2.13.RELEASE                      [82/89]
[INFO] --------------------------------[ pom ]---------------------------------
[INFO] 
[INFO] --- spring-javaformat-maven-plugin:0.0.26:apply (default-cli) @ spring-boot-project ---
[INFO] 
[INFO] ------< org.springframework.boot:spring-boot-smoke-tests-invoker >------
[INFO] Building Spring Boot Smoke Tests Invoker 2.2.13.RELEASE          [83/89]
[INFO] --------------------------------[ pom ]---------------------------------
[INFO] 
[INFO] --- spring-javaformat-maven-plugin:0.0.26:apply (default-cli) @ spring-boot-smoke-tests-invoker ---
[INFO] 
[INFO] -------------< org.springframework.boot:spring-boot-tests >-------------
[INFO] Building Spring Boot Tests 2.2.13.RELEASE                        [84/89]
[INFO] --------------------------------[ pom ]---------------------------------
[INFO] 
[INFO] --- spring-javaformat-maven-plugin:0.0.26:apply (default-cli) @ spring-boot-tests ---
[INFO] 
[INFO] -------< org.springframework.boot:spring-boot-integration-tests >-------
[INFO] Building Spring Boot Integration Tests 2.2.13.RELEASE            [85/89]
[INFO] --------------------------------[ pom ]---------------------------------
[INFO] 
[INFO] --- spring-javaformat-maven-plugin:0.0.26:apply (default-cli) @ spring-boot-integration-tests ---
[INFO] 
[INFO] --< org.springframework.boot:spring-boot-configuration-processor-tests >--
[INFO] Building Spring Boot Configuration Processor Tests 2.2.13.RELEASE [86/89]
[INFO] --------------------------------[ jar ]---------------------------------
[INFO] 
[INFO] --- spring-javaformat-maven-plugin:0.0.26:apply (default-cli) @ spring-boot-configuration-processor-tests ---
[INFO] 
[INFO] --------< org.springframework.boot:spring-boot-devtools-tests >---------
[INFO] Building Spring Boot DevTools Tests 2.2.13.RELEASE               [87/89]
[INFO] --------------------------------[ jar ]---------------------------------
[INFO] 
[INFO] --- spring-javaformat-maven-plugin:0.0.26:apply (default-cli) @ spring-boot-devtools-tests ---
[INFO] 
[INFO] ---------< org.springframework.boot:spring-boot-server-tests >----------
[INFO] Building Spring Boot Server Tests 2.2.13.RELEASE                 [88/89]
[INFO] --------------------------------[ jar ]---------------------------------
[INFO] 
[INFO] --- spring-javaformat-maven-plugin:0.0.26:apply (default-cli) @ spring-boot-server-tests ---
[INFO] 
[INFO] ------< org.springframework.boot:spring-boot-launch-script-tests >------
[INFO] Building Spring Boot Launch Script Integration Tests 2.2.13.RELEASE [89/89]
[INFO] --------------------------------[ jar ]---------------------------------
[INFO] 
[INFO] --- spring-javaformat-maven-plugin:0.0.26:apply (default-cli) @ spring-boot-launch-script-tests ---
[INFO] ------------------------------------------------------------------------
[INFO] Reactor Summary for Spring Boot Build 2.2.13.RELEASE:
[INFO] 
[INFO] Spring Boot Build .................................. SUCCESS [  0.378 s]
[INFO] Spring Boot Dependencies ........................... SUCCESS [  0.011 s]
[INFO] Spring Boot Parent ................................. SUCCESS [  0.021 s]
[INFO] Spring Boot Tools .................................. SUCCESS [  0.012 s]
[INFO] Spring Boot Testing Support ........................ SUCCESS [  0.649 s]
[INFO] Spring Boot Configuration Processor ................ SUCCESS [  0.501 s]
[INFO] Spring Boot ........................................ SUCCESS [  2.062 s]
[INFO] Spring Boot Test ................................... SUCCESS [  0.420 s]
[INFO] Spring Boot Auto-Configure Annotation Processor .... SUCCESS [  0.021 s]
[INFO] Spring Boot AutoConfigure .......................... SUCCESS [  1.187 s]
[INFO] Spring Boot Actuator ............................... SUCCESS [  0.482 s]
[INFO] Spring Boot Actuator AutoConfigure ................. SUCCESS [  0.453 s]
[INFO] Spring Boot Developer Tools ........................ SUCCESS [  0.173 s]
[INFO] Spring Boot Configuration Metadata ................. SUCCESS [  0.024 s]
[INFO] Spring Boot Properties Migrator .................... SUCCESS [  0.015 s]
[INFO] Spring Boot Test Auto-Configure .................... SUCCESS [  0.196 s]
[INFO] Spring Boot Loader ................................. SUCCESS [  0.109 s]
[INFO] Spring Boot Loader Tools ........................... SUCCESS [  0.062 s]
[INFO] Spring Boot Gradle Plugin .......................... SUCCESS [  0.080 s]
[INFO] Spring Boot Gradle Plugin Marker Artifact .......... SUCCESS [  0.005 s]
[INFO] Spring Boot Antlib ................................. SUCCESS [  0.013 s]
[INFO] Spring Boot Configuration Docs ..................... SUCCESS [  0.014 s]
[INFO] Spring Boot Maven Plugin ........................... SUCCESS [  0.048 s]
[INFO] Spring Boot Starters ............................... SUCCESS [  0.014 s]
[INFO] Spring Boot Logging Starter ........................ SUCCESS [  0.004 s]
[INFO] Spring Boot Starter ................................ SUCCESS [  0.008 s]
[INFO] Spring Boot ActiveMQ Starter ....................... SUCCESS [  0.005 s]
[INFO] Spring Boot AMQP Starter ........................... SUCCESS [  0.005 s]
[INFO] Spring Boot AOP Starter ............................ SUCCESS [  0.005 s]
[INFO] Spring Boot Artemis Starter ........................ SUCCESS [  0.005 s]
[INFO] Spring Boot JDBC Starter ........................... SUCCESS [  0.005 s]
[INFO] Spring Boot Batch Starter .......................... SUCCESS [  0.005 s]
[INFO] Spring Boot Cache Starter .......................... SUCCESS [  0.004 s]
[INFO] Spring Boot Spring Cloud Connectors Starter ........ SUCCESS [  0.005 s]
[INFO] Spring Boot Data Cassandra Starter ................. SUCCESS [  0.005 s]
[INFO] Spring Boot Data Cassandra Reactive Starter ........ SUCCESS [  0.004 s]
[INFO] Spring Boot Data Couchbase Starter ................. SUCCESS [  0.005 s]
[INFO] Spring Boot Data Couchbase Reactive Starter ........ SUCCESS [  0.005 s]
[INFO] Spring Boot Data Elasticsearch Starter ............. SUCCESS [  0.003 s]
[INFO] Spring Boot Data JDBC Starter ...................... SUCCESS [  0.003 s]
[INFO] Spring Boot Data JPA Starter ....................... SUCCESS [  0.004 s]
[INFO] Spring Boot Data LDAP Starter ...................... SUCCESS [  0.004 s]
[INFO] Spring Boot Data MongoDB Starter ................... SUCCESS [  0.005 s]
[INFO] Spring Boot Data MongoDB Reactive Starter .......... SUCCESS [  0.005 s]
[INFO] Spring Boot Data Neo4j Starter ..................... SUCCESS [  0.005 s]
[INFO] Spring Boot Data Redis Starter ..................... SUCCESS [  0.004 s]
[INFO] Spring Boot Data Redis Reactive Starter ............ SUCCESS [  0.004 s]
[INFO] Spring Boot Json Starter ........................... SUCCESS [  0.003 s]
[INFO] Spring Boot Tomcat Starter ......................... SUCCESS [  0.003 s]
[INFO] Spring Boot Validation Starter ..................... SUCCESS [  0.003 s]
[INFO] Spring Boot Web Starter ............................ SUCCESS [  0.003 s]
[INFO] Spring Boot Data REST Starter ...................... SUCCESS [  0.003 s]
[INFO] Spring Boot Data Solr Starter ...................... SUCCESS [  0.005 s]
[INFO] Spring Boot FreeMarker Starter ..................... SUCCESS [  0.003 s]
[INFO] Spring Boot Groovy Templates Starter ............... SUCCESS [  0.003 s]
[INFO] Spring Boot HATEOAS Starter ........................ SUCCESS [  0.004 s]
[INFO] Spring Boot Integration Starter .................... SUCCESS [  0.004 s]
[INFO] Spring Boot Jersey Starter ......................... SUCCESS [  0.003 s]
[INFO] Spring Boot Jetty Starter .......................... SUCCESS [  0.003 s]
[INFO] Spring Boot JOOQ Starter ........................... SUCCESS [  0.003 s]
[INFO] Spring Boot Atomikos JTA Starter ................... SUCCESS [  0.006 s]
[INFO] Spring Boot Bitronix JTA Starter ................... SUCCESS [  0.004 s]
[INFO] Spring Boot Log4j 2 Starter ........................ SUCCESS [  0.003 s]
[INFO] Spring Boot Mail Starter ........................... SUCCESS [  0.004 s]
[INFO] Spring Boot Mustache Starter ....................... SUCCESS [  0.003 s]
[INFO] Spring Boot Actuator Starter ....................... SUCCESS [  0.003 s]
[INFO] Spring Boot OAuth2/OpenID Connect Client Starter ... SUCCESS [  0.003 s]
[INFO] Spring Boot OAuth2 Resource Server Starter ......... SUCCESS [  0.002 s]
[INFO] Spring Boot Starter Parent ......................... SUCCESS [  0.004 s]
[INFO] Spring Boot Quartz Starter ......................... SUCCESS [  0.004 s]
[INFO] Spring Boot Reactor Netty Starter .................. SUCCESS [  0.003 s]
[INFO] Spring Boot RSocket Starter ........................ SUCCESS [  0.004 s]
[INFO] Spring Boot Security Starter ....................... SUCCESS [  0.004 s]
[INFO] Spring Boot Test Starter ........................... SUCCESS [  0.004 s]
[INFO] Spring Boot Thymeleaf Starter ...................... SUCCESS [  0.004 s]
[INFO] Spring Boot Undertow Starter ....................... SUCCESS [  0.004 s]
[INFO] Spring Boot WebFlux Starter ........................ SUCCESS [  0.004 s]
[INFO] Spring Boot WebSocket Starter ...................... SUCCESS [  0.003 s]
[INFO] Spring Boot Web Services Starter ................... SUCCESS [  0.003 s]
[INFO] Spring Boot CLI .................................... SUCCESS [  0.148 s]
[INFO] Spring Boot Docs ................................... SUCCESS [  0.067 s]
[INFO] Spring Boot Project ................................ SUCCESS [  0.003 s]
[INFO] Spring Boot Smoke Tests Invoker .................... SUCCESS [  0.004 s]
[INFO] Spring Boot Tests .................................. SUCCESS [  0.003 s]
[INFO] Spring Boot Integration Tests ...................... SUCCESS [  0.019 s]
[INFO] Spring Boot Configuration Processor Tests .......... SUCCESS [  0.008 s]
[INFO] Spring Boot DevTools Tests ......................... SUCCESS [  0.024 s]
[INFO] Spring Boot Server Tests ........................... SUCCESS [  0.030 s]
[INFO] Spring Boot Launch Script Integration Tests ........ SUCCESS [  0.014 s]
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  9.983 s
[INFO] Finished at: 2023-10-12T16:39:17+08:00
[INFO] ------------------------------------------------------------------------
[INFO] 89 goals, 89 executed
[INFO] 
[INFO] A build scan was not published as you have not authenticated with server 'ge.spring.io'.

Process finished with exit code 0
```



#### archive is not a ZIP archive

执行maven clean install 时报错

```java
[INFO] Spring Boot Launch Script Integration Tests ........ SKIPPED
[INFO] ------------------------------------------------------------------------
[INFO] BUILD FAILURE
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  01:21 min
[INFO] Finished at: 2023-10-12T16:56:28+08:00
[INFO] ------------------------------------------------------------------------
[INFO] 204 goals, 204 executed
[INFO] 
[INFO] A build scan was not published as you have not authenticated with server 'ge.spring.io'.
[ERROR] Failed to execute goal com.googlecode.maven-download-plugin:download-maven-plugin:1.4.2:wget (unpack-doc-resources) on project spring-boot-gradle-plugin: IO Error: Error while expanding D:\Workspace\idea\spring\spring-boot-2.2.13.RELEASE\spring-boot-project\spring-boot-tools\spring-boot-gradle-plugin\target\refdocs\asciidoc\spring-doc-resources-0.1.3.RELEASE.zip: archive is not a ZIP archive -> [Help 1]
[ERROR] 
[ERROR] To see the full stack trace of the errors, re-run Maven with the -e switch.
[ERROR] Re-run Maven using the -X switch to enable full debug logging.
[ERROR] 
[ERROR] For more information about the errors and possible solutions, please read the following articles:
[ERROR] [Help 1] http://cwiki.apache.org/confluence/display/MAVEN/MojoExecutionException
[ERROR] 
[ERROR] After correcting the problems, you can resume the build with the command
[ERROR]   mvn <args> -rf :spring-boot-gradle-plugin

Process finished with exit code 1
```







## 源码分析

我们要分析一个框架的源码不可能通过一篇文章就搞定的，本文我们就来分析下SpringBoot源码中的主线流程。先掌握SpringBoot项目启动的核心操作，然后我们再深入每一个具体的实现细节，注：本系列源码都以SpringBoot2.2.5.RELEASE版本来讲解

### 主线分析

#### SpringBoot启动的入口

当我们启动一个SpringBoot项目的时候，入口程序就是main方法，而在main方法中就执行了一个run方法。

```java
@SpringBootApplication
public class StartApp {

	public static void main(String[] args) {
		SpringApplication.run(StartApp.class);
	}
}
```

#### run方法

然后我们进入run()方法中看。代码比较简单

```java
	public static ConfigurableApplicationContext run(Class<?> primarySource, String... args) {
		// 调用重载的run方法，将传递的Class对象封装为了一个数组
		return run(new Class<?>[] { primarySource }, args);
	}
```

调用了重载的一个run()方法，将我们传递进来的类对象封装为了一个数组，仅此而已。我们再进入run()方法。

```java
	public static ConfigurableApplicationContext run(Class<?>[] primarySources, String[] args) {
		// 创建了一个SpringApplication对象，并调用其run方法
		// 1.先看下构造方法中的逻辑
		// 2.然后再看run方法的逻辑
		return new SpringApplication(primarySources).run(args);
	}
```

br

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640171593000/e70d3fe03ded4228abaf0abeb83ac7c0.png)

在该方法中创建了一个SpringApplication对象。同时调用了SpringApplication对象的run方法。这里的逻辑有分支，先看下SpringApplication的构造方法中的逻辑

#### SpringApplication构造器

我们进入SpringApplication的构造方法，看的核心代码为

```java
	public SpringApplication(ResourceLoader resourceLoader, Class<?>... primarySources) {
		// 传递的resourceLoader为null
		this.resourceLoader = resourceLoader;
		Assert.notNull(primarySources, "PrimarySources must not be null");
		// 记录主方法的配置类名称
		this.primarySources = new LinkedHashSet<>(Arrays.asList(primarySources));
		// 记录当前项目的类型
		this.webApplicationType = WebApplicationType.deduceFromClasspath();
		// 加载配置在spring.factories文件中的ApplicationContextInitializer对应的类型并实例化
		// 并将加载的数据存储在了 initializers 成员变量中。
		setInitializers((Collection) getSpringFactoriesInstances(ApplicationContextInitializer.class));
		// 初始化监听器 并将加载的监听器实例对象存储在了listeners成员变量中
		setListeners((Collection) getSpringFactoriesInstances(ApplicationListener.class));
		// 反推main方法所在的Class对象 并记录在了mainApplicationClass对象中
		this.mainApplicationClass = deduceMainApplicationClass();
	}
```

在本方法中完成了几个核心操作

1. 推断当前项目的类型
2. 加载配置在spring.factories文件中的ApplicationContextInitializer中的类型并实例化后存储在了initializers中。
3. 和2的步骤差不多，完成监听器的初始化操作，并将实例化的监听器对象存储在了listeners成员变量中
4. 通过StackTrace反推main方法所在的Class对象

上面的核心操作具体的实现细节我们在后面的详细文章会给大家剖析

### run方法

接下来我们在回到SpringApplication.run()方法中。

```java
	public ConfigurableApplicationContext run(String... args) {
		// 创建一个任务执行观察器
		StopWatch stopWatch = new StopWatch();
		// 开始执行记录执行时间
		stopWatch.start();
		// 声明 ConfigurableApplicationContext 对象
		ConfigurableApplicationContext context = null;
		// 声明集合容器用来存储 SpringBootExceptionReporter 启动错误的回调接口
		Collection<SpringBootExceptionReporter> exceptionReporters = new ArrayList<>();
		// 设置了一个名为java.awt.headless的系统属性
		// 其实是想设置该应用程序,即使没有检测到显示器,也允许其启动.
		//对于服务器来说,是不需要显示器的,所以要这样设置.
		configureHeadlessProperty();
		// 获取 SpringApplicationRunListener 加载的是 EventPublishingRunListener
		// 获取启动时到监听器
		SpringApplicationRunListeners listeners = getRunListeners(args);
		// 触发启动事件
		listeners.starting();
		try {
			// 构造一个应用程序的参数持有类
			ApplicationArguments applicationArguments = new DefaultApplicationArguments(args);
			// 创建并配置环境
			ConfigurableEnvironment environment = prepareEnvironment(listeners, applicationArguments);
			// 配置需要忽略的BeanInfo信息
			configureIgnoreBeanInfo(environment);
			// 输出的Banner信息
			Banner printedBanner = printBanner(environment);
			// 创建应用上下文对象
			context = createApplicationContext();
			// 加载配置的启动异常处理器
			exceptionReporters = getSpringFactoriesInstances(SpringBootExceptionReporter.class,
					new Class[] { ConfigurableApplicationContext.class }, context);
			// 刷新前操作
			prepareContext(context, environment, listeners, applicationArguments, printedBanner);
			// 刷新应用上下文 完成Spring容器的初始化
			refreshContext(context);
			// 刷新后操作
			afterRefresh(context, applicationArguments);
			// 结束记录启动时间
			stopWatch.stop();
			if (this.logStartupInfo) {
				new StartupInfoLogger(this.mainApplicationClass).logStarted(getApplicationLog(), stopWatch);
			}
			// 事件广播 启动完成了
			listeners.started(context);
			callRunners(context, applicationArguments);
		}
		catch (Throwable ex) {
			// 事件广播启动出错了
			handleRunFailure(context, ex, exceptionReporters, listeners);
			throw new IllegalStateException(ex);
		}
		try {
			// 监听器运行中
			listeners.running(context);
		}
		catch (Throwable ex) {
			handleRunFailure(context, ex, exceptionReporters, null);
			throw new IllegalStateException(ex);
		}
		// 返回上下文对象--> Spring容器对象
		return context;
	}
```

在这个方法中完成了SpringBoot项目启动的很多核心的操作，我们来总结下上面的步骤

1. 创建了一个任务执行的观察器，统计启动的时间
2. 声明ConfigurableApplicationContext对象
3. 声明集合容器来存储SpringBootExceptionReporter即启动错误的回调接口
4. 设置java.awt.headless的系统属性
5. 获取我们之间初始化的监听器(EventPublishingRunListener),并触发starting事件
6. 创建ApplicationArguments这是一个应用程序的参数持有类
7. 创建ConfigurableEnvironment这时一个配置环境的对象
8. 配置需要忽略的BeanInfo信息
9. 配置Banner信息对象
10. 创建对象的上下文对象
11. 加载配置的启动异常的回调异常处理器
12. 刷新应用上下文，本质就是完成Spring容器的初始化操作
13. 启动结束记录启动耗时
14. 完成对应的事件广播
15. 返回应用上下文对象。


到此SpringBoot项目的启动初始化的代码的主要流程就介绍完成了。细节部分后面详细讲解。


### SpringApplication构造器

前面给大家介绍了SpringBoot启动的核心流程，本文开始给大家详细的来介绍SpringBoot启动中的具体实现的相关细节。 https://www.processon.com/view/link/61eab8f47d9c085d604e614d

![SpringBoot2.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640256880000/20233d78473344abb911d4740c7e2643.png)

首先我们来看下在SpringApplication的构造方法中是如何帮我们完成这4个核心操作的。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640256880000/d27c903f4a0d416da247e96f4a9d06b1.png)

```java
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public SpringApplication(ResourceLoader resourceLoader, Class<?>... primarySources) {
		// 传递的resourceLoader为null
		this.resourceLoader = resourceLoader;
		Assert.notNull(primarySources, "PrimarySources must not be null");
		// 记录主方法的配置类名称
		this.primarySources = new LinkedHashSet<>(Arrays.asList(primarySources));
		// 记录当前项目的类型
		this.webApplicationType = WebApplicationType.deduceFromClasspath();
		// 加载配置在spring.factories文件中的ApplicationContextInitializer对应的类型并实例化
		// 并将加载的数据存储在了 initializers 成员变量中。
		setInitializers((Collection) getSpringFactoriesInstances(ApplicationContextInitializer.class));
		// 初始化监听器 并将加载的监听器实例对象存储在了listeners成员变量中
		setListeners((Collection) getSpringFactoriesInstances(ApplicationListener.class));
		// 反推main方法所在的Class对象 并记录在了mainApplicationClass对象中
		this.mainApplicationClass = deduceMainApplicationClass();
	}
```

#### 1.webApplicationType

首先来看下webApplicationType是如何来推导出当前启动的项目的类型。通过代码可以看到是通过deduceFromClassPath()方法根据ClassPath来推导出来的。

```java
this.webApplicationType = WebApplicationType.deduceFromClasspath();
```

跟踪进去看代码

```java
	static WebApplicationType deduceFromClasspath() {
		if (ClassUtils.isPresent(WEBFLUX_INDICATOR_CLASS, null)
				&& !ClassUtils.isPresent(WEBMVC_INDICATOR_CLASS, null)
				&& !ClassUtils.isPresent(JERSEY_INDICATOR_CLASS, null)) {
			return WebApplicationType.REACTIVE;
		}
		for (String className : SERVLET_INDICATOR_CLASSES) {
			if (!ClassUtils.isPresent(className, null)) {
				return WebApplicationType.NONE;
			}
		}
		return WebApplicationType.SERVLET;
	}
```

在看整体的实现逻辑之前，我们先分别看两个内容，第一就是在上面的代码中使用到了相关的静态变量。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640256880000/11c608e5613b47478aef40ba9fac2f7a.png)

这些静态变量其实就是一些绑定的Java类的全类路径。第二个就是 `ClassUtils.isPresent()`方法，该方法的逻辑也非常简单，就是通过反射的方式获取对应的类型的Class对象，如果存在返回true，否则返回false

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640256880000/34b735dda8e545809eb13c3a95bc4fe7.png)

所以到此推导的逻辑就非常清楚了

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640256880000/ed287633a72f4cbf914546f00a4deaf2.png)

#### 2.setInitializers

然后我们再来看下如何实现加载初始化器的。

```java
// 加载配置在spring.factories文件中的ApplicationContextInitializer对应的类型并实例化
		// 并将加载的数据存储在了 initializers 成员变量中。
		setInitializers((Collection) getSpringFactoriesInstances(ApplicationContextInitializer.class));
```

首先所有的初始化器都实现了 `ApplicationContextInitializer`接口,也就是根据这个类型来加载相关的实现类。

```java
public interface ApplicationContextInitializer<C extends ConfigurableApplicationContext> {
    void initialize(C var1);
}
```

然后加载的关键方法是 `getSpringFactoriesInstances()`方法。该方法会加载 `spring.factories`文件中的key为 `org.springframework.context.ApplicationContextInitializer` 的值。

spring-boot项目下

```properties
# Application Context Initializers
org.springframework.context.ApplicationContextInitializer=\
org.springframework.boot.context.ConfigurationWarningsApplicationContextInitializer,\
org.springframework.boot.context.ContextIdApplicationContextInitializer,\
org.springframework.boot.context.config.DelegatingApplicationContextInitializer,\
org.springframework.boot.rsocket.context.RSocketPortInfoApplicationContextInitializer,\
org.springframework.boot.web.context.ServerPortInfoApplicationContextInitializer
```

spring-boot-autoconfigure项目下

```properties
# Initializers
org.springframework.context.ApplicationContextInitializer=\
org.springframework.boot.autoconfigure.SharedMetadataReaderFactoryContextInitializer,\
org.springframework.boot.autoconfigure.logging.ConditionEvaluationReportLoggingListener

```

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640256880000/b5facc54c9854f3995cecfa7cee14a8f.png)

具体的加载方法为 `getSpringFacotiesInstance()`方法，我们进入查看

```java
	private <T> Collection<T> getSpringFactoriesInstances(Class<T> type, Class<?>[] parameterTypes, Object... args) {
		// 获取当前上下文类加载器
		ClassLoader classLoader = getClassLoader();
		// 获取到的扩展类名存入set集合中防止重复
		Set<String> names = new LinkedHashSet<>(SpringFactoriesLoader.loadFactoryNames(type, classLoader));
		// 创建扩展点实例
		List<T> instances = createSpringFactoriesInstances(type, parameterTypes, classLoader, args, names);
		AnnotationAwareOrderComparator.sort(instances);
		return instances;
	}
```

先进入 `SpringFactoriesLoader.loadFactoryNames(type, classLoader)`中具体查看加载文件的过程.

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640256880000/264e6321f8734d16b02aea25d9004cfa.png)

然后我们来看下 `loadSpringFactories`方法

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640256880000/e48b0dd8e7024f2a8912f83606b1afa1.png)

通过Debug的方式查看会更清楚哦

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640256880000/335ab7d63ccc49188c7176b9c49fbb54.png)

通过 `loadSpringFactories` 方法我们看到把 `spring.factories`文件中的所有信息都加载到了内存中了，但是我们现在只需要加载 `ApplicationContextInitializer`类型的数据。这时我们再通过 `getOrDefault()`方法来查看。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640256880000/661ec6eb875e4931804b30e5f2608ace.png)

进入方法中查看

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640256880000/ae25bcc8768840b4866bc416ba725da4.png)

然后会根据反射获取对应的实例对象。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640256880000/ba90364b8faa4f839d308b8856d7cd30.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640256880000/5fd5c8871194447da7de114e196fcf94.png)

好了到这其实我们就清楚了 `getSpringFactoriesInstances`方法的作用就是帮我们获取定义在 `META-INF/spring.factories`文件中的可以为 `ApplicationContextInitializer` 的值。并通过反射的方式获取实例对象。然后把实例的对象信息存储在了SpringApplication的 `initializers`属性中。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640256880000/682f31c036c2438392e56f70d58866aa.png)

#### 3.setListeners

清楚了 `setInitializers()`方法的作用后，再看 `setListeners()`方法就非常简单了，都是调用了 `getSpringFactoriesInstances`方法，只是传入的类型不同。也就是要获取的 `META-INF/spring.factories`文件中定义的不同信息罢了。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640256880000/5fb3f99fd2fb4c448ee8ee666d8fde9a.png)

即加载定义在 `META-INF/spring.factories`文件中声明的所有的监听器，并将获取后的监听器存储在了 `SpringApplication`的 `listeners`属性中。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640256880000/d0c88a1d7e3c451c9740424117516dfb.png)

默认加载的监听器为：

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640256880000/563d2fbf30af4d68b6d92dde9e2564d0.png)

#### 4.mainApplicationClass

最后我们来看下 `duduceMainApplicaitonClass()`方法是如何反推导出main方法所在的Class对象的。通过源码我们可以看到是通过 `StackTrace`来实现的。

> ```txt
> StackTrace:
> 我们在学习函数调用时，都知道每个函数都拥有自己的栈空间。
> 一个函数被调用时，就创建一个新的栈空间。那么通过函数的嵌套调用最后就形成了一个函数调用堆栈
> ```

`StackTrace`其实就是记录了程序方法执行的链路。通过Debug方式可以更直观的来呈现。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640256880000/9ce11b1720254826810c4e189c209dff.png)

那么相关的调用链路我们都可以获取到，剩下的就只需要获取每链路判断执行的方法名称是否是 `main`就可以了。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640256880000/f65ee0c2e1bc4d3f86b551bfc0ae4536.png)



### 监听器

#### 监听器设计

##### 1.观察者模式

监听器的设计会使用到Java设计模式中的观察者模式，所以在搞清楚SpringBoot中的监听器的设计之前我们还是非常有必要把观察者模式先弄清楚。

观察者模式又称为发布/订阅(Publish/Subscribe)模式,在对象之间定义了一对多的依赖，这样一来，当一个对象改变状态，依赖它的对象会收到通知并自动更新.

在java.util包中包含有基本的Observer接口和Observable抽象类.功能上和Subject接口和Observer接口类似.不过在使用上,就方便多了,因为许多功能比如说注册,删除,通知观察者的那些功能已经内置好了.

###### 1.1 定义具体被观察者

```java
package com.dpb.observer2;

import java.util.Observable;

/**
 * 目标对象
 * 继承 Observable
 * @author dengp
 *
 */
public class ConcreteSubject extends Observable {

	private int state; 

	public void set(int s){
		state = s;  //目标对象的状态发生了改变
		setChanged();  //表示目标对象已经做了更改
		notifyObservers(state);  //通知所有的观察者
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}
}

```

观察者只需要继承Observable父类。发送消息的方式执行如下两行代码即可

```java
setChanged();  //表示目标对象已经做了更改
notifyObservers(state);  //通知所有的观察者
```

Observable源码对应的是：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190216234306676.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM4NTI2NTcz,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190216234428190.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM4NTI2NTcz,size_16,color_FFFFFF,t_70)

###### 1.2 定义具体观察者

```java
package com.dpb.observer2;

import java.util.Observable;
import java.util.Observer;
/**
 * 观察者模式：观察者(消息订阅者)
 * 实现Observer接口
 * @author dengp
 *
 */
public class ObserverA implements Observer {

	private int myState;

	@Override
	public void update(Observable o, Object arg) {
		myState = ((ConcreteSubject)o).getState();
	}
	public int getMyState() {
		return myState;
	}
	public void setMyState(int myState) {
		this.myState = myState;
	}
}
```

观察者也就是订阅者只需要实现Observer接口并重写相关update方法即可，在目标实现中我们发现触发的时候执行的就是观察者的update方法。

###### 1.3 测试

```java
package com.dpb.observer2;

public class Client {
	public static void main(String[] args) {
		//创建目标对象Obserable
		ConcreteSubject subject = new ConcreteSubject();

		//创建观察者
		ObserverA obs1 = new ObserverA();
		ObserverA obs2 = new ObserverA();
		ObserverA obs3 = new ObserverA();

		//将上面三个观察者对象添加到目标对象subject的观察者容器中
		subject.addObserver(obs1);
		subject.addObserver(obs2);
		subject.addObserver(obs3);

		//改变subject对象的状态
		subject.set(3000);
		System.out.println("===============状态修改了！");
		//观察者的状态发生了变化
		System.out.println(obs1.getMyState());
		System.out.println(obs2.getMyState());
		System.out.println(obs3.getMyState());

		subject.set(600);
		System.out.println("===============状态修改了！");
		//观察者的状态发生了变化
		System.out.println(obs1.getMyState());
		System.out.println(obs2.getMyState());
		System.out.println(obs3.getMyState());

		//移除一个订阅者
		subject.deleteObserver(obs2);
		subject.set(100);
		System.out.println("===============状态修改了！");
		//观察者的状态发生了变化
		System.out.println(obs1.getMyState());
		System.out.println(obs2.getMyState());
		System.out.println(obs3.getMyState());
	}
}

```

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190216235018273.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM4NTI2NTcz,size_16,color_FFFFFF,t_70)
这样就实现了官方提供观察者模式.

##### 2.SpringBoot中监听器的设计

然后我们来看下SpringBoot启动这涉及到的监听器这块是如何实现的。

###### 2.1 初始化操作

通过前面的介绍我们知道在SpringApplication的构造方法中会加载所有声明在spring.factories中的监听器。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640324549000/6b458524aaf546eb9084434519c7ef0d.png)

通过Debug模式我们可以看到加载的监听器有哪些。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640324549000/76e9dcc5e9104561aeceeb91405ef447.png)

其实就是加载的spring.factories文件中的key为ApplicationListener的value

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640324549000/f1cffe9621c24e91a8ef27d761d409a7.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640324549000/2789a2faaba44ee690b23e3e2b14371e.png)

通过对这些内置监听器的源码查看我们发现这些监听器都实现了 `ApplicationEvent`接口。也就是都会监听 `ApplicationEvent`发布的相关的事件。ApplicationContext事件机制是观察者设计模式的实现，通过ApplicationEvent类和ApplicationListener接口，可以实现ApplicationContext事件处理。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640324549000/035e9e1d7361441ca0b88aa0945045a0.png)

###### 2.2 run方法

然后我们来看下在SpringApplication.run()方法中是如何发布对应的事件的。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640324549000/64f69bc57a564148a66d4a9c3ac7abd5.png)

首先会通过getRunListeners方法来获取我们在spring.factories中定义的SpringApplicationRunListener类型的实例。也就是EventPublishingRunListener.

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640324549000/1ea1d66e450b41c4918aaddd6ef9b2f5.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640324549000/fa15b74df90e4695a6c7ebf84f6b845a.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640324549000/baf819379bd5489fa4e0ff241ed15274.png)

加载这个类型的时候会同步的完成实例化。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640324549000/7f7fdbf0dc6d4856bae9c8eb85adf0a3.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640324549000/5f832aed53344b04bff2f36367bc933b.png)

实例化操作就会执行EventPublishingRunListener.

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640324549000/d2970e863b784cfdb89d8dff92f78b32.png)

在这个构造方法中会绑定我们前面加载的11个过滤器。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640324549000/53658b78f3bf453f9f7455c32834f90b.png)

到这其实我们就已经清楚了EventPublishingRunListener和我们前面加载的11个监听器的关系了。然后在看事件发布的方法。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640324549000/ee3af2c5febd4e6abc30a35d3aa5b2a0.png)

查看starting()方法。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640324549000/41e3034fe63c47d18d8b89d1ef533e17.png)

再进入

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640324549000/f0e9438cd1194f3cbfa205f936856402.png)

进入到multicastEvent中方法中我们可以看到具体的触发逻辑

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640324549000/01a7d30aa5ff4e05af862413a2d241c6.png)

在这儿以ConfigFileApplicationListener为例。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640324549000/a52f6503a0b040f280240eb49eb260e3.png)

触发会进入ConfigFileApplicationListener对象的onApplicationEvent方法中，

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640324549000/dd68d5a821d243a0bb91652f5c80bcbc.png)

通过代码我们可以发现当前的事件是ApplicationStartingEvent事件，都不满足，所以ConfigFileApplicationListener在SpringBoot项目开始启动的时候就不会做任何的操作。而当我们在配置环境信息的时候，会发布对应的事件来触发

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640324549000/6ba12346ba634f7089031aede43c6bb5.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640324549000/fe354248666d422187a756f5f511e384.png)

继续进入

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640324549000/fee9bdfad79f44b883a575a01e17e589.png)

继续进入

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640324549000/cff0163367d5440e9e03799efdc550b4.png)

然后再触发ConfigFileApplicationListener监听器的时候就会触发如下方法了

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640324549000/666a39112134400992c1e2ab43d74cb3.png)

其实到这儿，后面的事件发布与监听器的处理逻辑就差不多是一致了。到这儿对应SpringBoot中的监听器这块就分析的差不错了。像SpringBoot的属性文件中的信息什么时候加载的就是在这些内置的监听器中完成的。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640324549000/2bf30239816c46fbb8105250c952ab26.png)

官方内置的事件有：

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1640324549000/55fe63f0dc334bf2bd96fa62185e9bc8.png)

好了本文就给大家介绍到这里，希望能对你有所帮助哦。



#### 自定义监听器

前面我们系统的给大家介绍了SpringBoot中的监听器机制，清楚的知道了SpringBoot中默认给我们提供了多个监听器，提供了一个默认的事件发布器，还有很多默认的事件，本文我们就在前面的基础上来，来看下如果我们要自定义监听器如何来实现。

##### 1.SpringBoot中默认的监听器

首先来回顾下SpringBoot中给我们提供的默认的监听器，这些都定义在spring.factories文件中。

| 监听器                                     | 监听事件                                                     | 说明                                                         |
| ------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| ClearCachesApplicationListener             | ContextRefreshedEvent                                        | 当触发ContextRefreshedEvent事件会清空应用的缓存              |
| ParentContextCloserApplicationListener     | ParentContextAvailableEvent                                  | 触发ParentContextAvailableEvent事件会完成父容器关闭的监听器  |
| CloudFoundryVcapEnvironmentPostProcessor   | ApplicationPreparedEvent                                     | 判断环境中是否存在VCAP_APPLICATION或者VCAP_SERVICES。如果有就添加Cloud Foundry的配置；没有就不执行任何操作。 |
| FileEncodingApplicationListener            | ApplicationEnvironmentPreparedEvent                          | 文件编码的监听器                                             |
| AnsiOutputApplicationListener              | ApplicationEnvironmentPreparedEvent                          | 根据 `spring.output.ansi.enabled`参数配置 `AnsiOutput`       |
| ConfigFileApplicationListener              | ApplicationEnvironmentPreparedEvent `<br>`ApplicationPreparedEvent | 完成相关属性文件的加载，application.properties<br />application.yml<br />前面源码内容详细讲解过 |
| DelegatingApplicationListener              | ApplicationEnvironmentPreparedEvent                          | 监听到事件后转发给环境变量 `context.listener.classes`指定的那些事件监听器 |
| ClasspathLoggingApplicationListener        | ApplicationEnvironmentPreparedEvent `<br>`ApplicationFailedEvent | 一个SmartApplicationListener,对环境就绪事件ApplicationEnvironmentPreparedEvent/应用失败事件ApplicationFailedEvent做出响应，往日志DEBUG级别输出TCCL(thread context class loader)的classpath。 |
| LoggingApplicationListener                 | ApplicationStartingEvent `<br>`ApplicationEnvironmentPreparedEvent `<br>`ApplicationPreparedEvent `<br>`ContextClosedEvent `<br>`ApplicationFailedEvent | 配置 `LoggingSystem`。使用 `logging.config`环境变量指定的配置或者缺省配置 |
| LiquibaseServiceLocatorApplicationListener | ApplicationStartingEvent                                     | 使用一个可以和Spring Boot可执行jar包配合工作的版本替换liquibase ServiceLocator |
| BackgroundPreinitializer                   | ApplicationStartingEvent `<br>`ApplicationReadyEvent `<br>`ApplicationFailedEvent | 尽早触发一些耗时的初始化任务，使用一个后台线程               |

##### 2.SpringBoot中的事件类型

然后我们来看下对应的事件类型，SpringBoot中的所有的事件都是继承于 `ApplicationEvent`这个抽象类，在SpringBoot启动的时候会发布如下的相关事件，而这些事件其实都实现了 `SpringApplicationContext`接口。

| 事件                                | 说明                       |
| ----------------------------------- | -------------------------- |
| ApplicationStartingEvent            | 容器启动的事件             |
| ApplicationEnvironmentPreparedEvent | 应用处理环境变量相关的事件 |
| ApplicationContextInitializedEvent  | 容器初始化的事件           |
| ApplicationPreparedEvent            | 应用准备的事件             |
| ApplicationFailedEvent              | 应用启动出错的事件         |
| ApplicationStartedEvent             | 应用Started状态事件        |
| ApplicationReadyEvent               | 应用准备就绪的事件         |

也就是这些事件都是属于SpringBoot启动过程中涉及到的相关的事件

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641277469000/3716d2d823e74f70a9a61a9587fe9baa.png)

当然在启动过程中还会发布其他的相关事件，大家可以自行查阅相关源码哦

##### 3.自定义事件

接下来我们通过几个自定义事件来加深下对事件监听机制的理解

###### 3.1 监听所有事件

我们先创建一个自定义监听器，来监听所有的事件。创建一个Java类，实现ApplicationListener接口在泛型中指定要监听的事件类型即可，如果要监听所有的事件，那么泛型就写ApplicationEvent。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641277469000/fb6afb1146674c2e94fa99891610751f.png)

之后为了在容器启动中能够发下我们的监听器并且添加到SimpleApplicationEventMulticaster中，我们需要在spring.factories中注册自定义的监听器

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641277469000/2bace08cd74e415a8351d4c95c1c8641.png)

这样当我们启动服务的时候就可以看到相关事件发布的时候，我们的监听器被触发了。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641277469000/b85ff088faa04871b357cda1b33abc33.png)

###### 3.1 监听特定事件

那如果是监听特定的事件呢，我们只需要在泛型出制定即可。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641277469000/70c4ba2ed30849bea2838fb8bca6abb6.png)

启动服务查看

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641277469000/cab7fbe8798c4b7595f999a231649fb1.png)

###### 3.2 自定义事件

那如果我们想要通过自定义的监听器来监听自定义的事件呢？首先创建自定义的事件类，非常简单，只需要继承ApplicationEvent即可

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641277469000/c0156f3ff75d44b5b4d689dc5dbc7bac.png)

然后在自定义的监听器中监听自定义的事件。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641277469000/b61d8c9f0320462195d2e3f342ac07dc.png)

同样的别忘了在spring.factories中注册哦

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641277469000/6643f4e7ca124a94b7450dc6cf1b29c8.png)

之后我们就可以在我们特定的业务场景中类发布对应的事件了

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641277469000/721e760f63434fba91ef64f16b71f9d8.png)

然后当我们提交请求后

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641277469000/bce4861eb66f4ebfbbada9877c64d45c.png)

可以看到对应的监听器触发了

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641277469000/beafdfe5e82042528fee0cd75edf52d6.png)

这样一来不光搞清楚了SpringBoot中的监听机制，而且也可以扩展应用到我们业务开发中了。好了本文就给大家介绍到这里，希望对你有所帮助。



### 配置文件





### 内置Tomcat

#### 一、Tomcat基础

我们想要搞清楚在SpringBoot启动中到的是如何集成的Tomcat容器，这个就需要我们先对Tomcat本身要有所了解，不然这个就没办法分析了，所以我们先来回顾下Tomcat的基础内容。Tomcat版本是8.5.73

##### 1.目录结构

先简单的回顾下一个Tomcat文件的目录结构

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641985582000/220c333eed974afcb0fbeee3bea197d7.png)

这个比较基础和简单，快速看一遍就行。

##### 2.启动流程

Tomcat的架构相关的内容在本文中不再赘述，可以查阅Tomcat源码专题的内容，我们来看下当我们要启动一个Tomcat服务，我们其实是执行的bin目录下的脚本程序，`startup.bat`和 `startup.sh`.一个是windows的脚本，一个是Linux下的脚本，同样还可以看到两个停止的脚本 `shutdown.bat` 和 `shutdown.sh`.

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641985582000/77a2a5f08c264884a9063073f4fc5f4b.png)

为了比较直观的来查看脚本的内容，我们通过VSCode来查看吧。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641985582000/533dfa39250c466db98a5b7630ef9fb4.png)

查看 `startup.bat`

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641985582000/020204598c2f429fb37da26d15751e35.png)

可以看到在这个脚本中调用了 `catalina.bat`这个脚本文件，继续进入，配置信息很多，找核心的脚本

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641985582000/13c041772ce44436850baa000114218e.png)

对应的我们进入到doStart方法中

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641985582000/810ea415a22f4cbb985446d5fb2472d1.png)

最后会执行的程序是

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641985582000/0a031b7997e442be95f4b9778e8c9ffa.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641985582000/7fd05509f8ea423d86c190fabe6f0387.png)

而这个MAINCLASS变量是前面定义的有的

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641985582000/53d0e527e29f41a482c9d80d64c76163.png)

其实前面看了这么一堆的脚本文件，都是在做一些环境的检测和运行时的参数，最终执行的是Bootstrap中的main方法。

##### 3.Bootstrap类

###### 3.1 架构图

在分析具体的源码流程之前还是需要对Tomcat的架构图要有所了解的

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641985582000/d7b2ea97a64a44dfa352b655614f3fd7.png)

###### 3.2 流程分析

接下来我们需要查看下Bootstrap中的main方法了，这时我们需要下载对应的源码文件了。可以官网自行下载。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641985582000/4dcd2cf5b95f4b3f97b599a2c1fc5ef4.png)

本文不详解介绍，只为SpringBoot中内容做铺垫。

```java
bootstrap.init(); // 初始化类加载器
bootstrap.load(); // 间接调用Catalina，创建对象树，然后调用生命周期的init方法初始化整个对象树
bootstrap.start(); // 间接调用Catalina的start方法，然后调用生命周期的start方法启动整个对象树
```

#### 二、SpringBoot中详解

##### 1.自动装配

首先我们来看下在spring.factories中注入了哪些和Web容器相关的配置类。

###### 1.1 EmbeddedWebServerFactoryCustomizerAutoConfiguration

第一个是EmbeddedWebServerFactoryCustomizerAutoConfiguration。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641985582000/6ad955b9def440a38642dfb71ed0d381.png)

查看代码，比较容易

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641985582000/cc832ec25e5143628f899e54081c0d4c.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641985582000/073ccd01abd54d49acf52eb30182f039.png)

在这个配置类里面就是根据我们的配置来内嵌对应的Web容器，比如Tomcat或者Jetty等。

###### 1.2 ServletWebServerFactoryAutoConfiguration

然后来看下ServletWebServerFactoryAutoConfiguration这个配置类。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641985582000/f4de06c39ad14006a37981cd11cc5b08.png)

首先来看下在类的头部引入和一些核心的信息

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641985582000/f1889a654caa41c99e1804fd3069abf8.png)

重点我们需要看下EmbeddedTomcat这个内部类。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641985582000/f6c696be699641cb95ae165691367cd8.png)

看到的核心其实是创建了一个TomcatServletWebServerFactory对象并注入到了Spring容器中。这块的内容非常重要，是我们后面串联的时候的一个切入点。

##### 2.启动流程

有了上面的自动配置类的支持我们就可以看看在SpringBoot的run方法中是在哪个位置帮我们内嵌了Tomcat容器呢？首先我们从SpringBoot的run方法的刷新上下文的方法进入。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641985582000/55282711a0d14bb2810a5b392fcfab17.png)

这部分其实就是Spring的核心代码了，我们进入到refresh()方法。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641985582000/6011bb9f5ee045c895e6cc22978ed67c.png)

继续进入：

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641985582000/ef4d5c6b8b744438887e0bce9c7b6640.png)

然后我们进入ServletWebServerApplicationContext对象的onRefresh方法中。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641985582000/8580555ce650489d8d3b7ad484e53a0f.png)

核心方法 createWebServer() 创建我们的Tomcat容器。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641985582000/107c6d0fd15840b7aa4b8e75826a4362.png)

可以看到，从容器中获取的工厂对象其实就我们上面注入的对象，然后根据工厂对象获取到了一个TomcatWebServer实例，也就是Tomcat服务对象。关键点我们需要看下getWebServer方法的逻辑

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641985582000/d142625dfef34d029cc1ab4e0bbcd575.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641985582000/095fee2481224aae989ff158f33697d2.png)

然后继续进入到 getTomcatWebServer方法中。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641985582000/345a830f044f492bb45a6e039f0f58b3.png)

进入构造方法查看

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641985582000/f1f0157abc14418b9d7fff8ae46b19bc.png)

进入Tomcat初始化的方法initialize方法

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641985582000/1e1b1927fb064f4aa81a20035408403d.png)

进入start方法

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641985582000/c2320be3fd014984899447c4aae9f181.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1641985582000/d9ee6b7b65f64682a32bba66f5d38729.png)

到这儿后面的逻辑其实就是Tomcat自身启动的逻辑了。这就需要你的Tomcat基础了，到这SpringBoot启动是如何内嵌Tomcat容器的到这儿就结束了哦。



## Actuator应用

#### Actuator介绍

通过前面的介绍我们明白了SpringBoot为什么能够很方便快捷的构建Web应用，那么应用部署上线后的健康问题怎么发现呢？在SpringBoot中给我们提供了Actuator来解决这个问题。

官网地址：[https://docs.spring.io/spring-boot/docs/current/reference/html/actuator.html](https://docs.spring.io/spring-boot/docs/current/reference/html/actuator.html)

> Spring Boot includes a number of additional features to help you monitor and manage your application when you push it to production. You can choose to manage and monitor your application by using HTTP endpoints or with JMX. Auditing, health, and metrics gathering can also be automatically applied to your application.
>
> Spring Boot包括许多附加特性，可以帮助您在将应用程序投入生产时监视和管理应用程序。您可以选择使用HTTP端点或使用JMX来管理和监视应用程序。审计、运行状况和度量收集也可以自动应用于您的应用程序。

使用Actuator我们需要添加依赖

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-actuator</artifactId>
</dependency>
```

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/3325ae08172f4345983edabbb346283c.png)

#### 端点(Endpoints)

  执行器端点（endpoints）可用于监控应用及与应用进行交互，Spring Boot包含很多内置的端点，你也可以添加自己的。例如，health端点提供了应用的基本健康信息。
   每个端点都可以启用或禁用。这控制着端点是否被创建，并且它的bean是否存在于应用程序上下文中。要远程访问端点，还必须通过JMX或HTTP进行暴露,大部分应用选择HTTP，端点的ID映射到一个带 `/actuator`前缀的URL。例如，health端点默认映射到 `/actuator/health`。

**注意**：
  Spring Boot 2.0的端点基础路径由“/”调整到”/actuator”下,如：`/info`调整为 `/actuator/info` 可以通过以下配置改为和旧版本一致:

```
management.endpoints.web.base-path=/
```

  默认在只放开了 `health`和 `info`两个 Endpoint。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/2be2fa41795f444fbcd11f46b90c1ecb.png)

  如果要放开更多的Endpoint，我们需要配置如下信息

```
management.endpoints.web.exposure.include=*
```

  以下是SpringBoot中提供的Endpoint。

| ID             | 描述                                                         | 默认启用 |
| -------------- | ------------------------------------------------------------ | -------- |
| auditevents    | 显示当前应用程序的审计事件信息                               | Yes      |
| beans          | 显示一个应用中 `所有Spring Beans`的完整列表                  | Yes      |
| conditions     | 显示 `配置类和自动配置类`(configuration and auto-configuration classes)的状态及它们被应用或未被应用的原因 | Yes      |
| configprops    | 显示一个所有 `@ConfigurationProperties`的集合列表            | Yes      |
| env            | 显示来自Spring的 `ConfigurableEnvironment`的属性             | Yes      |
| flyway         | 显示数据库迁移路径，如果有的话                               | Yes      |
| health         | 显示应用的 `健康信息`（当使用一个未认证连接访问时显示一个简单的’status’，使用认证连接访问则显示全部信息详情） | Yes      |
| info           | 显示任意的 `应用信息`                                        | Yes      |
| liquibase      | 展示任何Liquibase数据库迁移路径，如果有的话                  | Yes      |
| metrics        | 展示当前应用的 `metrics`信息                                 | Yes      |
| mappings       | 显示一个所有 `@RequestMapping`路径的集合列表                 | Yes      |
| scheduledtasks | 显示应用程序中的 `计划任务`                                  | Yes      |
| sessions       | 允许从Spring会话支持的会话存储中检索和删除(retrieval and deletion)用户会话。使用Spring Session对反应性Web应用程序的支持时不可用。 | Yes      |
| shutdown       | 允许应用以优雅的方式关闭（默认情况下不启用）                 | No       |
| threaddump     | 执行一个线程dump                                             | Yes      |

  shutdown端点默认是关闭的，我们可以打开它

```
# 放开 shutdown 端点
management.endpoint.shutdown.enabled=true
```

  `shutdown`只支持post方式提交，我们可以使用 `POSTMAN`来提交或者使用IDEA中提供的工具来提交。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/9963fc54eefe4a88bd8b168432d8c64f.png)

  如果使用web应用(Spring MVC, Spring WebFlux, 或者 Jersey)，你还可以使用以下端点：

| ID         | 描述                                                         | 默认启用 |
| ---------- | ------------------------------------------------------------ | -------- |
| heapdump   | 返回一个GZip压缩的 `hprof`堆dump文件                         | Yes      |
| jolokia    | 通过HTTP暴露 `JMX beans`（当Jolokia在类路径上时，WebFlux不可用） | Yes      |
| logfile    | 返回 `日志文件内容`（如果设置了logging.file或logging.path属性的话），支持使用HTTP **Range**头接收日志文件内容的部分信息 | Yes      |
| prometheus | 以可以被Prometheus服务器抓取的格式显示 `metrics`信息         | Yes      |

  现在我们看的 `health`信息比较少，如果我们需要看更详细的信息，可以配置如下

```
# health 显示详情
management.endpoint.health.show-details=always
```

  再访问测试

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/a0a26665947c4265a84e8d126c9abefa.png)

  这样一来 `health`不仅仅可以监控SpringBoot本身的状态，还可以监控其他组件的信息，比如我们开启Redis服务。

```
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-redis</artifactId>
</dependency>
```

  添加Redis的配置信息

```
# Redis的 host 信息
spring.redis.host=192.168.100.120
```

  重启服务，查看 `http://localhost:8080/actuator/health`

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/3e4ae19304364baa9f458b92013d72a9.png)

#### 3.监控类型

  介绍几个监控中比较重要的类型

##### 3.1 health

  显示的系统的健康信息，这个在上面的案例中讲解的比较多，不再赘述。

##### 3.2 metrics

  metrics 端点用来返回当前应用的各类重要度量指标，比如内存信息，线程信息，垃圾回收信息等。如下：

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/a77b0c3e670248e081e4dfa6eebeb218.png)

各个指标信息的详细描述：

| 序号       | 参数                                 | 参数说明                                            | 是否监控 | 监控手段                                                     | 重要度 |
| ---------- | ------------------------------------ | --------------------------------------------------- | -------- | ------------------------------------------------------------ | ------ |
| **JVM**    |                                      |                                                     |          |                                                              |        |
| 1          | **jvm.memory.max**                   | **JVM** 最大内存                                    |          |                                                              |        |
| 2          | **jvm.memory.committed**             | **JVM** 可用内存                                    | 是       | 展示并监控堆内存和**Metaspace**                              | 重要   |
| 3          | **jvm.memory.used**                  | **JVM** 已用内存                                    | 是       | 展示并监控堆内存和**Metaspace**                              | 重要   |
| 4          | **jvm.buffer.memory.used**           | **JVM** 缓冲区已用内存                              |          |                                                              |        |
| 5          | **jvm.buffer.count**                 | 当前缓冲区数                                        |          |                                                              |        |
| 6          | **jvm.threads.daemon**               | **JVM** 守护线程数                                  | 是       | 显示在监控页面                                               |        |
| 7          | **jvm.threads.live**                 | **JVM** 当前活跃线程数                              | 是       | 显示在监控页面；监控达到阈值时报警                           | 重要   |
| 8          | **jvm.threads.peak**                 | **JVM** 峰值线程数                                  | 是       | 显示在监控页面                                               |        |
| 9          | **jvm.classes.loaded**               | 加载**classes** 数                                  |          |                                                              |        |
| 10         | **jvm.classes.unloaded**             | 未加载的**classes** 数                              |          |                                                              |        |
| 11         | **jvm.gc.memory.allocated**          | **GC** 时，年轻代分配的内存空间                     |          |                                                              |        |
| 12         | **jvm.gc.memory.promoted**           | **GC** 时，老年代分配的内存空间                     |          |                                                              |        |
| 13         | **jvm.gc.max.data.size**             | **GC** 时，老年代的最大内存空间                     |          |                                                              |        |
| 14         | **jvm.gc.live.data.size**            | **FullGC** 时，老年代的内存空间                     |          |                                                              |        |
| 15         | **jvm.gc.pause**                     | **GC** 耗时                                         | 是       | 显示在监控页面                                               |        |
| **TOMCAT** |                                      |                                                     |          |                                                              |        |
| 16         | **tomcat.sessions.created**          | **tomcat** 已创建 **session** 数                    |          |                                                              |        |
| 17         | **tomcat.sessions.expired**          | **tomcat** 已过期 **session** 数                    |          |                                                              |        |
| 18         | **tomcat.sessions.active.current**   | **tomcat** 活跃 **session** 数                      |          |                                                              |        |
| 19         | **tomcat.sessions.active.max**       | **tomcat** 最多活跃 **session** 数                  | 是       | 显示在监控页面，超过阈值可报警或者进行动态扩容               | 重要   |
| 20         | **tomcat.sessions.alive.max.second** | **tomcat** 最多活跃 **session** 数持续时间          |          |                                                              |        |
| 21         | **tomcat.sessions.rejected**         | 超过**session** 最大配置后，拒绝的 **session** 个数 | 是       | 显示在监控页面，方便分析问题                                 |        |
| 22         | **tomcat.global.error**              | 错误总数                                            | 是       | 显示在监控页面，方便分析问题                                 |        |
| 23         | **tomcat.global.sent**               | 发送的字节数                                        |          |                                                              |        |
| 24         | **tomcat.global.request.max**        | **request** 最长时间                                |          |                                                              |        |
| 25         | **tomcat.global.request**            | 全局**request** 次数和时间                          |          |                                                              |        |
| 26         | **tomcat.global.received**           | 全局**received** 次数和时间                         |          |                                                              |        |
| 27         | **tomcat.servlet.request**           | **servlet** 的请求次数和时间                        |          |                                                              |        |
| 28         | **tomcat.servlet.error**             | **servlet** 发生错误总数                            |          |                                                              |        |
| 29         | **tomcat.servlet.request.max**       | **servlet** 请求最长时间                            |          |                                                              |        |
| 30         | **tomcat.threads.busy**              | **tomcat** 繁忙线程                                 | 是       | 显示在监控页面，据此检查是否有线程夯住                       |        |
| 31         | **tomcat.threads.current**           | **tomcat** 当前线程数（包括守护线程）               | 是       | 显示在监控页面                                               | 重要   |
| 32         | **tomcat.threads.config.max**        | **tomcat** 配置的线程最大数                         | 是       | 显示在监控页面                                               | 重要   |
| 33         | **tomcat.cache.access**              | **tomcat** 读取缓存次数                             |          |                                                              |        |
| 34         | **tomcat.cache.hit**                 | **tomcat** 缓存命中次数                             |          |                                                              |        |
| **CPU**    |                                      |                                                     |          |                                                              |        |
| 35         | **system.cpu.count**                 | **CPU** 数量                                        |          |                                                              |        |
| 36         | **system.load.average.1m**           | **load average**                                    | 是       | 超过阈值报警                                                 | 重要   |
| 37         | **system.cpu.usage**                 | 系统**CPU** 使用率                                  |          |                                                              |        |
| 38         | **process.cpu.usage**                | 当前进程**CPU** 使用率                              | 是       | 超过阈值报警                                                 |        |
| 39         | **http.server.requests**             | **http** 请求调用情况                               | 是       | 显示**10** 个请求量最大，耗时最长的 **URL**；统计非 **200** 的请求量 | 重要   |
| 40         | **process.uptime**                   | 应用已运行时间                                      | 是       | 显示在监控页面                                               |        |
| 41         | **process.files.max**                | 允许最大句柄数                                      | 是       | 配合当前打开句柄数使用                                       |        |
| 42         | **process.start.time**               | 应用启动时间点                                      | 是       | 显示在监控页面                                               |        |
| 43         | **process.files.open**               | 当前打开句柄数                                      | 是       | 监控文件句柄使用率，超过阈值后报警                           | 重要   |

如果要查看具体的度量信息的话，直接在访问地址后面加上度量信息即可：

```
http://localhost:8080/actuator/metrics/jvm.buffer.memory.used
```

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/a84345f8807249afbfa0513d257612f6.png)

**添加自定义的统计指标**

  

```
@RestController
public class UserController {

    static final Counter userCounter = Metrics.counter("user.counter.total","services","bobo");
    private Timer timer = Metrics.timer("user.test.timer","timer","timersample");
    private DistributionSummary summary = Metrics.summary("user.test.summary","summary","summarysample");

    @GetMapping("/hello")
    public String hello(){
        // Gauge
        Metrics.gauge("user.test.gauge",8);
        // Counter
        userCounter.increment(1);
        // timer
        timer.record(()->{
            try {
                Thread.sleep(3000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        });

        summary.record(2);
        summary.record(3);
        summary.record(4);
        return "Hello";
    }
}
```

访问 [http://localhost:8080/hello](http://localhost:8080/hello) 这个请求后在看 metrics 信息



![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/3dfa0e6fd79e49bab6d7dca4c42a3d0a.png)

多出了我们自定义的度量信息。

##### 3.3 loggers

  loggers是用来查看当前项目每个包的日志级别的。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/18a95e6a972d4a938d34a8aaaf9c8621.png)

默认的是info级别。

修改日志级别：

发送POST请求到 [http://localhost:8080/actuator/loggers/](http://localhost:8080/actuator/loggers/)[包路径]

请求参数为

```
{
    "configuredLevel":"DEBUG"
}
```

通过POSTMAN来发送消息

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/bcc5a6b4baea43a1bc9b91658d0223ea.png)

然后再查看日志级别发现已经变动了

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/c57556b887004522b31a255095513aae.png)

控制台也可以看到

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/5c6a858e94fb4013983689197c63dd77.png)

##### 3.4 info

  显示任意的应用信息。我们可以在 properties 中来定义

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/9c30771845d04bfd905156365ea46ebe.png)

访问：[http://localhost:8080/actuator/info](http://localhost:8080/actuator/info)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/af1b3d994ae34c5a8b462c21f70768a6.png)

#### 4.定制端点

##### 4.1 定制Health端点

一般主流的框架组件都会提供对应的健康状态的端点，比如MySQL，Redis，Nacos等，但有时候我们自己业务系统或者自己封装的组件需要被健康检查怎么办，这时我们也可以自己来定义。先来看看 diskSpace磁盘状态的

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/864e7bfce119485498043dca60ede426.png)

对应的端点是 DiskSpaceHealthIndicator

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/c742eeda1cf642d2a697e90128b083a7.png)

有了上面的案例我们就可以自定义一个监控的健康状态的端点了。

```java
/**
 * 自定义的health端点
 */
@Component
public class DpbHealthIndicator extends AbstractHealthIndicator {
    @Override
    protected void doHealthCheck(Health.Builder builder) throws Exception {
        boolean check = doCheck();
        if(check){
            builder.up();
        }else {
            builder.down();
        }
        builder.withDetail("total",666).withDetail("msg","自定义的HealthIndicator");

    }

    private boolean doCheck() {
        return true;
    }
}

```


启动服务

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/5855e0e354a74b2a9048d296940b747d.png)

在admin中也可以监控到

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/ad36c03b52654e6ab614c39bf5c8394e.png)


##### 4.2 定制info端点

info节点默认情况下就是空的

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/d226358228a745e88a9559e51fc35165.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/96a01e6c46694c82a1c9f823c5215f1d.png)

这时我们可以通过info自定义来添加我们需要展示的信息，实现方式有两种

###### 1.编写配置文件

在属性文件中配置

```properties
info.author=bobo
info.serverName=ActuatorDemo1
info.versin=6.6.6
info.mavneProjectName=@project.artifactId@
```

重启服务

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/13f30b1e90a04e66a6fb187e9d91ca96.png)

admin中也一样

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/8632bdebc63343cfa921380626297a12.png)


###### 2.编写InfoContributor

上面的方式是直接写在配置文件中的，不够灵活，这时我们可以在自定义的Java类中类实现

```java
/**
 * 自定义info 信息
 */
@Component
public class DpbInfo implements InfoContributor {
    @Override
    public void contribute(Info.Builder builder) {
        builder.withDetail("msg","hello")
                .withDetail("时间",new Date())
                .withDetail("地址","湖南长沙");
    }
}
```

然后启动测试

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/afb254a75cf64a979385061936e07077.png)




##### 4.3 定制Metrics端点

除了使用metrics端点默认的这些统计指标外，我们还可以实现自定义统计指标，metrics提供了4中基本的度量类型：

* gauge 计量器，最简单的度量类型，只有一个简单的返回值，他用来记录一些对象或者事物的瞬时值。
* Counter 计数器 简单理解就是一种只增不减的计数器，它通常用于记录服务的请求数量，完成的任务数量，错误的发生数量
* Timer 计时器 可以同时测量一个特定的代码逻辑块的调用（执行）速度和它的时间分布。简单来说，就是在调用结束的时间点记录整个调用块执行的总时间，适用于测量短时间执行的事件的耗时分布，例如消息队列消息的消费速率。
* Summary 摘要 用于跟踪事件的分布。它类似于一个计时器，但更一般的情况是，它的大小并不一定是一段时间的测量值。在**micrometer** 中，对应的类是**DistributionSummary**，它的用法有点像**Timer**，但是记录的值是需要直接指定，而不是通过测量一个任务的执行时间。

测试：

```java
    @GetMapping("/hello")
    public String hello(String username){
        // 记录单个值，比如统计 MQ的消费者的数量
        Metrics.gauge("dpb.gauge",100);
        // 统计次数
        Metrics.counter("dpb.counter","username",username).increment();
        // Timer 统计代码执行的时间
         Metrics.timer("dpb.Timer").record(()->{
             // 统计业务代码执行的时间
             try {
                 Thread.sleep(new Random().nextInt(999));
             } catch (InterruptedException e) {
                 e.printStackTrace();
             }
         });

         Metrics.summary("dpb.summary").record(2.5);
       
        return "hello";
    }
```

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/0759c8cb2e524fc7ad75315877d653dc.png)

查看具体的指标信息

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/647e822bdcdd4c289735a8a5365b1f0b.png)

查看对应的tag信息

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/c9806ed3c683411c812394b901e62f46.png)



##### 4.4自定义Endpoint

  如果我们需要扩展Endpoint，这时我们可以自定义实现，我们可以在类的头部定义如下的注解

> @Endpoint
> @WebEndpoint
> @ControllerEndpoint
> @RestControllerEndpoint
> @ServletEndpoint

  再给方法添加@ReadOperation，@ WritOperation或@DeleteOperation注释后，该方法将通过JMX自动公开，并且在Web应用程序中也通过HTTP公开。

于方法的注解有以下三种，分别对应get post delete 请求

| Operation        | HTTP method |
| ---------------- | ----------- |
| @ReadOperation   | GET         |
| @WriteOperation  | POST        |
| @DeleteOperation | DELETE      |

案例：

```java
@Component
@Endpoint(id = "dpb.sessions")
public class DpbEndpoint {
    Map<String,Object> map = new HashMap<>();
    /**
     * 读取操作
     * @return
     */
    @ReadOperation
    public Map<String,Object> query(){

        map.put("username","dpb");
        map.put("age",18);
        return map;
    }

    @WriteOperation
    public void save( String address){
        map.put("address",address);
    }
}
```



![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/2ac84ab3442f4d29856d0479ad7b0ea8.png)

写入操作：

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/c20b41933ec744cbb360a485e7259bf7.png)


![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/a13f2709ef9449b6b1c7ccebd446b806.png)


#### 5.Actuator的两种监控形态

* http
* jmx  [Java Management Extensions] Java管理扩展

放开jmx

```
# 放开 jmx 的 endpoint
management.endpoints.jmx.exposure.include=*
spring.jmx.enabled=true
```

通过jdk中提供的jconsole来查看

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/47a9d2cf36da4f77aa803af3c435363d.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/fe60ba967174455eb37ea207527f07c9.png)

#### 6.监控系统

  SpringBoot可以收集监控数据，但是查看不是很方便，这时我们可以选择开源的监控系统来解决，比如Prometheus

* 数据采集
* 数据存储
* 可视化

  Prometheus在可视化方面效果不是很好，可以使用grafana来实现

##### 6.1 Prometheus

  先来安装Prometheus：官网：[https://prometheus.io/download/](https://prometheus.io/download/) 然后通过wget命令来直接下载

```
wget https://github.com/prometheus/prometheus/releases/download/v2.28.1/prometheus-2.28.1.linux-amd64.tar.gz
```

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/c4657c6ea4724504b9c8d1fb43dbf939.png)

然后配置Prometheus。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/edf4446604bb4f40943dcac959a1f6d2.png)

```
  - job_name: 'Prometheus'
    static_configs:
    metrics_path: '/actuator/prometheus'
    scrape_interval: 5s
    - targets: ['192.168.127.1:8080']
      labels:
        instance: Prometheus

```

* job_name：任务名称
* metrics_path： 指标路径
* targets：实例地址/项目地址，可配置多个
* scrape_interval： 多久采集一次
* scrape_timeout： 采集超时时间

执行脚本启动应用 boge_java

```
./prometheus --config.file=prometheus.yml
```

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/734fbaef8db44b3281817cc471a4484b.png)

访问应用： [http://ip:9090](http://ip:9090)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/6874dd4f5370495488e3385c05bba259.png)

然后在我们的SpringBoot服务中添加 Prometheus的端点,先添加必要的依赖

```
        <dependency>
            <groupId>io.micrometer</groupId>
            <artifactId>micrometer-registry-prometheus</artifactId>
        </dependency>
```

然后就会有该端点信息

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/28ae5b00f4e84066ba44ed2a8d1d02db.png)

Prometheus服务器可以周期性的爬取这个endpoint来获取metrics数据,然后可以看到

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/d6faf9272892400db17cc4e46f0e6111.png)

##### 6.2 Grafana

  可视化工具：[https://grafana.com/grafana/download](https://grafana.com/grafana/download)

通过wget命令下载

```
wget https://dl.grafana.com/oss/release/grafana-8.0.6-1.x86_64.rpm
sudo yum install grafana-8.0.6-1.x86_64.rpm
```

启动命令

```
sudo service grafana-server start
sudo service grafana-server status
```

访问的地址是 [http://ip:3000](http://ip:3000)  默认的帐号密码 admin/admin

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/fd9f6b4302ec4f9cb602ad58b24a67fa.png)

登录进来后的页面

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/7fb4ce890d524c4d994414b43e5dd4f8.png)

添加数据源：

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/dcb985dce95e45b896e9409cd3eaa591.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/8b89fb6e4d50413281e2e99df2383f12.png)

添加Dashboards  [https://grafana.com/grafana/dashboards](https://grafana.com/grafana/dashboards)  搜索SpringBoot的 Dashboards

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/3103c5f681c641c09ee42469001ea5b6.png)

找到Dashboards的ID

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/416c50934ffc48a784ba6650d8c2a9db.png)

然后导入即可

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/dfe09cde8db241e5bd9412a105c30182.png)

点击Load出现如下界面

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/f1f7353953d346d28c7e61eb0dee551c.png)

然后就可以看到对应的监控数据了

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/f9d1097cc7374dda9bb75d348b308c94.png)

#### 6.3 SpringBoot Admin

基于SpringBootAdmin的开源产品很多，我们选择这个:https://github.com/codecentric/spring-boot-admin

##### 6.3.1 搭建Admin服务器

创建建对应的SpringBoot项目，添加相关依赖

```xml
        <dependency>
            <groupId>de.codecentric</groupId>
            <artifactId>spring-boot-admin-starter-server</artifactId>
            <version>2.5.1</version>
        </dependency>
```

然后放开Admin服务即可

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/f5d90d07c2044bbda753b81d072ce0e7.png)

然后启动服务，即可访问

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/416169d6102946c3bb51d67a00efada2.png)

这个时候没有服务注册，所以是空的，这时我们可以创建对应的客户端来监控

##### 6.3.2 客户端配置

创建一个SpringBoot项目整合Actuator后添加Admin的客户端依赖

```xml
        <dependency>
            <groupId>de.codecentric</groupId>
            <artifactId>spring-boot-admin-starter-client</artifactId>
            <version>2.5.1</version>
        </dependency>
```

然后在属性文件中添加服务端的配置和Actuator的基本配置

```properties
server.port=8081
# 配置 SpringBoot Admin 服务端的地址
spring.boot.admin.client.url=http://localhost:8080
# Actuator的基本配置
management.endpoints.web.exposure.include=*
```

然后我们再刷新Admin的服务端页面

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/1c217aeb23194590bf66a5f7f3e12358.png)

那么我们就可以在这个可视化的界面来处理操作了

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/15b1eca7a0eb472b938eb6ed4499f998.png)

##### 6.3.3 服务状态

我们可以监控下MySQL的状态，先添加对应的依赖

```xml
        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-jdbc</artifactId>
        </dependency>
```

然后添加对应的jdbc配置

```properties
spring.datasource.driverClassName=com.mysql.cj.jdbc.Driver
spring.datasource.url=jdbc:mysql://localhost:3306/mysql-base?serverTimezone=UTC&useUnicode=true&characterEncoding=utf-8&useSSL=true
spring.datasource.username=root
spring.datasource.password=123456
```

然后我们在Admin中的health中就可以看到对应的数据库连接信息

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/ce15ab68845d470bb4fcdd26aca96929.png)

注意当我把MySQL数据库关闭后，我们来看看

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/1677da6e4f6444e68b9e8fa3475cc33c.png)

我们可以看到Admin中的应用墙变灰了

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/8843ecd87c344526bb9100840ca8a629.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/450b97c1cf8b43d5a57e1390542a97bf.png)

启动服务后，发现又正常了，然后我们修改下数据库连接的超时时间

```properties
# 数据库连接超时时间
spring.datasource.hikari.connection-timeout=2000
```

关闭数据库后，我们发下应用变红了

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/9ba464e3d8a14b99a14bc9a74609985f.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/9f5e6f53b7704f53ae35f1028839ed99.png)

设置数据库连接超时后即可在有效的时间内发下应用的状态。

* 绿色：正常状态
* 灰色：连接客户端健康信息超时
* 红色：可以看到具体的异常信息

##### 6.3.4 安全防护

其实我们可以发现在SpringBootAdmin的管理页面中我们是可以做很多的操作的，这时如果别人知道了对应的访问地址，想想是不是就觉得恐怖，所以必要的安全防护还是很有必要的，我们来看看具体应该怎么来处理呢？

由于在分布式 web 应用程序中有几种解决身份验证和授权的方法，Spring Boot Admin 没有提供默认的方法。默认情况下，spring-boot-admin-server-ui 提供了一个登录页面和一个注销按钮。

导入依赖：

```xml
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-security</artifactId>
        </dependency>
```

然后添加对应的配置类

```java
package com.bobo.admin.config;

import de.codecentric.boot.admin.server.config.AdminServerProperties;
import org.springframework.boot.autoconfigure.security.SecurityProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.security.web.csrf.CookieCsrfTokenRepository;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import java.util.UUID;

@Configuration(proxyBeanMethods = false)
public class SecuritySecureConfig extends WebSecurityConfigurerAdapter {
    private final AdminServerProperties adminServer;

    private final SecurityProperties security;

    public SecuritySecureConfig(AdminServerProperties adminServer, SecurityProperties security) {
        this.adminServer = adminServer;
        this.security = security;
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        SavedRequestAwareAuthenticationSuccessHandler successHandler = new SavedRequestAwareAuthenticationSuccessHandler();
        successHandler.setTargetUrlParameter("redirectTo");
        successHandler.setDefaultTargetUrl(this.adminServer.path("/"));

        http.authorizeRequests(
                (authorizeRequests) -> authorizeRequests.antMatchers(this.adminServer.path("/assets/**")).permitAll()
                        .antMatchers(this.adminServer.path("/actuator/info")).permitAll()
                        .antMatchers(this.adminServer.path("/actuator/health")).permitAll()
                        .antMatchers(this.adminServer.path("/login")).permitAll().anyRequest().authenticated()
        ).formLogin(
                (formLogin) -> formLogin.loginPage(this.adminServer.path("/login")).successHandler(successHandler).and()
        ).logout((logout) -> logout.logoutUrl(this.adminServer.path("/logout"))).httpBasic(Customizer.withDefaults())
                .csrf((csrf) -> csrf.csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse())
                        .ignoringRequestMatchers(
                                new AntPathRequestMatcher(this.adminServer.path("/instances"),
                                        HttpMethod.POST.toString()),
                                new AntPathRequestMatcher(this.adminServer.path("/instances/*"),
                                        HttpMethod.DELETE.toString()),
                                new AntPathRequestMatcher(this.adminServer.path("/actuator/**"))
                        ))
                .rememberMe((rememberMe) -> rememberMe.key(UUID.randomUUID().toString()).tokenValiditySeconds(1209600));
    }

    // Required to provide UserDetailsService for "remember functionality"
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.inMemoryAuthentication().withUser(security.getUser().getName())
                .password("{noop}" + security.getUser().getPassword()).roles("USER");
    }
}

```

然后对应的设置登录的账号密码

```properties
spring.security.user.name=user
spring.security.user.password=123456
```

然后访问Admin管理页面

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/4f46b812c08d44aba1c850f26e222ea8.png)

输入账号密码后可以进入，但是没有监控的应用了

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/8461efb548f14036a700c07c009eb39b.png)

原因是被监控的服务要连接到Admin服务端也是需要认证的

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/e5f517ef4a37487d90f3a5518160a48b.png)

我们在客户端配置连接的账号密码即可

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/60388acc52a64f47ae511ad34554e9f4.png)

重启后访问Admin服务管理页面

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/674848b6367d4d9e8739d23cf3f59c8b.png)

搞定

##### 6.3.5 注册中心

实际开发的时候我们可以需要涉及到的应用非常多，我们也都会把服务注册到注册中心中，比如nacos，Eureka等，接下来我们看看如何通过注册中心来集成客户端。就不需要每个客户端来集成了。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/4c77c39ec1994161a7b4a11a5cb28a13.png)

变为下面的场景

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/50346be5bebb4c7a9a83419c9cabd399.png)

那么我们需要先启动一个注册中心服务，我们以Nacos为例

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/00089c3909f94ecb87588337a386c27a.png)

然后访问下Nacos服务

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/cc684076866b4e499b1535f0e94e6c4f.png)

暂时还没有服务注册，这时我们可以注册几个服务，用我之前写过的案例来演示。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/de2a39649d7343fea6bbe040305424b9.png)

每个服务处理需要添加Nacos的注册中心配置外，我们还需要添加Actuator的配置

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/763bdeb99b3846919a3501da60fd50dc.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/472f99348de1409796dd05927893c72e.png)

然后启动相关的服务，可以看到相关的服务

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/b553bcedb6bd421db13709c0172d744b.png)

然后我们需要配置下Admin中的nacos

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>com.bobo</groupId>
        <artifactId>ActuatorDemo</artifactId>
        <version>1.0-SNAPSHOT</version>
        <relativePath/> <!-- lookup parent from repository -->
    </parent>
    <groupId>com.bobo</groupId>
    <artifactId>AdminServer</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>AdminServer</name>
    <description>Demo project for Spring Boot</description>
    <properties>
        <java.version>1.8</java.version>
        <spring-cloud.version>2020.0.1</spring-cloud.version>
    </properties>
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>

        <dependency>
            <groupId>de.codecentric</groupId>
            <artifactId>spring-boot-admin-starter-server</artifactId>
            <version>2.5.1</version>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-security</artifactId>
        </dependency>
        <dependency>
            <groupId>com.alibaba.cloud</groupId>
            <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>

    <dependencyManagement>
        <dependencies>
            <dependency>
                <groupId>org.springframework.cloud</groupId>
                <artifactId>spring-cloud-dependencies</artifactId>
                <version>${spring-cloud.version}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
                <dependency>
                    <groupId>com.alibaba.cloud</groupId>
                    <artifactId>spring-cloud-alibaba-dependencies</artifactId>
                    <version>2021.1</version>
                    <type>pom</type>
                    <scope>import</scope>
                </dependency>
        </dependencies>
    </dependencyManagement>

</project>

```

```properties
spring.application.name=spring-boot-admin-server
spring.cloud.nacos.discovery.server-addr=192.168.56.100:8848
spring.cloud.nacos.discovery.username=nacos
spring.cloud.nacos.discovery.password=nacos
```

启动服务，我们就可以看到对应的服务了

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/93387b084b5346ae8d60aed09191a761.png)

要查看服务的详细监控信息，我们需要配置对应的Actuator属性

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/75beaeb5afbb4d32b86ea54566def4ef.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/76cfb02756644eb68e44690c473fef38.png)

好了注册中心处理这块就介绍到这里

##### 6.3.6 邮件通知

如果监控的服务出现了问题，下线了，我们希望通过邮箱通知的方式来告诉维护人员，

```xml
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-mail</artifactId>
        </dependency>
```

然后配置对应的邮箱信息

```properties
# 使用的邮箱服务  qq 163等
spring.mail.host=smtp.qq.com
# 发送者
spring.mail.username=279583842@qq.com
# 授权码
spring.mail.password=rhcqzhfslkwjcach
#收件人
spring.boot.admin.notify.mail.to=1226203418@qq.com
#发件人
spring.boot.admin.notify.mail.from=279583842@qq.com

```

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/029b266be465485ea614f5de51c9bafb.png)

发送短信开启

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/a5cb4b062d6e4fceafbc5b4b02890d11.png)

然后启动服务

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/fac20ddecf7a4a709c8caa4d5e7d58f1.png)

然后我们关闭服务然后查看服务和邮箱信息

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/3244ed3739e64e54a8137483c70adcca.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/dcb0488829184ebeb26cf59bb2398714.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/1462/1643100783000/1a8efd2a6fd94e57b67684bcd762f79c.png)

好了对应的邮箱通知就介绍到这里，其他的通知方式可以参考官方网站





