# ORM

## ORM简介

什么是ORM？ORM即Object Relational Mapping ，就是是对象关系映射。将数据库中对象映射到面向对象编程语言中的对象。使得开发人员可以用操作对象的方式来操作数据库，从而屏蔽数据库之间的差异。

## 优点


数据模型都在一个地方定义，更容易更新和维护，也利于重用代码

ORM 有现成的工具，很多功能都可以自动完成，比如：数据消毒、预处理、事务等等。

> 数据消毒是指对用户输入的数据进行处理，以防止恶意数据或不合法数据对应用程序的攻击或错误影响。常见的数据消毒操作包括转义特殊字符、验证输入、限制输入长度等。ORM框架可以做参数化查询、数据类型验证等可以实现数据消毒

更适合MVC 架构，ORM 就是天然的 Model，使代码更加清晰。

基于 ORM 的业务代码比较简单，代码量少，语义性好，容易理解。不必编写性能不佳的 SQL。

## 缺点

ORM库本身是有学习成本，需要花精力学习和配置，不是轻量级工具。

对于复杂的查询，ORM可能无法表达，或者性能不如原生的 SQL。

ORM减少了开发者对数据库层的直接操作，开发者对数据库底层的认识也减少了，需要写复杂SQL时变的更加困难。

## ORM工具

Hibernate，Mybatis，MybatisPlus，Spring Data JPA

### Spring Data JPA

spirng data jpa是spring提供的一套简化JPA开发的框架，按照约定好的【方法命名规则】写dao层接口，就可以在不写接口实现的情况下，实现对数据库的访问和操作。同时提供了很多除了CRUD之外的功能，如分页、排序、复杂查询等等。

Spring Data JPA 可以理解为 JPA 规范的再次封装抽象，底层还是使用了 Hibernate 的 JPA 技术实现。

### gaarason

-  让连接数据库以及对数据库进行增删改查操作变得非常简单，不论希望使用原生 SQL、还是查询构造器，还是 Eloquent ORM。 
-  Eloquent ORM 提供一个美观、简单的与数据库打交道的 ActiveRecord  实现，每个数据表都对应一个与该表数据结构对应的实体（Entity），以及的进行交互的模型（Model），通过模型类，你可以对数据表进行查询、插入、更新、删除等操作，并将结果反映到实体实例化的 java 对象中。
-  对于关联关系 Eloquent ORM 提供了富有表现力的声明方式，与简洁的使用方法，并专注在内部进行查询与内存优化，在复杂的关系中有仍然有着良好的体验。
-  兼容于其他常见的 ORM 框架, 以及常见的数据源 (DataSource)

### 

# Mybatis

## 参考说明

