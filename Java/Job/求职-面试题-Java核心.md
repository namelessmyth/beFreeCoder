# 求职-面试题-Java核心

# 对象结构

## 字符

### String有长度限制么？

有，编译期和运行期不一样。

编译期需要用CONSTANT-UTF8-info 结构用于表示字符串常量的值，而这个结构是有长度限制，他的限制是65535。

运行期，String的length参数是Int类型的，那么也就是说，String定义的时候，最大支持的长度就是int的最大范围值。根据Integer类的定义，java.lang.Integer#MAX_VALUE的最大值是2^31^-1;



### String、StringBuilder、StringBuffer的区别?

典型回答

String是不可变的，StringBuilder和StringBuffer是可变的。而StringBuffer是线程安全的，而StringBuilder是非自线程安全的。



### String“+”的实现

使用+拼接字符串，其实只是Java提供的一个语法糖，那么他的内部原理是如何实现的?

这样一段代码。我们把他生成的字节码进行反编译，看看结果。

```java
String a = "123";
String b = "456";
String c = a +"."+ b;

//使用jad的反编译结果
String a = "123";
String b = "456";
String c = (new stringBuilder()).append(a).append(",").append(b).tostring();
```

通过反编译，我们可以发现，字符串常量在拼接过程中，是将String转成了StringBuilder后，使用其append方法进行处理的。



## 数字

### 为什么不建议用浮点数表示金额

因为不是所有的小数都能用二进制表示，所以为了解决这个问题，IEEE提出了一种使用近似值表示小数的方式，并且引入了精度的概念。这就是我们所熟知的浮点数。

比如0.1+0.2 != 0.3，而是等于0.300000000000000044。甚至有一个网站就叫做https://0.30000000000000004.com/，就是来解释这个现象的)

所以浮点数只是近似值，并不是精确值，所以不能用来表示金额。否则会有精度丢失

在Java中，使用float表示单精度浮点数，double表示双精度浮点数，表示的也都是近似值

所以，在Java代码中，千万不要使用foat或者double来进行高精度运算，尤其是金额运算，否则就很容易产生资损问题。

为了解决这样的精度问题，Java中提供了BigDecimal来进行精确运算。



### BigDecimal的equals方法不建议等值比较?

BigDecimal的equals方法和compareTo并不一样，equals方法会比较两部分内容，分别是值(value)和标度(scale)，而对于0.1和0.10这两个数字，使用equals比较的时候会返回false。因为他们的值一样，但是精度不一样。



### BigDecimal的构造方法建议使用哪个？

推荐使用String构造BigDecimal，禁止使用double创建BigDeciaml。

因为double是不精确的，所以使用一个不精确的数字来创建BigDeciaml，得到的数字也是不精确的。如0.1这个数字，double只能表示他的近似值

所以，主当我们使用new BigDecimal(0.1)创建一个BigDecimal 的时候，其实创建出来的值并不是正好等于0.1的。

而是0.1000000000000000055511151231257827021181583404541015625。这是因为double自身表示的只是一个近似值。

当我们使用new BigDecimal("0.1")创建一个BigDecimal 的时候，其实创建出来的 而对于BigDecimal(String)，值正好就是等于0.1的。
那么他的标度也就是1



## 集合

### Java中集合类介绍

常见集合类结构图

```mermaid
classDiagram
Iterable <|-- Collection
Collection <|-- List
Collection <|-- Set
Collection <|-- Queue

Set <|-- HashSet
Set <|-- TreeSet

List <|-- LinkedList
List <|-- ArrayList
List <|-- Vector

Queue <|-- ArrayDeque
Queue <|-- PriorityQueue
Queue <|-- BlockingQueue

Map <|-- HashMap
Map <|-- TreeMap
Map <|-- ConcurrentHashMap
```

**Set**

HashSet

基于哈希表实现的，HashSet中的数据是无序的，可以放入nul，但只能放入一个null，两者中的值都不能重复，就如数据库中唯一约束;底层基于HashMap

TreeSet

基于二叉树实现的，TreeSet中的数据是有序的且自动排好序，不允许放入nul值，底层基于TreeMap。



**Deque**

ArrayDeque

ArrayDeque也实现了Queue接口，是一个基于数组实现的双端队列（double-ended queue）。ArrayDeque在插入和删除元素时的效率比LinkedList更高。适用于栈和队列的应用以及需要高效的插入和删除操作的场景，例如生产者-消费者模式。

