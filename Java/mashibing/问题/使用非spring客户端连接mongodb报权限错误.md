# 环境说明

MongoDB是使用docker安装的5.0.5版本。

通过ssh客户端，可以往集合中插入数据。

MongoDB里面的数据都是用admin用户创建的

```sh
test> use admin
switched to db admin
admin> db.auth('admin', '123456')
{ ok: 1 }
admin> show dbs
admin    135 kB
config  36.9 kB
local   73.7 kB
test     115 kB
admin> use test
switched to db test
test> show tables
collection1
collection2
test> db.createCollection("c1")
{ ok: 1 }
test> show tables
c1
collection1
collection2
test> 
```

## maven依赖

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>com.gem</groupId>
        <artifactId>db</artifactId>
        <version>0.0.1-SNAPSHOT</version>
    </parent>
    <groupId>com.gem.db</groupId>
    <artifactId>MongoDb</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>MongoDb</name>
    <description>MongoDb</description>
    <properties>
        <java.version>1.8</java.version>
    </properties>
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>

        <dependency>
            <groupId>org.mongodb</groupId>
            <artifactId>mongo-java-driver</artifactId>
            <version>3.12.14</version>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-mongodb</artifactId>
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

</project>
```



# 问题描述

## 改成不用密码的方式插入文档

改成不用密码的方式去插入文档。还是报错：command insert requires authentication

### 详细报错日志

```java
17:25:12.582 [main] INFO org.mongodb.driver.cluster - Cluster created with settings {hosts=[docker-study:27017], mode=SINGLE, requiredClusterType=UNKNOWN, serverSelectionTimeout='30000 ms', maxWaitQueueSize=500}
17:25:12.668 [main] DEBUG org.mongodb.driver.cluster - Updating cluster description to  {type=UNKNOWN, servers=[{address=docker-study:27017, type=UNKNOWN, state=CONNECTING}]
17:25:20.767 [cluster-ClusterId{value='653b81f8495c0762343b6a64', description='null'}-docker-study:27017] INFO org.mongodb.driver.connection - Opened connection [connectionId{localValue:1, serverValue:12}] to docker-study:27017
17:25:20.768 [cluster-ClusterId{value='653b81f8495c0762343b6a64', description='null'}-docker-study:27017] DEBUG org.mongodb.driver.cluster - Checking status of docker-study:27017
17:25:20.795 [cluster-ClusterId{value='653b81f8495c0762343b6a64', description='null'}-docker-study:27017] DEBUG org.mongodb.driver.protocol.command - Sending command '{"ismaster": 1, "$db": "admin"}' with request id 3 to database admin on connection [connectionId{localValue:1, serverValue:12}] to server docker-study:27017
17:25:20.798 [cluster-ClusterId{value='653b81f8495c0762343b6a64', description='null'}-docker-study:27017] DEBUG org.mongodb.driver.protocol.command - Execution of command with request id 3 completed successfully in 23.66 ms on connection [connectionId{localValue:1, serverValue:12}] to server docker-study:27017
17:25:20.799 [cluster-ClusterId{value='653b81f8495c0762343b6a64', description='null'}-docker-study:27017] INFO org.mongodb.driver.cluster - Monitor thread successfully connected to server with description ServerDescription{address=docker-study:27017, type=STANDALONE, state=CONNECTED, ok=true, version=ServerVersion{versionList=[5, 0, 5]}, minWireVersion=0, maxWireVersion=13, maxDocumentSize=16777216, logicalSessionTimeoutMinutes=30, roundTripTimeNanos=28260500}
17:25:20.800 [cluster-ClusterId{value='653b81f8495c0762343b6a64', description='null'}-docker-study:27017] DEBUG org.mongodb.driver.cluster - Updating cluster description to  {type=STANDALONE, servers=[{address=docker-study:27017, type=STANDALONE, roundTripTime=28.3 ms, state=CONNECTED}]
17:25:20.847 [main] INFO org.mongodb.driver.connection - Opened connection [connectionId{localValue:2, serverValue:13}] to docker-study:27017
17:25:20.858 [main] DEBUG org.mongodb.driver.operation - retryWrites set to true but the server is a standalone server.
17:25:20.885 [main] DEBUG org.mongodb.driver.protocol.command - Sending command '{"insert": "collection1", "ordered": true, "$db": "test", "lsid": {"id": {"$binary": {"base64": "CJpTA1jLQ0u9TrQ2plWfXQ==", "subType": "04"}}}, "documents": [{"_id": {"$oid": "653b8200495c0762343b6a65"}, "username": "gem", "country": "China", "age": 36, "lenght": 178.75, "salary": {"$numberDecimal": "16565.22"}, "address": {"add": "xxx000", "aCode": "0000"}, "favorites": {"movies": ["爱死机", "光环"], "cites": ["北京", "南京"]}}]}' with request id 6 to database test on connection [connectionId{localValue:2, serverValue:13}] to server docker-study:27017
17:25:20.895 [main] DEBUG org.mongodb.driver.protocol.command - Execution of command with request id 6 failed to complete successfully in 15.11 ms on connection [connectionId{localValue:2, serverValue:13}] to server docker-study:27017
com.mongodb.MongoCommandException: Command failed with error 13 (Unauthorized): 'command insert requires authentication' on server docker-study:27017. The full response is {"ok": 0.0, "errmsg": "command insert requires authentication", "code": 13, "codeName": "Unauthorized"}
	at com.mongodb.internal.connection.ProtocolHelper.getCommandFailureException(ProtocolHelper.java:175)
	at com.mongodb.internal.connection.InternalStreamConnection.receiveCommandMessageResponse(InternalStreamConnection.java:302)
	at com.mongodb.internal.connection.InternalStreamConnection.sendAndReceive(InternalStreamConnection.java:258)
	at com.mongodb.internal.connection.UsageTrackingInternalConnection.sendAndReceive(UsageTrackingInternalConnection.java:99)
	at com.mongodb.internal.connection.DefaultConnectionPool$PooledConnection.sendAndReceive(DefaultConnectionPool.java:450)
	at com.mongodb.internal.connection.CommandProtocolImpl.execute(CommandProtocolImpl.java:72)
	at com.mongodb.internal.connection.DefaultServer$DefaultServerProtocolExecutor.execute(DefaultServer.java:226)
	at com.mongodb.internal.connection.DefaultServerConnection.executeProtocol(DefaultServerConnection.java:269)
	at com.mongodb.internal.connection.DefaultServerConnection.command(DefaultServerConnection.java:131)
	at com.mongodb.operation.MixedBulkWriteOperation.executeCommand(MixedBulkWriteOperation.java:435)
	at com.mongodb.operation.MixedBulkWriteOperation.executeBulkWriteBatch(MixedBulkWriteOperation.java:261)
	at com.mongodb.operation.MixedBulkWriteOperation.access$700(MixedBulkWriteOperation.java:72)
	at com.mongodb.operation.MixedBulkWriteOperation$1.call(MixedBulkWriteOperation.java:205)
	at com.mongodb.operation.MixedBulkWriteOperation$1.call(MixedBulkWriteOperation.java:196)
	at com.mongodb.operation.OperationHelper.withReleasableConnection(OperationHelper.java:501)
	at com.mongodb.operation.MixedBulkWriteOperation.execute(MixedBulkWriteOperation.java:196)
	at com.mongodb.operation.MixedBulkWriteOperation.execute(MixedBulkWriteOperation.java:71)
	at com.mongodb.client.internal.MongoClientDelegate$DelegateOperationExecutor.execute(MongoClientDelegate.java:216)
	at com.mongodb.client.internal.MongoCollectionImpl.executeSingleWriteRequest(MongoCollectionImpl.java:1053)
	at com.mongodb.client.internal.MongoCollectionImpl.executeInsertOne(MongoCollectionImpl.java:503)
	at com.mongodb.client.internal.MongoCollectionImpl.insertOne(MongoCollectionImpl.java:487)
	at com.mongodb.client.internal.MongoCollectionImpl.insertOne(MongoCollectionImpl.java:481)
	at com.gem.db.mongodb.MongoClientTest.insertOne(MongoClientTest.java:58)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at org.junit.platform.commons.util.ReflectionUtils.invokeMethod(ReflectionUtils.java:686)
	at org.junit.jupiter.engine.execution.MethodInvocation.proceed(MethodInvocation.java:60)
	at org.junit.jupiter.engine.execution.InvocationInterceptorChain$ValidatingInvocation.proceed(InvocationInterceptorChain.java:131)
	at org.junit.jupiter.engine.extension.TimeoutExtension.intercept(TimeoutExtension.java:149)
	at org.junit.jupiter.engine.extension.TimeoutExtension.interceptTestableMethod(TimeoutExtension.java:140)
	at org.junit.jupiter.engine.extension.TimeoutExtension.interceptTestMethod(TimeoutExtension.java:84)
	at org.junit.jupiter.engine.execution.ExecutableInvoker$ReflectiveInterceptorCall.lambda$ofVoidMethod$0(ExecutableInvoker.java:115)
	at org.junit.jupiter.engine.execution.ExecutableInvoker.lambda$invoke$0(ExecutableInvoker.java:105)
	at org.junit.jupiter.engine.execution.InvocationInterceptorChain$InterceptedInvocation.proceed(InvocationInterceptorChain.java:106)
	at org.junit.jupiter.engine.execution.InvocationInterceptorChain.proceed(InvocationInterceptorChain.java:64)
	at org.junit.jupiter.engine.execution.InvocationInterceptorChain.chainAndInvoke(InvocationInterceptorChain.java:45)
	at org.junit.jupiter.engine.execution.InvocationInterceptorChain.invoke(InvocationInterceptorChain.java:37)
	at org.junit.jupiter.engine.execution.ExecutableInvoker.invoke(ExecutableInvoker.java:104)
	at org.junit.jupiter.engine.execution.ExecutableInvoker.invoke(ExecutableInvoker.java:98)
	at org.junit.jupiter.engine.descriptor.TestMethodTestDescriptor.lambda$invokeTestMethod$6(TestMethodTestDescriptor.java:212)
	at org.junit.platform.engine.support.hierarchical.ThrowableCollector.execute(ThrowableCollector.java:73)
	at org.junit.jupiter.engine.descriptor.TestMethodTestDescriptor.invokeTestMethod(TestMethodTestDescriptor.java:208)
	at org.junit.jupiter.engine.descriptor.TestMethodTestDescriptor.execute(TestMethodTestDescriptor.java:137)
	at org.junit.jupiter.engine.descriptor.TestMethodTestDescriptor.execute(TestMethodTestDescriptor.java:71)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.lambda$executeRecursively$5(NodeTestTask.java:135)
	at org.junit.platform.engine.support.hierarchical.ThrowableCollector.execute(ThrowableCollector.java:73)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.lambda$executeRecursively$7(NodeTestTask.java:125)
	at org.junit.platform.engine.support.hierarchical.Node.around(Node.java:135)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.lambda$executeRecursively$8(NodeTestTask.java:123)
	at org.junit.platform.engine.support.hierarchical.ThrowableCollector.execute(ThrowableCollector.java:73)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.executeRecursively(NodeTestTask.java:122)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.execute(NodeTestTask.java:80)
	at java.util.ArrayList.forEach(ArrayList.java:1259)
	at org.junit.platform.engine.support.hierarchical.SameThreadHierarchicalTestExecutorService.invokeAll(SameThreadHierarchicalTestExecutorService.java:38)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.lambda$executeRecursively$5(NodeTestTask.java:139)
	at org.junit.platform.engine.support.hierarchical.ThrowableCollector.execute(ThrowableCollector.java:73)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.lambda$executeRecursively$7(NodeTestTask.java:125)
	at org.junit.platform.engine.support.hierarchical.Node.around(Node.java:135)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.lambda$executeRecursively$8(NodeTestTask.java:123)
	at org.junit.platform.engine.support.hierarchical.ThrowableCollector.execute(ThrowableCollector.java:73)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.executeRecursively(NodeTestTask.java:122)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.execute(NodeTestTask.java:80)
	at java.util.ArrayList.forEach(ArrayList.java:1259)
	at org.junit.platform.engine.support.hierarchical.SameThreadHierarchicalTestExecutorService.invokeAll(SameThreadHierarchicalTestExecutorService.java:38)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.lambda$executeRecursively$5(NodeTestTask.java:139)
	at org.junit.platform.engine.support.hierarchical.ThrowableCollector.execute(ThrowableCollector.java:73)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.lambda$executeRecursively$7(NodeTestTask.java:125)
	at org.junit.platform.engine.support.hierarchical.Node.around(Node.java:135)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.lambda$executeRecursively$8(NodeTestTask.java:123)
	at org.junit.platform.engine.support.hierarchical.ThrowableCollector.execute(ThrowableCollector.java:73)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.executeRecursively(NodeTestTask.java:122)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.execute(NodeTestTask.java:80)
	at org.junit.platform.engine.support.hierarchical.SameThreadHierarchicalTestExecutorService.submit(SameThreadHierarchicalTestExecutorService.java:32)
	at org.junit.platform.engine.support.hierarchical.HierarchicalTestExecutor.execute(HierarchicalTestExecutor.java:57)
	at org.junit.platform.engine.support.hierarchical.HierarchicalTestEngine.execute(HierarchicalTestEngine.java:51)
	at org.junit.platform.launcher.core.DefaultLauncher.execute(DefaultLauncher.java:248)
	at org.junit.platform.launcher.core.DefaultLauncher.lambda$execute$5(DefaultLauncher.java:211)
	at org.junit.platform.launcher.core.DefaultLauncher.withInterceptedStreams(DefaultLauncher.java:226)
	at org.junit.platform.launcher.core.DefaultLauncher.execute(DefaultLauncher.java:199)
	at org.junit.platform.launcher.core.DefaultLauncher.execute(DefaultLauncher.java:132)
	at com.intellij.junit5.JUnit5IdeaTestRunner.startRunnerWithArgs(JUnit5IdeaTestRunner.java:57)
	at com.intellij.rt.junit.IdeaTestRunner$Repeater$1.execute(IdeaTestRunner.java:38)
	at com.intellij.rt.execution.junit.TestsRepeater.repeat(TestsRepeater.java:11)
	at com.intellij.rt.junit.IdeaTestRunner$Repeater.startRunnerWithArgs(IdeaTestRunner.java:35)
	at com.intellij.rt.junit.JUnitStarter.prepareStreamsAndStart(JUnitStarter.java:232)
	at com.intellij.rt.junit.JUnitStarter.main(JUnitStarter.java:55)

com.mongodb.MongoCommandException: Command failed with error 13 (Unauthorized): 'command insert requires authentication' on server docker-study:27017. The full response is {"ok": 0.0, "errmsg": "command insert requires authentication", "code": 13, "codeName": "Unauthorized"}

	at com.mongodb.internal.connection.ProtocolHelper.getCommandFailureException(ProtocolHelper.java:175)
	at com.mongodb.internal.connection.InternalStreamConnection.receiveCommandMessageResponse(InternalStreamConnection.java:302)
	at com.mongodb.internal.connection.InternalStreamConnection.sendAndReceive(InternalStreamConnection.java:258)
	at com.mongodb.internal.connection.UsageTrackingInternalConnection.sendAndReceive(UsageTrackingInternalConnection.java:99)
	at com.mongodb.internal.connection.DefaultConnectionPool$PooledConnection.sendAndReceive(DefaultConnectionPool.java:450)
	at com.mongodb.internal.connection.CommandProtocolImpl.execute(CommandProtocolImpl.java:72)
	at com.mongodb.internal.connection.DefaultServer$DefaultServerProtocolExecutor.execute(DefaultServer.java:226)
	at com.mongodb.internal.connection.DefaultServerConnection.executeProtocol(DefaultServerConnection.java:269)
	at com.mongodb.internal.connection.DefaultServerConnection.command(DefaultServerConnection.java:131)
	at com.mongodb.operation.MixedBulkWriteOperation.executeCommand(MixedBulkWriteOperation.java:435)
	at com.mongodb.operation.MixedBulkWriteOperation.executeBulkWriteBatch(MixedBulkWriteOperation.java:261)
	at com.mongodb.operation.MixedBulkWriteOperation.access$700(MixedBulkWriteOperation.java:72)
	at com.mongodb.operation.MixedBulkWriteOperation$1.call(MixedBulkWriteOperation.java:205)
	at com.mongodb.operation.MixedBulkWriteOperation$1.call(MixedBulkWriteOperation.java:196)
	at com.mongodb.operation.OperationHelper.withReleasableConnection(OperationHelper.java:501)
	at com.mongodb.operation.MixedBulkWriteOperation.execute(MixedBulkWriteOperation.java:196)
	at com.mongodb.operation.MixedBulkWriteOperation.execute(MixedBulkWriteOperation.java:71)
	at com.mongodb.client.internal.MongoClientDelegate$DelegateOperationExecutor.execute(MongoClientDelegate.java:216)
	at com.mongodb.client.internal.MongoCollectionImpl.executeSingleWriteRequest(MongoCollectionImpl.java:1053)
	at com.mongodb.client.internal.MongoCollectionImpl.executeInsertOne(MongoCollectionImpl.java:503)
	at com.mongodb.client.internal.MongoCollectionImpl.insertOne(MongoCollectionImpl.java:487)
	at com.mongodb.client.internal.MongoCollectionImpl.insertOne(MongoCollectionImpl.java:481)
	at com.gem.db.mongodb.MongoClientTest.insertOne(MongoClientTest.java:58)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at org.junit.platform.commons.util.ReflectionUtils.invokeMethod(ReflectionUtils.java:686)
	at org.junit.jupiter.engine.execution.MethodInvocation.proceed(MethodInvocation.java:60)
	at org.junit.jupiter.engine.execution.InvocationInterceptorChain$ValidatingInvocation.proceed(InvocationInterceptorChain.java:131)
	at org.junit.jupiter.engine.extension.TimeoutExtension.intercept(TimeoutExtension.java:149)
	at org.junit.jupiter.engine.extension.TimeoutExtension.interceptTestableMethod(TimeoutExtension.java:140)
	at org.junit.jupiter.engine.extension.TimeoutExtension.interceptTestMethod(TimeoutExtension.java:84)
	at org.junit.jupiter.engine.execution.ExecutableInvoker$ReflectiveInterceptorCall.lambda$ofVoidMethod$0(ExecutableInvoker.java:115)
	at org.junit.jupiter.engine.execution.ExecutableInvoker.lambda$invoke$0(ExecutableInvoker.java:105)
	at org.junit.jupiter.engine.execution.InvocationInterceptorChain$InterceptedInvocation.proceed(InvocationInterceptorChain.java:106)
	at org.junit.jupiter.engine.execution.InvocationInterceptorChain.proceed(InvocationInterceptorChain.java:64)
	at org.junit.jupiter.engine.execution.InvocationInterceptorChain.chainAndInvoke(InvocationInterceptorChain.java:45)
	at org.junit.jupiter.engine.execution.InvocationInterceptorChain.invoke(InvocationInterceptorChain.java:37)
	at org.junit.jupiter.engine.execution.ExecutableInvoker.invoke(ExecutableInvoker.java:104)
	at org.junit.jupiter.engine.execution.ExecutableInvoker.invoke(ExecutableInvoker.java:98)
	at org.junit.jupiter.engine.descriptor.TestMethodTestDescriptor.lambda$invokeTestMethod$6(TestMethodTestDescriptor.java:212)
	at org.junit.platform.engine.support.hierarchical.ThrowableCollector.execute(ThrowableCollector.java:73)
	at org.junit.jupiter.engine.descriptor.TestMethodTestDescriptor.invokeTestMethod(TestMethodTestDescriptor.java:208)
	at org.junit.jupiter.engine.descriptor.TestMethodTestDescriptor.execute(TestMethodTestDescriptor.java:137)
	at org.junit.jupiter.engine.descriptor.TestMethodTestDescriptor.execute(TestMethodTestDescriptor.java:71)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.lambda$executeRecursively$5(NodeTestTask.java:135)
	at org.junit.platform.engine.support.hierarchical.ThrowableCollector.execute(ThrowableCollector.java:73)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.lambda$executeRecursively$7(NodeTestTask.java:125)
	at org.junit.platform.engine.support.hierarchical.Node.around(Node.java:135)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.lambda$executeRecursively$8(NodeTestTask.java:123)
	at org.junit.platform.engine.support.hierarchical.ThrowableCollector.execute(ThrowableCollector.java:73)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.executeRecursively(NodeTestTask.java:122)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.execute(NodeTestTask.java:80)
	at java.util.ArrayList.forEach(ArrayList.java:1259)
	at org.junit.platform.engine.support.hierarchical.SameThreadHierarchicalTestExecutorService.invokeAll(SameThreadHierarchicalTestExecutorService.java:38)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.lambda$executeRecursively$5(NodeTestTask.java:139)
	at org.junit.platform.engine.support.hierarchical.ThrowableCollector.execute(ThrowableCollector.java:73)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.lambda$executeRecursively$7(NodeTestTask.java:125)
	at org.junit.platform.engine.support.hierarchical.Node.around(Node.java:135)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.lambda$executeRecursively$8(NodeTestTask.java:123)
	at org.junit.platform.engine.support.hierarchical.ThrowableCollector.execute(ThrowableCollector.java:73)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.executeRecursively(NodeTestTask.java:122)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.execute(NodeTestTask.java:80)
	at java.util.ArrayList.forEach(ArrayList.java:1259)
	at org.junit.platform.engine.support.hierarchical.SameThreadHierarchicalTestExecutorService.invokeAll(SameThreadHierarchicalTestExecutorService.java:38)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.lambda$executeRecursively$5(NodeTestTask.java:139)
	at org.junit.platform.engine.support.hierarchical.ThrowableCollector.execute(ThrowableCollector.java:73)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.lambda$executeRecursively$7(NodeTestTask.java:125)
	at org.junit.platform.engine.support.hierarchical.Node.around(Node.java:135)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.lambda$executeRecursively$8(NodeTestTask.java:123)
	at org.junit.platform.engine.support.hierarchical.ThrowableCollector.execute(ThrowableCollector.java:73)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.executeRecursively(NodeTestTask.java:122)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.execute(NodeTestTask.java:80)
	at org.junit.platform.engine.support.hierarchical.SameThreadHierarchicalTestExecutorService.submit(SameThreadHierarchicalTestExecutorService.java:32)
	at org.junit.platform.engine.support.hierarchical.HierarchicalTestExecutor.execute(HierarchicalTestExecutor.java:57)
	at org.junit.platform.engine.support.hierarchical.HierarchicalTestEngine.execute(HierarchicalTestEngine.java:51)
	at org.junit.platform.launcher.core.DefaultLauncher.execute(DefaultLauncher.java:248)
	at org.junit.platform.launcher.core.DefaultLauncher.lambda$execute$5(DefaultLauncher.java:211)
	at org.junit.platform.launcher.core.DefaultLauncher.withInterceptedStreams(DefaultLauncher.java:226)
	at org.junit.platform.launcher.core.DefaultLauncher.execute(DefaultLauncher.java:199)
	at org.junit.platform.launcher.core.DefaultLauncher.execute(DefaultLauncher.java:132)
	at com.intellij.junit5.JUnit5IdeaTestRunner.startRunnerWithArgs(JUnit5IdeaTestRunner.java:57)
	at com.intellij.rt.junit.IdeaTestRunner$Repeater$1.execute(IdeaTestRunner.java:38)
	at com.intellij.rt.execution.junit.TestsRepeater.repeat(TestsRepeater.java:11)
	at com.intellij.rt.junit.IdeaTestRunner$Repeater.startRunnerWithArgs(IdeaTestRunner.java:35)
	at com.intellij.rt.junit.JUnitStarter.prepareStreamsAndStart(JUnitStarter.java:232)
	at com.intellij.rt.junit.JUnitStarter.main(JUnitStarter.java:55)

Disconnected from the target VM, address: '127.0.0.1:56234', transport: 'socket'

Process finished with exit code -1

```

### Java代码

执行到34行报错。

```java
public class MongoClientTest {
    //数据库
    private MongoDatabase db;
    //文档集合
    private MongoCollection<Document> doc;
    //连接客户端（内置连接池）
    private MongoClient client;

    @BeforeEach
    public void init() {
        client = new MongoClient("docker-study", 27017);
        db = client.getDatabase("test");
        doc = db.getCollection("collection1");
    }

    @Test
    public void insertOne() {
        Document doc1 = new Document();
        doc1.append("username", "gem");
        doc1.append("country", "China");
        doc1.append("age", 36);
        doc1.append("lenght", 178.75f);
        doc1.append("salary", new BigDecimal("16565.22"));//存金额，使用bigdecimal这个数据类型
        Map<String, String> address1 = new HashMap<String, String>();       //添加“address”子文档
        address1.put("aCode", "0000");
        address1.put("add", "xxx000");
        doc1.append("address", address1);
        Map<String, Object> favorites1 = new HashMap<String, Object>();        //添加“favorites”子文档，其中两个属性是数组
        favorites1.put("movies", Arrays.asList("爱死机", "光环"));
        favorites1.put("cites", Arrays.asList("北京", "南京"));
        doc1.append("favorites", favorites1);

        //使用insertMany插入多条数据
        doc.insertOne(doc1);
    }
}
```