本文内容主要来源于马士兵教育视频教程（[Mybatis源码精讲-连鹏举](https://www.mashibing.com/study?courseNo=286&sectionNo=35746&courseVersionId=1242)），结合了老师的讲课内容以及自己的实践做了一些修改。



## 架构

1. Configuration，配置文件
   1. 框架配置文件，mybatis-config.xml
      1. 数据源，DataSource
      2. 事务管理器，TransactionManager
      3. mapper文件配置，mappers
   2. mapper配置文件，存储sql
2. StatementHandler，封装SQL和参数。
3. 执行器，执行SQL
4. ResultSetHandler，将执行结果映射成为实体类。



## 配置

Mybatis所有支持的配置参考[官网说明](https://mybatis.org/mybatis-3/zh/configuration.html)。



## 源码解析

### 前置知识

#### JDBC使用步骤

1. 加载驱动
2. 获取连接
3. 创建sql语句
4. 获取Statement对象
5. 执行sql语句
6. 处理结果集
7. 关闭连接



#### Mybatis使用步骤

1. 创建xml配置文件
2. 搞个mapper接口
3. SqlSessionFactory
4. SqlSession



### 前置准备

- 下载Mybatis源码。可以下载官方的，也可以下载别人写好注释的版本。如果看视频学习源码，推荐下载老师提供的版本。
- 准备好一个可以连接的数据库，有表有数据。例如：MySQL自带demo数据库，有一张emp表。
- 参考[官方入门案例](https://mybatis.org/mybatis-3/zh/getting-started.html)，创建好实体类，mapper，mybatis-config.xml以及测试启动代码。

本文使用的马士兵连老师的注释版本，载入之后修改maven路径，等他依赖包下载完毕就可以开始debug了。



### 框架脉络

强烈建议，看框架源码时，先梳理脉络，再去抠细节。千万别每看到一行就点进去。不断的层层深入到方法细节中。这样看很容易晕的。可以根据老师的注释，或者方法名，或者方法注释等猜测方法意图。看完当前方法内部的所有细节再点到某一行的细节中，这样逐层深入看源码效果会提升很多。

所以我们可以先使用一个简单的案例，来初步理清楚Mybatis源码的脉络。



### 配置文件解析

配置文件对应的类：Configuration

入口方法：

```java
SqlSessionFactory sqlSessionFactory = null;

@Before
public void init() throws Exception{
    // 根据全局配置文件创建出SqlSessionFactory
    // SqlSessionFactory:负责创建SqlSession对象的工厂
    // SqlSession:表示跟数据库建议的一次会话
    String resource = "mybatis-config.xml";
    InputStream inputStream = Resources.getResourceAsStream(resource);
    sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
}
```

#### Configuration类解析

源码

```java
/**
 * Mybatis全局配置类
 */
public class Configuration {

  //环境信息
  protected Environment environment;

  //---------以下设置项对应<settings>节点，可以在官网找到-------
  protected boolean safeRowBoundsEnabled;
  protected boolean safeResultHandlerEnabled = true;
  protected boolean mapUnderscoreToCamelCase;
  protected boolean aggressiveLazyLoading;
  protected boolean multipleResultSetsEnabled = true;
  protected boolean useGeneratedKeys;
  protected boolean useColumnLabel = true;
  //默认启用缓存
  protected boolean cacheEnabled = true;
  protected boolean callSettersOnNulls;
  protected boolean useActualParamName = true;
  protected boolean returnInstanceForEmptyRow;
  protected boolean shrinkWhitespacesInSql;

  protected String logPrefix;
  protected Class<? extends Log> logImpl;
  protected Class<? extends VFS> vfsImpl;
  protected Class<?> defaultSqlProviderType;
  protected LocalCacheScope localCacheScope = LocalCacheScope.SESSION;
  protected JdbcType jdbcTypeForNull = JdbcType.OTHER;
  protected Set<String> lazyLoadTriggerMethods = new HashSet<>(Arrays.asList("equals", "clone", "hashCode", "toString"));
  protected Integer defaultStatementTimeout;
  protected Integer defaultFetchSize;
  protected ResultSetType defaultResultSetType;
  //默认为简单执行器
  protected ExecutorType defaultExecutorType = ExecutorType.SIMPLE;
  protected AutoMappingBehavior autoMappingBehavior = AutoMappingBehavior.PARTIAL;
  protected AutoMappingUnknownColumnBehavior autoMappingUnknownColumnBehavior = AutoMappingUnknownColumnBehavior.NONE;
  //---------以上都是<settings>节点-------
  protected Properties variables = new Properties();
  //对象工厂和对象包装器工厂
  protected ReflectorFactory reflectorFactory = new DefaultReflectorFactory();
  protected ObjectFactory objectFactory = new DefaultObjectFactory();
  protected ObjectWrapperFactory objectWrapperFactory = new DefaultObjectWrapperFactory();

  //默认禁用延迟加载
  protected boolean lazyLoadingEnabled = false;
  protected ProxyFactory proxyFactory = new JavassistProxyFactory(); // #224 Using internal Javassist instead of OGNL

  protected String databaseId;
  /**
   * Configuration factory class.
   * Used to create Configuration for loading deserialized unread properties.
   *
   * @see <a href='https://github.com/mybatis/old-google-code-issues/issues/300'>Issue 300 (google code)</a>
   */
  protected Class<?> configurationFactory;

  //Mapper注册器，负责对mapper进行新增和查询
  protected final MapperRegistry mapperRegistry = new MapperRegistry(this);
  //拦截器链
  protected final InterceptorChain interceptorChain = new InterceptorChain();
  //类型处理器注册机（里面注册了每一种JdbcType和java类型的处理类）
  protected final TypeHandlerRegistry typeHandlerRegistry = new TypeHandlerRegistry(this);
  //类型别名注册机
  protected final TypeAliasRegistry typeAliasRegistry = new TypeAliasRegistry();
  protected final LanguageDriverRegistry languageRegistry = new LanguageDriverRegistry();

  //映射的语句,存在Map里
  protected final Map<String, MappedStatement> mappedStatements = new StrictMap<MappedStatement>("Mapped Statements collection")
      .conflictMessageProducer((savedValue, targetValue) ->
          ". please check " + savedValue.getResource() + " and " + targetValue.getResource());
  //缓存,存在Map里
  protected final Map<String, Cache> caches = new StrictMap<>("Caches collection");
  //结果映射,存在Map里
  protected final Map<String, ResultMap> resultMaps = new StrictMap<>("Result Maps collection");
  protected final Map<String, ParameterMap> parameterMaps = new StrictMap<>("Parameter Maps collection");
  protected final Map<String, KeyGenerator> keyGenerators = new StrictMap<>("Key Generators collection");

  protected final Set<String> loadedResources = new HashSet<>();
  protected final Map<String, XNode> sqlFragments = new StrictMap<>("XML fragments parsed from previous mappers");

  //不完整的SQL语句
  protected final Collection<XMLStatementBuilder> incompleteStatements = new LinkedList<>();
  protected final Collection<CacheRefResolver> incompleteCacheRefs = new LinkedList<>();
  protected final Collection<ResultMapResolver> incompleteResultMaps = new LinkedList<>();
  protected final Collection<MethodResolver> incompleteMethods = new LinkedList<>();

  /*
   * A map holds cache-ref relationship. The key is the namespace that
   * references a cache bound to another namespace and the value is the
   * namespace which the actual cache is bound to.
   */
  protected final Map<String, String> cacheRefMap = new HashMap<>();

  public Configuration(Environment environment) {
    this();
    this.environment = environment;
  }

  public Configuration() {
      //注册别名和java类之间的关系
    typeAliasRegistry.registerAlias("JDBC", JdbcTransactionFactory.class);
    typeAliasRegistry.registerAlias("MANAGED", ManagedTransactionFactory.class);

    typeAliasRegistry.registerAlias("JNDI", JndiDataSourceFactory.class);
    typeAliasRegistry.registerAlias("POOLED", PooledDataSourceFactory.class);
    typeAliasRegistry.registerAlias("UNPOOLED", UnpooledDataSourceFactory.class);

    typeAliasRegistry.registerAlias("PERPETUAL", PerpetualCache.class);
    typeAliasRegistry.registerAlias("FIFO", FifoCache.class);
    typeAliasRegistry.registerAlias("LRU", LruCache.class);
    typeAliasRegistry.registerAlias("SOFT", SoftCache.class);
    typeAliasRegistry.registerAlias("WEAK", WeakCache.class);

    typeAliasRegistry.registerAlias("DB_VENDOR", VendorDatabaseIdProvider.class);

    typeAliasRegistry.registerAlias("XML", XMLLanguageDriver.class);
    typeAliasRegistry.registerAlias("RAW", RawLanguageDriver.class);

    typeAliasRegistry.registerAlias("SLF4J", Slf4jImpl.class);
    typeAliasRegistry.registerAlias("COMMONS_LOGGING", JakartaCommonsLoggingImpl.class);
    typeAliasRegistry.registerAlias("LOG4J", Log4jImpl.class);
    typeAliasRegistry.registerAlias("LOG4J2", Log4j2Impl.class);
    typeAliasRegistry.registerAlias("JDK_LOGGING", Jdk14LoggingImpl.class);
    typeAliasRegistry.registerAlias("STDOUT_LOGGING", StdOutImpl.class);
    typeAliasRegistry.registerAlias("NO_LOGGING", NoLoggingImpl.class);

    typeAliasRegistry.registerAlias("CGLIB", CglibProxyFactory.class);
    typeAliasRegistry.registerAlias("JAVASSIST", JavassistProxyFactory.class);

    languageRegistry.setDefaultDriverClass(XMLLanguageDriver.class);
    languageRegistry.register(RawLanguageDriver.class);
  }
}
```



#### XMLConfigBuilder.parse()

配置文件解析

```java
// 解析配置
  public Configuration parse() {
    // 根据parsed变量的值判断是否已经完成了对mybatis-config.xml配置文件的解析
    if (parsed) {
      throw new BuilderException("Each XMLConfigBuilder can only be used once.");
    }
    parsed = true;
    // 在mybatis-config.xml配置文件中查找<configuration>节点，并开始解析
    parseConfiguration(parser.evalNode("/configuration"));
    return configuration;
  }

  // 解析配置
  private void parseConfiguration(XNode root) {
    try {
      // issue #117 read properties first
      // 解析properties
      propertiesElement(root.evalNode("properties"));
      // 解析settings
      Properties settings = settingsAsProperties(root.evalNode("settings"));
      // 设置vfsImpl字段
      loadCustomVfs(settings);
      loadCustomLogImpl(settings);
      // 解析类型别名（可以在这里给类定义别名，以便在配置文件中直接使用，也可以通过注解@Alias("xxx")）
      typeAliasesElement(root.evalNode("typeAliases"));
      // 解析插件(例如：分页插件
      pluginElement(root.evalNode("plugins"));
      // 对象工厂
      objectFactoryElement(root.evalNode("objectFactory"));
      // 对象包装工厂
      objectWrapperFactoryElement(root.evalNode("objectWrapperFactory"));
      // 反射工厂
      reflectorFactoryElement(root.evalNode("reflectorFactory"));
      //设置具体的属性到configuration对象
      settingsElement(settings);
      // read it after objectFactory and objectWrapperFactory issue #631
      // 环境(涉及DataSource和TransactionManager)
      environmentsElement(root.evalNode("environments"));
      // databaseIdProvider
      databaseIdProviderElement(root.evalNode("databaseIdProvider"));
      // 类型处理器
      typeHandlerElement(root.evalNode("typeHandlers"));
      // 映射器
      mapperElement(root.evalNode("mappers"));
    } catch (Exception e) {
      throw new BuilderException("Error parsing SQL Mapper Configuration. Cause: " + e, e);
    }
  }
```



#### Mappers元素解析

mappers元素是配置文件中相对比较重要的元素。参考[官网说明](https://mybatis.org/mybatis-3/zh/configuration.html#mappers)。Mappers底下可以配置一个包路径，xml文件地址，或者mapper类。

```xml
<!-- 将包内的映射器接口全部注册为映射器 -->
<mappers>
  <package name="org.mybatis.builder"/>
</mappers>

<!-- 使用相对于类路径的资源引用 -->
<mappers>
  <mapper resource="org/mybatis/builder/AuthorMapper.xml"/>
  <mapper resource="org/mybatis/builder/BlogMapper.xml"/>
  <mapper resource="org/mybatis/builder/PostMapper.xml"/>
</mappers>

<!-- 使用映射器接口实现类的完全限定类名 -->
<mappers>
  <mapper class="org.mybatis.builder.AuthorMapper"/>
  <mapper class="org.mybatis.builder.BlogMapper"/>
  <mapper class="org.mybatis.builder.PostMapper"/>
</mappers>
```







# Mybatis-plus