PriorityQueue

PriorityQueue是一个基于优先级堆的队列实现，它不是严格意义上的先进先出队列，而是根据元素的优先级进行排序。

PriorityQueue可以根据自定义的比较器来确定元素的优先级顺序。适用于需要按照一定优先级顺序处理元素的场景，例如任务调度等。



### 集合的排序方式

1. 调用Collections.sort(list)方法，然后List中的实体类实现实现Comparable接口。

2. 调用Collections.sort(list, Comparator)方法，通过lambda表达式。例如：`Collections.sort(list, (a, b) -> { ... })` 

   1. 这种方式还可以通过Comparator.comparing来构建Comparator。

   2. ```java
      List<Employee> employees = List.of(
          new Employee("John", 30),
          new Employee("Alice", 25),
          new Employee("Bob", 35),
          new Employee("John", 28)
      );
      
      Comparator<Employee> comparator = Comparator.comparing(Employee::getName)
          .thenComparing(Employee::getAge);
      
      Collections.sort(employees, comparator);
      
      // 输出：
      // [Employee{name='Alice', age=25}, Employee{name='Bob', age=35}, Employee{name='John', age=28}, Employee{name='John', age=30}]
      ```

3. list自己也有sort方法。例如： `list.sort((a, b) -> { ... })` 方法。



### 如何在循环中移除集合元素

**1. 使用迭代器**

使用 `Iterator` 遍历列表，并在需要时使用 `remove()` 方法删除元素。

```java
List<String> list = new ArrayList<>();
list.add("apple");
list.add("banana");
list.add("cherry");

Iterator<String> iterator = list.iterator();
while (iterator.hasNext()) {
    String fruit = iterator.next();
    if (fruit.equals("banana")) {
        iterator.remove();
    }
}

System.out.println(list); // 输出：[apple, cherry]
```



**2. 使用 `removeIf()` 方法 (Java 8+)**

`removeIf()` 方法接受一个 `Predicate`，并删除列表中所有满足该谓词的元素。

```java
List<String> list = new ArrayList<>();
list.add("apple");
list.add("banana");
list.add("cherry");

list.removeIf(fruit -> fruit.equals("banana"));

System.out.println(list); // 输出：[apple, cherry]
```



**3. 使用ConcurrentHashMap或CopyOnWriteArrayList**

```java
// 使用 ConcurrentHashMap
ConcurrentHashMap<String, Integer> map = new ConcurrentHashMap<>();
map.put("apple",  1);
map.put("banana", 2);
map.put("cherry", 3);

map.forEach((key, value) -> {
    if (key.equals("banana")) {
        map.remove(key);
    }
});

System.out.println(map); // 输出：{apple=1, cherry=3}

// 使用 CopyOnWriteArrayList
CopyOnWriteArrayList<String> list = new CopyOnWriteArrayList<>();
list.add("apple");
list.add("banana");
list.add("cherry");

list.forEach(fruit -> {
    if (fruit.equals("banana")) {
        list.remove(fruit);
    }
});

System.out.println(list); // 输出：[apple, cherry]
```



**4. 使用 Stream 删除元素**

可以使用 `Stream` 的 `filter()` 方法删除元素，该方法接受一个 `Predicate`，并返回一个只包含满足该谓词的元素的新流。然后，可以使用 `collect()` 方法将新流收集到一个新的列表中。

```java
List<String> list = new ArrayList<>();
list.add("apple");
list.add("banana");
list.add("cherry");

List<String> newList = list.stream()
    .filter(fruit -> !fruit.equals("banana"))
    .collect(Collectors.toList());

System.out.println(newList); // 输出：[apple, cherry]
```

**注意事项：**

- `filter()` 方法不会修改原始列表，它会创建一个新的流。
- `collect()` 方法会创建一个新的列表。



### HashMap的底层结构

[HashMap底层最全分析](https://blog.csdn.net/weixin_44141495/article/details/108327490)

HashMap在不同的Jdk版本的实现原理是不一样的。大体上：

在JDK1.7中使用的是数组+ 单链表的数据结构。

![](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9naXRlZS5jb20vZGFya25pZ2h0amFrdC9tYXBkZXBvdC9yYXcvbWFzdGVyL2ltZy9jc2RuLzIwMjAwODMxMTkwMDUxLnBuZw?x-oss-process=image/format,png)

在JDK1.8及之后版本，使用的是数组+链表+红黑树的数据结构（当链表的深度达到8的时候，也就是默认阈值，就会自动扩容把链表转成红黑树的数据结构来把时间复杂度从O(n)变成O(logN)提高了效率）

![](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9naXRlZS5jb20vZGFya25pZ2h0amFrdC9tYXBkZXBvdC9yYXcvbWFzdGVyL2ltZy9jc2RuLzIwMjAwODMxMTkwMDQ4LnBuZw?x-oss-process=image/format,png)

结合HashMap源码讲解：

HashMap内部有一个Node数组`Node<K,V>[] table`代表表数据，Node<K,V>是HashMap的内部类，实现Map.Entry<K,V>接口

Node<K,V>中维护着：确定位置的hash值，Key，Value，指向链表下一个元素的next指针。

当链表中的元素数量超过8后会将链表转换为红黑树，此时该下标的元素将成为TreeNode<K,V>，是Node<K,V>的子类

HashMap有4种构造方法，默认构造方法是懒加载，在第一次添加元素的时候才真正的初始化。
```java
//表数据，即Node键值对数组，Node是单向链表，它实现了Map.Entry接口，长度是2的幂次倍
transient Node<K,V>[] table;

static class Node<K,V> implements Map.Entry<K,V> {
    // 哈希值，HashMap根据该值确定记录的位置
    final int hash;
    // node的key
    final K key;
    // node的value
    V value;
    // 链表下一个节点
    Node<K,V> next;

    // 省略 。。。
}

//默认构造方法
public HashMap() {  
    this.loadFactor = DEFAULT_LOAD_FACTOR; // all other fields defaulted  
} 

```


put()方法流程如下：

1. 判断键值对数组table[]是否为空或为null，否则执行resize()进行扩容；

2. 根据键值key计算hash值得到插入的数组索引 i，如果table[i]==null，直接新建节点添加，转向⑥，如果 table[i]不为空，转向③；

3. 判断table[i]的首个元素的key是否和要放的相同，如果相同直接覆盖value，否则转向④，这里的相同指的是hashCode以及equals；

4. 判断table[i]是否为treeNode，即table[i]是否是红黑树，如果是红黑树，则直接在树中插入键值对，否则转向⑤；

5. 遍历table[i]的链表，判断长度是否大于8，大于8的话把链表转换为红黑树。
   1. 然后在红黑树中执行插入操作，否则进行链表的插入操作；遍历过程中若发现key已经存在直接覆盖value即可；
6. 插入成功后，判断实际存在的键值对数量size是否超多了最大容量threshold，如果超过，进行扩容。


![](https://img-blog.csdnimg.cn/20191214222552803.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aGlua3dvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

### HashMap1.8与1.7区别

[参考答案](https://blog.csdn.net/weixin_44141495/article/details/108402128)



### equals和hashCode方法重写注意事项

在重写equals和hashCode方法时，需要注意以下事项：

1. 一致性：equals方法和hashCode方法的实现必须是一致的。即如果两个对象根据equals方法判断相等，它们的hashCode值必须相等。这是因为在哈希表中，如果两个对象相等（equals返回true），它们的hashCode值必须相等，否则会导致无法正确定位对象。
2. 相等对象的hashCode值必须相等：如果两个对象根据equals方法判断相等，那么它们的hashCode值必须相等。这是为了保证在哈希表中，相等的对象具有相同的哈希值，从而能够正确地进行查找、插入和删除操作。
3. hashCode方法应该具有良好的散列性能：hashCode方法的返回值应该尽可能地分布均匀，以减少哈希冲突的发生。这样可以提高HashMap等基于哈希表的数据结构的性能。
4. 不需要每个属性都参与hashCode计算：在重写hashCode方法时，不需要每个属性都参与计算哈希值，只需要选择一些重要的属性参与计算即可。这样可以避免不必要的复杂性和性能开销。
5. 谨慎处理null值：在重写equals方法时，需要谨慎处理null值的情况，避免出现空指针异常。通常可以使用Objects.equals方法来比较对象是否相等，该方法会处理null值的情况。

遵循以上注意事项可以确保重写的equals和hashCode方法在使用HashMap等数据结构时能够正确地工作，避免出现问题和错误。



### 重写equals和hashCode的推荐方式

以下是重写equals和hashCode方法时的一些推荐实现方式：

1. 使用instanceof关键字检查类型：在equals方法中，首先使用instanceof关键字检查对象是否为同一类型，然后再进行属性比较。

```java
@Override
public boolean equals(Object obj) {
    if (this == obj) {
        return true;
    }
    if (!(obj instanceof MyClass)) {
        return false;
    }
    MyClass other = (MyClass) obj;
    // 进行属性比较
    return this.field1.equals(other.field1) && this.field2 == other.field2;
}
```

1. 使用Objects.equals方法比较属性：在equals方法中，可以使用Objects.equals方法比较属性值，该方法会处理null值的情况。

```java
@Override
public boolean equals(Object obj) {
    if (this == obj) {
        return true;
    }
    if (!(obj instanceof MyClass)) {
        return false;
    }
    MyClass other = (MyClass) obj;
    // 使用Objects.equals比较属性
    return Objects.equals(this.field1, other.field1) && this.field2 == other.field2;
}
```

1. 在hashCode方法中使用Objects.hash方法计算哈希值：可以使用Objects.hash方法结合需要参与哈希计算的属性值来计算哈希值。

```java
@Override
public int hashCode() {
    return Objects.hash(field1, field2);
}
```

以上是一些推荐的实现方式，它们能够简洁、高效地实现重写equals和hashCode方法，并且能够正确地处理各种情况，避免出现问题。



## 数组

### Arrays.sort()用的什么排序

sort()方法采用了一种自适应排序算法，会根据待排序数组的长度和元素类型选择最适合的排序算法，以提高排序的效率和性能。

在JDK8中

数组长度为n，则1 <= n < 47 使用插入排序，插入排序在小型数据集上的效率比较高

数组长度为n，则47 <= n < 286 使用使用快速排序

数组长度为n，则286 > n 使用归并排序或快速排序（有一定顺序使用归并排序，毫无顺序使用快排）

https://blog.csdn.net/yuanchangliang/article/details/107755756



## 链表

### 链表和数组的区别及应用

在Java中，链表（LinkedList）和数组（Array）是两种不同的数据结构，它们有以下区别：

1. 内存分配方式：
   - 数组在内存中是连续存储的，元素的访问速度较快，但大小固定，无法动态扩展。
   - 链表的节点在内存中可以是不连续的，通过指针将节点连接起来，可以动态增加或删除节点。
2. 插入和删除操作：
   - 数组的插入和删除操作可能会涉及元素的移动，时间复杂度为O(n)。
   - 链表的插入和删除操作只需要修改指针指向，时间复杂度为O(1)。
3. 随机访问：
   - 数组支持随机访问，可以通过下标直接访问元素，时间复杂度为O(1)。
   - 链表不支持随机访问，需要从头节点开始遍历到目标位置，时间复杂度为O(n)。
4. 空间占用：
   - 数组在内存中会占用一块连续的空间，需要预先分配固定大小的空间。
   - 链表的节点可以在内存中分散存储，不需要预先分配固定大小的空间。



### 判断链表是否有环

思路

 如果一个链表无环，那么遍历链表一定可以遇到链表的终点；如果链表有环，那么遍历链表就永远在环内转下去。具体如下：

 1.设置快慢指针分别为fast和slow。开始，slow和fast都指向链表的头节点head。然后slow每次移动一步，fast每次移动两部，在链表中遍历。

 2.如果链表无环，fast指针在移动过程一定先遇到终点，直接返回null，表示链表无环。

 3.如果有环，fast和slow一定在环中相遇。相遇时，fast重新回到head位置，slow不动。接下来，fast指针每次移动一步，slow依然每次移动一步，继续遍历。

 4.fast和slow指针一定会再次相遇，并在第一个入环的节点处相遇，证明略。

```java
public Node getLoopNode(Node head){
    if (head == null || head.next == null || head.next.next == null){
        return null;
    }
    Node n1 = head.next; //n1 -> slow
    Node n2 = head.next.next; // n2 -> fast
    while (n1 != n2){
        if (n2.next == null || n2.next.next == null){
            return null;
        }
        n2 = n2.next.next;
        n1 = n1.next;
    }
    n2 = head; // n2 -> walk again from head
    while (n1 != n2){
        n1 = n1.next;
        n2 = n2.next;
    }
    return n1;
}
```



## 日期

### SimpleDateFormat是线程安全的吗

使用SimpleDateFormat类可以把时间显示成我们需要的格式。但它是非线程安全的。

在阿里巴巴Java开发手册中，有如下规定:

【强制】SimpleDateFormat 是线程不安全的类，一般不要定义为static变量，如果定义为static，必须加锁，或者使用 Dateutils工具类:

也就是说在多线程场景中，不能使用SimpleDateFormat作为共享变量.

因为SimpleDateFormat中的format方法在执行过程中，会使用一个成员变量calendar来保存时间。





# 基础

### Java为什么不能多继承

因为如果要实现多继承，就会像C++中一样，存在**菱形继承**的问题，C++为了解决菱形继承问题，又引入了虚继承。经过分析，人们发现我们其实真正想要使用多继承的情况并不多。所以，在 Java 中，不允许“多继承”，即一个类不允许继承多个父类。

除了萎形的问题，支持多继承复杂度也会增加。一个类继承了多个父类，可能会继承大量的属性和方法，导致类的接口变得庞大、难以理解和维护。此外，在修改一个父类时，可能会影响到多个子类，增加了代码的耦合度。

在Java 8以前，接口中是不能有方法的实现的。所以一个类同时实现多个接口的话，也不会出现C++中的歧义问题。因为所有方法都没有方法体，真正的实现还是在子类中的。但是，Java 8中支持了默认函数(defaultmethod )，即接口中可以定义一个有方法体的方法了。

而又因为Java支持同时实现多个接口，这就相当于通过implements就可以从多个接口中继承到多个方法了，但是，Java8中为了避免萎形继承的问题，在实现的多个接口中如果有相同方法，就会要求该类必须重写这个方法



### Java的语法糖介绍

语法糖(Syntactic sugar)，指在计算机语言中添加的某种语法，这种语法对语言的功能并没有影响，但是可以方便程序员更便捷的使用。

Java中有很多语法糖，但Java虚拟机并不支持这些语法糖，所以这些语法糖在编译阶段就会被还原成简单的基础语法结构，这样才能被虚拟机识别，这个过程就是解语法糖。

看过Java虛拟机的源码的小伙伴会发现，在编译过程中有一个重要的步骤就是调用desugar()方法，负责解语法糖的实现。

常见的语法糖

switch支持枚举及字符串、泛型、条件编译、断言、可变参数、自动装箱/拆箱、枚举、内部类增强for循环、try-with-resources语句、lambda表达式等。



### lambda表达式的底层实现

lambda表达式，属于Java的语法糖。实现方式是依赖了JVM底层提供的lambda相关api。

先来看案例代码:

```java
public static void main(String... args) {
	List<String> strList = ImmutableList.of("1", "2", "3");
    strList.forEach( s -> { System.out.println(s); } );
}
```

编译后的代码：

```java
public static /* varargs */ void main(String ... args) {
    ImmutableList strList = ImmutableList.of((Object)"1", (Object)"2", (Object)"3");
    strList.forEach((Consumer<String>)LambdaMetafactory.metafactory(null, null, null,(Ljava/lang/Object;)V, lambda$main$0(java.lang.String ), (Ljava/lang/String;)V)());
}

private static /* synthetic */ void lambda$main$0(String s) {
    System.out.println(s);
}
```

可以看到，在 forEach 方法中，其实是调用了 java.lang.invoke.LambdaMetafactory#metafactory 方法，该方法的第5个参数implMethod指定了方法实现。可以看到这里其实是调用了一个 `lambda$main$0` 静态方法进行了输出。而这个方法在编译时就被加到了class文件中。



### 什么是类型擦除？

类型擦除可以简单的理解为将泛型java代码转换为普通java代码，只不过编译器更直接点，将泛型java代码直接转换成普通java字节码。

也就是说，在代码中的List<String>和 List<Integer>使用的类，经过编译后都是同一个类。

所以说泛型技术实际上是Java语言的一颗语法糖，因为泛型经过编译器处理之后就被擦除了。

这种擦除的过程，被称之为--类型擦除。所以类型擦除指的是通过类型参数合并，将泛型类型实例关联到同份字节码上。编译器只为泛型类型生成一份字节码，并将其实例关联到这份字节码上。类型擦除的关键在于从泛型类型中清除类型参数的相关信息，并且在必要的时候添加类型检查和类型转换的方法。



### 泛型上下界限

`<? extends T>`表示类型的上界，表示参数化类型的可能是T 或是 T的子类

`<? super T>`表示类型下界(Java Core中叫超类型限定)，表示参数化类型是此类型的超类型(父类型)，直至Object



### SPI的应用场景

适用于：调用者可以根据实际使用需要，启用、扩展、或者替换框架的实现策略。比较常见的例子

1.数据库驱动加载接口实现类的加载

2.JDBC加载不同类型数据库的驱动

3.日志门面接口实现类加载

4.SLF4J加载不同提供商的日志实现类

Spring

Spring中大量使用了SPl。比如：对servlet3.0规范对ServletContainerlnitializer的实现、自动类型转换TypeConversion SPl(Converter SPl、Formatter SPl)等

Dubbo

Dubbo中也大量使用SPI的方式实现框架的扩展，不过它对Java提供的原生SPI做了封装，允许用户扩展实现Filter接口



### Java中创建对象的方式

使用new

使用反射。Class类或Constructor类的newInstance方法。

使用clone方法

使用反序列化。ObjectOutputStream

使用方法句柄。

```java
class MyClass {
    private String message;

    public MyClass(String message) {
        this.message = message;
    }

    public String getMessage() {
        return message;
    }
}

public class MethodHandleExample {
    public static void main(String[] args) throws Throwable {
        MethodHandles.Lookup lookup = MethodHandles.lookup();
        MethodType constructorType = MethodType.methodType(void.class, String.class);
        var constructor = lookup.findConstructor(MyClass.class, constructorType);
        
        MyClass myObject = (MyClass) constructor.invoke("Hello MethodHandle!"); // 使用方法句柄创建对象
        System.out.println("Created object with message: " + myObject.getMessage());
    }
}
```



### JDK新版本的特性

这道题面试官是想知道你是不是经常关心前沿技术。

- JDK 8中推出了Lambda表达式、Stream、Optional、新的日期API等JDK 9中推出了模块化
- JDK 10中推出了本地变量类型推断
- JDK 12中增加了switch表达式
- JDK13中增加了text block
- JDK 14中增加了Records，instance模式匹配
- JDK 15中增加了封闭类
- JDK 17中扩展了switch模式匹配
- JDK 19中增加了协程



# IO

### 解释BIO、NIO、AIO

BIO(Blocking l/O)

同步阻塞l/O，是JDK1.4之前的传统IO模型。 线程发起IO请求后，一直阻塞，直到缓冲区数据就绪后，再进入下一步操作。

NIO(Non-Blocking l/O)

同步非阻塞IO，线程发起IO请求后，不需要阻塞，立即返回。用户线程不原地等待IO缓冲区，可以先做一些其他操作，只需要定时轮询检查IO缓冲区数据是否就绪即可。

AIO (Asynchronous I/O)

异步非阻塞l/O模型。线程发起IO请求后，不需要阻塞，立即返回，也不需要定时轮询检查结果，异步IO操作之后会回调通知调用方。

![](https://pics2.baidu.com/feed/95eef01f3a292df52b17c1059eeb0e6c35a87334.jpeg@f_auto?token=9fa51b8435f6c110d8500fbcf55359a8)





### 深拷贝和浅拷贝

Java中的深拷贝和浅拷贝是针对对象复制时的两种不同方式：

1. 浅拷贝（Shallow Copy）：浅拷贝是指只复制对象本身和其内部的基本数据类型的值，而不复制对象内部的引用类型的数据。即新对象和原对象的引用类型字段指向的是同一个对象。如果原对象内部包含引用类型字段，浅拷贝后的对象和原对象的引用类型字段指向的是同一个对象，修改其中一个对象的引用类型字段会影响另一个对象。
2. 深拷贝（Deep Copy）：深拷贝是指复制对象本身以及其所有内部的引用类型数据，即创建一个新的对象，同时复制原对象内部所有引用类型字段指向的对象。深拷贝后的对象和原对象完全独立，修改其中一个对象的引用类型字段不会影响另一个对象。

推荐实现深拷贝的方式是通过序列化和反序列化来实现，因为序列化会将对象及其内部的所有对象都进行序列化，然后再反序列化得到一个全新的对象，从而实现深拷贝。以下是一个简单的示例代码：

```java
import java.io.*;

class MyClass implements Serializable {
    private String message;

    public MyClass(String message) {
        this.message = message;
    }

    public String getMessage() {
        return message;
    }
}

public class DeepCopyExample {
    public static void main(String[] args) {
        MyClass original = new MyClass("Hello, World!");

        // 深拷贝对象original
        MyClass deepCopy = deepCopy(original);

        System.out.println("Original object message: " + original.getMessage());
        System.out.println("Deep copy object message: " + deepCopy.getMessage());
    }

    public static <T extends Serializable> T deepCopy(T object) {
        try {
            ByteArrayOutputStream bos = new ByteArrayOutputStream();
            ObjectOutputStream out = new ObjectOutputStream(bos);
            out.writeObject(object);
            out.flush();

            ByteArrayInputStream bis = new ByteArrayInputStream(bos.toByteArray());
            ObjectInputStream in = new ObjectInputStream(bis);
            return (T) in.readObject();
        } catch (IOException | ClassNotFoundException e) {
            e.printStackTrace();
            return null;
        }
    }
}
```

使用Hutool实现深拷贝

```java
public static void main(String[] args) {
    MyClass original = new MyClass("Hello, World!");
    MyClass deepCopy = ObjectUtil.cloneByStream(original);

    System.out.println("Original object message: " + original.getMessage());
    System.out.println("Deep copy object message: " + deepCopy.getMessage());
}
```

Apache Commons

```java
MyClass original = new MyClass("Hello, World!");
MyClass deepCopy = SerializationUtils.clone(original);
```

Gson库

```java
Gson gson = new Gson();
MyClass original = new MyClass("Hello, World!");
MyClass deepCopy = gson.fromJson(gson.toJson(original), MyClass.class);
```

Jackson库

```java
ObjectMapper objectMapper = new ObjectMapper();
MyClass original = new MyClass("Hello, World!");
MyClass deepCopy = objectMapper.readValue(objectMapper.writeValueAsString(original), MyClass.class);
```



### 序列化和反序列化是什么？

在Java中，我们可以通过多种方式来创建对象，并且只要对象没有被回收我们都可以复用该对象。

但是，我们创建出来的这些Java对象都是存在于JVM的堆内存中的。只有JVM处于运行状态的时候，这些对象才可能存在。一旦JVM停止运行，这些对象的状态也就随之而丢失了

但是在真实的应用场景中，我们需要将这些对象持久化下来，并且能够在需要的时候把对象重新读取出来。Java的对象序列化可以帮助我们实现该功能。

对象序列化机制是Java语言内建的一种对象持久化方式，通过对象序列化，可以把对象的状态保存为字节数组，并且可以在有需要的时候将这个字节数组通过反序列化的方式再转换成对象。对象序列化可以很容易的在JVM中的活动对象和字节数组(流)之间进行转换。

所以序列化就是把Java对象序列化成字节数组的过程，反序列化就是把字节数组再转换成Java对象的过程



# 异常

## 对象

### Throwable,Exception,Error,RuntimeException



## 处理

### finally中的代码一定执行么？

通常情况下，finally的代码被执行的前提是：

1、对应 try 语句块被执行,
2、程序正常运行。

如果没有符合这两个条件的话，finally中的代码就无法被执行，如发生以下情况，都会导致finally不会执行

1、System.exit()方法被执行
2、Runtime.getRuntime().halt()方法被执行
3、try或者catch中有死循环
4、操作系统强制杀掉了JM进程，如执行了kil -9
5、其他原因导致的虚拟机崩溃了
6、虚拟机所运行的环境挂了，如计算机电源断了
7、如果一个finally是由守护线程执行的，那么是不保证一定能执行的，如果这时候JM要退出，JM会检查其他非守护线程，如果都执行完了，那么就直接退出了。这时候finally可能就没办法执行完。



### try、catch、finally中都有return

例如：try中return A，catch中return B， finally中return c，最终返回值是什么?

最终的返回值将会是C!

finally块总是在try和catch块之后执行，无论是否有异常发生。如果finally块中有一个return语句，它将覆盖try块和catch块中的任何return语句。



