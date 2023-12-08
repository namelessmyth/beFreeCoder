# J2SE

# 多线程并发

## 概念

### Happens-Before原则

#### 设计意图

1. 对于编译器和处理器来说，它们希望约束尽量少一些，毕竟限制越多越影响它们的执行效率，不能让他们尽己所能的优化来提供性能。所以他们需要一个弱内存模型。
2. 程序员写代码时，是要求内存模型易于理解，易于编程，所以需要依赖一个强内存模型来编码。 也就是说向公理一样，定义好的规则，我们遵守规则写代码就完事了。

上面谈到的两点明显是冲突的，作为程序员我们希望JMM提供给我们一个强内存模型，而底层的编译器和处理器又需要一个弱内存模型来提高自己的性能。所以我们需要找到一个平衡点，来满足程序员的需求，同时也尽可能满足编译器和处理器限制放松，性能最大化。

因此JMM在设计时，定义了如下原则：

1. 对于会改变程序执行结果的重排序，JMM要求编译器和处理器必须禁止这种重排序。
2. 对于不会改变程序执行结果的重排序，JMM对编译器和处理器不做要求（JMM允许这种重排序）。

例如，如果编译器经过细致的分析后，认定一个锁只会被单个线程访问，那么这个锁可以被消除。再如，如果编译器经过细致的分析后，认定一个volatile变量只会被单个线程访问，那么编译器可以把这个volatile变量当作一个普通变量来对待。这些优化既不会改变程序的执行结果，又能提高程序的执行效率。

不需要过分的关注happens-before原则，写出线程安全的代码才是关注重点。

#### Happens-Before介绍

JSR-133使用happens-before的概念来指定两个操作之间的执行顺序。由于这两个操作可以在一个线程之内，也可以是在不同线程之间。因此，JMM可以通过happens-before关系向程序员提供跨线程的内存可见性保证。

如果A线程的写操作a，与B线程的读操作b之间存在happens-before关系，尽管a操作和b操作在不同的线程中执行，但JMM向程序员保证a操作将对b操作可见。具体的定义如下：

1. 如果一个操作happens-before另一个操作，那么第一个操作的执行结果将对第二个操作可见，而且第一个操作的执行顺序排在第二个操作之前。
2. 两个操作之间存在happens-before关系，并不意味着Java平台的具体实现必须要按照happens-before关系指定的顺序来执行。如果重排序之后的执行结果，与按happens-before关系来执行的结果一致，那么这种重排序并不非法（也就是说，JMM允许这种重排序）。

上面的1.是JMM对程序员的承诺。从程序员的角度来说，可以这样理解happens-before关系：如果A happens-before  B，那么Java内存模型将向程序员保证：A操作的结果将对B可见，且A的执行顺序排在B之前。注意：这只是Java内存模型向程序员做出的保证！

上面的2.是JMM对编译器和处理器重排序的约束原则。正如前面所言，JMM其实是在遵循一个基本原则：只要不改变程序的执行结果（指的是单线程程序和正确同步的多线程程序），编译器和处理器怎么优化都行。JMM这么做的原因是：程序员对于这两个操作是否真的被重排序并不关心，程序员关心的是程序执行时的语义不能被改变（即执行结果不能被改变）。因此，happens-before关系本质上和as-if-serial语义是一回事。

#### 概述

  　　1. 程序顺序规则：在同一个线程中，书写在前面的操作happen-before后面的操作。
  　　2. 监视器锁原则：同一个锁的解锁操作一定happen-before此锁的lock操作。
  　　3. volatile的happen-before原则： 对一个volatile变量的写操作happen-before对此变量的任意操作。
  　　4. happen-before的传递性原则： 如果A操作 happen-before B操作，B操作happen-before C操作，那么A操作happen-before C操作。
  　　5. 线程启动的happen-before原则：同一个线程的start方法happen-before此线程的其它方法。
  　　6. 线程中断的happen-before原则：对线程interrupt方法的调用happen-before被中断线程的检测到中断发送的代码。
  　　7. 线程终结的happen-before原则：线程中的所有操作都happen-before线程的终止检测。
  　　8. 对象创建的happen-before原则：一个对象的初始化完成先于他的finalize方法调用。



#### 程序顺序规则

一个线程中，按照程序的顺序，前面的操作happens-before后续的任何操作。

对于这一点，可能会有疑问。顺序性是指，我们可以按照顺序推演程序的执行结果，但是编译器未必一定会按照这个顺序编译，但是编译器保证结果一定等于程序顺序推演的结果。

```java
int a = 2;
int b = 3;
int c = a*b;//无论怎么排序不能改变单线程下 c=6的这个结果
```

#### volatile变量规则

对一个volatile变量的写操作，Happens-Before于后续对这个变量的读操作。

也就是说，只要有一个线程先对volatile变量进行写操作，那后面线程去读这个变量时一定能读到正确的结果。这个需要大家重点理解。

#### 监视器锁规则

```java
//如果存在锁，那一个线程对锁的释放，一定happens before其他线程对于这个变量的加锁操作
int x = 0;
synchronized(this){
    //其他线程这个地方读到一定是12
    if(x < 12){
        X = 12;
    }
}
```

#### 线程启动规则（Start）

在主线程A执行过程中，启动子线程B，那么主线程A在启动子线程之前操作对start之后的线程B可见。

```java
//在线程start之前的操作一定happens before 线程内部的操作。
public static void StartDemo(){
    int x = 0;
    Thread t = new Thread(()->{
        if(x == 20){
            //这里X一定是20
        }
    });
    
    x = 20;
    t.start();
}
```

#### Join规则（线程终止规则）

```java
//一个线程join()之前的操作，一定对join之后的主线程可见。
int x = 0;
public static void joinDemo(){
    Thread t = new Thread(()->{
        x = 200;
    });
    t.start();
    t.join();
    //这里X一定是200
}
```

#### 中断规则

interrupt() 方法的调用，happens before线程检测到中断事件的发生，即你检测到中断事件时，一定是在 interrupt 方法后

#### 对象终结规则

一个对象的初始化完成，也就是构造函数执行的结束一定 happens-before它的finalize()方法。

#### 传递性规则

如果 a happens before b, b happens before c

那 a happens before  c



## **线程的基础概念**

#### 一、**基础概念**

##### 1.1 进程与线程A

什么是进程？

**进程是指运行中的程序。 比如我们使用钉钉，浏览器，需要启动这个程序，操作系统会给这个程序分配一定的资源（占用内存资源）。**

什么线程？

**线程是CPU调度的基本单位，每个线程执行的都是某一个进程的代码的某个片段。**

举个栗子：房子与人

比如现在有一个100平的房子，这个方式可以看做是一个进程

房子里有人，人就可以看做成一个线程。

人在房子中做一个事情，比如吃饭，学习，睡觉。这个就好像线程在执行某个功能的代码。

所谓进程就是线程的容器，需要线程利用进程中的一些资源，处理一个代码、指令。最终实现进程锁预期的结果。

进程和线程的区别：

* 根本不同：进程是操作系统分配的资源，而线程是CPU调度的基本单位。
* 资源方面：同一个进程下的线程共享进程中的一些资源。线程同时拥有自身的独立存储空间。进程之间的资源通常是独立的。
* 数量不同：进程一般指的就是一个进程。而线程是依附于某个进程的，而且一个进程中至少会有一个或多个线程。
* 开销不同：毕竟进程和线程不是一个级别的内容，线程的创建和终止的时间是比较短的。而且线程之间的切换比进程之间的切换速度要快很多。而且进程之间的通讯很麻烦，一般要借助内核才可以实现，而线程之间通讯，相当方面。
* ………………

##### 1.2 多线程

什么是多线程？

多线程是指：**单个进程中同时运行多个线程。**

多线程的不低是为了提高CPU的利用率。

可以通过避免一些网络IO或者磁盘IO等需要等待的操作，让CPU去调度其他线程。

这样可以大幅度的提升程序的效率，提高用户的体验。

比如Tomcat可以做并行处理，提升处理的效率，而不是一个一个排队。

不如要处理一个网络等待的操作，开启一个线程去处理需要网络等待的任务，让当前业务线程可以继续往下执行逻辑，效率是可以得到大幅度提升的。

多线程的局限

* 如果线程数量特别多，CPU在切换线程上下文时，会额外造成很大的消耗。
* 任务的拆分需要依赖业务场景，有一些异构化的任务，很难对任务拆分，还有很多业务并不是多线程处理更好。
* **线程安全问题**：虽然多线程带来了一定的性能提升，但是再做一些操作时，多线程如果操作临界资源，可能会发生一些数据不一致的安全问题，甚至涉及到锁操作时，会造成死锁问题。

##### 1.3 串行、并行、并发

什么是串行：

串行就是一个一个排队，第一个做完，第二个才能上。

什么是并行：

并行就是同时处理。（一起上！！！）

什么是并发：

这里的并发并不是三高中的高并发问题，这里是多线程中的并发概念（CPU调度线程的概念）。CPU在极短的时间内，反复切换执行不同的线程，看似好像是并行，但是只是CPU高速的切换。

并行囊括并发。

并行就是多核CPU同时调度多个线程，是真正的多个线程同时执行。

单核CPU无法实现并行效果，单核CPU是并发。

##### 1.4 同步异步、阻塞非阻塞

同步与异步：执行某个功能后，被调用者是否会**主动反馈**信息

阻塞和非阻塞：执行某个功能后，调用者是否需要**一直等待结果**的反馈。

两个概念看似相似，但是侧重点是完全不一样的。

**同步阻塞**：比如用锅烧水，水开后，不会主动通知你。烧水开始执行后，需要一直等待水烧开。

**同步非阻塞**：比如用锅烧水，水开后，不会主动通知你。烧水开始执行后，不需要一直等待水烧开，可以去执行其他功能，但是需要时不时的查看水开了没。

**异步阻塞**：比如用水壶烧水，水开后，会主动通知你水烧开了。烧水开始执行后，需要一直等待水烧开。

**异步非阻塞**：比如用水壶烧水，水开后，会主动通知你水烧开了。烧水开始执行后，不需要一直等待水烧开，可以去执行其他功能。

异步非阻塞这个效果是最好的，平时开发时，提升效率最好的方式就是采用异步非阻塞的方式处理一些多线程的任务。

#### 二、**线程的创建**

线程的创建分为三种方式：

##### 2.1 继承Thread类 重写run方法

启动线程是调用start方法，这样会创建一个新的线程，并执行线程的任务。

如果直接调用run方法，这样会让当前线程执行run方法中的业务逻辑。

```java
public class MiTest {

    public static void main(String[] args) {
        MyJob t1 = new MyJob();
        t1.start();
        for (int i = 0; i < 100; i++) {
            System.out.println("main:" + i);
        }
    }

}
class MyJob extends Thread{
    @Override
    public void run() {
        for (int i = 0; i < 100; i++) {
            System.out.println("MyJob:" + i);
        }
    }
}

```

##### 2.2 实现Runnable接口 重写run方法

```java
public class MiTest {

    public static void main(String[] args) {
        MyRunnable myRunnable = new MyRunnable();
        Thread t1 = new Thread(myRunnable);
        t1.start();
        for (int i = 0; i < 1000; i++) {
            System.out.println("main:" + i);
        }
    }

}

class MyRunnable implements Runnable{

    @Override
    public void run() {
        for (int i = 0; i < 1000; i++) {
            System.out.println("MyRunnable:" + i);
        }

    }
}
```

最常用的方式：

* 匿名内部类方式：

  ```java
  Thread t1 = new Thread(new Runnable() {
      @Override
      public void run() {
          for (int i = 0; i < 1000; i++) {
              System.out.println("匿名内部类:" + i);
          }
      }
  });
  ```

* lambda方式：

  ```java
  Thread t2 = new Thread(() -> {
      for (int i = 0; i < 100; i++) {
          System.out.println("lambda:" + i);
      }
  });
  ```

##### 2.3 实现Callable 重写call方法，配合FutureTask

Callable一般用于有返回结果的非阻塞的执行方法

同步非阻塞。

```java
public class MiTest {

    public static void main(String[] args) throws ExecutionException, InterruptedException {
        //1. 创建MyCallable
        MyCallable myCallable = new MyCallable();
        //2. 创建FutureTask，传入Callable
        FutureTask futureTask = new FutureTask(myCallable);
        //3. 创建Thread线程
        Thread t1 = new Thread(futureTask);
        //4. 启动线程
        t1.start();
        //5. 做一些操作
        //6. 要结果
        Object count = futureTask.get();
        System.out.println("总和为：" + count);
    }
}

class MyCallable implements Callable{

    @Override
    public Object call() throws Exception {
        int count = 0;
        for (int i = 0; i < 100; i++) {
            count += i;
        }
        return count;
    }
}
```

##### 2.4 基于线程池构建线程

追其底层，其实只有一种，实现Runnble

#### **二、线程的使用**

##### 2.1 线程的状态

网上对线程状态的描述很多，有5种，6种，7种，都可以接受

5中状态一般是针对传统的线程状态来说（操作系统层面）

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1654095150060/b802326396694bd8a4e17ab21a04d348.png)

Java中给线程准备的6种状态

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1654095150060/558ee9b72713409c8d9486410aa0074e.png)

NEW：Thread对象被创建出来了，但是还没有执行start方法。

RUNNABLE：Thread对象调用了start方法，就为RUNNABLE状态（CPU调度/没有调度）

BLOCKED、WAITING、TIME_WAITING：都可以理解为是阻塞、等待状态，因为处在这三种状态下，CPU不会调度当前线程

BLOCKED：synchronized没有拿到同步锁，被阻塞的情况

WAITING：调用wait方法就会处于WAITING状态，需要被手动唤醒

TIME_WAITING：调用sleep方法或者join方法，会被自动唤醒，无需手动唤醒

TERMINATED：run方法执行完毕，线程生命周期到头了

在Java代码中验证一下效果

NEW：

```java
public static void main(String[] args) throws InterruptedException {
    Thread t1 = new Thread(() -> {
  
    });
    System.out.println(t1.getState());
}
```

RUNNABLE：

```java
public static void main(String[] args) throws InterruptedException {
    Thread t1 = new Thread(() -> {
        while(true){

        }
    });
    t1.start();
    Thread.sleep(500);
    System.out.println(t1.getState());
}
```

BLOCKED：

```java
public static void main(String[] args) throws InterruptedException {
    Object obj = new Object();
    Thread t1 = new Thread(() -> {
        // t1线程拿不到锁资源，导致变为BLOCKED状态
        synchronized (obj){

        }
    });
    // main线程拿到obj的锁资源
    synchronized (obj) {
        t1.start();
        Thread.sleep(500);
        System.out.println(t1.getState());
    }
}
```

WAITING：

```java
public static void main(String[] args) throws InterruptedException {
    Object obj = new Object();
    Thread t1 = new Thread(() -> {
        synchronized (obj){
            try {
                obj.wait();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    });
    t1.start();
    Thread.sleep(500);
    System.out.println(t1.getState());
}
```

TIMED_WAITING：

```java
public static void main(String[] args) throws InterruptedException {
    Thread t1 = new Thread(() -> {
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    });
    t1.start();
    Thread.sleep(500);
    System.out.println(t1.getState());
}
```

TERMINATED：

```java
public static void main(String[] args) throws InterruptedException {
    Thread t1 = new Thread(() -> {
        try {
            Thread.sleep(500);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    });
    t1.start();
    Thread.sleep(1000);
    System.out.println(t1.getState());
}
```

##### 2.2 线程的常用方法

###### 2.2.1 获取当前线程

Thread的静态方法获取当前线程对象

```java
public static void main(String[] args) throws ExecutionException, InterruptedException {
	// 获取当前线程的方法
    Thread main = Thread.currentThread();
    System.out.println(main);
    // "Thread[" + getName() + "," + getPriority() + "," +  group.getName() + "]";
    // Thread[main,5,main]
}
```

###### 2.2.2 线程的名字

在构建Thread对象完毕后，一定要设置一个有意义的名称，方面后期排查错误

```java
public static void main(String[] args) throws ExecutionException, InterruptedException {
    Thread t1 = new Thread(() -> {
        System.out.println(Thread.currentThread().getName());
    });
    t1.setName("模块-功能-计数器");
    t1.start();
}
```

###### 2.2.3 线程的优先级

其实就是CPU调度线程的优先级、

java中给线程设置的优先级别有10个级别，从1~10任取一个整数。

如果超出这个范围，会排除参数异常的错误

```java
public static void main(String[] args) throws ExecutionException, InterruptedException {
    Thread t1 = new Thread(() -> {
        for (int i = 0; i < 1000; i++) {
            System.out.println("t1:" + i);
        }
    });
    Thread t2 = new Thread(() -> {
        for (int i = 0; i < 1000; i++) {
            System.out.println("t2:" + i);
        }
    });
    t1.setPriority(1);
    t2.setPriority(10);
    t2.start();
    t1.start();
}
```

###### 2.2.4 线程的让步

可以通过Thread的静态方法yield，让当前线程从运行状态转变为就绪状态。

```java
public static void main(String[] args) throws ExecutionException, InterruptedException {
    Thread t1 = new Thread(() -> {
        for (int i = 0; i < 100; i++) {
            if(i == 50){
                Thread.yield();
            }
            System.out.println("t1:" + i);
        }
    });
    Thread t2 = new Thread(() -> {
        for (int i = 0; i < 100; i++) {
            System.out.println("t2:" + i);
        }
    });
    t2.start();
    t1.start();
}
```

###### 2.2.5 线程的休眠

Thread的静态方法，让线程从运行状态转变为等待状态

sleep有两个方法重载：

* 第一个就是native修饰的，让线程转为等待状态的效果
* 第二个是可以传入毫秒和一个纳秒的方法（如果纳秒值大于等于0.5毫秒，就给休眠的毫秒值+1。如果传入的毫秒值是0，纳秒值不为0，就休眠1毫秒）

sleep会抛出一个InterruptedException

```java
public static void main(String[] args) throws InterruptedException {
    System.out.println(System.currentTimeMillis());
    Thread.sleep(1000);
    System.out.println(System.currentTimeMillis());
}
```

###### 2.2.6 线程的强占

Thread的非静态方法join方法

需要在某一个线程下去调用这个方法

如果在main线程中调用了t1.join()，那么main线程会进入到等待状态，需要等待t1线程全部执行完毕，在恢复到就绪状态等待CPU调度。

如果在main线程中调用了t1.join(2000)，那么main线程会进入到等待状态，需要等待t1执行2s后，在恢复到就绪状态等待CPU调度。如果在等待期间，t1已经结束了，那么main线程自动变为就绪状态等待CPU调度。

```java
public static void main(String[] args) throws InterruptedException {
    Thread t1 = new Thread(() -> {
        for (int i = 0; i < 10; i++) {
            System.out.println("t1:" + i);
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    });
    t1.start();
    for (int i = 0; i < 10; i++) {
        System.out.println("main:" + i);
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        if (i == 1){
            try {
                t1.join(2000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}
```

###### 2.2.7 守护线程

默认情况下，线程都是非守护线程

JVM会在程序中没有非守护线程时，结束掉当前JVM

主线程默认是非守护线程，如果主线程执行结束，需要查看当前JVM内是否还有非守护线程，如果没有JVM直接停止

```java
public static void main(String[] args) throws InterruptedException {
    Thread t1 = new Thread(() -> {
        for (int i = 0; i < 10; i++) {
            System.out.println("t1:" + i);
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    });
    t1.setDaemon(true);
    t1.start();
}
```

###### 2.2.8 线程的等待和唤醒

可以让获取synchronized锁资源的线程通过wait方法进去到锁的**等待池**，并且会释放锁资源

可以让获取synchronized锁资源的线程，通过notify或者notifyAll方法，将等待池中的线程唤醒，添加到**锁池**中

notify随机的唤醒等待池中的一个线程到锁池

notifyAll将等待池中的全部线程都唤醒，并且添加到锁池

在调用wait方法和notify以及norifyAll方法时，必须在synchronized修饰的代码块或者方法内部才可以，因为要操作基于某个对象的锁的信息维护。

```java
public static void main(String[] args) throws InterruptedException {
    Thread t1 = new Thread(() -> {
        sync();
    },"t1");

    Thread t2 = new Thread(() -> {
        sync();
    },"t2");
    t1.start();
    t2.start();
    Thread.sleep(12000);
    synchronized (MiTest.class) {
        MiTest.class.notifyAll();
    }
}

public static synchronized void sync()  {
    try {
        for (int i = 0; i < 10; i++) {
            if(i == 5) {
                MiTest.class.wait();
            }
            Thread.sleep(1000);
            System.out.println(Thread.currentThread().getName());
        }
    } catch (InterruptedException e) {
        e.printStackTrace();
    }
}
```

##### 2.3 线程的结束方式

线程结束方式很多，最常用就是让线程的run方法结束，无论是return结束，还是抛出异常结束，都可以

###### 2.3.1 stop方法（不用）

强制让线程结束，无论你在干嘛，不推荐使用当然当然方式，但是，他确实可以把线程干掉

```java
public static void main(String[] args) throws InterruptedException {
    Thread t1 = new Thread(() -> {
        try {
            Thread.sleep(5000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    });
    t1.start();
    Thread.sleep(500);
    t1.stop();
    System.out.println(t1.getState());
}
```

###### 2.3.2 使用共享变量（很少会用）

这种方式用的也不多，有的线程可能会通过死循环来保证一直运行。

咱们可以通过修改共享变量在破坏死循环，让线程退出循环，结束run方法

```java
static volatile boolean flag = true;

public static void main(String[] args) throws InterruptedException {
    Thread t1 = new Thread(() -> {
        while(flag){
            // 处理任务
        }
        System.out.println("任务结束");
    });
    t1.start();
    Thread.sleep(500);
    flag = false;
}
```

###### 2.3.3 interrupt方式

共享变量方式

```java
public static void main(String[] args) throws InterruptedException {
    // 线程默认情况下，    interrupt标记位：false
    System.out.println(Thread.currentThread().isInterrupted());
    // 执行interrupt之后，再次查看打断信息
    Thread.currentThread().interrupt();
    // interrupt标记位：ture
    System.out.println(Thread.currentThread().isInterrupted());
    // 返回当前线程，并归位为false interrupt标记位：ture
    System.out.println(Thread.interrupted());
    // 已经归位了
    System.out.println(Thread.interrupted());

    // =====================================================
    Thread t1 = new Thread(() -> {
        while(!Thread.currentThread().isInterrupted()){
            // 处理业务
        }
        System.out.println("t1结束");
    });
    t1.start();
    Thread.sleep(500);
    t1.interrupt();
}
```

通过打断WAITING或者TIMED_WAITING状态的线程，从而抛出异常自行处理

这种停止线程方式是最常用的一种，在框架和JUC中也是最常见的

```java
public static void main(String[] args) throws InterruptedException {
    Thread t1 = new Thread(() -> {
        while(true){
            // 获取任务
            // 拿到任务，执行任务
            // 没有任务了，让线程休眠
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
                System.out.println("基于打断形式结束当前线程");
                return;
            }
        }
    });
    t1.start();
    Thread.sleep(500);
    t1.interrupt();
}
```

wait和sleep的区别？

* 单词不一样。
* sleep属于Thread类中的static方法、wait属于Object类的方法
* sleep属于TIMED_WAITING，自动被唤醒、wait属于WAITING，需要手动唤醒。
* sleep方法在持有锁时，执行，不会释放锁资源、wait在执行后，会释放锁资源。
* sleep可以在持有锁或者不持有锁时，执行。 wait方法必须在只有锁时才可以执行。

wait方法会将持有锁的线程从owner扔到WaitSet集合中，这个操作是在修改ObjectMonitor对象，如果没有持有synchronized锁的话，是无法操作ObjectMonitor对象的。

## **并发编程的三大特性**

### **一、原子性**

##### 1.1 什么是并发编程的原子性

JMM（Java Memory Model）。不同的硬件和不同的操作系统在内存上的操作有一定差异的。Java为了解决相同代码在不同操作系统上出现的各种问题，用JMM屏蔽掉各种硬件和操作系统带来的差异。

让Java的并发编程可以做到跨平台。

JMM规定所有变量都会存储在主内存中，在操作的时候，需要从主内存中复制一份到线程内存（CPU内存），在线程内部做计算。**然后再写回主内存中（不一定！）。**

**原子性的定义：原子性指一个操作是不可分割的，不可中断的，一个线程在执行时，另一个线程不会影响到他。**

并发编程的原子性用代码阐述：

```java
private static int count;

public static void increment(){
    try {
        Thread.sleep(10);
    } catch (InterruptedException e) {
        e.printStackTrace();
    }
    count++;
}

public static void main(String[] args) throws InterruptedException {
    Thread t1 = new Thread(() -> {
        for (int i = 0; i < 100; i++) {
           increment();
        }
    });
    Thread t2 = new Thread(() -> {
        for (int i = 0; i < 100; i++) {
            increment();
        }
    });
    t1.start();
    t2.start();
    t1.join();
    t2.join();
    System.out.println(count);
}
```

当前程序：多线程操作共享数据时，预期的结果，与最终的结果不符。

**原子性：多线程操作临界资源，预期的结果与最终结果一致。**

通过对这个程序的分析，可以查看出，++的操作，一共分为了三部，首先是线程从主内存拿到数据保存到CPU的寄存器中，然后在寄存器中进行+1操作，最终将结果写回到主内存当中。

#### 1.2 保证并发编程的原子性

##### 1.2.1 synchronized

因为++操作可以从指令中查看到

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1654095150060/c53311e92c734b248e0c31ef615e8c4f.png)

可以在方法上追加synchronized关键字或者采用同步代码块的形式来保证原子性

synchronized可以让避免多线程同时操作临街资源，同一时间点，只会有一个线程正在操作临界资源

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1654095150060/4d92d0e53d49438fafa4f2c9710aa398.png)

##### 1.2.2 CAS

到底什么是CAS

compare and swap也就是比较和交换，他是一条CPU的并发原语。

他在替换内存的某个位置的值时，首先查看内存中的值与预期值是否一致，如果一致，执行替换操作。这个操作是一个原子性操作。

Java中基于Unsafe的类提供了对CAS的操作的方法，JVM会帮助我们将方法实现CAS汇编指令。

但是要清楚CAS只是比较和交换，在获取原值的这个操作上，需要你自己实现。

```java
private static AtomicInteger count = new AtomicInteger(0);

public static void main(String[] args) throws InterruptedException {
    Thread t1 = new Thread(() -> {
        for (int i = 0; i < 100; i++) {
            count.incrementAndGet();
        }
    });
    Thread t2 = new Thread(() -> {
        for (int i = 0; i < 100; i++) {
            count.incrementAndGet();
        }
    });
    t1.start();
    t2.start();
    t1.join();
    t2.join();
    System.out.println(count);
}
```

Doug Lea在CAS的基础上帮助我们实现了一些原子类，其中就包括现在看到的AtomicInteger，还有其他很多原子类……

**CAS的缺点**：CAS只能保证对一个变量的操作是原子性的，无法实现对多行代码实现原子性。

**CAS的问题**：

* **ABA问题**：问题如下，可以引入版本号的方式，来解决ABA的问题。Java中提供了一个类在CAS时，针对各个版本追加版本号的操作。 AtomicStampeReference![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1654095150060/1a90706738b3476d81d038d2648d3c7c.png)

* AtomicStampedReference在CAS时，不但会判断原值，还会比较版本信息。

* ```java
  public static void main(String[] args) {
      AtomicStampedReference<String> reference = new AtomicStampedReference<>("AAA",1);
  
      String oldValue = reference.getReference();
      int oldVersion = reference.getStamp();
  
      boolean b = reference.compareAndSet(oldValue, "B", oldVersion, oldVersion + 1);
      System.out.println("修改1版本的：" + b);
  
      boolean c = reference.compareAndSet("B", "C", 1, 1 + 1);
      System.out.println("修改2版本的：" + c);
  }
  ```

* **自旋时间过长问题**：

  * 可以指定CAS一共循环多少次，如果超过这个次数，直接失败/或者挂起线程。（自旋锁、自适应自旋锁）
  * 可以在CAS一次失败后，将这个操作暂存起来，后面需要获取结果时，将暂存的操作全部执行，再返回最后的结果。

##### 1.2.3 Lock锁

Lock锁是在JDK1.5由Doug Lea研发的，他的性能相比synchronized在JDK1.5的时期，性能好了很多多，但是在JDK1.6对synchronized优化之后，性能相差不大，但是如果涉及并发比较多时，推荐ReentrantLock锁，性能会更好。

实现方式：

```java
private static int count;

private static ReentrantLock lock = new ReentrantLock();

public static void increment()  {
    lock.lock();
    try {
        count++;
        try {
            Thread.sleep(10);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    } finally {
        lock.unlock();
    }


}

public static void main(String[] args) throws InterruptedException {
    Thread t1 = new Thread(() -> {
        for (int i = 0; i < 100; i++) {
            increment();
        }
    });
    Thread t2 = new Thread(() -> {
        for (int i = 0; i < 100; i++) {
            increment();
        }
    });
    t1.start();
    t2.start();
    t1.join();
    t2.join();
    System.out.println(count);
}
```

ReentrantLock可以直接对比synchronized，在功能上来说，都是锁。

但是ReentrantLock的功能性相比synchronized更丰富。

**ReentrantLock底层是基于AQS实现的，有一个基于CAS维护的state变量来实现锁的操作。**

##### 1.2.4 ThreadLocal

**Java中的四种引用类型**

Java中的使用引用类型分别是**强，软，弱，虚**。

User user = new User（）；

在 Java 中最常见的就是强引用，把一个对象赋给一个引用变量，这个引用变量就是一个强引用。当一个对象被强引用变量引用时，它始终处于可达状态，它是不可能被垃圾回收机制回收的，即使该对象以后永远都不会被用到 JVM 也不会回收。因此强引用是造成 Java 内存泄漏的主要原因之一。

```
SoftReference
```

其次是软引用，对于只有软引用的对象来说，当系统内存足够时它不会被回收，当系统内存空间不足时它会被回收。软引用通常用在对内存敏感的程序中，作为缓存使用。

然后是弱引用，它比软引用的生存期更短，对于只有弱引用的对象来说，只要垃圾回收机制一运行，不管 JVM 的内存空间是否足够，总会回收该对象占用的内存。可以解决内存泄漏问题，ThreadLocal就是基于弱引用解决内存泄漏的问题。

最后是虚引用，它不能单独使用，必须和引用队列联合使用。虚引用的主要作用是跟踪对象被垃圾回收的状态。不过在开发中，我们用的更多的还是强引用。

ThreadLocal保证原子性的方式，是不让多线程去操作**临界资源**，让每个线程去操作属于自己的数据

代码实现

```java
static ThreadLocal tl1 = new ThreadLocal();
static ThreadLocal tl2 = new ThreadLocal();

public static void main(String[] args) {
    tl1.set("123");
    tl2.set("456");
    Thread t1 = new Thread(() -> {
        System.out.println("t1:" + tl1.get());
        System.out.println("t1:" + tl2.get());
    });
    t1.start();

    System.out.println("main:" + tl1.get());
    System.out.println("main:" + tl2.get());
}
```

ThreadLocal实现原理：

* 每个Thread中都存储着一个成员变量，ThreadLocalMap
* ThreadLocal本身不存储数据，像是一个工具类，基于ThreadLocal去操作ThreadLocalMap
* ThreadLocalMap本身就是基于Entry[]实现的，因为一个线程可以绑定多个ThreadLocal，这样一来，可能需要存储多个数据，所以采用Entry[]的形式实现。
* 每一个现有都自己独立的ThreadLocalMap，再基于ThreadLocal对象本身作为key，对value进行存取
* ThreadLocalMap的key是一个弱引用，弱引用的特点是，即便有弱引用，在GC时，也必须被回收。这里是为了在ThreadLocal对象失去引用后，如果key的引用是强引用，会导致ThreadLocal对象无法被回收

ThreadLocal内存泄漏问题：

* 如果ThreadLocal引用丢失，key因为弱引用会被GC回收掉，如果同时线程还没有被回收，就会导致内存泄漏，内存中的value无法被回收，同时也无法被获取到。
* 只需要在使用完毕ThreadLocal对象之后，及时的调用remove方法，移除Entry即可

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1654095150060/e5c66dabcdb94dc2b375ba7cdb22471d.png)

### **二、可见性**

#### 2.1 什么是可见性

可见性问题是基于CPU位置出现的，CPU处理速度非常快，相对CPU来说，去主内存获取数据这个事情太慢了，CPU就提供了L1，L2，L3的三级缓存，每次去主内存拿完数据后，就会存储到CPU的三级缓存，每次去三级缓存拿数据，效率肯定会提升。

这就带来了问题，现在CPU都是多核，每个线程的工作内存（CPU三级缓存）都是独立的，会告知每个线程中做修改时，只改自己的工作内存，没有及时的同步到主内存，导致数据不一致问题。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1654095150060/b3e82a21b18741a1ab3898e3c3ce95a7.png)

可见性问题的代码逻辑

```java
private static boolean flag = true;

public static void main(String[] args) throws InterruptedException {
    Thread t1 = new Thread(() -> {
        while (flag) {
            // ....
        }
        System.out.println("t1线程结束");
    });

    t1.start();
    Thread.sleep(10);
    flag = false;
    System.out.println("主线程将flag改为false");
}
```

#### 2.2 解决可见性的方式

##### 2.2.1 volatile

volatile是一个关键字，用来修饰成员变量。

如果属性被volatile修饰，相当于会告诉CPU，对当前属性的操作，不允许使用CPU的缓存，必须去和主内存操作

volatile的内存语义：

* volatile属性被写：当写一个volatile变量，JMM会将当前线程对应的CPU缓存及时的刷新到主内存中
* volatile属性被读：当读一个volatile变量，JMM会将对应的CPU缓存中的内存设置为无效，必须去主内存中重新读取共享变量

其实加了volatile就是告知CPU，对当前属性的读写操作，不允许使用CPU缓存，加了volatile修饰的属性，会在转为汇编之后后，追加一个lock的前缀，CPU执行这个指令时，如果带有lock前缀会做两个事情：

* 将当前处理器缓存行的数据写回到主内存
* 这个写回的数据，在其他的CPU内核的缓存中，直接无效。

**总结：volatile就是让CPU每次操作这个数据时，必须立即同步到主内存，以及从主内存读取数据。**

```java
private volatile static boolean flag = true;

public static void main(String[] args) throws InterruptedException {
    Thread t1 = new Thread(() -> {
        while (flag) {
            // ....
        }
        System.out.println("t1线程结束");
    });

    t1.start();
    Thread.sleep(10);
    flag = false;
    System.out.println("主线程将flag改为false");
}
```

##### 2.2.2 synchronized

synchronized也是可以解决可见性问题的，synchronized的内存语义。

如果涉及到了synchronized的同步代码块或者是同步方法，获取锁资源之后，将内部涉及到的变量从CPU缓存中移除，必须去主内存中重新拿数据，而且在释放锁之后，会立即将CPU缓存中的数据同步到主内存。

```java
private static boolean flag = true;

public static void main(String[] args) throws InterruptedException {
    Thread t1 = new Thread(() -> {
        while (flag) {
            synchronized (MiTest.class){
                //...
            }
            System.out.println(111);
        }
        System.out.println("t1线程结束");

    });

    t1.start();
    Thread.sleep(10);
    flag = false;
    System.out.println("主线程将flag改为false");
}
```

##### 2.2.3 Lock

Lock锁保证可见性的方式和synchronized完全不同，synchronized基于他的内存语义，在获取锁和释放锁时，对CPU缓存做一个同步到主内存的操作。

Lock锁是基于volatile实现的。Lock锁内部再进行加锁和释放锁时，会对一个由volatile修饰的state属性进行加减操作。

如果对volatile修饰的属性进行写操作，CPU会执行带有lock前缀的指令，CPU会将修改的数据，从CPU缓存立即同步到主内存，同时也会将其他的属性也立即同步到主内存中。还会将其他CPU缓存行中的这个数据设置为无效，必须重新从主内存中拉取。

```java
private static boolean flag = true;
private static Lock lock = new ReentrantLock();

public static void main(String[] args) throws InterruptedException {
    Thread t1 = new Thread(() -> {
        while (flag) {
            lock.lock();
            try{
                //...
            }finally {
                lock.unlock();
            }
        }
        System.out.println("t1线程结束");

    });

    t1.start();
    Thread.sleep(10);
    flag = false;
    System.out.println("主线程将flag改为false");
}
```

##### 2.2.4 final

final修饰的属性，在运行期间是不允许修改的，这样一来，就间接的保证了可见性，所有多线程读取final属性，值肯定是一样。

final并不是说每次取数据从主内存读取，他没有这个必要，而且final和volatile是不允许同时修饰一个属性的

final修饰的内容已经不允许再次被写了，而volatile是保证每次读写数据去主内存读取，并且volatile会影响一定的性能，就不需要同时修饰。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1654095150060/b4dca6c8368846fab361bb8435493e4d.png)

### **三、有序性**

#### 3.1 什么是有序性

在Java中，.java文件中的内容会被编译，在执行前需要再次转为CPU可以识别的指令，CPU在执行这些指令时，为了提升执行效率，在不影响最终结果的前提下（满足一些要求），会对指令进行重排。

指令乱序执行的原因，是为了尽可能的发挥CPU的性能。

Java中的程序是乱序执行的。

Java程序验证乱序执行效果：

```java
static int a,b,x,y;

public static void main(String[] args) throws InterruptedException {
    for (int i = 0; i < Integer.MAX_VALUE; i++) {
        a = 0;
        b = 0;
        x = 0;
        y = 0;

        Thread t1 = new Thread(() -> {
            a = 1;
            x = b;
        });
        Thread t2 = new Thread(() -> {
            b = 1;
            y = a;
        });

        t1.start();
        t2.start();
        t1.join();
        t2.join();

        if(x == 0 && y == 0){
            System.out.println("第" + i + "次，x = "+ x + ",y = " + y);
        }
    }
}
```

单例模式由于指令重排序可能会出现问题：

线程可能会拿到没有初始化的对象，导致在使用时，可能由于内部属性为默认值，导致出现一些不必要的问题

```java
private static volatile MiTest test;

private MiTest(){}

public static MiTest getInstance(){
    // B
    if(test  == null){
        synchronized (MiTest.class){

            if(test == null){
                // A   ,  开辟空间，test指向地址，初始化
                test = new MiTest();
            }
        }
    }
    return test;
}
```

#### 3.2 as-if-serial

as-if-serial语义：

不论指定如何重排序，需要保证单线程的程序执行结果是不变的。

而且如果存在依赖的关系，那么也不可以做指令重排。

```java
// 这种情况肯定不能做指令重排序
int i = 0;
i++;

// 这种情况肯定不能做指令重排序
int j = 200;
j * 100;
j + 100;
// 这里即便出现了指令重排，也不可以影响最终的结果，20100
```

#### 3.4 volatile

如果需要让程序对某一个属性的操作不出现指令重排，除了满足happens-before原则之外，还可以基于volatile修饰属性，从而对这个属性的操作，就不会出现指令重排的问题了。

volatile如何实现的禁止指令重排？

内存屏障概念。将内存屏障看成一条指令。

会在两个操作之间，添加上一道指令，这个指令就可以避免上下执行的其他指令进行重排序。

## **锁**

### 一、**锁的分类**

#### 1.1 可重入锁、不可重入锁

Java中提供的synchronized，ReentrantLock，ReentrantReadWriteLock都是可重入锁。

**重入**：当前线程获取到A锁，在获取之后尝试再次获取A锁是可以直接拿到的。

**不可重入**：当前线程获取到A锁，在获取之后尝试再次获取A锁，无法获取到的，因为A锁被当前线程占用着，需要等待自己释放锁再获取锁。

#### 1.2 乐观锁、悲观锁

Java中提供的synchronized，ReentrantLock，ReentrantReadWriteLock都是悲观锁。

Java中提供的CAS操作，就是乐观锁的一种实现。

**悲观锁**：获取不到锁资源时，会将当前线程挂起（进入BLOCKED、WAITING），线程挂起会涉及到用户态和内核的太的切换，而这种切换是比较消耗资源的。

* 用户态：JVM可以自行执行的指令，不需要借助操作系统执行。
* 内核态：JVM不可以自行执行，需要操作系统才可以执行。

**乐观锁**：获取不到锁资源，可以再次让CPU调度，重新尝试获取锁资源。

Atomic原子性类中，就是基于CAS乐观锁实现的。

#### 1.3 公平锁、非公平锁

Java中提供的synchronized只能是非公平锁。

Java中提供的ReentrantLock，ReentrantReadWriteLock可以实现公平锁和非公平锁

**公平锁**：线程A获取到了锁资源，线程B没有拿到，线程B去排队，线程C来了，锁被A持有，同时线程B在排队。直接排到B的后面，等待B拿到锁资源或者是B取消后，才可以尝试去竞争锁资源。

**非公平锁**：线程A获取到了锁资源，线程B没有拿到，线程B去排队，线程C来了，先尝试竞争一波

* 拿到锁资源：开心，插队成功。
* 没有拿到锁资源：依然要排到B的后面，等待B拿到锁资源或者是B取消后，才可以尝试去竞争锁资源。

#### 1.4 互斥锁、共享锁

Java中提供的synchronized、ReentrantLock是互斥锁。

Java中提供的ReentrantReadWriteLock，有互斥锁也有共享锁。

**互斥锁**：同一时间点，只会有一个线程持有者当前互斥锁。

**共享锁**：同一时间点，当前共享锁可以被多个线程同时持有。

### 二、**深入synchronized**

#### 2.1 类锁、对象锁

synchronized的使用一般就是同步方法和同步代码块。

synchronized的锁是基于对象实现的。

如果使用同步方法

* static：此时使用的是当前类.class作为锁（类锁）

* 非static：此时使用的是当前对象做为锁（对象锁）

  ```java
  public class MiTest {
  
      public static void main(String[] args) {
          // 锁的是，当前Test.class
          Test.a();
  
          Test test = new Test();
          // 锁的是new出来的test对象
          test.b();
      }
  
  }
  
  class Test{
      public static synchronized void a(){
          System.out.println("1111");
      }
  
      public synchronized void b(){
          System.out.println("2222");
      }
  }
  ```

#### 2.2 synchronized的优化

在JDK1.5的时候，Doug Lee推出了ReentrantLock，lock的性能远高于synchronized，所以JDK团队就在JDK1.6中，对synchronized做了大量的优化。

**锁消除**：在synchronized修饰的代码中，如果不存在操作临界资源的情况，会触发锁消除，你即便写了synchronized，他也不会触发。

```java
public synchronized void method(){
    // 没有操作临界资源
    // 此时这个方法的synchronized你可以认为木有~~
}
```

**锁膨胀**：如果在一个循环中，频繁的获取和释放做资源，这样带来的消耗很大，锁膨胀就是将锁的范围扩大，避免频繁的竞争和获取锁资源带来不必要的消耗。

```java
public void method(){
    for(int i = 0;i < 999999;i++){
        synchronized(对象){

        }
    }
    // 这是上面的代码会触发锁膨胀
    synchronized(对象){
        for(int i = 0;i < 999999;i++){

        }
    }
}
```

**锁升级**：ReentrantLock的实现，是先基于乐观锁的CAS尝试获取锁资源，如果拿不到锁资源，才会挂起线程。synchronized在JDK1.6之前，完全就是获取不到锁，立即挂起当前线程，所以synchronized性能比较差。

synchronized就在JDK1.6做了锁升级的优化

* **无锁、匿名偏向**：当前对象没有作为锁存在。
* **偏向锁**：如果当前锁资源，只有一个线程在频繁的获取和释放，那么这个线程过来，只需要判断，当前指向的线程是否是当前线程 。
  * 如果是，直接拿着锁资源走。
  * 如果当前线程不是我，基于CAS的方式，尝试将偏向锁指向当前线程。如果获取不到，触发锁升级，升级为轻量级锁。（偏向锁状态出现了锁竞争的情况）
* **轻量级锁**：会采用自旋锁的方式去频繁的以CAS的形式获取锁资源（采用的是**自适应自旋锁**）
  * 如果成功获取到，拿着锁资源走
  * 如果自旋了一定次数，没拿到锁资源，锁升级。
* **重量级锁**：就是最传统的synchronized方式，拿不到锁资源，就挂起当前线程。（用户态&内核态）

#### 2.3 synchronized实现原理

synchronized是基于对象实现的。

先要对Java中对象在堆内存的存储有一个了解。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1654095150060/5960ce8eb65d44c299d542fea1b61781.png)

展开MarkWord

![](https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg-blog.csdnimg.cn%2F20200314202610433.png%3Fx-oss-process%3Dimage%2Fwatermark%2Ctype_ZmFuZ3poZW5naGVpdGk%2Cshadow_10%2Ctext_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L0ludHJvbmNoZW5n%2Csize_16%2Ccolor_FFFFFF%2Ct_70&refer=http%3A%2F%2Fimg-blog.csdnimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1659024071&t=5135a8e6d07b807c6bb771ceafd8a227)

MarkWord中标记着四种锁的信息：无锁、偏向锁、轻量级锁、

#### 2.4 synchronized的锁升级

为了可以在Java中看到对象头的MarkWord信息，需要导入依赖

```xml
<dependency>
    <groupId>org.openjdk.jol</groupId>
    <artifactId>jol-core</artifactId>
    <version>0.9</version>
</dependency>
```

锁默认情况下，开启了偏向锁延迟。

> 偏向锁在升级为轻量级锁时，会涉及到偏向锁撤销，需要等到一个安全点（STW），才可以做偏向锁撤销，在明知道有并发情况，就可以选择不开启偏向锁，或者是设置偏向锁延迟开启
>
> 因为JVM在启动时，需要加载大量的.class文件到内存中，这个操作会涉及到synchronized的使用，为了避免出现偏向锁撤销操作，JVM启动初期，有一个延迟4s开启偏向锁的操作
>
> 如果正常开启偏向锁了，那么不会出现无锁状态，对象会直接变为匿名偏向

```java
public static void main(String[] args) throws InterruptedException {
    Thread.sleep(5000);
    Object o = new Object();
    System.out.println(ClassLayout.parseInstance(o).toPrintable());

    new Thread(() -> {

        synchronized (o){
            //t1  - 偏向锁
            System.out.println("t1:" + ClassLayout.parseInstance(o).toPrintable());
        }
    }).start();
    //main - 偏向锁 - 轻量级锁CAS - 重量级锁
    synchronized (o){
        System.out.println("main:" + ClassLayout.parseInstance(o).toPrintable());
    }
}
```

整个锁升级状态的转变：

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1654095150060/20d71edbf3dd438b95358d0169b69226.png)

Lock Record以及ObjectMonitor存储的内容

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1654095150060/616fb837af0c4bcfac43e281d3d22e08.png)

#### 2.5 重量锁底层ObjectMonitor

需要去找到openjdk，在百度中直接搜索openjdk，第一个链接就是

找到ObjectMonitor的两个文件，hpp，cpp

先查看核心属性：http://hg.openjdk.java.net/jdk8u/jdk8u/hotspot/file/69087d08d473/src/share/vm/runtime/objectMonitor.hpp

```hpp
ObjectMonitor() {
    _header       = NULL;   // header存储着MarkWord
    _count        = 0;      // 竞争锁的线程个数
    _waiters      = 0,      // wait的线程个数
    _recursions   = 0;      // 标识当前synchronized锁重入的次数
    _object       = NULL;
    _owner        = NULL;   // 持有锁的线程
    _WaitSet      = NULL;   // 保存wait的线程信息，双向链表
    _WaitSetLock  = 0 ;
    _Responsible  = NULL ;
    _succ         = NULL ;
    _cxq          = NULL ;  // 获取锁资源失败后，线程要放到当前的单向链表中
    FreeNext      = NULL ;
    _EntryList    = NULL ;  // _cxq以及被唤醒的WaitSet中的线程，在一定机制下，会放到EntryList中
    _SpinFreq     = 0 ;
    _SpinClock    = 0 ;
    OwnerIsThread = 0 ;
    _previous_owner_tid = 0;
  }
```

适当的查看几个C++中实现的加锁流程

http://hg.openjdk.java.net/jdk8u/jdk8u/hotspot/file/69087d08d473/src/share/vm/runtime/objectMonitor.cpp

TryLock

```cpp
int ObjectMonitor::TryLock (Thread * Self) {
   for (;;) {
	  // 拿到持有锁的线程
      void * own = _owner ;
      // 如果有线程持有锁，告辞
      if (own != NULL) return 0 ;
      // 说明没有线程持有锁，own是null，cmpxchg指令就是底层的CAS实现。
      if (Atomic::cmpxchg_ptr (Self, &_owner, NULL) == NULL) {
		 // 成功获取锁资源
         return 1 ;
      }
      // 这里其实重试操作没什么意义，直接返回-1
      if (true) return -1 ;
   }
}
```

try_entry

```cpp
bool ObjectMonitor::try_enter(Thread* THREAD) {
  // 在判断_owner是不是当前线程
  if (THREAD != _owner) {
    // 判断当前持有锁的线程是否是当前线程，说明轻量级锁刚刚升级过来的情况
    if (THREAD->is_lock_owned ((address)_owner)) {
       _owner = THREAD ;
       _recursions = 1 ;
       OwnerIsThread = 1 ;
       return true;
    }
    // CAS操作，尝试获取锁资源
    if (Atomic::cmpxchg_ptr (THREAD, &_owner, NULL) != NULL) {
      // 没拿到锁资源，告辞
      return false;
    }
    // 拿到锁资源
    return true;
  } else {
    // 将_recursions + 1，代表锁重入操作。
    _recursions++;
    return true;
  }
}
```

enter（想方设法拿到锁资源，如果没拿到，挂起扔到_cxq单向链表中）

```cpp
void ATTR ObjectMonitor::enter(TRAPS) {
  // 拿到当前线程
  Thread * const Self = THREAD ;
  void * cur ;
  // CAS走你，
  cur = Atomic::cmpxchg_ptr (Self, &_owner, NULL) ;
  if (cur == NULL) {
     // 拿锁成功
     return ;
  }
  // 锁重入操作
  if (cur == Self) {
     // TODO-FIXME: check for integer overflow!  BUGID 6557169.
     _recursions ++ ;
     return ;
  }
  //轻量级锁过来的。
  if (Self->is_lock_owned ((address)cur)) {
    _recursions = 1 ;
    _owner = Self ;
    OwnerIsThread = 1 ;
    return ;
  }


  // 走到这了，没拿到锁资源，count++
  Atomic::inc_ptr(&_count);

  
    for (;;) {
      jt->set_suspend_equivalent();
      // 入队操作，进到cxq中
      EnterI (THREAD) ;
      if (!ExitSuspendEquivalent(jt)) break ;
      _recursions = 0 ;
      _succ = NULL ;
      exit (false, Self) ;
      jt->java_suspend_self();
    }
  }
  // count--
  Atomic::dec_ptr(&_count);
  
}
```

EnterI

```cpp
for (;;) {
    // 入队
    node._next = nxt = _cxq ;
    // CAS的方式入队。
    if (Atomic::cmpxchg_ptr (&node, &_cxq, nxt) == nxt) break ;

    // 重新尝试获取锁资源
    if (TryLock (Self) > 0) {
        assert (_succ != Self         , "invariant") ;
        assert (_owner == Self        , "invariant") ;
        assert (_Responsible != Self  , "invariant") ;
        return ;
    }
}
```

### 三、**深入ReentrantLock**

#### 3.1 ReentrantLock和synchronized的区别

废话区别：单词不一样。。。

核心区别：

* ReentrantLock是个类，synchronized是关键字，当然都是在JVM层面实现互斥锁的方式

效率区别：

* 如果竞争比较激烈，推荐ReentrantLock去实现，不存在锁升级概念。而synchronized是存在锁升级概念的，如果升级到重量级锁，是不存在锁降级的。

底层实现区别：

* 实现原理是不一样，ReentrantLock基于AQS实现的，synchronized是基于ObjectMonitor

功能向的区别：

* ReentrantLock的功能比synchronized更全面。
  * ReentrantLock支持公平锁和非公平锁
  * ReentrantLock可以指定等待锁资源的时间。

选择哪个：如果你对并发编程特别熟练，推荐使用ReentrantLock，功能更丰富。如果掌握的一般般，使用synchronized会更好

#### 3.2 AQS概述

AQS就是AbstractQueuedSynchronizer抽象类，AQS其实就是JUC包下的一个基类，JUC下的很多内容都是基于AQS实现了部分功能，比如ReentrantLock，ThreadPoolExecutor，阻塞队列，CountDownLatch，Semaphore，CyclicBarrier等等都是基于AQS实现。

首先AQS中提供了一个由volatile修饰，并且采用CAS方式修改的int类型的state变量。

其次AQS中维护了一个双向链表，有head，有tail，并且每个节点都是Node对象

```java
static final class Node {
        static final Node SHARED = new Node();
        static final Node EXCLUSIVE = null;

        static final int CANCELLED =  1;
        static final int SIGNAL    = -1;
        static final int CONDITION = -2;

        static final int PROPAGATE = -3;


        volatile int waitStatus;


        volatile Node prev;


        volatile Node next;


        volatile Thread thread; 
}
```

AQS内部结构和属性

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1654095150060/6f1f8f1f2ff4494c81adddef4a0897e6.png)

#### 3.3 加锁流程源码剖析

##### 3.3.1 加锁流程概述

这个是非公平锁的流程

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1654095150060/d25877e5d048450180f19d97a0778fba.png)

##### 3.3.2 三种加锁源码分析

###### 3.3.2.1 lock方法

1. 执行lock方法后，公平锁和非公平锁的执行套路不一样

   ```java
   // 非公平锁
   final void lock() {
       // 上来就先基于CAS的方式，尝试将state从0改为1
       if (compareAndSetState(0, 1))
           // 获取锁资源成功，会将当前线程设置到exclusiveOwnerThread属性，代表是当前线程持有着锁资源
           setExclusiveOwnerThread(Thread.currentThread());
       else
           // 执行acquire，尝试获取锁资源
           acquire(1);
   }
   
   // 公平锁
   final void lock() {
       //  执行acquire，尝试获取锁资源
       acquire(1);
   }
   ```

2. acquire方法，是公平锁和非公平锁的逻辑一样

   ```java
   public final void acquire(int arg) {
       // tryAcquire：再次查看，当前线程是否可以尝试获取锁资源
       if (!tryAcquire(arg) &&
           // 没有拿到锁资源
           // addWaiter(Node.EXCLUSIVE)：将当前线程封装为Node节点，插入到AQS的双向链表的结尾
           // acquireQueued：查看我是否是第一个排队的节点，如果是可以再次尝试获取锁资源，如果长时间拿不到，挂起线程
           // 如果不是第一个排队的额节点，就尝试挂起线程即可
           acquireQueued(addWaiter(Node.EXCLUSIVE), arg))
           // 中断线程的操作
           selfInterrupt();
   }
   ```

3. tryAcquire方法竞争锁最资源的逻辑，分为公平锁和非公平锁

   ```java
   // 非公平锁实现
   final boolean nonfairTryAcquire(int acquires) {
       // 获取当前线程
       final Thread current = Thread.currentThread();
       // 获取了state熟属性
       int c = getState();
       // 判断state当前是否为0,之前持有锁的线程释放了锁资源
       if (c == 0) {
           // 再次抢一波锁资源
           if (compareAndSetState(0, acquires)) {
               setExclusiveOwnerThread(current);
               // 拿锁成功返回true
               return true;
           }
       }
       // 不是0，有线程持有着锁资源，如果是，证明是锁重入操作
       else if (current == getExclusiveOwnerThread()) {
           // 将state + 1
           int nextc = c + acquires;
           if (nextc < 0) // 说明对重入次数+1后，超过了int正数的取值范围
               // 01111111 11111111 11111111 11111111
               // 10000000 00000000 00000000 00000000
               // 说明重入的次数超过界限了。
               throw new Error("Maximum lock count exceeded");
           // 正常的将计算结果，复制给state
           setState(nextc);
           // 锁重入成功
           return true;
       }
       // 返回false
       return false;
   }
   ```


   // 公平锁实现
   protected final boolean tryAcquire(int acquires) {
       // 获取当前线程
       final Thread current = Thread.currentThread();
       // ....
       int c = getState();
       if (c == 0) {
           // 查看AQS中是否有排队的Node
           // 没人排队抢一手 。有人排队，如果我是第一个，也抢一手
           if (!hasQueuedPredecessors() &&
               // 抢一手~
               compareAndSetState(0, acquires)) {
               setExclusiveOwnerThread(current);
               return true;
           }
       }
       // 锁重入~~~
       else if (current == getExclusiveOwnerThread()) {
           int nextc = c + acquires;
           if (nextc < 0)
               throw new Error("Maximum lock count exceeded");
           setState(nextc);
           return true;
       }
       return false;
   }

   // 查看是否有线程在AQS的双向队列中排队
   // 返回false，代表没人排队
   public final boolean hasQueuedPredecessors() {
       // 头尾节点
       Node t = tail; 
       Node h = head;
       // s为头结点的next节点
       Node s;
       // 如果头尾节点相等，证明没有线程排队，直接去抢占锁资源
       return h != t &&
           // s节点不为null，并且s节点的线程为当前线程（排在第一名的是不是我）
           (s == null || s.thread != Thread.currentThread());
   }

   ```
4. addWaite方法，将没有拿到锁资源的线程扔到AQS队列中去排队
   ```java
   // 没有拿到锁资源，过来排队，  mode：代表互斥锁
   private Node addWaiter(Node mode) {
       // 将当前线程封装为Node，
       Node node = new Node(Thread.currentThread(), mode);
       // 拿到尾结点
       Node pred = tail;
       // 如果尾结点不为null
       if (pred != null) {
           // 当前节点的prev指向尾结点
           node.prev = pred;
           // 以CAS的方式，将当前线程设置为tail节点
           if (compareAndSetTail(pred, node)) {
               // 将之前的尾结点的next指向当前节点
               pred.next = node;
               return node;
           }
       }
       // 如果CAS失败，以死循环的方式，保证当前线程的Node一定可以放到AQS队列的末尾
       enq(node);
       return node;
   }

   private Node enq(final Node node) {
       for (;;) {
           // 拿到尾结点
           Node t = tail;
           // 如果尾结点为空，AQS中一个节点都没有，构建一个伪节点，作为head和tail
           if (t == null) { 
               if (compareAndSetHead(new Node()))
                   tail = head;
           } else {
               // 比较熟悉了，以CAS的方式，在AQS中有节点后，插入到AQS队列的末尾
               node.prev = t;
               if (compareAndSetTail(t, node)) {
                   t.next = node;
                   return t;
               }
           }
       }
   }
   ```

5. acquireQueued方法，判断当前线程是否还能再次尝试获取锁资源，如果不能再次获取锁资源，或者又没获取到，尝试将当前线程挂起

   ```java
   // 当前没有拿到锁资源后，并且到AQS排队了之后触发的方法。  中断操作这里不用考虑
   final boolean acquireQueued(final Node node, int arg) {
       // 不考虑中断
       // failed：获取锁资源是否失败（这里简单掌握落地，真正触发的，还是tryLock和lockInterruptibly）
       boolean failed = true;
       try {
           boolean interrupted = false;
           // 死循环…………
           for (;;) {
               // 拿到当前节点的前继节点
               final Node p = node.predecessor();
               // 前继节点是否是head，如果是head，再次执行tryAcquire尝试获取锁资源。
               if (p == head && tryAcquire(arg)) {
                   // 获取锁资源成功
                   // 设置头结点为当前获取锁资源成功Node，并且取消thread信息
                   setHead(node);
                   // help GC
                   p.next = null; 
                   // 获取锁失败标识为false
                   failed = false;
                   return interrupted;
               }
               // 没拿到锁资源……
               // shouldParkAfterFailedAcquire：基于上一个节点转改来判断当前节点是否能够挂起线程，如果可以返回true，
               // 如果不能，就返回false，继续下次循环
               if (shouldParkAfterFailedAcquire(p, node) &&
                   // 这里基于Unsafe类的park方法，将当前线程挂起
                   parkAndCheckInterrupt())
                   interrupted = true;
           }
       } finally {
           if (failed)
               // 在lock方法中，基本不会执行。
               cancelAcquire(node);
       }
   }
   // 获取锁资源成功后，先执行setHead
   private void setHead(Node node) {
       // 当前节点作为头结点  伪
       head = node;
       // 头结点不需要线程信息
       node.thread = null;
       node.prev = null;
   }
   
   // 当前Node没有拿到锁资源，或者没有资格竞争锁资源，看一下能否挂起当前线程
   private static boolean shouldParkAfterFailedAcquire(Node pred, Node node) {
       // -1，SIGNAL状态：代表当前节点的后继节点，可以挂起线程，后续我会唤醒我的后继节点
       // 1，CANCELLED状态：代表当前节点以及取消了
       int ws = pred.waitStatus;
       if (ws == Node.SIGNAL)
           // 上一个节点为-1之后，当前节点才可以安心的挂起线程
           return true;
       if (ws > 0) {
           // 如果当前节点的上一个节点是取消状态，我需要往前找到一个状态不为1的Node，作为他的next节点
           // 找到状态不为1的节点后，设置一下next和prev
           do {
               node.prev = pred = pred.prev;
           } while (pred.waitStatus > 0);
           pred.next = node;
       } else {
           // 上一个节点的状态不是1或者-1，那就代表节点状态正常，将上一个节点的状态改为-1
           compareAndSetWaitStatus(pred, ws, Node.SIGNAL);
       }
       return false;
   }
   ```

###### 3.3.2.2 tryLock方法

* tryLock();

  ```java
  // tryLock方法，无论公平锁还有非公平锁。都会走非公平锁抢占锁资源的操作
  // 就是拿到state的值， 如果是0，直接CAS浅尝一下
  // state 不是0，那就看下是不是锁重入操作
  // 如果没抢到，或者不是锁重入操作，告辞，返回false
  public boolean tryLock() {
      // 非公平锁的竞争锁操作
      return sync.nonfairTryAcquire(1);
  }
  final boolean nonfairTryAcquire(int acquires) {
      final Thread current = Thread.currentThread();
      int c = getState();
      if (c == 0) {
          if (compareAndSetState(0, acquires)) {
              setExclusiveOwnerThread(current);
              return true;
          }
      }
      else if (current == getExclusiveOwnerThread()) {
          int nextc = c + acquires;
          if (nextc < 0) // overflow
              throw new Error("Maximum lock count exceeded");
          setState(nextc);
          return true;
      }
      return false;
  }
  ```

* tryLock(time,unit);

  * 第一波分析，类似的代码：

    ```java
    // tryLock(time,unit)执行的方法
    public final boolean tryAcquireNanos(int arg, long nanosTimeout)throws InterruptedException {
        // 线程的中断标记位，是不是从false，别改为了true，如果是，直接抛异常
        if (Thread.interrupted())
            throw new InterruptedException();
        // tryAcquire分为公平和非公平锁两种执行方式，如果拿锁成功， 直接告辞，
        return tryAcquire(arg) ||
            // 如果拿锁失败，在这要等待指定时间
            doAcquireNanos(arg, nanosTimeout);
    }
    
    private boolean doAcquireNanos(int arg, long nanosTimeout)
            throws InterruptedException {
        // 如果等待时间是0秒，直接告辞，拿锁失败  
        if (nanosTimeout <= 0L)
            return false;
        // 设置结束时间。
        final long deadline = System.nanoTime() + nanosTimeout;
        // 先扔到AQS队列
        final Node node = addWaiter(Node.EXCLUSIVE);
        // 拿锁失败，默认true
        boolean failed = true;
        try {
            for (;;) {
                // 如果在AQS中，当前node是head的next，直接抢锁
                final Node p = node.predecessor();
                if (p == head && tryAcquire(arg)) {
                    setHead(node);
                    p.next = null; // help GC
                    failed = false;
                    return true;
                }
                // 结算剩余的可用时间
                nanosTimeout = deadline - System.nanoTime();
                // 判断是否是否用尽的位置
                if (nanosTimeout <= 0L)
                    return false;
                // shouldParkAfterFailedAcquire：根据上一个节点来确定现在是否可以挂起线程
                if (shouldParkAfterFailedAcquire(p, node) &&
                    // 避免剩余时间太少，如果剩余时间少就不用挂起线程
                    nanosTimeout > spinForTimeoutThreshold)
                    // 如果剩余时间足够，将线程挂起剩余时间
                    LockSupport.parkNanos(this, nanosTimeout);
                // 如果线程醒了，查看是中断唤醒的，还是时间到了唤醒的。
                if (Thread.interrupted())
                    // 是中断唤醒的！
                    throw new InterruptedException();
            }
        } finally {
            if (failed)
                cancelAcquire(node);
        }
    }
    ```

  * 取消节点分析：![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1654095150060/c283fb2473a8401985b9f874cb222f40.png)

    ```java
    // 取消在AQS中排队的Node
    private void cancelAcquire(Node node) {
        // 如果当前节点为null，直接忽略。
        if (node == null)
            return;
        //1. 线程设置为null
        node.thread = null;
    
        //2. 往前跳过被取消的节点，找到一个有效节点
        Node pred = node.prev;
        while (pred.waitStatus > 0)
            node.prev = pred = pred.prev;
    
        //3. 拿到了上一个节点之前的next
        Node predNext = pred.next;
    
        //4. 当前节点状态设置为1，代表节点取消
        node.waitStatus = Node.CANCELLED;
    
        // 脱离AQS队列的操作
        // 当前Node是尾结点，将tail从当前节点替换为上一个节点
        if (node == tail && compareAndSetTail(node, pred)) {
            compareAndSetNext(pred, predNext, null);
        } else {
            // 到这，上面的操作CAS操作失败
            int ws = pred.waitStatus;
            // 不是head的后继节点
            if (pred != head &&
                // 拿到上一个节点的状态，只要上一个节点的状态不是取消状态，就改为-1
                (ws == Node.SIGNAL || (ws <= 0 && compareAndSetWaitStatus(pred, ws, Node.SIGNAL))) 
                && pred.thread != null) {
                // 上面的判断都是为了避免后面节点无法被唤醒。
                // 前继节点是有效节点，可以唤醒后面的节点
                Node next = node.next;
                if (next != null && next.waitStatus <= 0)
                    compareAndSetNext(pred, predNext, next);
            } else {
                // 当前节点是head的后继节点
                unparkSuccessor(node);
            }
    
            node.next = node; // help GC
        }
    }
    ```

###### 3.3.2.3 lockInterruptibly方法

```java
// 这个是lockInterruptibly和tryLock(time,unit)唯一的区别
// lockInterruptibly，拿不到锁资源，就死等，等到锁资源释放后，被唤醒，或者是被中断唤醒
private void doAcquireInterruptibly(int arg) throws InterruptedException {
    final Node node = addWaiter(Node.EXCLUSIVE);
    boolean failed = true;
    try {
        for (;;) {
            final Node p = node.predecessor();
            if (p == head && tryAcquire(arg)) {
                setHead(node);
                p.next = null; // help GC
                failed = false;
                return;
            }
            if (shouldParkAfterFailedAcquire(p, node) && parkAndCheckInterrupt())
                // 中断唤醒抛异常！
                throw new InterruptedException();
        }
    } finally {
        if (failed)
            cancelAcquire(node);
    }
}

private final boolean parkAndCheckInterrupt() {
    LockSupport.park(this);
    // 这个方法可以确认，当前挂起的线程，是被中断唤醒的，还是被正常唤醒的。
    // 中断唤醒，返回true，如果是正常唤醒，返回false
    return Thread.interrupted();
}
```

#### 3.4 释放锁流程源码剖析

##### 3.4.1 释放锁流程概述

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1654095150060/33b1deba4dd94713b2f6071e54813fe2.png)

##### 3.4.2 释放锁源码分析

```java
public void unlock() {
    // 释放锁资源不分为公平锁和非公平锁，都是一个sync对象
    sync.release(1);
}

// 释放锁的核心流程
public final boolean release(int arg) {
    // 核心释放锁资源的操作之一
    if (tryRelease(arg)) {
        // 如果锁已经释放掉了，走这个逻辑
        Node h = head;
        // h不为null，说明有排队的（录课时估计脑袋蒙圈圈。）
        // 如果h的状态不为0（为-1），说明后面有排队的Node，并且线程已经挂起了。
        if (h != null && h.waitStatus != 0)
            // 唤醒排队的线程
            unparkSuccessor(h);
        return true;
    }
    return false;
}
// ReentrantLock释放锁资源操作
protected final boolean tryRelease(int releases) {
    // 拿到state - 1（并没有赋值给state）
    int c = getState() - releases;
    // 判断当前持有锁的线程是否是当前线程，如果不是，直接抛出异常
    if (Thread.currentThread() != getExclusiveOwnerThread())
        throw new IllegalMonitorStateException();
    // free，代表当前锁资源是否释放干净了。
    boolean free = false;
    if (c == 0) {
        // 如果state - 1后的值为0，代表释放干净了。
        free = true;
        // 将持有锁的线程置位null
        setExclusiveOwnerThread(null);
    }
    // 将c设置给state
    setState(c);
    // 锁资源释放干净返回true，否则返回false
    return free;
}

// 唤醒后面排队的Node
private void unparkSuccessor(Node node) {
    // 拿到头节点状态
    int ws = node.waitStatus;
    if (ws < 0)
        // 先基于CAS，将节点状态从-1，改为0
        compareAndSetWaitStatus(node, ws, 0);
    // 拿到头节点的后续节点。
    Node s = node.next;
    // 如果后续节点为null或者，后续节点的状态为1，代表节点取消了。
    if (s == null || s.waitStatus > 0) {
        s = null;
        // 如果后续节点为null，或者后续节点状态为取消状态，从后往前找到一个有效节点环境
        for (Node t = tail; t != null && t != node; t = t.prev)
            // 从后往前找到状态小于等于0的节点
            // 找到离head最新的有效节点，并赋值给s
            if (t.waitStatus <= 0)
                s = t;
    }
    // 只要找到了这个需要被唤醒的节点，执行unpark唤醒
    if (s != null)
        LockSupport.unpark(s.thread);
}
```

#### 3.5 AQS中常见的问题

##### 3.5.1 AQS中为什么要有一个虚拟的head节点

**AQS可以没有head，设计之初指定head只是为了更方便的操作。方便管理双向链表而已，一个哨兵节点的存在。**

比如ReentrantLock中释放锁资源时，会考虑是否需要唤醒后继节点。如果头结点的状态不是-1。就不需要去唤醒后继节点。唤醒后继节点时，需要找到head.next节点，如果head.next为null，或者是取消了，此时需要遍历整个双向链表，从后往前遍历，找到离head最近的Node。规避了一些不必要的唤醒操作。

如果不用虚拟节点（哨兵节点），当前节点挂起，当前节点的状态设置为-1。可行。AQS本身就是使用了哨兵节点做双向链表的一些操作。

网上说了，虚拟的head，可以避免重复唤醒操作。虚拟的head并没有处理这个问题。

##### 3.5.2 AQS中为什么使用双向链表

**AQS的双向链表就为了更方便的操作Node节点。**

在执行tryLock，lockInterruptibly方法时，如果在线程阻塞时，中断了线程，此时线程会执行cancelAcquire取消当前节点，不在AQS的双向链表中排队。如果是单向链表，此时会导致取消节点，无法直接将当前节点的prev节点的next指针，指向当前节点的next节点。

#### 3.6 ConditionObject

##### 3.6.1 ConditionObject的介绍&应用

像synchronized提供了wait和notify的方法实现线程在持有锁时，可以实现挂起，已经唤醒的操作。

ReentrantLock也拥有这个功能。

ReentrantLock提供了await和signal方法去实现类似wait和notify的功能。

想执行await或者是signal就必须先持有lock锁的资源。

先look一下Condition的应用

```java
public static void main(String[] args) throws InterruptedException, IOException {
    ReentrantLock lock = new ReentrantLock();
    Condition condition = lock.newCondition();

    new Thread(() -> {
        lock.lock();
        System.out.println("子线程获取锁资源并await挂起线程");
        try {
            Thread.sleep(5000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        try {
            condition.await();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println("子线程挂起后被唤醒！持有锁资源");

    }).start();
    Thread.sleep(100);
    // =================main======================
    lock.lock();
    System.out.println("主线程等待5s拿到锁资源，子线程执行了await方法");
    condition.signal();
    System.out.println("主线程唤醒了await挂起的子线程");
    lock.unlock();
}
```

##### 3.6.2 Condition的构建方式&核心属性

发现在通过lock锁对象执行newCondition方法时，本质就是直接new的AQS提供的ConditionObject对象

```java
final ConditionObject newCondition() {
    return new ConditionObject();
}
```

其实lock锁中可以有多个Condition对象。

在对Condition1进行操作时，不会影响到Condition2的单向链表。

其次可以发现ConditionObject中，只有两个核心属性：

```java
/** First node of condition queue. */
private transient Node firstWaiter;
/** Last node of condition queue. */
private transient Node lastWaiter;
```

虽然Node对象有prev和next，但是在ConditionObject中是不会使用这两个属性的，只要在Condition队列中，这两个属性都是null。在ConditionObject中只会使用nextWaiter的属性实现单向链表的效果。

##### 3.6.3 Condition的await方法分析（前置分析）

持有锁的线程在执行await方法后会做几个操作：

* 判断线程是否中断，如果中断了，什么都不做。
* 没有中断，就讲当前线程封装为Node添加到Condition的单向链表中
* 一次性释放掉锁资源。
* 如果当前线程没有在AQS队列，就正常执行LockSupport.park(this)挂起线程。

```java
、// await方法的前置分析，只分析到线程挂起
public final void await() throws InterruptedException {
    // 先判断线程的中断标记位是否是true
    if (Thread.interrupted())
        // 如果是true，就没必要执行后续操作挂起了。
        throw new InterruptedException();
    // 在线程挂起之前，先将当前线程封装为Node，并且添加到Condition队列中
    Node node = addConditionWaiter();
    // fullyRelease在释放锁资源，一次性将锁资源全部释放，并且保留重入的次数
    int savedState = fullyRelease(node);
    // 省略一行代码……
    // 当前Node是否在AQS队列中？
    // 执行fullyRelease方法后，线程就释放锁资源了，如果线程刚刚释放锁资源，其他线程就立即执行了signal方法，
    // 此时当前线程就被放到了AQS的队列中，这样一来线程就不需要执行LockSupport.park(this);去挂起线程了
    while (!isOnSyncQueue(node)) {
        // 如果没有在AQS队列中，正常在Condition单向链表里，正常挂起线程。
        LockSupport.park(this);
        // 省略部分代码……
    }
    // 省略部分代码……
}

// 线程挂起先，添加到Condition单向链表的业务~~
private Node addConditionWaiter() {
    // 拿到尾节点。
    Node t = lastWaiter;
    // 如果尾节点有值，并且尾节点的状态不正常，不是-2，尾节点可能要拜拜了~
    if (t != null && t.waitStatus != Node.CONDITION) {
        // 如果尾节点已经取消了，需要干掉取消的尾节点~
        unlinkCancelledWaiters();
        // 重新获取lastWaiter
        t = lastWaiter;
    }
    // 构建当前线程的Node，并且状态设置为-2
    Node node = new Node(Thread.currentThread(), Node.CONDITION);
    // 如果last节点为null。直接将当前节点设置为firstWaiter
    if (t == null)
        firstWaiter = node;
    else
        // 如果last节点不为null，说明有值，就排在lastWaiter的后面
        t.nextWaiter = node;
    // 把当前节点设置为最后一个节点
    lastWaiter = node;
    // 返回当前节点
    return node;
}

// 干掉取消的尾节点。
private void unlinkCancelledWaiters() {
    // 拿到头节点
    Node t = firstWaiter;
    // 声明一个节点，爱啥啥~~~
    Node trail = null;
    // 如果t不为null，就正常执行~~
    while (t != null) {
        // 拿到t的next节点
        Node next = t.nextWaiter;
        // 如果t的状态不为-2，说明有问题
        if (t.waitStatus != Node.CONDITION) {
            // t节点的next为null
            t.nextWaiter = null;
            // 如果trail为null，代表头结点状态就是1，
            if (trail == null)
                // 将头结点指向next节点
                firstWaiter = next;
            else
                // 如果trail有值，说明不是头结点位置
                trail.nextWaiter = next;
            // 如果next为null，说明单向链表遍历到最后了，直接结束
            if (next == null)
                lastWaiter = trail;
        }
        // 如果t的状态是-2，一切正常
        else {
            // 临时存储t
            trail = t;
        }
        // t指向之前的next
        t = next;
    }
}

// 一次性释放锁资源
final int fullyRelease(Node node) {
    // 标记位，释放锁资源默认失败！
    boolean failed = true;
    try {
        // 拿到现在state的值
        int savedState = getState();
        // 一次性释放干净全部锁资源
        if (release(savedState)) {
            // 释放锁资源失败了么？ 没有！
            failed = false;
            // 返回对应的锁资源信息
            return savedState;
        } else {
            throw new IllegalMonitorStateException();
        }
    } finally {
        if (failed)
            // 如果释放锁资源失败，将节点状态设置为取消
            node.waitStatus = Node.CANCELLED;
    }
}
```

##### 3.6.4 Condition的signal方法分析

分为了几个部分：

* 确保执行signal方法的是持有锁的线程
* 脱离Condition的队列
* 将Node状态从-2改为0
* 将Node添加到AQS队列
* 为了避免当前Node无法在AQS队列正常唤醒做了一些判断和操作

```java
// 线程挂起后，可以基于signal唤醒~
public final void signal() {
    // 在ReentrantLock中，如果执行signal的线程没有持有锁资源，直接扔异常
    if (!isHeldExclusively())
        throw new IllegalMonitorStateException();
    // 拿到排在Condition首位的Node
    Node first = firstWaiter;
    // 有Node在排队，才需要唤醒，如果没有，直接告辞~~
    if (first != null)
        doSignal(first);
}

// 开始唤醒Condition中的Node中的线程
private void doSignal(Node first) {
    // 先一波do-while走你~~~
    do {
        // 获取到第二个节点，并且将第二个节点设置为firstWaiter
        if ( (firstWaiter = first.nextWaiter) == null)
            // 说明就一个节点在Condition队列中，那么直接将firstWaiter和lastWaiter置位null
            lastWaiter = null;
        // 如果还有nextWaiter节点，因为当前节点要被唤醒了，脱离整个Condition队列。将nextWaiter置位null
        first.nextWaiter = null;
        // 如果transferForSignal返回true，一切正常，退出while循环
    } while (!transferForSignal(first) &&
            // 如果后续节点还有，往后面继续唤醒，如果没有，退出while循环
             (first = firstWaiter) != null);
}

// 准备开始唤醒在Condition中排队的Node
final boolean transferForSignal(Node node) {
    // 将在Condition队列中的Node的状态从-2，改为0，代表要扔到AQS队列了。
    if (!compareAndSetWaitStatus(node, Node.CONDITION, 0))
        // 如果失败了，说明在signal之前应当是线程被中断了，从而被唤醒了。
        return false;
    // 如果正常的将Node的状态从-2改为0，这是就要将Condition中的这个Node扔到AQS的队列。
    // 将当前Node扔到AQS队列，返回的p是当前Node的prev
    Node p = enq(node);
    // 获取上一个Node的状态
    int ws = p.waitStatus;
    // 如果ws > 0 ，说明这个Node已经被取消了。
    // 如果ws状态不是取消，将prev节点的状态改为-1,。
    if (ws > 0 || !compareAndSetWaitStatus(p, ws, Node.SIGNAL))
        // 如果prev节点已经取消了，可能会导致当前节点永远无法被唤醒。立即唤醒当前节点，基于acquireQueued方法，
            // 让当前节点找到一个正常的prev节点，并挂起线程
        // 如果prev节点正常，但是CAS修改prev节点失败了。证明prev节点因为并发原因导致状态改变。还是为了避免当前
            // 节点无法被正常唤醒，提前唤醒当前线程，基于acquireQueued方法，让当前节点找到一个正常的prev节点，并挂起线程
        LockSupport.unpark(node.thread);
    // 返回true
    return true;
}
```

##### 3.6.5 Conditiond的await方法分析（后置分析）

分为了几个部分：

* 唤醒之后，要先确认是中断唤醒还是signal唤醒，还是signal唤醒后被中断
* 确保当前线程的Node已经在AQS队列中
* 执行acquireQueued方法，等待锁资源。
* 在获取锁资源后，要确认是否在获取锁资源的阶段被中断过，如果被中断过，并且不是THROW_IE，那就确保interruptMode是REINTERRUPT。
* 确认当前Node已经不在Condition队列中了
* 最终根据interruptMode来决定具体做的事情
  * 0：嘛也不做。
  * THROW_IE：抛出异常
  * REINTERRUPT：执行线程的interrupt方法

```java
// 现在分析await方法的后半部分
public final void await() throws InterruptedException {
    if (Thread.interrupted())
        throw new InterruptedException();
    Node node = addConditionWaiter();
    int savedState = fullyRelease(node);
    // 中断模式~
    int interruptMode = 0;
    while (!isOnSyncQueue(node)) {
        LockSupport.park(this);
        // 如果线程执行到这，说明现在被唤醒了。
        // 线程可以被signal唤醒。（如果是signal唤醒，可以确认线程已经在AQS队列中）
        // 线程可以被interrupt唤醒，线程被唤醒后，没有在AQS队列中。
        // 如果线程先被signal唤醒，然后线程中断了。。。。（做一些额外处理）
        // checkInterruptWhileWaiting可以确认当前中如何唤醒的。
        // 返回的值，有三种
        // 0：正常signal唤醒，没别的事（不知道Node是否在AQS队列）
        // THROW_IE（-1）：中断唤醒，并且可以确保在AQS队列
        // REINTERRUPT（1）：signal唤醒，但是线程被中断了，并且可以确保在AQS队列
        if ((interruptMode = checkInterruptWhileWaiting(node)) != 0)
            break;
    }
    // Node一定在AQS队列
    // 执行acquireQueued，尝试在ReentrantLock中获取锁资源。
    // acquireQueued方法返回true：代表线程在AQS队列中挂起时，被中断过
    if (acquireQueued(node, savedState) && interruptMode != THROW_IE)
        // 如果线程在AQS队列排队时，被中断了，并且不是THROW_IE状态，确保线程的interruptMode是REINTERRUPT
        // REINTERRUPT：await不是中断唤醒，但是后续被中断过！！！
        interruptMode = REINTERRUPT;
    // 如果当前Node还在condition的单向链表中，脱离Condition的单向链表
    if (node.nextWaiter != null) 
        unlinkCancelledWaiters();
    // 如果interruptMode是0，说明线程在signal后以及持有锁的过程中，没被中断过，什么事都不做！
    if (interruptMode != 0)
        // 如果不是0~
        reportInterruptAfterWait(interruptMode);
}
// 判断当前线程被唤醒的模式，确认interruptMode的值。
private int checkInterruptWhileWaiting(Node node) {
    // 判断线程是否中断了。
    return Thread.interrupted() ?
        // THROW_IE：代表线程是被interrupt唤醒的，需要向上排除异常
        // REINTERRUPT：代表线程是signal唤醒的，但是在唤醒之后，被中断了。

        (transferAfterCancelledWait(node) ? THROW_IE : REINTERRUPT) :
        // 线程是正常的被signal唤醒，并且线程没有中断过。
        0;
}

// 判断线程到底是中断唤醒的，还是signal唤醒的！
final boolean transferAfterCancelledWait(Node node) {
    // 基于CAS将Node的状态从-2改为0
    if (compareAndSetWaitStatus(node, Node.CONDITION, 0)) {
        // 说明是中断唤醒的线程。因为CAS成功了。
        // 将Node添加到AQS队列中~（如果是中断唤醒的，当前线程同时存在Condition的单向链表以及AQS的队列中）
        enq(node);
        // 返回true
        return true;
    }
    // 判断当前的Node是否在AQS队列（signal唤醒的，但是可能线程还没放到AQS队列）
    // 等到signal方法将线程的Node扔到AQS队列后，再做后续操作
    while (!isOnSyncQueue(node))
        // 如果没在AQS队列上，那就线程让步，稍等一会，Node放到AQS队列再处理（看CPU）
        Thread.yield();
    // signal唤醒的，返回false
    return false;
}

// 确认Node是否在AQS队列上
final boolean isOnSyncQueue(Node node) {
    // 如果线程状态为-2，肯定没在AQS队列
    // 如果prev节点的值为null，肯定没在AQS队列
    if (node.waitStatus == Node.CONDITION || node.prev == null)
        // 返回false
        return false;
    // 如果节点的next不为null。说明已经在AQS队列上。、
    if (node.next != null) 
        // 确定AQS队列上有！
        return true;
    // 如果上述判断都没有确认节点在AQS队列上，在AQS队列中寻找一波
    return findNodeFromTail(node);
}
// 在AQS队列中找当前节点
private boolean findNodeFromTail(Node node) {
    // 拿到尾节点
    Node t = tail;
    for (;;) {
        // tail是否是当前节点，如果是，说明在AQS队列
        if (t == node)
            // 可以跳出while循环
            return true;
        // 如果节点为null，AQS队列中没有当前节点
        if (t == null)
            // 进入while，让步一手
            return false;
        // t向前引用
        t = t.prev;
    }
}

private void reportInterruptAfterWait(int interruptMode) throws InterruptedException {
    // 如果是中断唤醒的await，直接抛出异常！
    if (interruptMode == THROW_IE)
        throw new InterruptedException();
    // 如果是REINTERRUPT，signal后被中断过
    else if (interruptMode == REINTERRUPT)
        // 确认线程的中断标记位是true
        // Thread.currentThread().interrupt();
        selfInterrupt();
}
```

##### 3.6.6 Condition的awaitNanos&signalAll方法分析

awaitNanos：仅仅是在await方法的基础上，做了一内内的改变，整体的逻辑思想都是一样的。

挂起线程时，传入要阻塞的时间，时间到了，自动唤醒，走添加到AQS队列的逻辑

```java
// await指定时间，多了个时间到了自动醒。
public final long awaitNanos(long nanosTimeout)
        throws InterruptedException {
    if (Thread.interrupted())
        throw new InterruptedException();
    Node node = addConditionWaiter();
    int savedState = fullyRelease(node);
    // deadline：当前线程最多挂起到什么时间点
    final long deadline = System.nanoTime() + nanosTimeout;
    int interruptMode = 0;
    while (!isOnSyncQueue(node)) {
        // nanosTimeout的时间小于等于0，直接告辞！！
        if (nanosTimeout <= 0L) {
            // 正常扔到AQS队列
            transferAfterCancelledWait(node);
            break;
        }
        // nanosTimeout的时间大于1000纳秒时，才可以挂起线程
        if (nanosTimeout >= spinForTimeoutThreshold)
            // 如果大于，正常挂起
            LockSupport.parkNanos(this, nanosTimeout);
        if ((interruptMode = checkInterruptWhileWaiting(node)) != 0)
            break;
        // 计算剩余的挂起时间，可能需要重新的走while循环，再次挂起线程
        nanosTimeout = deadline - System.nanoTime();
    }
    if (acquireQueued(node, savedState) && interruptMode != THROW_IE)
        interruptMode = REINTERRUPT;
    if (node.nextWaiter != null)
        unlinkCancelledWaiters();
    if (interruptMode != 0)
        reportInterruptAfterWait(interruptMode);
    // 剩余的挂起时间
    return deadline - System.nanoTime();
}
```

signalAll方法。这个方法一看就懂，之前signal是唤醒1个，这个是全部唤醒

```java
// 以do-while的形式，将Condition单向链表中的所有Node，全部唤醒并扔到AQS队列
private void doSignalAll(Node first) {
    // 将头尾都置位null~
    lastWaiter = firstWaiter = null;
    do {
        // 拿到next节点的引用
        Node next = first.nextWaiter;
        // 断开当前Node的nextWaiter
        first.nextWaiter = null;
        // 修改Node状态，扔AQS队列，是否唤醒！
        transferForSignal(first);
        // 指向下一个节点
        first = next;
    } while (first != null);
}
```

### 四、**深入ReentrantReadWriteLock**

#### 一、为什么要出现读写锁

synchronized和ReentrantLock都是互斥锁。

如果说有一个操作是读多写少的，还要保证线程安全的话。如果采用上述的两种互斥锁，效率方面很定是很低的。

在这种情况下，咱们就可以使用ReentrantReadWriteLock读写锁去实现。

读读之间是不互斥的，可以读和读操作并发执行。

但是如果涉及到了写操作，那么还得是互斥的操作。

```java
static ReentrantReadWriteLock lock = new ReentrantReadWriteLock();

static ReentrantReadWriteLock.WriteLock writeLock = lock.writeLock();

static ReentrantReadWriteLock.ReadLock readLock = lock.readLock();

public static void main(String[] args) throws InterruptedException {
    new Thread(() -> {
        readLock.lock();
        try {
            System.out.println("子线程！");
            try {
                Thread.sleep(500000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        } finally {
            readLock.unlock();
        }
    }).start();

    Thread.sleep(1000);
    writeLock.lock();
    try {
        System.out.println("主线程！");
    } finally {
        writeLock.unlock();
    }
}
```

#### 二、读写锁的实现原理

**ReentrantReadWriteLock还是基于AQS实现的，还是对state进行操作，拿到锁资源就去干活，如果没有拿到，依然去AQS队列中排队。**

**读锁操作：基于state的高16位进行操作。**

**写锁操作：基于state的低16为进行操作。**

**ReentrantReadWriteLock依然是可重入锁。**

**写锁重入**：读写锁中的写锁的重入方式，基本和ReentrantLock一致，没有什么区别，依然是对state进行+1操作即可，只要确认持有锁资源的线程，是当前写锁线程即可。只不过之前ReentrantLock的重入次数是state的正数取值范围，但是读写锁中写锁范围就变小了。

**读锁重入**：因为读锁是共享锁。读锁在获取锁资源操作时，是要对state的高16位进行 + 1操作。因为读锁是共享锁，所以同一时间会有多个读线程持有读锁资源。这样一来，多个读操作在持有读锁时，无法确认每个线程读锁重入的次数。为了去记录读锁重入的次数，每个读操作的线程，都会有一个ThreadLocal记录锁重入的次数。

**写锁的饥饿问题**：读锁是共享锁，当有线程持有读锁资源时，再来一个线程想要获取读锁，直接对state修改即可。在读锁资源先被占用后，来了一个写锁资源，此时，大量的需要获取读锁的线程来请求锁资源，如果可以绕过写锁，直接拿资源，会造成写锁长时间无法获取到写锁资源。

**读锁在拿到锁资源后，如果再有读线程需要获取读锁资源，需要去AQS队列排队。如果队列的前面需要写锁资源的线程，那么后续读线程是无法拿到锁资源的。持有读锁的线程，只会让写锁线程之前的读线程拿到锁资源**

#### 三、写锁分析

##### 3.1 写锁加锁流程概述

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1654095150060/09215181ecf44581aa9b0e464e05b418.png)

##### 3.2 写锁加锁源码分析

写锁加锁流程

```java
// 写锁加锁的入口
public void lock() {
    sync.acquire(1);
}

// 阿巴阿巴！！
public final void acquire(int arg) {
    if (!tryAcquire(arg) &&
        acquireQueued(addWaiter(Node.EXCLUSIVE), arg))
        selfInterrupt();
}

// 读写锁的写锁实现tryAcquire
protected final boolean tryAcquire(int acquires) {
    // 拿到当前线程
    Thread current = Thread.currentThread();
    // 拿到state的值
    int c = getState();
    // 得到state低16位的值
    int w = exclusiveCount(c);
    // 判断是否有线程持有着锁资源
    if (c != 0) {
        // 当前没有线程持有写锁，读写互斥，告辞。
        // 有线程持有写锁，持有写锁的线程不是当前线程，不是锁重入，告辞。
        if (w == 0 || current != getExclusiveOwnerThread())
            return false;
        // 当前线程持有写锁。 锁重入。
        if (w + exclusiveCount(acquires) > MAX_COUNT)
            throw new Error("Maximum lock count exceeded");
        // 没有超过锁重入的次数，正常 + 1
        setState(c + acquires);
        return true;
    }
    // 尝试获取锁资源
    if (writerShouldBlock() ||
        // CAS拿锁
        !compareAndSetState(c, c + acquires))
        return false;
    // 拿锁成功，设置占有互斥锁的线程
    setExclusiveOwnerThread(current);
    // 返回true
    return true;
}

// ================================================================
// 这个方法是将state的低16位的值拿到
int w = exclusiveCount(c);
state & ((1 << 16) - 1)
00000000 00000000 00000000 00000001    ==   1
00000000 00000001 00000000 00000000    ==   1 << 16
00000000 00000000 11111111 11111111    ==   (1 << 16) - 1
&运算，一个为0，必然为0，都为1，才为1
// ================================================================
// writerShouldBlock方法查看公平锁和非公平锁的效果
// 非公平锁直接返回false执行CAS尝试获取锁资源
// 公平锁需要查看是否有排队的，如果有排队的，我是否是head的next
```

##### 3.3 写锁释放锁流程概述&释放锁源码

释放的流程和ReentrantLock一致，只是在判断释放是否干净时，判断低16位的值

```java
// 写锁释放锁的tryRelease方法
protected final boolean tryRelease(int releases) {
    // 判断当前持有写锁的线程是否是当前线程
    if (!isHeldExclusively())
        throw new IllegalMonitorStateException();
    // 获取state - 1
    int nextc = getState() - releases;
    // 判断低16位结果是否为0，如果为0，free设置为true
    boolean free = exclusiveCount(nextc) == 0;
    if (free)
        // 将持有锁的线程设置为null
        setExclusiveOwnerThread(null);
    // 设置给state
    setState(nextc);
    // 释放干净，返回true。  写锁有冲入，这里需要返回false，不去释放排队的Node
    return free;
}
```

#### 四、读锁分析

##### 4.1 读锁加锁流程概述

1、分析读锁加速的基本流程

2、分析读锁的可重入锁实现以及优化

3、解决ThreadLocal内存泄漏问题

4、读锁获取锁自后，如果唤醒AQS中排队的读线程

##### 4.1.1 基础读锁流程

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1654095150060/08d73c23a8654fe2867269d63678cdee.png)

针对上述简单逻辑的源码分析

```java
// 读锁加锁的方法入口
public final void acquireShared(int arg) {
    // 竞争锁资源滴干活
    if (tryAcquireShared(arg) < 0)
        // 没拿到锁资源，去排队
        doAcquireShared(arg);
}

// 读锁竞争锁资源的操作
protected final int tryAcquireShared(int unused) {
    // 拿到当前线程
    Thread current = Thread.currentThread();
    // 拿到state
    int c = getState();
    // 拿到state的低16位，判断 != 0，有写锁占用着锁资源
    // 并且，当前占用锁资源的线程不是当前线程
    if (exclusiveCount(c) != 0 && getExclusiveOwnerThread() != current)
        // 写锁被其他线程占用，无法获取读锁，直接返回 -1，去排队
        return -1;
    // 没有线程持有写锁、当前线程持有写锁
    // 获取读锁的信息，state的高16位。
    int r = sharedCount(c);
    // 公平锁：就查看队列是由有排队的，有排队的，直接告辞，进不去if，后面也不用判断（没人排队继续走）
    // 非公平锁：没有排队的，直接抢。 有排队的，但是读锁其实不需要排队，如果出现这个情况，大部分是写锁资源刚刚释放，
    // 后续Node还没有来记得拿到读锁资源，当前竞争的读线程，可以直接获取
    if (!readerShouldBlock() &&
        // 判断持有读锁的临界值是否达到
        r < MAX_COUNT &&
        // CAS修改state，对高16位进行 + 1
        compareAndSetState(c, c + SHARED_UNIT)) {
        // 省略部分代码！！！！
        return 1;
    }
    return fullTryAcquireShared(current);
}
// 非公平锁的判断
final boolean apparentlyFirstQueuedIsExclusive() {
    Node h, s;
    return (h = head) != null &&    // head为null，可以直接抢占锁资源
        (s = h.next)  != null &&    // head的next为null，可以直接抢占锁资源
        !s.isShared()         &&    // 如果排在head后面的Node，是共享锁，可以直接抢占锁资源。
        s.thread != null;           // 后面排队的thread为null，可以直接抢占锁资源
}
```

##### 4.1.2 读锁重入流程

> =============================重入操作================
>
> 前面阐述过，读锁为了记录锁重入的次数，需要让每个读线程用ThreadLocal存储重入次数
>
> ReentrantReadWriteLock对读锁重入做了一些优化操作
>
> ============================记录重入次数的核心================
>
> ReentrantReadWriteLock在内部对ThreadLocal做了封装，基于HoldCount的对象存储重入次数，在内部有个count属性记录，而且每个线程都是自己的ThreadLocalHoldCounter，所以可以直接对内部的count进行++操作。
>
> =============================第一个获取读锁资源的重入次数记录方式================
>
> 第一个拿到读锁资源的线程，不需要通过ThreadLocal存储，内部提供了两个属性来记录第一个拿到读锁资源线程的信息
>
> 内部提供了firstReader记录第一个拿到读锁资源的线程，firstReaderHoldCount记录firstReader的锁重入次数
>
> ==============================最后一个获取读锁资源的重入次数记录方式================
>
> 最后一个拿到读锁资源的线程，也会缓存他的重入次数，这样++起来更方便
>
> 基于cachedHoldCounter缓存最后一个拿到锁资源现成的重入次数
>
> ==============================最后一个获取读锁资源的重入次数记录方式================
>
> 重入次数的流程执行方式：
>
> 1、判断当前线程是否是第一个拿到读锁资源的：如果是，直接将firstReader以及firstReaderHoldCount设置为当前线程的信息
>
> 2、判断当前线程是否是firstReader：如果是，直接对firstReaderHoldCount++即可。
>
> 3、跟firstReader没关系了，先获取cachedHoldCounter，判断是否是当前线程。
>
> 3.1、如果不是，获取当前线程的重入次数，将cachedHoldCounter设置为当前线程。
>
> 3.2、如果是，判断当前重入次数是否为0，重新设置当前线程的锁从入信息到readHolds（ThreadLocal）中，算是初始化操作，重入次数是0
>
> 3.3、前面两者最后都做count++

上述逻辑源码分析

```java
protected final int tryAcquireShared(int unused) {
    Thread current = Thread.currentThread();
    int c = getState();
    if (exclusiveCount(c) != 0 &&
        getExclusiveOwnerThread() != current)
        return -1;
    int r = sharedCount(c);
    if (!readerShouldBlock() &&
        r < MAX_COUNT &&
        compareAndSetState(c, c + SHARED_UNIT)) {
        // ===============================================================
        // 判断r == 0，当前是第一个拿到读锁资源的线程
        if (r == 0) {
            // 将firstReader设置为当前线程
            firstReader = current;
            // 将count设置为1
            firstReaderHoldCount = 1;
        } 
        // 判断当前线程是否是第一个获取读锁资源的线程
        else if (firstReader == current) {
            // 直接++。
            firstReaderHoldCount++;
        } 
        // 到这，就说明不是第一个获取读锁资源的线程
        else {
            // 那获取最后一个拿到读锁资源的线程
            HoldCounter rh = cachedHoldCounter;
            // 判断当前线程是否是最后一个拿到读锁资源的线程
            if (rh == null || rh.tid != getThreadId(current))
                // 如果不是，设置当前线程为cachedHoldCounter
                cachedHoldCounter = rh = readHolds.get();
            // 当前线程是之前的cacheHoldCounter
            else if (rh.count == 0)
                // 将当前的重入信息设置到ThreadLocal中
                readHolds.set(rh);
            // 重入的++
            rh.count++;
        }
        // ===============================================================
        return 1;
    }
    return fullTryAcquireShared(current);
}
```

##### 4.1.3 读锁加锁的后续逻辑fullTryAcquireShared

```java
// tryAcquireShard方法中，如果没有拿到锁资源，走这个方法，尝试再次获取，逻辑跟上面基本一致。
final int fullTryAcquireShared(Thread current) {
    // 声明当前线程的锁重入次数
    HoldCounter rh = null;
    // 死循环
    for (;;) {
        // 再次拿到state
        int c = getState();
        // 当前如果有写锁在占用锁资源，并且不是当前线程，返回-1，走排队策略
        if (exclusiveCount(c) != 0) {
            if (getExclusiveOwnerThread() != current)
                return -1;

        } 
        // 查看当前是否可以尝试竞争锁资源（公平锁和非公平锁的逻辑）
        else if (readerShouldBlock()) {
            // 无论公平还是非公平，只要进来，就代表要放到AQS队列中了，先做一波准备
            // 在处理ThreadLocal的内存泄漏问题
            if (firstReader == current) {
                // 如果当前当前线程是之前的firstReader，什么都不用做
            } else {
                // 第一次进来是null。
                if (rh == null) {
                    // 拿到最后一个获取读锁的线程
                    rh = cachedHoldCounter;
                    // 当前线程并不是cachedHoldCounter，没到拿到
                    if (rh == null || rh.tid != getThreadId(current)) {
                        // 从自己的ThreadLocal中拿到重入计数器
                        rh = readHolds.get();
                        // 如果计数器为0，说明之前没拿到过读锁资源
                        if (rh.count == 0)
                            // remove，避免内存泄漏
                            readHolds.remove();
                    }
                }
                // 前面处理完之后，直接返回-1
                if (rh.count == 0)
                    return -1;
            }
        }
        // 判断重入次数，是否超出阈值
        if (sharedCount(c) == MAX_COUNT)
            throw new Error("Maximum lock count exceeded");
        // CAS尝试获取锁资源
        if (compareAndSetState(c, c + SHARED_UNIT)) {
            if (sharedCount(c) == 0) {
                firstReader = current;
                firstReaderHoldCount = 1;
            } else if (firstReader == current) {
                firstReaderHoldCount++;
            } else {
                if (rh == null)
                    rh = cachedHoldCounter;
                if (rh == null || rh.tid != getThreadId(current))
                    rh = readHolds.get();
                else if (rh.count == 0)
                    readHolds.set(rh);
                rh.count++;
                cachedHoldCounter = rh; // cache for release
            }
            return 1;
        }
    }
}
```

##### 4.1.4 读线程在AQS队列获取锁资源的后续操作

> 1、正常如果都是读线程来获取读锁资源，不需要使用到AQS队列的，直接CAS操作即可
>
> 2、如果写线程持有着写锁，这是读线程就需要进入到AQS队列排队，可能会有多个读线程在AQS中。
>
> 当写锁释放资源后，会唤醒head后面的读线程，当head后面的读线程拿到锁资源后，还需要查看next节点是否也是读线程在阻塞，如果是，直接唤醒

源码分析

```java
// 读锁需要排队的操作
private void doAcquireShared(int arg) {
    // 声明Node，类型是共享锁，并且扔到AQS中排队
    final Node node = addWaiter(Node.SHARED);
    boolean failed = true;
    try {
        boolean interrupted = false;
        for (;;) {
            // 拿到上一个节点
            final Node p = node.predecessor();
            // 如果prev节点是head，直接可以执行tryAcquireShared
            if (p == head) {
                int r = tryAcquireShared(arg);
                if (r >= 0) {
                    // 拿到读锁资源后，需要做的后续处理
                    setHeadAndPropagate(node, r);
                    p.next = null; // help GC
                    if (interrupted)
                        selfInterrupt();
                    failed = false;
                    return;
                }
            }
            // 找到prev有效节点，将状态设置为-1，挂起当前线程
            if (shouldParkAfterFailedAcquire(p, node) &&
                parkAndCheckInterrupt())
                interrupted = true;
        }
    } finally {
        if (failed)
            cancelAcquire(node);
    }
}

private void setHeadAndPropagate(Node node, int propagate) {
    // 拿到head节点
    Node h = head; 
    // 将当前节点设置为head节点
    setHead(node);
    // 第一个判断更多的是在信号量有处理JDK1.5 BUG的操作。
    if (propagate > 0 || h == null || h.waitStatus < 0 || (h = head) == null || h.waitStatus < 0) {
        // 拿到当前Node的next节点
        Node s = node.next;
        // 如果next节点是共享锁，直接唤醒next节点
        if (s == null || s.isShared())
            doReleaseShared();
    }
}
```

#### 4.2 读锁的释放锁流程

1、处理重入以及state的值

2、唤醒后续排队的Node

源码分析

```java
// 读锁释放锁流程
public final boolean releaseShared(int arg) {
    // tryReleaseShared：处理state的值，以及可重入的内容
    if (tryReleaseShared(arg)) {
        // AQS队列的事！
        doReleaseShared();
        return true;
    }
    return false;
}

// 1、 处理重入问题  2、 处理state
protected final boolean tryReleaseShared(int unused) {
    // 拿到当前线程
    Thread current = Thread.currentThread();
    // 如果是firstReader，直接干活，不需要ThreadLocal
    if (firstReader == current) {
        // assert firstReaderHoldCount > 0;
        if (firstReaderHoldCount == 1)
            firstReader = null;
        else
            firstReaderHoldCount--;
    } 
    // 不是firstReader，从cachedHoldCounter以及ThreadLocal处理
    else {
        // 如果是cachedHoldCounter，正常--
        HoldCounter rh = cachedHoldCounter;
        // 如果不是cachedHoldCounter，从自己的ThreadLocal中拿
        if (rh == null || rh.tid != getThreadId(current))
            rh = readHolds.get();
        int count = rh.count;
        // 如果为1或者更小，当前线程就释放干净了，直接remove，避免value内存泄漏
        if (count <= 1) {
            readHolds.remove();
            // 如果已经是0，没必要再unlock，扔个异常
            if (count <= 0)
                throw unmatchedUnlockException();
        }
        // -- 走你。
        --rh.count;
    }
    for (;;) {
        // 拿到state，高16位，-1，成功后，返回state是否为0
        int c = getState();
        int nextc = c - SHARED_UNIT;
        if (compareAndSetState(c, nextc))
            return nextc == 0;
    }
}

// 唤醒AQS中排队的线程
private void doReleaseShared() {
    // 死循环
    for (;;) {
        // 拿到头
        Node h = head;
        // 说明有排队的
        if (h != null && h != tail) {
            // 拿到head的状态
            int ws = h.waitStatus;
            // 判断是否为 -1 
            if (ws == Node.SIGNAL) {
                // 到这，说明后面有挂起的线程，先基于CAS将head的状态从-1，改为0
                if (!compareAndSetWaitStatus(h, Node.SIGNAL, 0))
                    continue;   
                // 唤醒后续节点
                unparkSuccessor(h);
            }
            // 这里不是给读写锁准备的，在信号量里说。。。
            else if (ws == 0 && !compareAndSetWaitStatus(h, 0, Node.PROPAGATE))
                continue;
        }
        // 这里是出口
        if (h == head)   
            break;
    }
}
```

### 五、**死锁问题**

在咱们的操作系统2022版本有，已经有最新的死锁课程了，这里就不做过多讲解

查看这个课程：

https://www.mashibing.com/course/1368

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1654095150060/3a3563ce1673493787f97aeac99dc5e4.png)

## **阻塞队列**

### 一、**基础概念**

#### 1.1 生产者消费者概念

生产者消费者是设计模式的一种。让生产者和消费者基于一个容器来解决强耦合问题。

生产者 消费者彼此之间不会直接通讯的，而是通过一个容器（队列）进行通讯。

所以生产者生产完数据后扔到容器中，不通用等待消费者来处理。

消费者不需要去找生产者要数据，直接从容器中获取即可。

而这种容器最常用的结构就是队列。

#### 1.2 JUC阻塞队列的存取方法

常用的存取方法都是来自于JUC包下的BlockingQueue

生产者存储方法

```java
add(E)     	// 添加数据到队列，如果队列满了，无法存储，抛出异常
offer(E)    // 添加数据到队列，如果队列满了，返回false
offer(E,timeout,unit)   // 添加数据到队列，如果队列满了，阻塞timeout时间，如果阻塞一段时间，依然没添加进入，返回false
put(E)      // 添加数据到队列，如果队列满了，挂起线程，等到队列中有位置，再扔数据进去，死等！
```

消费者取数据方法

```java
remove()    // 从队列中移除数据，如果队列为空，抛出异常
poll()      // 从队列中移除数据，如果队列为空，返回null，么的数据
poll(timeout,unit)   // 从队列中移除数据，如果队列为空，挂起线程timeout时间，等生产者扔数据，再获取
take()     // 从队列中移除数据，如果队列为空，线程挂起，一直等到生产者扔数据，再获取
```

### 二、**ArrayBlockingQueue**

#### 2.1 ArrayBlockingQueue的基本使用

**ArrayBlockingQueue**在初始化的时候，必须指定当前队列的长度。

因为**ArrayBlockingQueue**是基于数组实现的队列结构，数组长度不可变，必须提前设置数组长度信息。

```java
public static void main(String[] args) throws ExecutionException, InterruptedException, IOException {
    // 必须设置队列的长度
    ArrayBlockingQueue queue = new ArrayBlockingQueue(4);

    // 生产者扔数据
    queue.add("1");
    queue.offer("2");
    queue.offer("3",2,TimeUnit.SECONDS);
    queue.put("2");

    // 消费者取数据
    System.out.println(queue.remove());
    System.out.println(queue.poll());
    System.out.println(queue.poll(2,TimeUnit.SECONDS));
    System.out.println(queue.take());
}
```

#### 2.2 生产者方法实现原理

生产者添加数据到队列的方法比较多，需要一个一个查看

##### 2.2.1 ArrayBlockingQueue的常见属性

ArrayBlockingQueue中的成员变量

```sh
lock = 就是一个ReentrantLock
count = 就是当前数组中元素的个数
iterms = 就是数组本身
## 基于putIndex和takeIndex将数组结构实现为了队列结构
putIndex = 存储数据时的下标
takeIndex = 去数据时的下标
notEmpty = 消费者挂起线程和唤醒线程用到的Condition（看成sync的wait和notify）
notFull = 生产者挂起线程和唤醒线程用到的Condition（看成sync的wait和notify）
```

##### 2.2.2 add方法实现

add方法本身就是调用了offer方法，如果offer方法返回false，直接抛出异常

```java
public boolean add(E e) {
    if (offer(e))
        return true;
    else
        // 抛出的异常
        throw new IllegalStateException("Queue full");
}
```

##### 2.2.3 offer方法实现

```java
public boolean offer(E e) {
    // 要求存储的数据不允许为null，为null就抛出空指针
    checkNotNull(e);
    // 当前阻塞队列的lock锁
    final ReentrantLock lock = this.lock;
    // 为了保证线程安全，加锁
    lock.lock();
    try {
        // 如果队列中的元素已经存满了，
        if (count == items.length)
            // 返回false
            return false;
        else {
            // 队列没满，执行enqueue将元素添加到队列中
            enqueue(e);
            // 返回true
            return true;
        }
    } finally {
        // 操作完释放锁
        lock.unlock();
    }
}

//==========================================================
private void enqueue(E x) {
    // 拿到数组的引用
    final Object[] items = this.items;
    // 将元素放到指定位置
    items[putIndex] = x;
    // 对inputIndex进行++操作，并且判断是否已经等于数组长度，需要归位
    if (++putIndex == items.length)
        // 将索引设置为0
        putIndex = 0;
    // 元素添加成功，进行++操作。
    count++;
    // 将一个Condition中阻塞的线程唤醒。
    notEmpty.signal();
}
```

##### 2.2.4  offer(time,unit)方法

生产者在添加数据时，如果队列已经满了，阻塞一会。

- 阻塞到消费者消费了消息，然后唤醒当前阻塞线程
- 阻塞到了time时间，再次判断是否可以添加，不能，直接告辞。

```java
// 如果线程在挂起的时候，如果对当前阻塞线程的中断标记位进行设置，此时会抛出异常直接结束
public boolean offer(E e, long timeout, TimeUnit unit) throws InterruptedException {
	// 非空检验
    checkNotNull(e);
    // 将时间单位转换为纳秒
    long nanos = unit.toNanos(timeout);
    // 加锁
    final ReentrantLock lock = this.lock;
    // 允许线程中断并排除异常的加锁方式
    lock.lockInterruptibly();
    try {
        // 为什么是while（虚假唤醒）
        // 如果元素个数和数组长度一致，队列慢了
        while (count == items.length) {
            // 判断等待的时间是否还充裕
            if (nanos <= 0)
                // 不充裕，直接添加失败
                return false;
            // 挂起等待，会同时释放锁资源（对标sync的wait方法）
            // awaitNanos会挂起线程，并且返回剩余的阻塞时间
            // 恢复执行时，需要重新获取锁资源
            nanos = notFull.awaitNanos(nanos);
        }
        // 说明队列有空间了，enqueue将数据扔到阻塞队列中
        enqueue(e);
        return true;
    } finally {
        // 释放锁资源
        lock.unlock();
    }
}
```

##### 2.2.5 put方法

如果队列是满的， 就一直挂起，直到被唤醒，或者被中断

```java
public void put(E e) throws InterruptedException {
    checkNotNull(e);
    final ReentrantLock lock = this.lock;
    lock.lockInterruptibly();
    try {
        while (count == items.length)
            // await方法一直阻塞，直到被唤醒或者中断标记位
            notFull.await();
        enqueue(e);
    } finally {
        lock.unlock();
    }
}
```

#### 2.3 消费者方法实现原理

##### 2.3.1 remove方法

```java
// remove方法就是调用了poll
public E remove() {
    E x = poll();
    // 如果有数据，直接返回
    if (x != null)
        return x;
    // 没数据抛出异常
    else
        throw new NoSuchElementException();
}
```

##### 2.4.2 poll方法

```java
// 拉取数据
public E poll() {
    // 加锁操作
    final ReentrantLock lock = this.lock;
    lock.lock();
    try {
        // 如果没有数据，直接返回null，如果有数据，执行dequeue，取出数据并返回
        return (count == 0) ? null : dequeue();
    } finally {
        lock.unlock();
    }
}

//==========================================================
// 取出数据
private E dequeue() {
    // 将成员变量引用到局部变量
    final Object[] items = this.items;
    // 直接获取指定索引位置的数据
    E x = (E) items[takeIndex];
    // 将数组上指定索引位置设置为null
    items[takeIndex] = null;
    // 设置下次取数据时的索引位置
    if (++takeIndex == items.length)
        takeIndex = 0;
    // 对count进行--操作
    count--;
    // 迭代器内容，先跳过
    if (itrs != null)
        itrs.elementDequeued();
    // signal方法，会唤醒当前Condition中排队的一个Node。
    // signalAll方法，会将Condition中所有的Node，全都唤醒
    notFull.signal();
    // 返回数据。
    return x;
}
```

##### 2.4.3 poll(time,unit)方法

```java
public E poll(long timeout, TimeUnit unit) throws InterruptedException {
    // 转换时间单位
    long nanos = unit.toNanos(timeout);
    // 竞争锁
    final ReentrantLock lock = this.lock;
    lock.lockInterruptibly();
    try {
        // 如果没有数据
        while (count == 0) {
            if (nanos <= 0)
                // 没数据，也无法阻塞了，返回null
                return null;
            // 没数据，挂起消费者线程
            nanos = notEmpty.awaitNanos(nanos);
        }
        // 取数据
        return dequeue();
    } finally {
        lock.unlock();
    }
}
```

##### 2.4.4 take方法

```java
public E take() throws InterruptedException {
    final ReentrantLock lock = this.lock;
    lock.lockInterruptibly();
    try {
        // 虚假唤醒
        while (count == 0)
            notEmpty.await();
        return dequeue();
    } finally {
        lock.unlock();
    }
}
```

##### 2.4.5 虚假唤醒

阻塞队列中，如果需要线程挂起操作，判断有无数据的位置采用的是while循环 ，为什么不能换成if

肯定是不能换成if逻辑判断

线程A，线程B，线程E，线程C。 其中ABE生产者，C属于消费者

假如线程的队列是满的

```java
// E，拿到锁资源，还没有走while判断
while (count == items.length)
    // A醒了
    // B挂起
    notFull.await();
enqueue(e)；
```

C此时消费一条数据，执行notFull.signal()唤醒一个线程，A线程被唤醒

E走判断，发现有空余位置，可以添加数据到队列，E添加数据，走enqueue

如果判断是if，A在E释放锁资源后，拿到锁资源，直接走enqueue方法。

此时A线程就是在putIndex的位置，覆盖掉之前的数据，造成数据安全问题

### 三、**LinkedBlockingQueue**

#### 3.1 LinkedBlockingQueue的底层实现

查看LinkedBlockingQueue是如何存储数据，并且实现链表结构的。

```java
// Node对象就是存储数据的单位
static class Node<E> {
    // 存储的数据
    E item;
	// 指向下一个数据的指针
    Node<E> next;
	// 有参构造
    Node(E x) { item = x; }
}
```

查看LinkedBlockingQueue的有参构造

```java
// 可以手动指定LinkedBlockingQueue的长度，如果没有指定，默认为Integer.MAX_VALUE
public LinkedBlockingQueue(int capacity) {
    if (capacity <= 0) throw new IllegalArgumentException();
    this.capacity = capacity;
    // 在初始化时，构建一个item为null的节点，作为head和last
	 // 这种node可以成为哨兵Node，
    // 如果没有哨兵节点，那么在获取数据时，需要判断head是否为null，才能找next
    // 如果没有哨兵节点，那么在添加数据时，需要判断last是否为null，才能找next
    last = head = new Node<E>(null);
}
```

查看LinkedBlockingQueue的其他属性

```java
// 因为是链表，没有想数组的length属性，基于AtomicInteger来记录长度
private final AtomicInteger count = new AtomicInteger();
// 链表的头，取
transient Node<E> head;
// 链表的尾，存
private transient Node<E> last;
// 消费者的锁
private final ReentrantLock takeLock = new ReentrantLock();
// 消费者的挂起操作，以及唤醒用的condition
private final Condition notEmpty = takeLock.newCondition();
// 生产者的锁
private final ReentrantLock putLock = new ReentrantLock();
// 生产者的挂起操作，以及唤醒用的condition
private final Condition notFull = putLock.newCondition();
```

#### 3.2 生产者方法实现原理

##### 3.2.1 add方法

你懂得，还是走offer方法

```java
public boolean add(E e) {
    if (offer(e))
        return true;
    else
        throw new IllegalStateException("Queue full");
}
```

##### 3.2.2 offer方法

```java
public boolean offer(E e) {
    // 非空校验
    if (e == null) throw new NullPointerException();
    // 拿到存储数据条数的count
    final AtomicInteger count = this.count;
    // 查看当前数据条数，是否等于队列限制长度，达到了这个长度，直接返回false
    if (count.get() == capacity)
        return false;
    // 声明c，作为标记存在
    int c = -1;
    // 将存储的数据封装为Node对象
    Node<E> node = new Node<E>(e);
    // 获取生产者的锁。
    final ReentrantLock putLock = this.putLock;
    // 竞争锁资源
    putLock.lock();
    try {
        // 再次做一个判断，查看是否还有空间
        if (count.get() < capacity) {
            // enqueue，扔数据
            enqueue(node);
            // 将数据个数 + 1
            c = count.getAndIncrement();
            // 拿到count的值 小于 长度限制
            // 有生产者在基于await挂起，这里添加完数据后，发现还有空间可以存储数据，
            // 唤醒前面可能已经挂起的生产者
            // 因为这里生产者和消费者不是互斥的，写操作进行的同时，可能也有消费者在消费数据。
            if (c + 1 < capacity)
                // 唤醒生产者
                notFull.signal();
        }
    } finally {
        // 释放锁资源
        putLock.unlock();
    }
    // 如果c == 0，代表添加数据之前，队列元素个数是0个。
    // 如果有消费者在队列没有数据的时候，来消费，此时消费者一定会挂起线程
    if (c == 0)
        // 唤醒消费者
        signalNotEmpty();
    // 添加成功返回true，失败返回-1
    return c >= 0;
}

//================================================
private void enqueue(Node<E> node) {
    // 将当前Node设置为last的next，并且再将当前Node作为last
    last = last.next = node;
}
//================================================
private void signalNotEmpty() {
    // 获取读锁
    final ReentrantLock takeLock = this.takeLock;
    takeLock.lock();
    try {
        // 唤醒。
        notEmpty.signal();
    } finally {
        takeLock.unlock();
    }
}
sync -> wait / notify
```

##### 3.2.3 offer(time,unit)方法

```java
public boolean offer(E e, long timeout, TimeUnit unit) throws InterruptedException {
	 // 非空检验
    if (e == null) throw new NullPointerException();
    // 将时间转换为纳秒
    long nanos = unit.toNanos(timeout);
    // 标记
    int c = -1;
    // 写锁，数据条数
    final ReentrantLock putLock = this.putLock;
    final AtomicInteger count = this.count;
    // 允许中断的加锁方式
    putLock.lockInterruptibly();
    try {
        // 如果元素个数和限制个数一致，直接准备挂起
        while (count.get() == capacity) {
            // 挂起的时间是不是已经没了
            if (nanos <= 0)
                // 添加失败，返回false
                return false;
            // 挂起线程
            nanos = notFull.awaitNanos(nanos);
        }
        // 有空余位置，enqueue添加数据
        enqueue(new Node<E>(e));
        // 元素个数 + 1
        c = count.getAndIncrement();
        // 当前添加完数据，还有位置可以添加数据，唤醒可能阻塞的生产者
        if (c + 1 < capacity)
            notFull.signal();
    } finally {
        // 释放锁
        putLock.unlock();
    }
    // 如果之前元素个数是0，唤醒可能等待的消费者
    if (c == 0)
        signalNotEmpty();
    return true;
}
```

##### 3.2.4 put方法

```java
public void put(E e) throws InterruptedException {
    if (e == null) throw new NullPointerException();
    int c = -1;
    Node<E> node = new Node<E>(e);
    final ReentrantLock putLock = this.putLock;
    final AtomicInteger count = this.count;
    putLock.lockInterruptibly();
    try {
        while (count.get() == capacity) {
            // 一直挂起线程，等待被唤醒
            notFull.await();
        }
        enqueue(node);
        c = count.getAndIncrement();
        if (c + 1 < capacity)
            notFull.signal();
    } finally {
        putLock.unlock();
    }
    if (c == 0)
        signalNotEmpty();
}
```

#### 3.3 消费者方法实现原理

从remove方法开始，查看消费者获取数据的方式

##### 3.3.1 remove方法

```java
public E remove() {
    E x = poll();
    if (x != null)
        return x;
    else
        throw new NoSuchElementException();
}
```

##### 3.3.2 poll方法

```java
public E poll() {
    // 拿到队列数据个数的计数器
    final AtomicInteger count = this.count;
    // 当前队列中数据是否0
    if (count.get() == 0)
        // 说明队列没数据，直接返回null即可
        return null;
    // 声明返回结果
    E x = null;
    // 标记
    int c = -1;
    // 获取消费者的takeLock
    final ReentrantLock takeLock = this.takeLock;
    // 加锁
    takeLock.lock();
    try {
        // 基于DCL，确保当前队列中依然有元素
        if (count.get() > 0) {
            // 从队列中移除数据
            x = dequeue();
            // 将之前的元素个数获取，并--
            c = count.getAndDecrement();
            if (c > 1)
                // 如果依然有数据，继续唤醒await的消费者。
                notEmpty.signal();
        }
    } finally {
        // 释放锁资源
        takeLock.unlock();
    }
    // 如果之前的元素个数为当前队列的限制长度，
    // 现在消费者消费了一个数据，多了一个空位可以添加
    if (c == capacity)
        // 唤醒阻塞的生产者
        signalNotFull();
    return x;
}

//================================================

private E dequeue() {
    // 拿到队列的head位置数据
    Node<E> h = head;
    // 拿到了head的next，因为这个是哨兵Node，需要拿到的head.next的数据
    Node<E> first = h.next;
    // 将之前的哨兵Node.next置位null。help GC。
    h.next = h; 
    // 将first置位新的head
    head = first;
    // 拿到返回结果first节点的item数据，也就是之前head.next.item
    E x = first.item;
    // 将first数据置位null，作为新的head
    first.item = null;
    // 返回数据
    return x;
}

//================================================

private void signalNotFull() {
    final ReentrantLock putLock = this.putLock;
    putLock.lock();
    try {
        // 唤醒生产者。
        notFull.signal();
    } finally {
        putLock.unlock();
    }
}
```

##### 3.3.3 poll(time,unit)方法

```java
public E poll(long timeout, TimeUnit unit) throws InterruptedException {
    // 返回结果
    E x = null;
    // 标识
    int c = -1;
    // 将挂起实现设置为纳秒级别
    long nanos = unit.toNanos(timeout);
    // 拿到计数器
    final AtomicInteger count = this.count;
    // take锁加锁
    final ReentrantLock takeLock = this.takeLock;
    takeLock.lockInterruptibly();
    try {
        // 如果没数据，进到while
        while (count.get() == 0) {
            if (nanos <= 0)
                return null;
            // 挂起当前线程
            nanos = notEmpty.awaitNanos(nanos);
        }
        // 剩下内容，和之前一样。
        x = dequeue();
        c = count.getAndDecrement();
        if (c > 1)
            notEmpty.signal();
    } finally {
        takeLock.unlock();
    }
    if (c == capacity)
        signalNotFull();
    return x;
} 
```

##### 3.3.4 take方法

```java
public E take() throws InterruptedException {
    E x;
    int c = -1;
    final AtomicInteger count = this.count;
    final ReentrantLock takeLock = this.takeLock;
    takeLock.lockInterruptibly();
    try {
        // 相比poll(time,unit)方法，这里的出口只有一个，就是中断标记位，抛出异常，否则一直等待
        while (count.get() == 0) {
            notEmpty.await();
        }
        x = dequeue();
        c = count.getAndDecrement();
        if (c > 1)
            notEmpty.signal();
    } finally {
        takeLock.unlock();
    }
    if (c == capacity)
        signalNotFull();
    return x;
}
```

### 四、**PriorityBlockingQueue概念**

#### 4.1 PriorityBlockingQueue介绍

首先PriorityBlockingQueue是一个优先级队列，他不满足先进先出的概念。

会将查询的数据进行排序，排序的方式就是基于插入数据值的本身。

**如果是自定义对象必须要实现Comparable接口才可以添加到优先级队列**

排序的方式是基于**二叉堆**实现的。底层是采用数据结构实现的二叉堆。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1654095150060/b0cc492556d746a3a2c1ac9f31e06dde.png)

#### 4.2 二叉堆结构介绍

优先级队列PriorityBlockingQueue基于二叉堆实现的。

```java
private transient Object[] queue;
```

PriorityBlockingQueue是基于数组实现的二叉堆。

二叉堆是什么？

- 二叉堆就是一个完整的二叉树。
- 任意一个节点大于父节点或者小于父节点
- 基于同步的方式，可以定义出小顶堆和大顶堆

小顶堆以及小顶堆基于数据实现的方式。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1654095150060/be0f3126b64443d1bf1e05299f33d71a.png)

#### 4.3 PriorityBlockingQueue核心属性

```java
// 数组的初始长度
private static final int DEFAULT_INITIAL_CAPACITY = 11;

// 数组的最大长度
// -8的目的是为了适配各个版本的虚拟机
// 默认当前使用的hotspot虚拟机最大支持Integer.MAX_VALUE - 2，但是其他版本的虚拟机不一定。
private static final int MAX_ARRAY_SIZE = Integer.MAX_VALUE - 8;

// 存储数据的数组，也是基于这个数组实现的二叉堆。
private transient Object[] queue;

// size记录当前阻塞队列中元素的个数
private transient int size;

// 要求使用的对象要实现Comparable比较器。基于comparator做对象之间的比较
private transient Comparator<? super E> comparator;

// 实现阻塞队列的lock锁
private final ReentrantLock lock;

// 挂起线程操作。
private final Condition notEmpty;

// 因为PriorityBlockingQueue的底层是基于二叉堆的，而二叉堆又是基于数组实现的，数组长度是固定的，如果需要扩容，需要构建一个新数组。PriorityBlockingQueue在做扩容操作时，不会lock住的，释放lock锁，基于allocationSpinLock属性做标记，来避免出现并发扩容的问题。
private transient volatile int allocationSpinLock;

// 阻塞队列中用到的原理，其实就是普通的优先级队列。
private PriorityQueue<E> q;
```

#### 4.4 PriorityBlockingQueue的写入操作

毕竟是阻塞队列，添加数据的操作，咱们是很了解，无法还是add，offer，offer(time,unit)，put。但是因为优先级队列中，数组是可以扩容的，虽然有长度限制，但是依然属于无界队列的概念，所以生产者不会阻塞，所以只有offer方法可以查看。

这次核心的内容并不是添加数据的区别。主要关注的是如何保证二叉堆中小顶堆的结构的，并且还要查看数组扩容的一个过程是怎样的。

##### 4.4.1 offer基本流程

因为add方法依然调用的是offer方法，直接查看offer方法即可

```java
public boolean offer(E e) {
    // 非空判断。
    if (e == null)
        throw new NullPointerException();
    // 拿到锁，直接上锁
    final ReentrantLock lock = this.lock;
    lock.lock();
    // n：size，元素的个数
    // cap：当前数组的长度
    // array：就是存储数据的数组
    int n, cap;
    Object[] array;
    while ((n = size) >= (cap = (array = queue).length))
        // 如果元素个数大于等于数组的长度，需要尝试扩容。
        tryGrow(array, cap);
    try {
        // 拿到了比较器
        Comparator<? super E> cmp = comparator;
        // 比较数据大小，存储数据，是否需要做上移操作，保证平衡的
        if (cmp == null)
            siftUpComparable(n, e, array);
        else
            siftUpUsingComparator(n, e, array, cmp);
        // 元素个数 + 1
        size = n + 1;
        // 如果有挂起的线程，需要去唤醒挂起的消费者。
        notEmpty.signal();
    } finally {
        // 释放锁
        lock.unlock();
    }
    // 返回true
    return true;
}
```

##### 4.4.2 offer扩容操作

在添加数据之前，会采用while循环的方式，来判断当前元素个数是否大于等于数组长度。如果满足，需要执行tryGrow方法，对数组进行扩容

如果两个线程同时执行tryGrow，只会有一个线程在扩容，另一个线程可能多次走while循环，多次走tryGrow方法，但是依然需要等待前面的线程扩容完毕。

```java
private void tryGrow(Object[] array, int oldCap) {
    // 释放锁资源。
    lock.unlock(); 
    // 声明新数组。
    Object[] newArray = null;
    // 如果allocationSpinLock属性值为0，说明当前没有线程正在扩容的。
    if (allocationSpinLock == 0 &&
        // 基于CAS的方式，将allocationSpinLock从0修改为1，代表当前线程可以开始扩容
        UNSAFE.compareAndSwapInt(this, allocationSpinLockOffset,0, 1)) {
        try {
            // 计算新数组长度
            int newCap = oldCap + ((oldCap < 64) ?
                                   // 如果数组长度比较小，这里加快扩容长度速度。
                                   (oldCap + 2) : 
                                   // 如果长度大于等于64了，每次扩容到1.5倍即可。
                                   (oldCap >> 1));
            // 如果新数组长度大于MAX_ARRAY_SIZE，需要做点事了。
            if (newCap - MAX_ARRAY_SIZE > 0) {   
                // 声明minCap，长度为老数组 + 1
                int minCap = oldCap + 1;
                // 老数组+1变为负数，或者老数组长度已经大于MAX_ARRAY_SIZE了，无法扩容了。
                if (minCap < 0 || minCap > MAX_ARRAY_SIZE)
                    // 告辞，凉凉~~~~
                    throw new OutOfMemoryError();
                // 如果没有超过限制，直接设置为最大长度即可
                newCap = MAX_ARRAY_SIZE;
            }
            // 新数组长度，得大于老数组长度，
            // 第二个判断确保没有并发扩容的出现。
            if (newCap > oldCap && queue == array)
                // 构建出新数组
                newArray = new Object[newCap];
        } finally {
            // 新数组有了，标记位归0~~
            allocationSpinLock = 0;
        }
    }
    // 如果到了这，newArray依然为null，说明这个线程没有进到if方法中，去构建新数组
    if (newArray == null) 
        // 稍微等一手。
        Thread.yield();
    // 拿锁资源，
    lock.lock();
    // 拿到锁资源后，确认是构建了新数组的线程，这里就需要将新数组复制给queue，并且导入数据
    if (newArray != null && queue == array) {
        // 将新数组赋值给queue
        queue = newArray;
        // 将老数组的数据全部导入到新数组中。
        System.arraycopy(array, 0, newArray, 0, oldCap);
    }
}
```

##### 4.4.3 offer添加数据

这里是数据如何放到数组上，并且如何保证的二叉堆结构

```java
// k：当前元素的个数（其实就是要放的索引位置）
// x：需要添加的数据
// array：数组。。
private static <T> void siftUpComparable(int k, T x, Object[] array) {
    // 将插入的元素直接强转为Comparable（com.mashibing.User cannot be cast to java.lang.Comparable）
    // 这行强转，会导致添加没有实现Comparable的元素，直接报错。
    Comparable<? super T> key = (Comparable<? super T>) x;
    // k大于0，走while逻辑。（原来有数据）
    while (k > 0) {
        // 获取父节点的索引位置。
        int parent = (k - 1) >>> 1;
        // 拿到父节点的元素。
        Object e = array[parent];
        // 用子节点compareTo父节点，如果 >= 0，说明当前son节点比parent要大。
        if (key.compareTo((T) e) >= 0)
            // 直接break，完事，
            break;
        // 将son节点的位置设置上之前的parent节点
        array[k] = e;
        // 重新设置x节点需要放置的位置。
        k = parent;
    }
    // k == 0，当前元素是第一个元素，直接插入进去。
    array[k] = key;
}
```

#### 4.5 PriorityBlockingQueue的读取操作

读取操作是存储现在挂起的情况的，因为如果数组中元素个数为0，当前线程如果执行了take方法，必然需要挂起。

其次获取数据，因为是优先级队列，所以需要从二叉堆栈顶拿数据，直接拿索引为0的数据即可，但是拿完之后，需要保持二叉堆结构，所以会有下移操作。

##### 4.5.1 查看获取方法流程

poll：

```java
public E poll() {
    final ReentrantLock lock = this.lock;
    // 加锁
    lock.lock();
    try {
        // 拿到返回数据，没拿到，返回null
        return dequeue();
    } finally {
        lock.unlock();
    }
}
```

poll(time,unit)：

```java
public E poll(long timeout, TimeUnit unit) throws InterruptedException {
    // 将挂起的时间转换为纳秒
    long nanos = unit.toNanos(timeout);
    final ReentrantLock lock = this.lock;
    // 允许线程中断抛异常的加锁
    lock.lockInterruptibly();
    // 声明结果
    E result;
    try {
        // dequeue是去拿数据的，可能会出现拿到的数据为null，如果为null，同时挂起时间还有剩余，这边就直接通过notEmpty挂起线程
        while ( (result = dequeue()) == null && nanos > 0)
            nanos = notEmpty.awaitNanos(nanos);
    } finally {
        lock.unlock();
    }
    // 有数据正常返回，没数据，告辞~
    return result;
}
```

take：

```java
public E take() throws InterruptedException {
    final ReentrantLock lock = this.lock;
    lock.lockInterruptibly();
    E result;
    try {
        while ( (result = dequeue()) == null)
            // 无线等，要么有数据，要么中断线程
            notEmpty.await();
    } finally {
        lock.unlock();
    }
    return result;
}
```

##### 4.5.2 查看dequeue获取数据

获取数据主要就是从数组中拿到0索引位置数据，然后保持二叉堆结构

```java
private E dequeue() {
    // 将元素个数-1，拿到了索引位置。
    int n = size - 1;
    // 判断是不是木有数据了，没数据直接返回null即可
    if (n < 0)
        return null;
    // 说明有数据
    else {
        // 拿到数组，array
        Object[] array = queue;
        // 拿到0索引位置的数据
        E result = (E) array[0];
        // 拿到最后一个数据
        E x = (E) array[n];
        // 将最后一个位置置位null
        array[n] = null;
        Comparator<? super E> cmp = comparator;
        if (cmp == null)
            siftDownComparable(0, x, array, n);
        else
            siftDownUsingComparator(0, x, array, n, cmp);
        // 元素个数-1，赋值size
        size = n;
        // 返回result
        return result;
    }
}
```

##### 4.6.3 下移做平衡操作

一定要以局部的方式去查看树结构的变化，他是从跟节点往下找较小的一个子节点，将较小的子节点挪动到父节点位置，再将循环往下走，如果一来，整个二叉堆的结构就可以保证了。

```java
// k：默认进来是0
// x：代表二叉堆的最后一个数据
// array：数组
// n：最后一个索引
private static <T> void siftDownComparable(int k, T x, Object[] array,int n) {
    // 健壮性校验，取完第一个数据，已经没数据了，那就不需要做平衡操作
    if (n > 0) {
        // 拿到最后一个数据的比较器
        Comparable<? super T> key = (Comparable<? super T>)x;
        // 因为二叉堆是一个二叉满树，所以在保证二叉堆结构时，只需要做一半就可以
        int half = n >>> 1; 
        // 做了超过一半，就不需要再往下找了。
        while (k < half) {
            // 找左子节点索引，一个公式，可以找到当前节点的左子节点
            int child = (k << 1) + 1; 
            // 拿到左子节点的数据
            Object c = array[child];
            // 拿到右子节点索引
            int right = child + 1;
            // 确认有右子节点
            // 判断左节点是否大于右节点
            if (right < n && c.compareTo(array[right]) > 0)
                // 如果左大于右，那么c就执行右
                c = array[child = right];
            // 比较最后一个节点是否小于当前的较小的子节点
            if (key.compareTo((T) c) <= 0)
                break;
            // 将左右子节点较小的放到之前的父节点位置
            array[k] = c;
            // k重置到之前的子节点位置
            k = child;
        }
        // 上面while循环搞定后，可以确认整个二叉堆中，数据已经移动ok了，只差当前k的位置数据是null
        // 将最后一个索引的数据放到k的位置
        array[k] = key;
    }
}
```

### 五、DelayQueue

#### 5.1 DelayQueue介绍&应用

DelayQueue就是一个延迟队列，生产者写入一个消息，这个消息还有直接被消费的延迟时间。

需要让消息具有延迟的特性。

DelayQueue也是基于二叉堆结构实现的，甚至本事就是基于PriorityQueue实现的功能。二叉堆结构每次获取的是栈顶的数据，需要让DelayQueue中的数据，在比较时，跟根据延迟时间做比较，剩余时间最短的要放在栈顶。

查看DelayQueue类信息：

```java
public class DelayQueue<E extends Delayed> extends AbstractQueue<E> implements BlockingQueue<E> {
    // 发现DelayQueue中的元素，需要继承Delayed接口。
}
// ==========================================
// 接口继承了Comparable，这样就具备了比较的能力。
public interface Delayed extends Comparable<Delayed> {
    // 抽象方法，就是咱们需要设置的延迟时间
    long getDelay(TimeUnit unit);
  
    // Comparable接口提供的：public int compareTo(T o);
}
```

基于上述特点，声明一个可以写入DelayQueue的元素类

```java
public class Task implements Delayed {

    /** 任务的名称 */
    private String name;

    /** 什么时间点执行 */
    private Long time;

    /**
     *
     * @param name
     * @param delay  单位毫秒。
     */
    public Task(String name, Long delay) {
        // 任务名称
        this.name = name;
        this.time = System.currentTimeMillis() + delay;
    }

    /**
     * 设置任务什么时候可以出延迟队列
     * @param unit
     * @return
     */
    @Override
    public long getDelay(TimeUnit unit) {
		// 单位是毫秒，视频里写错了，写成了纳秒，
        return unit.convert(time - System.currentTimeMillis(),TimeUnit.MILLISECONDS);
    }

    /**
     * 两个任务在插入到延迟队列时的比较方式
     * @param o
     * @return
     */
    @Override
    public int compareTo(Delayed o) {
        return (int) (this.time - ((Task)o).getTime());
    }
}
```

在使用时，查看到DelayQueue底层用了PriorityQueue，在一定程度上，DelayQueue也是无界队列。

测试效果

```java
public static void main(String[] args) throws InterruptedException {
    // 声明元素
    Task task1 = new Task("A",1000L);
    Task task2 = new Task("B",5000L);
    Task task3 = new Task("C",3000L);
    Task task4 = new Task("D",2000L);
    // 声明阻塞队列
    DelayQueue<Task> queue = new DelayQueue<>();
    // 将元素添加到延迟队列中
    queue.put(task1);
    queue.put(task2);
    queue.put(task3);
    queue.put(task4);
    // 获取元素
    System.out.println(queue.take());
    System.out.println(queue.take());
    System.out.println(queue.take());
    System.out.println(queue.take());
    // A,D,C,B
}
```

在应用时，外卖，15分钟商家需要节点，如果不节点，这个订单自动取消。

可以每下一个订单，就放到延迟队列中，如果规定时间内，商家没有节点，直接通过消费者获取元素，然后取消订单。

只要是有需要延迟一定时间后，再执行的任务，就可以通过延迟队列去实现。

#### 5.2、DelayQueue核心属性

可以查看到DelayQueue就四个核心属性

```java
// 因为DelayQueue依然属于阻塞队列，需要保证线程安全。看到只有一把锁，生产者和消费者使用的是一个lock
private final transient ReentrantLock lock = new ReentrantLock();
// 因为DelayQueue还是基于二叉堆结构实现的，没有必要重新搞一个二叉堆，直接使用的PriorityQueue
private final PriorityQueue<E> q = new PriorityQueue<E>();
// leader一般会存储等待栈顶数据的消费者，在整体写入和消费的过程中，会设置的leader的一些判断。
private Thread leader = null;
// 生产者在插入数据时，不会阻塞的。当前的Condition就是给消费者用的
// 比如消费者在获取数据时，发现栈顶的数据还又没到延迟时间。
// 这个时候，咱们就需要将消费者线程挂起，阻塞一会，阻塞到元素到了延迟时间，或者是，生产者插入的元素到了栈顶，此时生产者会唤醒消费者。
private final Condition available = lock.newCondition();
```

#### 5.3、DelayQueue写入流程分析

Delay是无界的，数组可以动态的扩容，不需要关注生产者的阻塞问题，他就没有阻塞问题。

这里只需要查看offer方法即可。

```java
public boolean offer(E e) {
    // 直接获取lock，加锁。
    final ReentrantLock lock = this.lock;
    lock.lock();
    try {
        // 直接调用PriorityQueue的插入方法，这里会根据之前重写Delayed接口中的compareTo方法做排序，然后调整上移和下移操作。
        q.offer(e);
        // 调用优先级队列的peek方法，拿到堆顶的数据
        // 拿到堆顶数据后，判断是否是刚刚插入的元素
        if (q.peek() == e) {
            // leader赋值为null。在消费者的位置再提一嘴
            leader = null;
            // 唤醒消费者，避免刚刚插入的数据的延迟时间出现问题。
            available.signal();
        }
        // 插入成功，
        return true;
    } finally {
        // 释放锁
        lock.unlock();
    }
}
```

#### 5.4、DelayQueue读取流程分析

消费者依然还是存在阻塞的情况，因为有两个情况

- 消费者要拿到栈顶数据，但是延迟时间还没到，此时消费者需要等待一会。
- 消费者要来拿数据，但是发现已经有消费者在等待栈顶数据了，这个后来的消费者也需要等待一会。

依然需要查看四个方法的实现

##### 5.4.1 remove方法

```java
// 依然是AbstractQueue提供的方法，有结果就返回，没结果扔异常
public E remove() {
    E x = poll();
    if (x != null)
        return x;
    else
        throw new NoSuchElementException();
}
```

##### 5.4.2 poll方法

```java
// poll是浅尝一下，不会阻塞消费者，能拿就拿，拿不到就拉倒
public E poll() {
    // 消费者和生产者是一把锁，先拿锁，加锁。
    final ReentrantLock lock = this.lock;
    lock.lock();
    try {
       	 // 拿到栈顶数据。
        E first = q.peek();
        // 如果元素为null，直接返回null
        // 如果getDelay方法返回的结果是大于0的，那说明当前元素还每到延迟时间，元素无法返回，返回null
        if (first == null || first.getDelay(NANOSECONDS) > 0)
            return null;
        else
            // 到这说明元素不为null，并且已经达到了延迟时间，直接调用优先级队列的poll方法
            return q.poll();
    } finally {
        // 释放锁。
        lock.unlock();
    }
}
```

##### 5.4.3 poll(time,unit)方法

这个是允许阻塞的，并且指定一定的时间

```java
public E poll(long timeout, TimeUnit unit) throws InterruptedException {
    // 先将时间转为纳秒
    long nanos = unit.toNanos(timeout);
    // 拿锁，加锁。
    final ReentrantLock lock = this.lock;
    lock.lockInterruptibly();
    try {
        // 死循环。
        for (;;) {
            // 拿到堆顶数据
            E first = q.peek();
            // 如果元素为null
            if (first == null) {
                // 并且等待的时间小于等于0。不能等了，直接返回null
                if (nanos <= 0)
                    return null;
                // 说明当前线程还有可以阻塞的时间，阻塞指定时间即可。
                else
                    // 这里挂起线程后，说明队列没有元素，在生产者添加数据之后，会唤醒
                    nanos = available.awaitNanos(nanos);
            // 到这说明，有数据
            } else {
                // 有数据的话，先获取数据现在是否可以执行，延迟时间是否已经到了指定时间
                long delay = first.getDelay(NANOSECONDS);
                // 延迟时间是否已经到了，
                if (delay <= 0)
                    // 时间到了，直接执行优先级队列的poll方法，返回元素
                    return q.poll();
                // ==================延迟时间没到，消费者需要等一会===================
                // 这个是查看消费者可以等待的时间，
                if (nanos <= 0)
                    // 直接返回nulll
                    return null;
                // ==================延迟时间没到，消费者可以等一会===================
                // 把first赋值为null
                first = null; 
                // 如果等待的时间，小于元素剩余的延迟时间，消费者直接挂起。反正暂时拿不到，但是不能保证后续是否有生产者添加一个新的数据，我是可以拿到的。
                // 如果已经有一个消费者在等待堆顶数据了，我这边不做额外操作，直接挂起即可。
                if (nanos < delay || leader != null)
                    nanos = available.awaitNanos(nanos);
                // 当前消费者的阻塞时间可以拿到数据，并且没有其他消费者在等待堆顶数据
                else {
                    // 拿到当前消费者的线程对象
                    Thread thisThread = Thread.currentThread();
                    // 将leader设置为当前线程
                    leader = thisThread;
                    try {
                        // 会让当前消费者，阻塞这个元素的延迟时间
                        long timeLeft = available.awaitNanos(delay);
                        // 重新计算当前消费者剩余的可阻塞时间，。
                        nanos -= delay - timeLeft;
                    } finally {
                        // 到了时间，将leader设置为null
                        if (leader == thisThread)
                            leader = null;
                    }
                }
            }
        }
    } finally {
        // 没有消费者在等待元素，队列中的元素不为null
        if (leader == null && q.peek() != null)
            // 只要当前没有leader在等，并且队列有元素，就需要再次唤醒消费者。、
            // 避免队列有元素，但是没有消费者处理的问题
            available.signal();
        // 释放锁
        lock.unlock();
    }
}
```

##### 5.4.4 take方法

这个是允许阻塞的，但是可以一直等，要么等到元素，要么等到被中断。

```java
public E take() throws InterruptedException {
    // 正常加锁，并且允许中断
    final ReentrantLock lock = this.lock;
    lock.lockInterruptibly();
    try {
        for (;;) {
            // 拿到元素
            E first = q.peek();
            if (first == null)
                // 没有元素挂起。
                available.await();
            else {
                // 有元素，获取延迟时间。
                long delay = first.getDelay(NANOSECONDS);
                // 判断延迟时间是不是已经到了
                if (delay <= 0)
                    // 基于优先级队列的poll方法返回
                    return q.poll();
                first = null; 
                // 如果有消费者在等，就正常await挂起
                if (leader != null)
                    available.await();
                // 如果没有消费者在等的堆顶数据，我来等
                else {
                    // 获取当前线程
                    Thread thisThread = Thread.currentThread();
                    // 设置为leader，代表等待堆顶的数据
                    leader = thisThread;
                    try {
                        // 等待指定（堆顶元素的延迟时间）时长，
                        available.awaitNanos(delay);
                    } finally {
                        if (leader == thisThread)
                            // leader赋值null
                            leader = null;
                    }
                }
            }
        }
    } finally {
        // 避免消费者无线等，来一个唤醒消费者的方法，一般是其他消费者拿到元素走了之后，并且延迟队列还有元素，就执行if内部唤醒方法
        if (leader == null && q.peek() != null)
            available.signal();
        // 释放锁
        lock.unlock();
    }
}
```

### 六、**SynchronousQueue**

#### 6.1 SynchronousQueue介绍

SynchronousQueue这个阻塞队列和其他的阻塞队列有很大的区别

在咱们的概念中，队列肯定是要存储数据的，但是SynchronousQueue不会存储数据的

SynchronousQueue队列中，他不存储数据，存储生产者或者是消费者

当存储一个生产者到SynchronousQueue队列中之后，生产者会阻塞（看你调用的方法）

生产者最终会有几种结果：

- 如果在阻塞期间有消费者来匹配，生产者就会将绑定的消息交给消费者
- 生产者得等阻塞结果，或者不允许阻塞，那么就直接失败
- 生产者在阻塞期间，如果线程中断，直接告辞。

同理，消费者和生产者的效果是一样。

生产者和消费者的数据是直接传递的，不会经过SynchronousQueue。

SynchronousQueue是不会存储数据的。

经过阻塞队列的学习：

生产者：

- offer()：生产者在放到SynchronousQueue的同时，如果有消费者在等待消息，直接配对。如果没有消费者在等待消息，这里直接返回，告辞。
- offer(time,unit)：生产者在放到SynchronousQueue的同时，如果有消费者在等待消息，直接配对。如果没有消费者在等待消息，阻塞time时间，如果还没有，告辞。
- put()：生产者在放到SynchronousQueue的同时，如果有消费者在等待消息，直接配对。如果没有，死等。

消费者：poll()，poll(time,unit)，take()。道理和上面的生产者一致。

测试效果：

```java
public static void main(String[] args) throws InterruptedException {
    // 因为当前队列不存在数据，没有长度的概念。
    SynchronousQueue queue = new SynchronousQueue();

    String msg = "消息！";
    /*new Thread(() -> {
        // b = false：代表没有消费者来拿
        boolean b = false;
        try {
            b = queue.offer(msg,1, TimeUnit.SECONDS);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println(b);
    }).start();

    Thread.sleep(100);

    new Thread(() -> {
        System.out.println(queue.poll());
    }).start();*/
    new Thread(() -> {
        try {
            System.out.println(queue.poll(1, TimeUnit.SECONDS));
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }).start();

    Thread.sleep(100);

    new Thread(() -> {
        queue.offer(msg);
    }).start();
}
```

#### 6.2 SynchronousQueue核心属性

进到SynchronousQueue类的内部后，发现了一个内部类，Transferer，内部提供了一个transfer的方法

```java
abstract static class Transferer<E> {
    abstract E transfer(E e, boolean timed, long nanos);
}
```

当前这个类中提供的transfer方法，就是生产者和消费者在调用读写数据时要用到的核心方法。

生产者在调用上述的transfer方法时，第一个参数e会正常传递数据

消费者在调用上述的transfer方法时，第一个参数e会传递null

SynchronousQueue针对抽象类Transferer做了几种实现。

一共看到了两种实现方式：

- TransferStack
- TransferQueue

这两种类继承了Transferer抽象类，在构建SynchronousQueue时，会指定使用哪种子类

```java
// 到底采用哪种实现，需要把对应的对象存放到这个属性中
private transient volatile Transferer<E> transferer;
// 采用无参时，会调用下述方法，再次调用有参构造传入false
public SynchronousQueue() {
    this(false);
}
// 调用的是当前的有参构造，fair代表公平还是不公平
public SynchronousQueue(boolean fair) {
    // 如果是公平，采用Queue，如果是不公平，采用Stack
    transferer = fair ? new TransferQueue<E>() : new TransferStack<E>();
}
```

TransferQueue的特点

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1654095150060/8c0df115166f4202b14a89a11b849c00.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1654095150060/c6fe53bff00f468f90440012c507ef2e.png)

代码查看效果

```java
public static void main(String[] args) throws InterruptedException {
    // 因为当前队列不存在数据，没有长度的概念。
    SynchronousQueue queue = new SynchronousQueue(true);
    SynchronousQueue queue = new SynchronousQueue(false);

    new Thread(() -> {
        try {
            queue.put("生1");
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }).start();
    new Thread(() -> {
        try {
            queue.put("生2");
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }).start();
    new Thread(() -> {
        try {
            queue.put("生3");
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }).start();

    Thread.sleep(100);
    new Thread(() -> {
        System.out.println("消1：" + queue.poll());
    }).start();
    Thread.sleep(100);
    new Thread(() -> {
        System.out.println("消2：" + queue.poll());
    }).start();
    Thread.sleep(100);
    new Thread(() -> {
        System.out.println("消3：" + queue.poll());
    }).start();
}
```

#### 6.3 SynchronousQueue的TransferQueue源码

为了查看清除SynchronousQueue的TransferQueue源码，需要从两点开始查看源码信息

##### 6.3.1 QNode源码信息

```java
static final class QNode {
    // 当前节点可以获取到next节点
    volatile QNode next;  
    // item在不同情况下效果不同
    // 生产者：有数据
    // 消费者：为null
    volatile Object item;   
    // 当前线程
    volatile Thread waiter;   
    // 当前属性是永磊区分消费者和生产者的属性
    final boolean isData;
    // 最终生产者需要将item交给消费者
    // 最终消费者需要获取生产者的item
  
    // 省略了大量提供的CAS操作
    ....
}
```

##### 6.3.2 transfer方法实现

```java
// 当前方法是TransferQueue的核心内容
// e：传递的数据
// timed：false，代表无限阻塞，true，代表阻塞nacos时间
E transfer(E e, boolean timed, long nanos) {
    // 当前QNode是要封装当前生产者或者消费者的信息
    QNode s = null; 
    // isData == true：代表是生产者
    // isData == false：代表是消费者
    boolean isData = (e != null);
    // 死循环
    for (;;) {
        // 获取尾节点和头结点
        QNode t = tail;
        QNode h = head;
        // 为了避免TransferQueue还没有初始化，这边做一个健壮性判断
        if (t == null || h == null)   
            continue;  

        // 如果满足h == t 条件，说明当前队列没有生产者或者消费者，为空
        // 如果有节点，同时当前节点和队列节点属于同一种角色。
        // if中的逻辑是进到队列
        if (h == t || t.isData == isData) { 
            // ===================在判断并发问题==========================
            // 拿到尾节点的next
            QNode tn = t.next;
            // 如果t不为尾节点，进来说明有其他线程并发修改了tail
            if (t != tail)   
                // 重新走for循环   
                continue;
            // tn如果为不null，说明前面有线程并发，添加了一个节点
            if (tn != null) {  
                // 直接帮助那个并发线程修改tail的指向   
                advanceTail(t, tn);
                // 重新走for循环   
                continue;
            }
            // 获取当前线程是否可以阻塞
            // 如果timed为true，并且阻塞的时间小于等于0
            // 不需要匹配，直接告辞！！！
            if (timed && nanos <= 0)   
                return null;
            // 如果可以阻塞，将当前需要插入到队列的QNode构建出来
            if (s == null)
                s = new QNode(e, isData);
            // 基于CAS操作，将tail节点的next设置为当前线程
            if (!t.casNext(null, s))   
                // 如果进到if，说明修改失败，重新执行for循环修改   
                continue;
            // CAS操作成功，直接替换tail的指向
            advanceTail(t, s);   
            // 如果进到队列中了，挂起线程，要么等生产者，要么等消费者。
            // x是返回替换后的数据
            Object x = awaitFulfill(s, e, timed, nanos);
            // 如果元素和节点相等，说明节点取消了
            if (x == s) {  
                // 清空当前节点，将上一个节点的next指向当前节点的next，直接告辞   
                clean(t, s);
                return null;
            }
            // 判断当前节点是否还在队列中
            if (!s.isOffList()) {   
                // 将当前节点设置为head
                advanceHead(t, s);   
                // 如果 x != null， 如果拿到了数据，说明我是消费者
                if (x != null)   
                    // 将当前节点的item设置为自己   
                    s.item = s;
                // 线程置位null
                s.waiter = null;
            }
            // 返回数据
            return (x != null) ? (E)x : e;
        } 
        // 匹配队列中的橘色
        else {   
            // 拿到head的next，作为要匹配的节点   
            QNode m = h.next;  
            // 做并发判断，如果头节点，尾节点，或者head.next发生了变化，这边要重新走for循环
            if (t != tail || m == null || h != head)
                continue;  
            // 没并发问题，可以拿数据
            // 拿到m节点的item作为x。
            Object x = m.item;
            // 如果isData == (x != null)满足，说明当前出现了并发问题，避免并发消费出现坑
            if (isData == (x != null) ||  
                // 如果排队的节点取消，就会讲当前QNode中的item指向QNode
                x == m ||   
                // 如果前面两个都没满足，可以交换数据了。 
                // 如果交换失败，说明有并发问题，
                !m.casItem(x, e)) {   
                // 重新设置head节点，并且再走一次循环  
                advanceHead(h, m);  
                continue;
            }
            // 替换head
            advanceHead(h, m);  
            // 唤醒head.next中的线程
            LockSupport.unpark(m.waiter);
            // 这边匹配好了，数据也交换了，直接返回
            // 如果 x != null，说明队列中是生产者，当前是消费者，这边直接返回x具体数据
            // 反之，队列中是消费者，当前是生产者，直接返回自己的数据
            return (x != null) ? (E)x : e;
        }
    }
}
```

##### 6.3.3 tansfer方法流程图

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1654095150060/70d2778577b94910a15baad2778f0a9d.png)





## 线程池

### **一、什么是线程池**

为什么要使用线程池

在开发中，为了提升效率的操作，我们需要将一些业务采用多线程的方式去执行。

比如有一个比较大的任务，可以将任务分成几块，分别交给几个线程去执行，最终做一个汇总就可以了。

比如做业务操作时，需要发送短信或者是发送邮件，这种操作也可以基于异步的方式完成，这种异步的方式，其实就是再构建一个线程去执行。

但是，如果每次异步操作或者多线程操作都需要新创建一个线程，使用完毕后，线程再被销毁，这样的话，对系统造成一些额外的开销。在处理过程中到底由多线程处理了多少个任务，以及每个线程的开销无法统计和管理。

所以咱们需要一个线程池机制来管理这些内容。线程池的概念和连接池类似，都是在一个Java的集合中存储大量的线程对象，每次需要执行异步操作或者多线程操作时，不需要重新创建线程，直接从集合中拿到线程对象直接执行方法就可以了。

JDK中就提供了线程池的类。

在线程池构建初期，可以将任务提交到线程池中。会根据一定的机制来异步执行这个任务。

* 可能任务直接被执行
* 任务可以暂时被存储起来了。等到有空闲线程再来处理。
* 任务也可能被拒绝，无法被执行。

JDK提供的线程池中记录了每个线程处理了多少个任务，以及整个线程池处理了多少个任务。同时还可以针对任务执行前后做一些勾子函数的实现。可以在任务执行前后做一些日志信息，这样可以多记录信息方便后面统计线程池执行任务时的一些内容参数等等……

### 二、**JDK自带的构建线程池的方式**

JDK中基于Executors提供了很多种线程池

#### 2.1 newFixedThreadPool

这个线程池的特别是线程数是固定的。

在Executors中第一个方法就是构建newFixedThreadPool

```java
public static ExecutorService newFixedThreadPool(int nThreads) {
    return new ThreadPoolExecutor(nThreads, nThreads,
            0L, TimeUnit.MILLISECONDS,
            new LinkedBlockingQueue<Runnable>());
}
```

构建时，需要给newFixedThreadPool方法提供一个nThreads的属性，而这个属性其实就是当前线程池中线程的个数。当前线程池的本质其实就是使用ThreadPoolExecutor。

构建好当前线程池后，线程个数已经固定好**（线程是懒加载，在构建之初，线程并没有构建出来，而是随着人任务的提交才会将线程在线程池中国构建出来）**。如果线程没构建，线程会待着任务执行被创建和执行。如果线程都已经构建好了，此时任务会被放到LinkedBlockingQueue无界队列中存放，等待线程从LinkedBlockingQueue中去take出任务，然后执行。

测试功能效果

```java
public static void main(String[] args) throws Exception {
    ExecutorService threadPool = Executors.newFixedThreadPool(3);
    threadPool.execute(() -> {
        System.out.println("1号任务：" + Thread.currentThread().getName() + System.currentTimeMillis());
        try {
            Thread.sleep(5000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    });
    threadPool.execute(() -> {
        System.out.println("2号任务：" + Thread.currentThread().getName() + System.currentTimeMillis());
        try {
            Thread.sleep(5000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    });
    threadPool.execute(() -> {
        System.out.println("3号任务：" + Thread.currentThread().getName() + System.currentTimeMillis());
        try {
            Thread.sleep(5000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    });
}
```

#### 2.2 newSingleThreadExecutor

这个线程池看名字就知道是单例线程池，线程池中只有一个工作线程在处理任务

如果业务涉及到顺序消费，可以采用newSingleThreadExecutor

```java
// 当前这里就是构建单例线程池的方式
public static ExecutorService newSingleThreadExecutor() {
    return new FinalizableDelegatedExecutorService
        // 在内部依然是构建了ThreadPoolExecutor，设置的线程个数为1
        // 当任务投递过来后，第一个任务会被工作线程处理，后续的任务会被扔到阻塞队列中
        // 投递到阻塞队列中任务的顺序，就是工作线程处理的顺序
        // 当前这种线程池可以用作顺序处理的一些业务中
        (new ThreadPoolExecutor(1, 1,
                                0L, TimeUnit.MILLISECONDS,
                                new LinkedBlockingQueue<Runnable>()));
}

static class FinalizableDelegatedExecutorService extends DelegatedExecutorService {
    // 线程池的使用没有区别，跟正常的ThreadPoolExecutor没区别
    FinalizableDelegatedExecutorService(ExecutorService executor) {
        super(executor);
    }
    // finalize是当前对象被GC干掉之前要执行的方法
    // 当前FinalizableDelegatedExecutorService的目的是为了在当前线程池被GC回收之前
    // 可以执行shutdown，shutdown方法是将当前线程池停止，并且干掉工作线程
    // 但是不能基于这种方式保证线程池一定会执行shutdown
    // finalize在执行时，是守护线程，这种线程无法保证一定可以执行完毕。
    // 在使用线程池时，如果线程池是基于一个业务构建的，在使用完毕之后，一定要手动执行shutdown，
    // 否则会造成JVM中一堆线程
    protected void finalize() {
        super.shutdown();
    }
}
```

测试单例线程池效果：

```java
public static void main(String[] args) throws Exception {
    ExecutorService threadPool = Executors.newSingleThreadExecutor();

    threadPool.execute(() -> {
        System.out.println(Thread.currentThread().getName() + "," + "111");
    });
    threadPool.execute(() -> {
        System.out.println(Thread.currentThread().getName() + "," + "222");
    });
    threadPool.execute(() -> {
        System.out.println(Thread.currentThread().getName() + "," + "333");
    });
    threadPool.execute(() -> {
        System.out.println(Thread.currentThread().getName() + "," + "444");
    });
}
```

测试线程池使用完毕后，不执行shutdown的后果：

如果是局部变量仅限当前线程池使用的线程池，在使用完毕之后要记得执行shutdown，避免线程无法结束

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1661937858024/e2c585e0a27945889b943c8954d84e54.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1661937858024/66fba14d8eba48008ba2f688d0a47507.png)

如果是全局的线程池，很多业务都会到，使用完毕后不要shutdown，因为其他业务也要执行当前线程池

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1661937858024/d94e335c71684a2cba4aa69cc104367f.png)

```java
static ExecutorService threadPool = Executors.newFixedThreadPool(200);

public static void main(String[] args) throws Exception {
    newThreadPool();
    System.gc();
    Thread.sleep(5000);
    System.out.println("线程池被回收了！！");
    System.in.read();
}

private static void newThreadPool(){
    for (int i = 0; i < 200; i++) {
        final int a = i;
        threadPool.execute(() -> {
            System.out.println(a);
        });
    }
    threadPool.shutdown();
    for (int i = 0; i < 200; i++) {
        final int a = i;
        threadPool.execute(() -> {
            System.out.println(a);
        });
    }
}
```

#### 2.3 newCachedThreadPool

看名字好像是一个缓存的线程池，查看一下构建的方式

```java
public static ExecutorService newCachedThreadPool() {
    return new ThreadPoolExecutor(0, Integer.MAX_VALUE,
                                  60L, TimeUnit.SECONDS,
                                  new SynchronousQueue<Runnable>());
}
```

当第一次提交任务到线程池时，会直接构建一个工作线程

这个工作线程带执行完人后，60秒没有任务可以执行后，会结束

如果在等待60秒期间有任务进来，他会再次拿到这个任务去执行

如果后续提升任务时，没有线程是空闲的，那么就构建工作线程去执行。

最大的一个特点，**任务只要提交到当前的newCachedThreadPool中，就必然有工作线程可以处理**

代码测试效果

```java
public static void main(String[] args) throws Exception {
    ExecutorService executorService = Executors.newCachedThreadPool();
    for (int i = 1; i <= 200; i++) {
        final int j = i;
        executorService.execute(() -> {
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            System.out.println(Thread.currentThread().getName() + ":" + j);
        });
    }
}
```

#### 2.4 newScheduleThreadPool

首先看到名字就可以猜到当前线程池是一个定时任务的线程池，而这个线程池就是可以以一定周期去执行一个任务，或者是延迟多久执行一个任务一次

查看一下如何构建的。

```java
public static ScheduledExecutorService newScheduledThreadPool(int corePoolSize) {
    return new ScheduledThreadPoolExecutor(corePoolSize);
}
```

基于这个方法可以看到，构建的是ScheduledThreadPoolExecutor线程池

```java
public class ScheduledThreadPoolExecutor extends ThreadPoolExecutor{
	//....
}
```

所以本质上还是正常线程池，只不过在原来的线程池基础上实现了定时任务的功能

原理是基于DelayQueue实现的延迟执行。周期性执行是任务执行完毕后，再次扔回到阻塞队列。

代码查看使用的方式和效果

```java
public static void main(String[] args) throws Exception {
    ScheduledExecutorService pool = Executors.newScheduledThreadPool(10);

    // 正常执行
//        pool.execute(() -> {
//            System.out.println(Thread.currentThread().getName() + "：1");
//        });

    // 延迟执行，执行当前任务延迟5s后再执行
//        pool.schedule(() -> {
//            System.out.println(Thread.currentThread().getName() + "：2");
//        },5,TimeUnit.SECONDS);

    // 周期执行，当前任务第一次延迟5s执行，然后没3s执行一次
    // 这个方法在计算下次执行时间时，是从任务刚刚开始时就计算。
//        pool.scheduleAtFixedRate(() -> {
//            try {
//                Thread.sleep(3000);
//            } catch (InterruptedException e) {
//                e.printStackTrace();
//            }
//            System.out.println(System.currentTimeMillis() + "：3");
//        },2,1,TimeUnit.SECONDS);

    // 周期执行，当前任务第一次延迟5s执行，然后没3s执行一次
    // 这个方法在计算下次执行时间时，会等待任务结束后，再计算时间
    pool.scheduleWithFixedDelay(() -> {
        try {
            Thread.sleep(3000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println(System.currentTimeMillis() + "：3");
    },2,1,TimeUnit.SECONDS);
}
```

至于Executors提供的newSingleThreadScheduledExecutor单例的定时任务线程池就不说了。

一个线程的线程池可以延迟或者以一定的周期执行一个任务。

#### 2.5 newWorkStealingPool

当前JDK提供构建线程池的方式newWorkStealingPool和之前的线程池很非常大的区别

之前定长，单例，缓存，定时任务都基于ThreadPoolExecutor去实现的。

newWorkStealingPool是基于ForkJoinPool构建出来的

**ThreadPoolExecutor的核心点**：

在ThreadPoolExecutor中只有一个阻塞队列存放当前任务

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1661937858024/90707080cdaa42da91564df1b5aef45a.png)
ForkJoinPool的核心特点：

ForkJoinPool从名字上就能看出一些东西。当有一个特别大的任务时，如果采用上述方式，这个大任务只能会某一个线程去执行。ForkJoin第一个特点是可以将一个大任务拆分成多个小任务，放到当前线程的阻塞队列中。其他的空闲线程就可以去处理有任务的线程的阻塞队列中的任务

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1661937858024/b8dea88b3afd427583c789a9c76fa7fa.png)

来一个比较大的数组，里面存满值，计算总和

单线程处理一个任务：

```java
/** 非常大的数组 */
static int[] nums = new int[1_000_000_000];
// 填充值
static{
    for (int i = 0; i < nums.length; i++) {
        nums[i] = (int) ((Math.random()) * 1000);
    }
}
public static void main(String[] args) {
    // ===================单线程累加10亿数据================================
    System.out.println("单线程计算数组总和！");
    long start = System.nanoTime();
    int sum = 0;
    for (int num : nums) {
        sum += num;
    }
    long end = System.nanoTime();
    System.out.println("单线程运算结果为：" + sum + "，计算时间为：" + (end  - start));
}
```

多线程分而治之的方式处理：

```java
/** 非常大的数组 */
static int[] nums = new int[1_000_000_000];
// 填充值
static{
    for (int i = 0; i < nums.length; i++) {
        nums[i] = (int) ((Math.random()) * 1000);
    }
}
public static void main(String[] args) {
    // ===================单线程累加10亿数据================================
    System.out.println("单线程计算数组总和！");
    long start = System.nanoTime();
    int sum = 0;
    for (int num : nums) {
        sum += num;
    }
    long end = System.nanoTime();
    System.out.println("单线程运算结果为：" + sum + "，计算时间为：" + (end  - start));

    // ===================多线程分而治之累加10亿数据================================
    // 在使用forkJoinPool时，不推荐使用Runnable和Callable
    // 可以使用提供的另外两种任务的描述方式
    // Runnable(没有返回结果) ->   RecursiveAction
    // Callable(有返回结果)   ->   RecursiveTask
    ForkJoinPool forkJoinPool = (ForkJoinPool) Executors.newWorkStealingPool();
    System.out.println("分而治之计算数组总和！");
    long forkJoinStart = System.nanoTime();
    ForkJoinTask<Integer> task = forkJoinPool.submit(new SumRecursiveTask(0, nums.length - 1));
    Integer result = task.join();
    long forkJoinEnd = System.nanoTime();
    System.out.println("分而治之运算结果为：" + result + "，计算时间为：" + (forkJoinEnd  - forkJoinStart));
}

private static class SumRecursiveTask extends RecursiveTask<Integer>{
    /** 指定一个线程处理哪个位置的数据 */
    private int start,end;
    private final int MAX_STRIDE = 100_000_000;
    //  200_000_000： 147964900
    //  100_000_000： 145942100

    public SumRecursiveTask(int start, int end) {
        this.start = start;
        this.end = end;
    }

    @Override
    protected Integer compute() {
        // 在这个方法中，需要设置好任务拆分的逻辑以及聚合的逻辑
        int sum = 0;
        int stride = end - start;
        if(stride <= MAX_STRIDE){
            // 可以处理任务
            for (int i = start; i <= end; i++) {
                sum += nums[i];
            }
        }else{
            // 将任务拆分，分而治之。
            int middle = (start + end) / 2;
            // 声明为2个任务
            SumRecursiveTask left = new SumRecursiveTask(start, middle);
            SumRecursiveTask right = new SumRecursiveTask(middle + 1, end);
            // 分别执行两个任务
            left.fork();
            right.fork();
            // 等待结果，并且获取sum
            sum = left.join() + right.join();
        }
        return sum;
    }
}
```

最终可以发现，这种累加的操作中，采用分而治之的方式效率提升了2倍多。

但是也不是所有任务都能拆分提升效率，首先任务得大，耗时要长。

### 三、**ThreadPoolExecutor应用&源码剖析**

前面讲到的Executors中的构建线程池的方式，大多数还是基于ThreadPoolExecutor去new出来的。

#### 3.1 为什么要自定义线程池

首先ThreadPoolExecutor中，一共提供了7个参数，每个参数都是非常核心的属性，在线程池去执行任务时，每个参数都有决定性的作用。

但是如果直接采用JDK提供的方式去构建，可以设置的核心参数最多就两个，这样就会导致对线程池的控制粒度很粗。所以在阿里规范中也推荐自己去自定义线程池。手动的去new ThreadPoolExecutor设置他的一些核心属性。

自定义构建线程池，可以细粒度的控制线程池，去管理内存的属性，并且针对一些参数的设置可能更好的在后期排查问题。

查看一下ThreadPoolExecutor提供的七个核心参数

```java
public ThreadPoolExecutor(
    int corePoolSize,           // 核心工作线程（当前任务执行结束后，不会被销毁）
    int maximumPoolSize,        // 最大工作线程（代表当前线程池中，一共可以有多少个工作线程）
    long keepAliveTime,         // 非核心工作线程在阻塞队列位置等待的时间
    TimeUnit unit,              // 非核心工作线程在阻塞队列位置等待时间的单位
    BlockingQueue<Runnable> workQueue,   // 任务在没有核心工作线程处理时，任务先扔到阻塞队列中
    ThreadFactory threadFactory,         // 构建线程的线程工作，可以设置thread的一些信息
    RejectedExecutionHandler handler) {  // 当线程池无法处理投递过来的任务时，执行当前的拒绝策略
    // 初始化线程池的操作
}
```

#### 3.2 ThreadPoolExecutor应用

手动new一下，处理的方式还是执行execute或者submit方法。

JDK提供的几种拒绝策略：

* AbortPolicy：当前拒绝策略会在无法处理任务时，直接抛出一个异常

  ```
  public void rejectedExecution(Runnable r, ThreadPoolExecutor e) {
      throw new RejectedExecutionException("Task " + r.toString() +
                                           " rejected from " +
                                           e.toString());
  }
  ```

* CallerRunsPolicy：当前拒绝策略会在线程池无法处理任务时，将任务交给调用者处理

  ```
  public void rejectedExecution(Runnable r, ThreadPoolExecutor e) {
      if (!e.isShutdown()) {
          r.run();
      }
  }
  ```

* DiscardPolicy：当前拒绝策略会在线程池无法处理任务时，直接将任务丢弃掉

  ```
  public void rejectedExecution(Runnable r, ThreadPoolExecutor e) {
  }
  ```

* DiscardOldestPolicy：当前拒绝策略会在线程池无法处理任务时，将队列中最早的任务丢弃掉，将当前任务再次尝试交给线程池处理

  ```
  public void rejectedExecution(Runnable r, ThreadPoolExecutor e) {
      if (!e.isShutdown()) {
          e.getQueue().poll();
          e.execute(r);
      }
  }
  ```

* 自定义Policy：根据自己的业务，可以将任务扔到数据库，也可以做其他操作。

  ```
  private static class MyRejectedExecution implements RejectedExecutionHandler{
      @Override
      public void rejectedExecution(Runnable r, ThreadPoolExecutor executor) {
          System.out.println("根据自己的业务情况，决定编写的代码！");
      }
  }
  ```

代码构建线程池，并处理有无返回结果的任务

```java
public static void main(String[] args) throws ExecutionException, InterruptedException {
    //1. 构建线程池
    ThreadPoolExecutor threadPool = new ThreadPoolExecutor(
            2,
            5,
            10,
            TimeUnit.SECONDS,
            new ArrayBlockingQueue<>(5),
            new ThreadFactory() {
                @Override
                public Thread newThread(Runnable r) {
                    Thread thread = new Thread(r);
                    thread.setName("test-ThreadPoolExecutor");
                    return thread;
                }
            },
            new MyRejectedExecution()
    );

    //2. 让线程池处理任务,没返回结果
    threadPool.execute(() -> {
        System.out.println("没有返回结果的任务");
    });

    //3. 让线程池处理有返回结果的任务
    Future<Object> future = threadPool.submit(new Callable<Object>() {
        @Override
        public Object call() throws Exception {
            System.out.println("我有返回结果！");
            return "返回结果";
        }
    });
    Object result = future.get();
    System.out.println(result);

    //4. 如果是局部变量的线程池，记得用完要shutdown
    threadPool.shutdown();
}



private static class MyRejectedExecution implements RejectedExecutionHandler{
    @Override
    public void rejectedExecution(Runnable r, ThreadPoolExecutor executor) {
        System.out.println("根据自己的业务情况，决定编写的代码！");
    }
}
```

#### 3.3 ThreadPoolExecutor源码剖析

线程池的源码内容会比较多一点，需要一点一点的去查看，内部比较多。

##### 3.3.1 ThreadPoolExecutor的核心属性

核心属性主要就是ctl，基于ctl拿到线程池的状态以及工作线程个数

在整个线程池的执行流程中，会基于ctl判断上述两个内容

```java
// 当前是线程池的核心属性
// 当前的ctl其实就是一个int类型的数值，内部是基于AtomicInteger套了一层，进行运算时，是原子性的。
// ctl表示着线程池中的2个核心状态：
// 线程池的状态：ctl的高3位，表示线程池状态
// 工作线程的数量：ctl的低29位，表示工作线程的个数
private final AtomicInteger ctl = new AtomicInteger(ctlOf(RUNNING, 0));

// Integer.SIZE：在获取Integer的bit位个数
// 声明了一个常量：COUNT_BITS = 29
private static final int COUNT_BITS = Integer.SIZE - 3;
00000000 00000000 00000000 00000001
00100000 00000000 00000000 00000000
00011111 11111111 11111111 11111111
// CAPACITY就是当前工作线程能记录的工作线程的最大个数
private static final int CAPACITY   = (1 << COUNT_BITS) - 1;


// 线程池状态的表示
// 当前五个状态中，只有RUNNING状态代表线程池没问题，可以正常接收任务处理
// 111：代表RUNNING状态，RUNNING可以处理任务，并且处理阻塞队列中的任务。
private static final int RUNNING    = -1 << COUNT_BITS;
// 000：代表SHUTDOWN状态，不会接收新任务，正在处理的任务正常进行，阻塞队列的任务也会做完。
private static final int SHUTDOWN   =  0 << COUNT_BITS;
// 001：代表STOP状态，不会接收新任务，正在处理任务的线程会被中断，阻塞队列的任务一个不管。
private static final int STOP       =  1 << COUNT_BITS;
// 010：代表TIDYING状态，这个状态是否SHUTDOWN或者STOP转换过来的，代表当前线程池马上关闭，就是过渡状态。
private static final int TIDYING    =  2 << COUNT_BITS;
// 011：代表TERMINATED状态，这个状态是TIDYING状态转换过来的，转换过来只需要执行一个terminated方法。
private static final int TERMINATED =  3 << COUNT_BITS;

// 在使用下面这几个方法时，需要传递ctl进来

// 基于&运算的特点，保证只会拿到ctl高三位的值。
private static int runStateOf(int c)     { return c & ~CAPACITY; }
// 基于&运算的特点，保证只会拿到ctl低29位的值。
private static int workerCountOf(int c)  { return c & CAPACITY; }
```

线程池状态的特点以及转换的方式

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1661937858024/9e8573ec5f5b4f1a9496e5795b773a44.png)

##### 3.3.2 ThreadPoolExecutor的有参构造

有参构造没啥说的，记住核心线程个数是允许为0的。

```java
// 有参构造。无论调用哪个有参构造，最终都会执行当前的有参构造
public ThreadPoolExecutor(int corePoolSize,
                          int maximumPoolSize,
                          long keepAliveTime,
                          TimeUnit unit,
                          BlockingQueue<Runnable> workQueue,
                          ThreadFactory threadFactory,
                          RejectedExecutionHandler handler) {
    // 健壮性校验
    // 核心线程个数是允许为0个的。
    // 最大线程数必须大于0，最大线程数要大于等于核心线程数
    // 非核心线程的最大空闲时间，可以等于0
    if (corePoolSize < 0 ||
        maximumPoolSize <= 0 ||
        maximumPoolSize < corePoolSize ||
        keepAliveTime < 0)
        // 不满足要求就抛出参数异常
        throw new IllegalArgumentException();
    // 阻塞队列，线程工厂，拒绝策略都不允许为null，为null就扔空指针异常
    if (workQueue == null || threadFactory == null || handler == null)
        throw new NullPointerException();
    // 不要关注当前内容，系统资源访问决策，和线程池核心业务关系不大。
    this.acc = System.getSecurityManager() == null ? null : AccessController.getContext();
    // 各种赋值，JUC包下，几乎所有涉及到线程挂起的操作，单位都用纳秒。
    // 有参构造的值，都赋值给成员变量。
    // Doug Lea的习惯就是将成员变量作为局部变量单独操作。
    this.corePoolSize = corePoolSize;
    this.maximumPoolSize = maximumPoolSize;
    this.workQueue = workQueue;
    this.keepAliveTime = unit.toNanos(keepAliveTime);
    this.threadFactory = threadFactory;
    this.handler = handler;
}
```

##### 3.3.3 ThreadPoolExecutor的execute方法

execute方法是提交任务到线程池的核心方法，很重要

线程池的执行流程其实就是在说execute方法内部做了哪些判断

execute源码的分析

```java
// 提交任务到线程池的核心方法
// command就是提交过来的任务
public void execute(Runnable command) {
    // 提交的任务不能为null
    if (command == null)
        throw new NullPointerException();
    // 获取核心属性ctl，用于后面的判断
    int c = ctl.get();
    // 如果工作线程个数，小于核心线程数。
    // 满足要求，添加核心工作线程
    if (workerCountOf(c) < corePoolSize) {
        // addWorker(任务,是核心线程吗)
        // addWorker返回true：代表添加工作线程成功
        // addWorker返回false：代表添加工作线程失败
        // addWorker中会基于线程池状态，以及工作线程个数做判断，查看能否添加工作线程
        if (addWorker(command, true))
            // 工作线程构建出来了，任务也交给command去处理了。
            return;
        // 说明线程池状态或者是工作线程个数发生了变化，导致添加失败，重新获取一次ctl
        c = ctl.get();
    }
    // 添加核心工作线程失败，往这走
    // 判断线程池状态是否是RUNNING，如果是，正常基于阻塞队列的offer方法，将任务添加到阻塞队列
    if (isRunning(c) && workQueue.offer(command)) {
        // 如果任务添加到阻塞队列成功，走if内部
        // 如果任务在扔到阻塞队列之前，线程池状态突然改变了。
        // 重新获取ctl
        int recheck = ctl.get();
        // 如果线程池的状态不是RUNNING，将任务从阻塞队列移除，
        if (!isRunning(recheck) && remove(command))
            // 并且直接拒绝策略
            reject(command);
        // 在这，说明阻塞队列有我刚刚放进去的任务
        // 查看一下工作线程数是不是0个
        // 如果工作线程为0个，需要添加一个非核心工作线程去处理阻塞队列中的任务
        // 发生这种情况有两种：
        // 1. 构建线程池时，核心线程数是0个。
        // 2. 即便有核心线程，可以设置核心线程也允许超时，设置allowCoreThreadTimeOut为true，代表核心线程也可以超时
        else if (workerCountOf(recheck) == 0)
            // 为了避免阻塞队列中的任务饥饿，添加一个非核心工作线程去处理
            addWorker(null, false);
    }
    // 任务添加到阻塞队列失败
    // 构建一个非核心工作线程
    // 如果添加非核心工作线程成功，直接完事，告辞
    else if (!addWorker(command, false))
        // 添加失败，执行决绝策略
        reject(command);
}
```

execute方法的完整执行流程图

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1661937858024/21bfed2ad43648b490292d59067142ea.png)

##### 3.3.4 ThreadPoolExecutor的addWorker方法

addWorker中主要分成两大块去看

* 第一块：校验线程池的状态以及工作线程个数
* 第二块：添加工作线程并且启动工作线程

校验线程池的状态以及工作线程个数

```java
// 添加工作线程之校验源码
private boolean addWorker(Runnable firstTask, boolean core) {
    // 外层for循环在校验线程池的状态
    // 内层for循环是在校验工作线程的个数

    // retry是给外层for循环添加一个标记，是为了方便在内层for循坏跳出外层for循环
    retry:
    for (;;) {
        // 获取ctl
        int c = ctl.get();
        // 拿到ctl的高3位的值
        int rs = runStateOf(c);
//==========================线程池状态判断==================================================
        // 如果线程池状态是SHUTDOWN，并且此时阻塞队列有任务，工作线程个数为0，添加一个工作线程去处理阻塞队列的任务

        // 判断线程池的状态是否大于等于SHUTDOWN，如果满足，说明线程池不是RUNNING
        if (rs >= SHUTDOWN &&
            // 如果这三个条件都满足，就代表是要添加非核心工作线程去处理阻塞队列任务
            // 如果三个条件有一个没满足，返回false，配合!，就代表不需要添加
            !(rs == SHUTDOWN && firstTask == null && ! workQueue.isEmpty()))
            // 不需要添加工作线程
            return false;

        for (;;) {
//==========================工作线程个数判断================================================== 
            // 基于ctl拿到低29位的值，代表当前工作线程个数   
            int wc = workerCountOf(c);
            // 如果工作线程个数大于最大值了，不可以添加了，返回false
            if (wc >= CAPACITY ||
                // 基于core来判断添加的是否是核心工作线程
                // 如果是核心：基于corePoolSize去判断
                // 如果是非核心：基于maximumPoolSize去判断
                wc >= (core ? corePoolSize : maximumPoolSize))
                // 代表不能添加，工作线程个数不满足要求
                return false;
            // 针对ctl进行 + 1，采用CAS的方式
            if (compareAndIncrementWorkerCount(c))
                // CAS成功后，直接退出外层循环，代表可以执行添加工作线程操作了。
                break retry;
            // 重新获取一次ctl的值
            c = ctl.get(); 
            // 判断重新获取到的ctl中，表示的线程池状态跟之前的是否有区别
            // 如果状态不一样，说明有变化，重新的去判断线程池状态
            if (runStateOf(c) != rs)
                // 跳出一次外层for循环
                continue retry;
        }
    }
    // 省略添加工作线程以及启动的过程
}
```

添加工作线程并且启动工作线程

```java
private boolean addWorker(Runnable firstTask, boolean core) {
    // 省略校验部分的代码

    // 添加工作线程以及启动工作线程~~~
    // 声明了三个变量
    // 工作线程启动了没，默认false
    boolean workerStarted = false;
    // 工作线程添加了没，默认false
    boolean workerAdded = false;
    // 工作线程，默认为null
    Worker w = null;

    try {
        // 构建工作线程，并且将任务传递进去
        w = new Worker(firstTask);
        // 获取了Worker中的Thread对象
        final Thread t = w.thread;
        // 判断Thread是否不为null，在new Worker时，内部会通过给予的ThreadFactory去构建Thread交给Worker
        // 一般如果为null，代表ThreadFactory有问题。
        if (t != null) {
            // 加锁，保证使用workers成员变量以及对largestPoolSize赋值时，保证线程安全
            final ReentrantLock mainLock = this.mainLock;
            mainLock.lock();
            try {
                // 再次获取线程池状态。
                int rs = runStateOf(ctl.get());
                // 再次判断
                // 如果满足  rs < SHUTDOWN  说明线程池是RUNNING，状态正常，执行if代码块
                // 如果线程池状态为SHUTDOWN，并且firstTask为null，添加非核心工作处理阻塞队列任务
                if (rs < SHUTDOWN ||
                    (rs == SHUTDOWN && firstTask == null)) {
                    // 到这，可以添加工作线程。
                    // 校验ThreadFactory构建线程后，不能自己启动线程，如果启动了，抛出异常
                    if (t.isAlive()) 
                        throw new IllegalThreadStateException();
                    // private final HashSet<Worker> workers = new HashSet<Worker>();
                    // 将new好的Worker添加到HashSet中。
                    workers.add(w);
                    // 获取了HashSet的size，拿到工作线程个数
                    int s = workers.size();
                    // largestPoolSize在记录最大线程个数的记录
                    // 如果当前工作线程个数，大于最大线程个数的记录，就赋值
                    if (s > largestPoolSize)
                        largestPoolSize = s;
                    // 添加工作线程成功
                    workerAdded = true;
                }
            } finally {
                mainLock.unlock();
            }
            // 如果工作线程添加成功，
            if (workerAdded) {
                // 直接启动Worker中的线程
                t.start();
                // 启动工作线程成功
                workerStarted = true;
            }
        }
    } finally {
        // 做补偿的操作，如果工作线程启动失败，将这个添加失败的工作线程处理掉
        if (!workerStarted)
            addWorkerFailed(w);
    }
    // 返回工作线程是否启动成功
    return workerStarted;
}
// 工作线程启动失败，需要不的步长操作
private void addWorkerFailed(Worker w) {
    // 因为操作了workers，需要加锁
    final ReentrantLock mainLock = this.mainLock;
    mainLock.lock();
    try {
        // 如果w不为null，之前Worker已经new出来了。
        if (w != null)
            // 从HashSet中移除
            workers.remove(w);
        // 同时对ctl进行 - 1，代表去掉了一个工作线程个数
        decrementWorkerCount();
        // 因为工作线程启动失败，判断一下状态的问题，是不是可以走TIDYING状态最终到TERMINATED状态了。
        tryTerminate();
    } finally {
        // 释放锁
        mainLock.unlock();
    }
}
```

##### 3.3.5 ThreadPoolExecutor的Worker工作线程

Worker对象主要包含了两个内容

* 工作线程要执行任务
* 工作线程可能会被中断，控制中断

```java
// Worker继承了AQS，目的就是为了控制工作线程的中断。
// Worker实现了Runnable，内部的Thread对象，在执行start时，必然要执行Worker中断额一些操作
private final class Worker extends AbstractQueuedSynchronizer implements Runnable{
  
// =======================Worker管理任务================================  
    // 线程工厂构建的线程
    final Thread thread;

    // 当前Worker要执行的任务
    Runnable firstTask;

    // 记录当前工作线程处理了多少个任务。
    volatile long completedTasks;

    // 有参构造
    Worker(Runnable firstTask) {
        // 将State设置为-1，代表当前不允许中断线程
        setState(-1); 
        // 任务赋值
        this.firstTask = firstTask;
        // 基于线程工作构建Thread，并且传入的Runnable是Worker
        this.thread = getThreadFactory().newThread(this);
    }

    // 当thread执行start方法时，调用的是Worker的run方法，
    public void run() {
        // 任务执行时，执行的是runWorker方法
        runWorker(this);
    }


// =======================Worker管理中断================================   
    // 当前方法是中断工作线程时，执行的方法
    void interruptIfStarted() {
        Thread t;
        // 只有Worker中的state >= 0的时候，可以中断工作线程
        if (getState() >= 0 && (t = thread) != null && !t.isInterrupted()) {
            try {
                // 如果状态正常，并且线程未中断，这边就中断线程
                t.interrupt();
            } catch (SecurityException ignore) {
            }
        }
    }
  
    protected boolean isHeldExclusively() {
        return getState() != 0;
    }
    protected boolean tryAcquire(int unused) {
        if (compareAndSetState(0, 1)) {
            setExclusiveOwnerThread(Thread.currentThread());
            return true;
        }
        return false;
    }
    protected boolean tryRelease(int unused) {
        setExclusiveOwnerThread(null);
        setState(0);
        return true;
    }
    public void lock()        { acquire(1); }
    public boolean tryLock()  { return tryAcquire(1); }
    public void unlock()      { release(1); }
    public boolean isLocked() { return isHeldExclusively(); }

  
}
```

##### 3.3.6 ThreadPoolExecutor的runWorker方法

runWorker就是让工作线程拿到任务去执行即可。

并且在内部也处理了在工作线程正常结束和异常结束时的处理方案

```java
// 工作线程启动后执行的任务。
final void runWorker(Worker w) {
    // 拿到当前线程
    Thread wt = Thread.currentThread();
    // 从worker对象中拿到任务
    Runnable task = w.firstTask;
    // 将Worker中的firstTask置位空
    w.firstTask = null;
    // 将Worker中的state置位0，代表当前线程可以中断的
    w.unlock(); // allow interrupts
    // 判断工作线程是否是异常结束，默认就是异常结束
    boolean completedAbruptly = true;
    try {
        // 获取任务
        // 直接拿到第一个任务去执行
        // 如果第一个任务为null，去阻塞队列中获取任务
        while (task != null || (task = getTask()) != null) {
            // 执行了Worker的lock方法，当前在lock时，shutdown操作不能中断当前线程，因为当前线程正在处理任务
            w.lock();
            // 比较ctl >= STOP,如果满足找个状态，说明线程池已经到了STOP状态甚至已经要凉凉了
            // 线程池到STOP状态，并且当前线程还没有中断，确保线程是中断的，进到if内部执行中断方法
            // if(runStateAtLeast(ctl.get(), STOP) && !wt.isInterrupted()) {中断线程}
            // 如果线程池状态不是STOP，确保线程不是中断的。
            // 如果发现线程中断标记位是true了，再次查看线程池状态是大于STOP了，再次中断线程
            // 这里其实就是做了一个事情，如果线程池状态 >= STOP，确保线程中断了。
            if (
                (
                    runStateAtLeast(ctl.get(), STOP) ||  
                    (     Thread.interrupted() && runStateAtLeast(ctl.get(), STOP)   )
                )
                && !wt.isInterrupted())
                wt.interrupt();
            try {
                // 勾子函数在线程池中没有做任何的实现，如果需要在线程池执行任务前后做一些额外的处理，可以重写勾子函数
                // 前置勾子函数
                beforeExecute(wt, task);
                Throwable thrown = null;
                try {
                    // 执行任务。
                    task.run();
                } catch (RuntimeException x) {
                    thrown = x; throw x;
                } catch (Error x) {
                    thrown = x; throw x;
                } catch (Throwable x) {
                    thrown = x; throw new Error(x);
                } finally {
                    // 前后置勾子函数
                    afterExecute(task, thrown);
                }
            } finally {
                // 任务执行完，丢掉任务
                task = null;
                // 当前工作线程处理的任务数+1
                w.completedTasks++;
                // 执行unlock方法，此时shutdown方法才可以中断当前线程
                w.unlock();
            }
        }
        // 如果while循环结束，正常走到这，说明是正常结束
        // 正常结束的话，在getTask中就会做一个额外的处理，将ctl - 1，代表工作线程没一个。
        completedAbruptly = false;
    } finally {
        // 考虑干掉工作线程
        processWorkerExit(w, completedAbruptly);
    }
}
// 工作线程结束前，要执行当前方法
private void processWorkerExit(Worker w, boolean completedAbruptly) {
    // 如果是异常结束
    if (completedAbruptly) 
        // 将ctl - 1，扣掉一个工作线程
        decrementWorkerCount();

    // 操作Worker，为了线程安全，加锁
    final ReentrantLock mainLock = this.mainLock;
    mainLock.lock();
    try {
        // 当前工作线程处理的任务个数累加到线程池处理任务的个数属性中
        completedTaskCount += w.completedTasks;
        // 将工作线程从hashSet中移除
        workers.remove(w);
    } finally {
        // 释放锁
        mainLock.unlock();
    }

    // 只要工作线程凉了，查看是不是线程池状态改变了。
    tryTerminate();

    // 获取ctl
    int c = ctl.get();
    // 判断线程池状态，当前线程池要么是RUNNING，要么是SHUTDOWN
    if (runStateLessThan(c, STOP)) {
        // 如果正常结束工作线程
        if (!completedAbruptly) {
            // 如果核心线程允许超时，min = 0，否则就是核心线程个数
            int min = allowCoreThreadTimeOut ? 0 : corePoolSize;
            // 如果min == 0，可能会出现没有工作线程，并且阻塞队列有任务没有线程处理
            if (min == 0 && ! workQueue.isEmpty())
                // 至少要有一个工作线程处理阻塞队列任务
                min = 1;
            // 如果工作线程个数 大于等于1，不怕没线程处理，正常return
            if (workerCountOf(c) >= min)
                return; 
        }
        // 异常结束，为了避免出现问题，添加一个空任务的非核心线程来填补上刚刚异常结束的工作线程
        addWorker(null, false);
    }
}
```

##### 3.3.7 ThreadPoolExecutor的getTask方法

工作线程在去阻塞队列获取任务前，要先查看线程池状态

如果状态没问题，去阻塞队列take或者是poll任务

第二个循环时，不但要判断线程池状态，还要判断当前工作线程是否可以被干掉

```java
// 当前方法就在阻塞队列中获取任务
// 前面半部分是判断当前工作线程是否可以返回null，结束。
// 后半部分就是从阻塞队列中拿任务
private Runnable getTask() {
    // timeOut默认值是false。
    boolean timedOut = false; 

    // 死循环
    for (;;) {
        // 拿到ctl
        int c = ctl.get();
        // 拿到线程池的状态
        int rs = runStateOf(c);

        // 如果线程池状态是STOP，没有必要处理阻塞队列任务，直接返回null
        // 如果线程池状态是SHUTDOWN，并且阻塞队列是空的，直接返回null
        if (rs >= SHUTDOWN && 
                (rs >= STOP || workQueue.isEmpty())) {
            // 如果可以返回null，先扣减工作线程个数
            decrementWorkerCount();
            // 返回null，结束runWorker的while循环
            return null;
        }

        // 基于ctl拿到工作线程个数
        int wc = workerCountOf(c);

        // 核心线程允许超时，timed为true
        // 工作线程个数大于核心线程数，timed为true
        boolean timed = allowCoreThreadTimeOut || wc > corePoolSize;

        if (
            // 如果工作线程个数，大于最大线程数。（一般情况不会满足），把他看成false
            // 第二个判断代表，只要工作线程数小于等于核心线程数，必然为false
            // 即便工作线程个数大于核心线程数了，此时第一次循环也不会为true，因为timedOut默认值是false
            // 考虑第二次循环了，因为循环内部必然有修改timeOut的位置
            (wc > maximumPoolSize || (timed && timedOut))
            && 
            // 要么工作线程还有，要么阻塞队列为空，并且满足上述条件后，工作线程才会走到if内部，结束工作线程
            (wc > 1 || workQueue.isEmpty())
           ) {
            // 第二次循环才有可能到这。
            // 正常结束，工作线程 - 1，因为是CAS操作，如果失败了，重新走for循环
            if (compareAndDecrementWorkerCount(c))
                return null;
            continue;
        }

        // 工作线程从阻塞队列拿任务
        try {
            // 如果是核心线程，timed是false，如果是非核心线程，timed就是true
            Runnable r = timed ?
                // 如果是非核心，走poll方法，拿任务，等待一会
                workQueue.poll(keepAliveTime, TimeUnit.NANOSECONDS) :
                // 如果是核心，走take方法，死等。
                workQueue.take();
            // 从阻塞队列拿到的任务不为null，这边就正常返回任务，去执行
            if (r != null)
                return r;
            // 说明当前线程没拿到任务，将timeOut设置为true，在上面就可以返回null退出了。
            timedOut = true;
        } catch (InterruptedException retry) {
            timedOut = false;
        }
    }
}
```

##### 3.3.8 ThreadPoolExecutor的关闭方法

首先查看shutdownNow方法，可以从RUNNING状态转变为STOP

```java
// shutDownNow方法，shutdownNow不会处理阻塞队列的任务，将任务全部给你返回了。
public List<Runnable> shutdownNow() {
    // 声明返回结果
    List<Runnable> tasks;
    // 加锁
    final ReentrantLock mainLock = this.mainLock;
    mainLock.lock();
    try {
        // 不关注这个方法……
        checkShutdownAccess();
        // 将线程池状态修改为STOP
        advanceRunState(STOP);
        // 无论怎么，直接中断工作线程。
        interruptWorkers();
        // 将阻塞队列的任务全部扔到List集合中。
        tasks = drainQueue();
    } finally {
        // 释放锁
        mainLock.unlock();
    }
    tryTerminate();
    return tasks;
}

// 将线程池状态修改为STOP
private void advanceRunState(int STOP) {
    // 死循环。
    for (;;) {
        // 获取ctl属性的值
        int c = ctl.get();
        // 第一个判断：如果当前线程池状态已经大于等于STOP了，不管了，告辞。
        if (runStateAtLeast(c, STOP) ||
            // 基于CAS，将ctl从c修改为STOP状态，不修改工作线程个数，但是状态变为了STOP
            // 如果修改成功结束
            ctl.compareAndSet(c, ctlOf(STOP, workerCountOf(c))))
            break;
    }
}
// 无论怎么，直接中断工作线程。
private void interruptWorkers() {
    final ReentrantLock mainLock = this.mainLock;
    mainLock.lock();
    try {
        // 遍历HashSet，拿到所有的工作线程，直接中断。
        for (Worker w : workers)
            w.interruptIfStarted();
    } finally {
        mainLock.unlock();
    }
}
// 移除阻塞队列，内容全部扔到List集合中
private List<Runnable> drainQueue() {
    BlockingQueue<Runnable> q = workQueue;
    ArrayList<Runnable> taskList = new ArrayList<Runnable>();
    // 阻塞队列自带的，直接清空阻塞队列，内容扔到List集合
    q.drainTo(taskList);
    // 为了避免任务丢失，重新判断，是否需要编辑阻塞队列，重新扔到List
    if (!q.isEmpty()) {
        for (Runnable r : q.toArray(new Runnable[0])) {
            if (q.remove(r))
                taskList.add(r);
        }
    }
    return taskList;
}

// 查看当前线程池是否可以变为TERMINATED状态
final void tryTerminate() {
    // 死循环。
    for (;;) {
        // 拿到ctl
        int c = ctl.get();
        // 如果是RUNNING，直接告辞。
        // 如果状态已经大于等于TIDYING，马上就要凉凉，直接告辞。
        // 如果状态是SHUTDOWN，但是阻塞队列还有任务，直接告辞。
        if (isRunning(c) ||
            runStateAtLeast(c, TIDYING) ||
            (runStateOf(c) == SHUTDOWN && ! workQueue.isEmpty()))
            return;
        // 如果还有工作线程
        if (workerCountOf(c) != 0) { 
            // 再次中断工作线程
            interruptIdleWorkers(ONLY_ONE);
            // 告辞，等你工作线程全完事，我这再尝试进入到TERMINATED状态
            return;
        }

        // 加锁，为了可以执行Condition的释放操作
        final ReentrantLock mainLock = this.mainLock;
        mainLock.lock();
        try {
            // 将线程池状态修改为TIDYING状态，如果成功，继续往下走
            if (ctl.compareAndSet(c, ctlOf(TIDYING, 0))) {
                try {
                    // 这个方法是空的，如果你需要在线程池关闭后做一些额外操作，这里你可以自行实现
                    terminated();
                } finally {
                    // 最终修改为TERMINATED状态
                    ctl.set(ctlOf(TERMINATED, 0));
                    // 线程池提供了一个方法，主线程在提交任务到线程池后，是可以继续做其他操作的。
                    // 咱们也可以让主线程提交任务后，等待线程池处理完毕，再做后续操作
                    // 这里线程池凉凉后，要唤醒哪些调用了awaitTermination方法的线程
                    termination.signalAll();
                }
                return;
            }
        } finally {
            mainLock.unlock();
        }
        // else retry on failed CAS
    }
}
```

再次shutdown方法，可以从RUNNING状态转变为SHUTDOWN

shutdown状态下，不会中断正在干活的线程，而且会处理阻塞队列中的任务

```java
public void shutdown() {
    // 加锁。。
    final ReentrantLock mainLock = this.mainLock;
    mainLock.lock();
    try {
        // 不看。
        checkShutdownAccess();
        // 里面是一个死循环，将线程池状态修改为SHUTDOWN
        advanceRunState(SHUTDOWN);
        // 中断空闲线程
        interruptIdleWorkers();
        // 说了，这个是为了ScheduleThreadPoolExecutor准备的，不管
        onShutdown(); 
    } finally {
        mainLock.unlock();
    }
    // 尝试结束线程
    tryTerminate();
}

// 中断空闲线程
private void interruptIdleWorkers(boolean onlyOne) {
    // 加锁
    final ReentrantLock mainLock = this.mainLock;
    mainLock.lock();
    try {
        for (Worker w : workers) {
            Thread t = w.thread;
            // 如果线程没有中断，那么就去获取Worker的锁，基于tryLock可知，不会中断正在干活的线程
            if (!t.isInterrupted() && w.tryLock()) {
                try {
                    // 会中断空闲线程
                    t.interrupt();
                } catch (SecurityException ignore) {
                } finally {
                    w.unlock();
                }
            }
            if (onlyOne)
                break;
        }
    } finally {
        mainLock.unlock();
    }
}
```

#### 3.4 线程池的核心参数设计规则

线程池的使用难度不大，难度在于线程池的参数并不好配置。

主要难点在于任务类型无法控制，比如任务有CPU密集型，还有IO密集型，甚至还有混合型的。

因为IO咱们无法直接控制，所以很多时间按照一些书上提供的一些方法，是无法解决问题的。

《Java并发编程实践》

想调试出一个符合当前任务情况的核心参数，最好的方式就是测试。

需要将项目部署到测试环境或者是沙箱环境中，结果各种压测得到一个相对符合的参数。

如果每次修改项目都需要重新部署，成本太高了。

此时咱们可以实现一个动态监控以及修改线程池的方案。

因为线程池的核心参数无非就是：

* corePoolSize：核心线程数
* maximumPoolSize：最大线程数
* workQueue：工作队列

线程池中提供了获取核心信息的get方法，同时也提供了动态修改核心属性的set方法。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1661937858024/d52b31cb12654481b26a11ddb6e5e4d2.png)

也可以采用一些开源项目提供的方式去做监控和修改

比如hippo4j就可以对线程池进行监控，而且可以和SpringBoot整合。

Github地址：https://github.com/opengoofy/hippo4j

官方文档：https://hippo4j.cn/docs/user_docs/intro

#### 3.5 线程池处理任务的核心流程

基于addWorker添加工作线程的流程切入到整体处理任务的位置

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1661937858024/8d14ec0135f44a4c8dc42b39fb58bf16.png)

### 四、**ScheduleThreadPoolExecutor应用&源码**

#### 4.1 ScheduleThreadPoolExecutor介绍

从名字上就可以看出，当前线程池是用于执行定时任务的线程池。

Java比较早的定时任务工具是Timer类。但是Timer问题很多，串行的，不靠谱，会影响到其他的任务执行。

其实除了Timer以及ScheduleThreadPoolExecutor之外，正常在企业中一般会采用Quartz或者是SpringBoot提供的Schedule的方式去实现定时任务的功能。

ScheduleThreadPoolExecutor支持延迟执行以及周期性执行的功能。

#### 4.2 ScheduleThreadPoolExecutor应用

定时任务线程池的有参构造

```java
public ScheduledThreadPoolExecutor(int corePoolSize,
                                   ThreadFactory threadFactory,
                                   RejectedExecutionHandler handler) {
    super(corePoolSize, Integer.MAX_VALUE, 0, NANOSECONDS,
          new DelayedWorkQueue(), threadFactory, handler);
}
```

发现ScheduleThreadPoolExecutor在构建时，直接调用了父类的构造方法

ScheduleThreadPoolExecutor的父类就是ThreadPoolExecutor

首先ScheduleThreadPoolExecutor最多允许设置3个参数：

* 核心线程数
* 线程工厂
* 拒绝策略

首先没有设置阻塞队列，以及最大线程数和空闲时间以及单位

阻塞队列设置的是DelayedWorkQueue，其实本质就是DelayQueue，一个延迟队列。DelayQueue是一个无界队列。所以最大线程数以及非核心线程的空闲时间是不需要设置的。

代码落地使用

```java
public static void main(String[] args) {
        //1. 构建定时任务线程池
        ScheduledThreadPoolExecutor pool = new ScheduledThreadPoolExecutor(
                5,
                new ThreadFactory() {
                    @Override
                    public Thread newThread(Runnable r) {
                        Thread t = new Thread(r);
                        return t;
                    }
                },
                new ThreadPoolExecutor.AbortPolicy()
        );
  
        //2. 应用ScheduledThreadPoolExecutor
        // 跟直接执行线程池的execute没啥区别
        pool.execute(() -> {
            System.out.println("execute");
        });
  
        // 指定延迟时间执行
        System.out.println(System.currentTimeMillis());
        pool.schedule(() -> {
            System.out.println("schedule");
            System.out.println(System.currentTimeMillis());
        },2, TimeUnit.SECONDS);
  
        // 指定第一次的延迟时间，并且确认后期的周期执行时间，周期时间是在任务开始时就计算
        // 周期性执行就是将执行完毕的任务再次社会好延迟时间，并且重新扔到阻塞队列
        // 计算的周期执行，也是在原有的时间上做累加，不关注任务的执行时长。
        System.out.println(System.currentTimeMillis());
        pool.scheduleAtFixedRate(() -> {
            System.out.println("scheduleAtFixedRate");
            System.out.println(System.currentTimeMillis());
        },2,3,TimeUnit.SECONDS);
  
  
    //        // 指定第一次的延迟时间，并且确认后期的周期执行时间，周期时间是在任务结束后再计算下次的延迟时间
        System.out.println(System.currentTimeMillis());
        pool.scheduleWithFixedDelay(() -> {
            System.out.println("scheduleWithFixedDelay");
            System.out.println(System.currentTimeMillis());
            try {
                Thread.sleep(4000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        },2,3,TimeUnit.SECONDS);
    }
```

#### 4.3 ScheduleThreadPoolExecutor源码剖析

##### 4.3.1 核心属性

后面的方法业务流程会涉及到这些属性。

```java
// 这里是针对任务取消时的一些业务判断会用到的标记
private volatile boolean continueExistingPeriodicTasksAfterShutdown;
private volatile boolean executeExistingDelayedTasksAfterShutdown = true;
private volatile boolean removeOnCancel = false;

// 计数器，如果两个任务的执行时间节点一模一样，根据这个序列来判断谁先执行
private static final AtomicLong sequencer = new AtomicLong();

// 这个方法是获取当前系统时间的毫秒值
final long now() {
    return System.nanoTime();
}

// 内部类。核心类之一。
private class ScheduledFutureTask<V>
        extends FutureTask<V> implements RunnableScheduledFuture<V> {

    // 全局唯一的序列，如果两个任务时间一直，基于当前属性判断
    private final long sequenceNumber;

    // 任务执行的时间，单位纳秒
    private long time;

    /**
     *  period == 0：执行一次的延迟任务
     *  period > 0：代表是At
     *  period < 0：代表是With
     */
    private final long period;

    // 周期性执行时，需要将任务重新扔回阻塞队列，基础当前属性拿到任务，方便扔回阻塞队列
    RunnableScheduledFuture<V> outerTask = this;


    /**
     * 构建schedule方法的任务
     */
    ScheduledFutureTask(Runnable r, V result, long ns) {
        super(r, result);
        this.time = ns;
        this.period = 0;
        this.sequenceNumber = sequencer.getAndIncrement();
    }

    /**
     * 构建At和With任务的有参构造
     */  
    ScheduledFutureTask(Runnable r, V result, long ns, long period) {
        super(r, result);
        this.time = ns;
        this.period = period;
        this.sequenceNumber = sequencer.getAndIncrement();
    }

}   

// 内部类。核心类之一。
static class DelayedWorkQueue extends AbstractQueue<Runnable> implements BlockingQueue<Runnable> {
// 这个类就是DelayQueue，不用过分关注，如果没看过，看阻塞队列中的优先级队列和延迟队列  
```

##### 4.3.2 schedule方法

execute方法也是调用的schedule方法，只不过传入的延迟时间是0纳秒

schedule方法就是将任务和延迟时间封装到一起，并且将任务扔到阻塞队列中，再去创建工作线程去take阻塞队列。

```java
// 延迟任务执行的方法。
// command：任务
// delay：延迟时间
// unit：延迟时间的单位
public ScheduledFuture<?> schedule(Runnable command, long delay, TimeUnit unit) {
    // 健壮性校验。
    if (command == null || unit == null)
        throw new NullPointerException();

    // 将任务和延迟时间封装到一起，最终组成ScheduledFutureTask
    // 要分成三个方法去看
    // triggerTime：计算延迟时间。最终返回的是当前系统时间 + 延迟时间 
    // triggerTime就是将延迟时间转换为纳秒，并且+当前系统时间，再做一些健壮性校验

    // ScheduledFutureTask有参构造：将任务以及延迟时间封装到一起，并且设置任务执行的方式

    // decorateTask：当前方式是让用户基于自身情况可以动态修改任务的一个扩展口
    RunnableScheduledFuture<?> t = decorateTask(command, 
                                   new ScheduledFutureTask<Void>(command, null,
                                   triggerTime(delay, unit)));
    // 任务封装好，执行delayedExecute方法，去执行任务
    delayedExecute(t);

    // 返回FutureTask
    return t;
}

// triggerTime做的事情
// 外部方法，对延迟时间做校验，如果小于0，就直接设置为0
// 并且转换为纳秒单位
private long triggerTime(long delay, TimeUnit unit) {
    return triggerTime(unit.toNanos((delay < 0) ? 0 : delay));
}
// 将延迟时间+当前系统时间
// 后面的校验是为了避免延迟时间超过Long的取值范围
long triggerTime(long delay) {
    return now() + ((delay < (Long.MAX_VALUE >> 1)) ? delay : overflowFree(delay));
}

// ScheduledFutureTask有参构造
ScheduledFutureTask(Runnable r, V result, long ns) {
    super(r, result);
    // time就是任务要执行的时间
    this.time = ns;
    // period,为0，代表任务是延迟执行，不是周期执行
    this.period = 0;
    // 基于AtmoicLong生成的序列
    this.sequenceNumber = sequencer.getAndIncrement();
}


// delayedExecute 执行延迟任务的操作
private void delayedExecute(RunnableScheduledFuture<?> task) {
    // 查看当前线程池是否还是RUNNING状态，如果不是RUNNING，进到if
    if (isShutdown())
        // 不是RUNNING。
        // 执行拒绝策略。
        reject(task);
    else {
        // 线程池状态是RUNNING
        // 直接让任务扔到延迟的阻塞队列中
        super.getQueue().add(task);
        // DCL的操作，再次查看线程池状态
        // 如果线程池在添加任务到阻塞队列后，状态不是RUNNING
        if (isShutdown() &&
            // task.isPeriodic()：现在反回的是false，因为任务是延迟执行，不是周期执行
            // 默认情况，延迟队列中的延迟任务，可以执行
            !canRunInCurrentRunState(task.isPeriodic()) &&
            // 从阻塞队列中移除任务。
            remove(task))
            task.cancel(false);
        else
            // 线程池状态正常，任务可以执行
            ensurePrestart();
    }
}

// 线程池状态不为RUNNING，查看任务是否可以执行
// 延迟执行：periodic==false
// 周期执行：periodic==true
// continueExistingPeriodicTasksAfterShutdown：周期执行任务，默认为false
// executeExistingDelayedTasksAfterShutdown：延迟执行任务，默认为true
boolean canRunInCurrentRunState(boolean periodic) {
    return isRunningOrShutdown(periodic ?
                               continueExistingPeriodicTasksAfterShutdown :
                               executeExistingDelayedTasksAfterShutdown);
}
// 当前情况，shutdownOK为true
final boolean isRunningOrShutdown(boolean shutdownOK) {
    int rs = runStateOf(ctl.get());
    // 如果状态是RUNNING，正常可以执行，返回true
    // 如果状态是SHUTDOWN，根据shutdownOK来决定
    return rs == RUNNING || (rs == SHUTDOWN && shutdownOK);
}


// 任务可以正常执行后，做的操作
void ensurePrestart() {
    // 拿到工作线程个数
    int wc = workerCountOf(ctl.get());
    // 如果工作线程个数小于核心线程数
    if (wc < corePoolSize)
        // 添加核心线程去处理阻塞队列中的任务
        addWorker(null, true);
    else if (wc == 0)
        // 如果工作线程数为0，核心线程数也为0，这是添加一个非核心线程去处理阻塞队列任务
        addWorker(null, false);
}
```

##### 4.3.3 At和With方法&任务的run方法

这两个方法在源码层面上的第一个区别，就是在计算周期时间时，需要将这个值传递给period，基于正负数在区别At和With

所以查看一个方法就ok，查看At方法

```java
// At方法，
// command：任务
// initialDelay：第一次执行的延迟时间
// period：任务的周期执行时间
// unit：上面两个时间的单位
public ScheduledFuture<?> scheduleAtFixedRate(Runnable command,
                                              long initialDelay,
                                              long period,
                                              TimeUnit unit) {
    // 健壮性校验
    if (command == null || unit == null)
        throw new NullPointerException();
    // 周期时间不能小于等于0.
    if (period <= 0)
        throw new IllegalArgumentException();
    // 将任务以及第一次的延迟时间，和后续的周期时间封装好。
    ScheduledFutureTask<Void> sft =
        new ScheduledFutureTask<Void>(command,
                                      null,
                                      triggerTime(initialDelay, unit),
                                      unit.toNanos(period));
    // 扩展口，可以对任务做修改。
    RunnableScheduledFuture<Void> t = decorateTask(command, sft);

    // 周期性任务，需要在任务执行完毕后，重新扔会到阻塞队列，为了方便拿任务，将任务设置到outerTask成员变量中
    sft.outerTask = t;
    // 和schedule方法一样的方式
    // 如果任务刚刚扔到阻塞队列，线程池状态变为SHUTDOWN，默认情况，当前任务不执行
    delayedExecute(t);
    return t;
}

// 延迟任务以及周期任务在执行时，都会调用当前任务的run方法。
public void run() {
    // periodic == false：一次性延迟任务
    // periodic == true：周期任务
    boolean periodic = isPeriodic();
    // 任务执行前，会再次判断状态，能否执行任务
    if (!canRunInCurrentRunState(periodic))
        cancel(false);
    // 判断是周期执行还是一次性任务
    else if (!periodic)
        // 一次性任务，让工作线程直接执行command的逻辑
        ScheduledFutureTask.super.run();
    // 到这个else if，说明任务是周期执行
    else if (ScheduledFutureTask.super.runAndReset()) {
        // 设置下次任务执行的时间
        setNextRunTime();
        // 将任务重新扔回线程池做处理
        reExecutePeriodic(outerTask);
    }
}
// 设置下次任务执行的时间
private void setNextRunTime() {
    // 拿到period值，正数：At，负数：With
    long p = period;
    if (p > 0)
        // 拿着之前的执行时间，直接追加上周期时间
        time += p;
    else
        // 如果走到else，代表任务是With方式，这种方式要重新计算延迟时间
        // 拿到当前系统时间，追加上延迟时间，
        time = triggerTime(-p);
}
 // 将任务重新扔回线程池做处理
void reExecutePeriodic(RunnableScheduledFuture<?> task) {
    // 如果状态ok，可以执行
    if (canRunInCurrentRunState(true)) {
        // 将任务扔到延迟队列
        super.getQueue().add(task);
        // DCL，判断线程池状态
        if (!canRunInCurrentRunState(true) && remove(task))
            task.cancel(false);
        else
            // 添加工作线程
            ensurePrestart();
    }
}
```

## 并发集合

### 一、ConcurrentHashMap

#### 1.1 存储结构

ConcurrentHashMap是线程安全的HashMap

ConcurrentHashMap在JDK1.8中是以CAS+synchronized实现的线程安全

CAS：在没有hash冲突时（Node要放在数组上时）

synchronized：在出现hash冲突时（Node存放的位置已经有数据了）

存储的结构：数组+链表+红黑树

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1650964041067/58b78127941e4384ba329d61539ed137.png)

#### 1.2 存储操作

##### 1.2.1 put方法

```java
public V put(K key, V value) {
    // 在调用put方法时，会调用putVal，第三个参数默认传递为false
    // 在调用putIfAbsent时，会调用putVal方法，第三个参数传递的为true
    // 如果传递为false，代表key一致时，直接覆盖数据
    // 如果传递为true，代表key一致时，什么都不做，key不存在，正常添加（Redis，setnx）
    return putVal(key, value, false);
}
```

##### 1.2.2 putVal方法-散列算法

```java
final V putVal(K key, V value, boolean onlyIfAbsent) {
    // ConcurrentHashMap不允许key或者value出现为null的值，跟HashMap的区别
    if (key == null || value == null) throw new NullPointerException();
    // 根据key的hashCode计算出一个hash值，后期得出当前key-value要存储在哪个数组索引位置
    int hash = spread(key.hashCode());
    // 一个标识，在后面有用！
    int binCount = 0;
    // 省略大量的代码……
}

// 计算当前Node的hash值的方法
static final int spread(int h) {
    // 将key的hashCode值的高低16位进行^运算，最终又与HASH_BITS进行了&运算
    // 将高位的hash也参与到计算索引位置的运算当中
    // 为什么HashMap、ConcurrentHashMap，都要求数组长度为2^n
    // HASH_BITS让hash值的最高位符号位肯定为0，代表当前hash值默认情况下一定是正数，因为hash值为负数时，有特殊的含义
    // static final int MOVED     = -1; // 代表当前hash位置的数据正在扩容！
    // static final int TREEBIN   = -2; // 代表当前hash位置下挂载的是一个红黑树
    // static final int RESERVED  = -3; // 预留当前索引位置……
    return (h ^ (h >>> 16)) & HASH_BITS;
    // 计算数组放到哪个索引位置的方法   (f = tabAt(tab, i = (n - 1) & hash)
    // n：是数组的长度
}
00001101 00001101 00101111 10001111  - h = key.hashCode

运算方式
00000000 00000000 00000000 00001111  - 15 (n - 1)
&
(
(
00001101 00001101 00101111 10001111  - h
^
00000000 00000000 00001101 00001101  - h >>> 16
)
&
01111111 11111111 11111111 11111111  - HASH_BITS
)
```

##### 1.2.3 putVal方法-添加数据到数组&初始化数组

```java
final V putVal(K key, V value, boolean onlyIfAbsent) {
    // 省略部分代码…………
    // 将Map的数组赋值给tab，死循环
    for (Node<K,V>[] tab = table;;) {
        // 声明了一堆变量~~
        // n:数组长度
        // i:当前Node需要存放的索引位置
        // f: 当前数组i索引位置的Node对象
        // fn：当前数组i索引位置上数据的hash值
        Node<K,V> f; int n, i, fh;
        // 判断当前数组是否还没有初始化
        if (tab == null || (n = tab.length) == 0)
            // 将数组进行初始化。
            tab = initTable();
        // 基于 (n - 1) & hash 计算出当前Node需要存放在哪个索引位置
        // 基于tabAt获取到i位置的数据
        else if ((f = tabAt(tab, i = (n - 1) & hash)) == null) {
            // 现在数组的i位置上没有数据，基于CAS的方式将数据存在i位置上
            if (casTabAt(tab, i, null,new Node<K,V>(hash, key, value, null)))
                // 如果成功，执行break跳出循环，插入数据成功
                break;   
        }
        // 判断当前位置数据是否正在扩容……
        else if ((fh = f.hash) == MOVED)
            // 让当前插入数据的线程协助扩容
            tab = helpTransfer(tab, f);
        // 省略部分代码…………
    }
    // 省略部分代码…………
}


sizeCtl：是数组在初始化和扩容操作时的一个控制变量
-1：代表当前数组正在初始化
小于-1：低16位代表当前数组正在扩容的线程个数（如果1个线程扩容，值为-2，如果2个线程扩容，值为-3）
0：代表数组还没初始化
大于0：代表当前数组的扩容阈值，或者是当前数组的初始化大小
// 初始化数组方法
private final Node<K,V>[] initTable() {
    // 声明标识
    Node<K,V>[] tab; int sc;
    // 再次判断数组没有初始化，并且完成tab的赋值
    while ((tab = table) == null || tab.length == 0) {
        // 将sizeCtl赋值给sc变量，并判断是否小于0
        if ((sc = sizeCtl) < 0)
            Thread.yield(); 
        // 可以尝试初始化数组，线程会以CAS的方式，将sizeCtl修改为-1，代表当前线程可以初始化数组
        else if (U.compareAndSwapInt(this, SIZECTL, sc, -1)) {
            // 尝试初始化！
            try {
                // 再次判断当前数组是否已经初始化完毕。
                if ((tab = table) == null || tab.length == 0) {
                    // 开始初始化，
                    // 如果sizeCtl > 0，就初始化sizeCtl长度的数组
                    // 如果sizeCtl == 0，就初始化默认的长度
                    int n = (sc > 0) ? sc : DEFAULT_CAPACITY;
                    // 初始化数组！
                    Node<K,V>[] nt = (Node<K,V>[])new Node<?,?>[n];
                    // 将初始化的数组nt，赋值给tab和table
                    table = tab = nt;
                    // sc赋值为了数组长度 - 数组长度 右移 2位    16 - 4 = 12
                    // 将sc赋值为下次扩容的阈值
                    sc = n - (n >>> 2);
                }
            } finally {
                // 将赋值好的sc，设置给sizeCtl
                sizeCtl = sc;
            }
            break;
        }
    }
    return tab;
}
```

##### 1.2.4 putVal方法-添加数据到链表

```java、
final V putVal(K key, V value, boolean onlyIfAbsent) {
    // 省略部分代码…………
    int binCount = 0;
    for (Node<K,V>[] tab = table;;) {
        Node<K,V> f; int n, i, fh;
        // n:数组长度
        // i:当前Node需要存放的索引位置
        // f: 当前数组i索引位置的Node对象
        // fn：当前数组i索引位置上数据的hash值
        // 省略部分代码…………
        else {
            // 声明变量为oldVal
            V oldVal = null;
            // 基于当前索引位置的Node，作为锁对象……
            synchronized (f) {
                // 判断当前位置的数据还是之前的f么……（避免并发操作的安全问题）
                if (tabAt(tab, i) == f) {
                    // 再次判断hash值是否大于0（不是树）
                    if (fh >= 0) {
                        // binCount设置为1（在链表情况下，记录链表长度的一个标识）
                        binCount = 1;
                        // 死循环，每循环一次，对binCount
                        for (Node<K,V> e = f;; ++binCount) {
                            // 声明标识ek
                            K ek;
                            // 当前i索引位置的数据，是否和当前put的key的hash值一致
                            if (e.hash == hash &&
                                // 如果当前i索引位置数据的key和put的key == 返回为true
                                // 或者equals相等
                                ((ek = e.key) == key || (ek != null && key.equals(ek)))) {
                                // key一致，可能需要覆盖数据！
                                // 当前i索引位置数据的value复制给oldVal
                                oldVal = e.val;
                                // 如果传入的是false，代表key一致，覆盖value
                                // 如果传入的是true，代表key一致，什么都不做！
                                if (!onlyIfAbsent)
                                    // 覆盖value
                                    e.val = value;
                                break;
                            }
                            // 拿到当前指定的Node对象
                            Node<K,V> pred = e;
                            // 将e指向下一个Node对象,如果next指向的是一个null，可以挂在当前Node下面
                            if ((e = e.next) == null) {
                                // 将hash，key，value封装为Node对象，挂在pred的next上
                                pred.next = new Node<K,V>(hash, key,
                                                          value, null);
                                break;
                            }
                        }
                    }
                    // 省略部分代码…………
                }
            }
            // binCount长度不为0
            if (binCount != 0) {
                // binCount是否大于8（链表长度是否 >= 8）
                if (binCount >= TREEIFY_THRESHOLD)
                    // 尝试转为红黑树或者扩容
                    // 基于treeifyBin方法和上面的if判断，可以得知链表想要转为红黑树，必须保证数组长度大于等于64，并且链表长度大于等于8
                    // 如果数组长度没有达到64的话，会首先将数组扩容
                    treeifyBin(tab, i);
                // 如果出现了数据覆盖的情况，
                if (oldVal != null)
                    // 返回之前的值
                    return oldVal;
                break;
            }
        }
    }
    // 省略部分代码…………
}

// 为什么链表长度为8转换为红黑树，不是能其他数值嘛？
// 因为布松分布
 The main disadvantage of per-bin locks is that other update
 * operations on other nodes in a bin list protected by the same
 * lock can stall, for example when user equals() or mapping
 * functions take a long time.  However, statistically, under
 * random hash codes, this is not a common problem.  Ideally, the
 * frequency of nodes in bins follows a Poisson distribution
 * (http://en.wikipedia.org/wiki/Poisson_distribution) with a
 * parameter of about 0.5 on average, given the resizing threshold
 * of 0.75, although with a large variance because of resizing
 * granularity. Ignoring variance, the expected occurrences of
 * list size k are (exp(-0.5) * pow(0.5, k) / factorial(k)). The
 * first values are:
 *
 * 0:    0.60653066
 * 1:    0.30326533
 * 2:    0.07581633
 * 3:    0.01263606
 * 4:    0.00157952
 * 5:    0.00015795
 * 6:    0.00001316
 * 7:    0.00000094
 * 8:    0.00000006
 * more: less than 1 in ten million
```

#### 1.3 扩容操作

##### 1.3.1 treeifyBin方法触发扩容

```java
// 在链表长度大于等于8时，尝试将链表转为红黑树
private final void treeifyBin(Node<K,V>[] tab, int index) {
    Node<K,V> b; int n, sc;
    // 数组不能为空
    if (tab != null) {
        // 数组的长度n，是否小于64
        if ((n = tab.length) < MIN_TREEIFY_CAPACITY)
            // 如果数组长度小于64，不能将链表转为红黑树，先尝试扩容操作
            tryPresize(n << 1);
        // 省略部分代码……
    }
}
```

##### 1.3.2 tryPreSize方法-针对putAll的初始化操作

```java
// size是将之前的数组长度 左移 1位得到的结果
private final void tryPresize(int size) {
    // 如果扩容的长度达到了最大值，就使用最大值
    // 否则需要保证数组的长度为2的n次幂
    // 这块的操作，是为了初始化操作准备的，因为调用putAll方法时，也会触发tryPresize方法
    // 如果刚刚new的ConcurrentHashMap直接调用了putAll方法的话，会通过tryPresize方法进行初始化
    int c = (size >= (MAXIMUM_CAPACITY >>> 1)) ? MAXIMUM_CAPACITY :
        tableSizeFor(size + (size >>> 1) + 1);
    // 这些代码和initTable一模一样
    // 声明sc
    int sc;
    // 将sizeCtl的值赋值给sc，并判断是否大于0，这里代表没有初始化操作，也没有扩容操作
    while ((sc = sizeCtl) >= 0) {
        // 将ConcurrentHashMap的table赋值给tab，并声明数组长度n
        Node<K,V>[] tab = table; int n;
        // 数组是否需要初始化
        if (tab == null || (n = tab.length) == 0) {
            // 进来执行初始化
            // sc是初始化长度，初始化长度如果比计算出来的c要大的话，直接使用sc，如果没有sc大，
            // 说明sc无法容纳下putAll中传入的map，使用更大的数组长度
            n = (sc > c) ? sc : c;
            // 设置sizeCtl为-1，代表初始化操作
            if (U.compareAndSwapInt(this, SIZECTL, sc, -1)) {
                try {
                    // 再次判断数组的引用有没有变化
                    if (table == tab) {
                        // 初始化数组
                        Node<K,V>[] nt = (Node<K,V>[])new Node<?,?>[n];
                        // 数组赋值
                        table = nt;
                        // 计算扩容阈值
                        sc = n - (n >>> 2);
                    }
                } finally {
                    // 最终赋值给sizeCtl
                    sizeCtl = sc;
                }
            }
        }
        // 如果计算出来的长度c如果小于等于sc，直接退出循环结束方法
        // 数组长度大于等于最大长度了，直接退出循环结束方法
        else if (c <= sc || n >= MAXIMUM_CAPACITY)
            break;
        // 省略部分代码
    }
}

// 将c这个长度设置到最近的2的n次幂的值，   15 - 16     17 - 32
// c == size + (size >>> 1) + 1
// size = 17
00000000 00000000 00000000 00010001
+ 
00000000 00000000 00000000 00001000
+
00000000 00000000 00000000 00000001
// c = 26
00000000 00000000 00000000 00011010
private static final int tableSizeFor(int c) {
    // 00000000 00000000 00000000 00011001
    int n = c - 1;
    // 00000000 00000000 00000000 00011001
    // 00000000 00000000 00000000 00001100
    // 00000000 00000000 00000000 00011101
    n |= n >>> 1;
    // 00000000 00000000 00000000 00011101
    // 00000000 00000000 00000000 00000111
    // 00000000 00000000 00000000 00011111
    n |= n >>> 2;
    // 00000000 00000000 00000000 00011111
    // 00000000 00000000 00000000 00000001
    // 00000000 00000000 00000000 00011111
    n |= n >>> 4;
    // 00000000 00000000 00000000 00011111
    // 00000000 00000000 00000000 00000000
    // 00000000 00000000 00000000 00011111
    n |= n >>> 8;
    // 00000000 00000000 00000000 00011111
    n |= n >>> 16;
    // 00000000 00000000 00000000 00100000
    return (n < 0) ? 1 : (n >= MAXIMUM_CAPACITY) ? MAXIMUM_CAPACITY : n + 1;

}
```

##### 1.3.3 tryPreSize方法-计算扩容戳并且查看BUG

```java
private final void tryPresize(int size) {
    // n：数组长度
    while ((sc = sizeCtl) >= 0) {
        // 判断当前的tab是否和table一致，
        else if (tab == table) {
            // 计算扩容表示戳，根据当前数组的长度计算一个16位的扩容戳
            // 第一个作用是为了保证后面的sizeCtl赋值时，保证sizeCtl为小于-1的负数
            // 第二个作用用来记录当前是从什么长度开始扩容的
            int rs = resizeStamp(n);
            // BUG --- sc < 0，永远进不去~
            // 如果sc小于0，代表有线程正在扩容。
            if (sc < 0) {
                // 省略部分代码……协助扩容的代码（进不来~~~~）
            }
            // 代表没有线程正在扩容，我是第一个扩容的。
            else if (U.compareAndSwapInt(this, SIZECTL, sc,
                                         (rs << RESIZE_STAMP_SHIFT) + 2))
                // 省略部分代码……第一个扩容的线程……
        }
    }
}
// 计算扩容表示戳
// 32 =  00000000 00000000 00000000 00100000
// Integer.numberOfLeadingZeros(32) = 26
// 1 << (RESIZE_STAMP_BITS - 1) 
// 00000000 00000000 10000000 00000000
// 00000000 00000000 00000000 00011010
// 00000000 00000000 10000000 00011010
static final int resizeStamp(int n) {
    return Integer.numberOfLeadingZeros(n) | (1 << (RESIZE_STAMP_BITS - 1));
}
```

##### 1.3.4 tryPreSize方法-对sizeCtl的修改以及条件判断的BUG

```java
private final void tryPresize(int size) {
    // sc默认为sizeCtl
    while ((sc = sizeCtl) >= 0) {
        else if (tab == table) {
            // rs：扩容戳  00000000 00000000 10000000 00011010
            int rs = resizeStamp(n);
            if (sc < 0) {
                // 说明有线程正在扩容，过来帮助扩容
                Node<K,V>[] nt;
                // 依然有BUG
                // 当前线程扩容时，老数组长度是否和我当前线程扩容时的老数组长度一致
                // 00000000 00000000 10000000 00011010
                if ((sc >>> RESIZE_STAMP_SHIFT) != rs  
                    // 10000000 00011010 00000000 00000010 
                    // 00000000 00000000 10000000 00011010
                    // 这两个判断都是有问题的，核心问题就应该先将rs左移16位，再追加当前值。
                    // 这两个判断是BUG
                    // 判断当前扩容是否已经即将结束
                    || sc == rs + 1   // sc == rs << 16 + 1 BUG
                    // 判断当前扩容的线程是否达到了最大限度
                    || sc == rs + MAX_RESIZERS   // sc == rs << 16 + MAX_RESIZERS BUG
                    // 扩容已经结束了。
                    || (nt = nextTable) == null 
                    // 记录迁移的索引位置，从高位往低位迁移，也代表扩容即将结束。
                    || transferIndex <= 0)
                    break;
                // 如果线程需要协助扩容，首先就是对sizeCtl进行+1操作，代表当前要进来一个线程协助扩容
                if (U.compareAndSwapInt(this, SIZECTL, sc, sc + 1))
                    // 上面的判断没进去的话，nt就代表新数组
                    transfer(tab, nt);
            }
            // 是第一个来扩容的线程
            // 基于CAS将sizeCtl修改为  10000000 00011010 00000000 00000010 
            // 将扩容戳左移16位之后，符号位是1，就代码这个值为负数
            // 低16位在表示当前正在扩容的线程有多少个,
            // 为什么低位值为2时，代表有一个线程正在扩容
            // 每一个线程扩容完毕后，会对低16位进行-1操作，当最后一个线程扩容完毕后，减1的结果还是-1，
            // 当值为-1时，要对老数组进行一波扫描，查看是否有遗漏的数据没有迁移到新数组
            else if (U.compareAndSwapInt(this, SIZECTL, sc,(rs << RESIZE_STAMP_SHIFT) + 2))
                // 调用transfer方法，并且将第二个参数设置为null，就代表是第一次来扩容！
                transfer(tab, null);
        }
    }
}
```

##### 1.3.5 transfer方法-计算每个线程迁移的长度

```java
// 开始扩容   tab=oldTable
private final void transfer(Node<K,V>[] tab, Node<K,V>[] nextTab) {
    // n = 数组长度
    // stride = 每个线程一次性迁移多少数据到新数组
    int n = tab.length, stride;
    // 基于CPU的内核数量来计算，每个线程一次性迁移多少长度的数据最合理
    // NCPU = 4
    // 举个栗子：数组长度为1024 - 512 - 256 - 128 / 4 = 32
    // MIN_TRANSFER_STRIDE = 16,为每个线程迁移数据的最小长度
    if ((stride = (NCPU > 1) ? (n >>> 3) / NCPU : n) < MIN_TRANSFER_STRIDE)
        stride = MIN_TRANSFER_STRIDE; 
    // 根据CPU计算每个线程一次迁移多长的数据到新数组，如果结果大于16，使用计算结果。 如果结果小于16，就使用最小长度16
}
```

##### 1.3.6 transfer方法-构建新数组并查看标识属性

```java
// 以32长度数组扩容到64位例子
private final void transfer(Node<K,V>[] tab, Node<K,V>[] nextTab) {
    // n = 老数组长度   32
    // stride = 步长   16
    // 第一个进来扩容的线程需要把新数组构建出来
    if (nextTab == null) {
        try {
            // 将原数组长度左移一位，构建新数组长度
            Node<K,V>[] nt = (Node<K,V>[])new Node<?,?>[n << 1];
            // 赋值操作
            nextTab = nt;
        } catch (Throwable ex) {   
            // 到这说明已经达到数组长度的最大取值范围
            sizeCtl = Integer.MAX_VALUE;
            // 设置sizeCtl后直接结束
            return;
        }
        // 将成员变量的新数组赋值
        nextTable = nextTab;
        // 迁移数据时，用到的标识，默认值为老数组长度
        transferIndex = n;   // 32
    }
    // 新数组长度
    int nextn = nextTab.length;  // 64
    // 在老数组迁移完数据后，做的标识
    ForwardingNode<K,V> fwd = new ForwardingNode<K,V>(nextTab);
    // 迁移数据时，需要用到的标识
    boolean advance = true;
    boolean finishing = false; 
    // 省略部分代码
}
```

##### 1.3.7 transfer方法-线程领取迁移任务

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1650964041067/fbc9fe63800d4acbbed32a7ac19420fa.png)

```java
// 以32长度扩容到64位为例子
private final void transfer(Node<K,V>[] tab, Node<K,V>[] nextTab) {
    // n：32
    // stride：16
    int n = tab.length, stride;
    if (nextTab == null) { 
        // 省略部分代码…………
        // nextTable：新数组
        nextTable = nextTab;
        // transferIndex：0
        transferIndex = n;
    }
    // nextn：64
    int nextn = nextTab.length;
    ForwardingNode<K,V> fwd = new ForwardingNode<K,V>(nextTab);
    // advance：true，代表当前线程需要接收任务，然后再执行迁移，  如果为false，代表已经接收完任务
    boolean advance = true;
    // finishing：false，是否迁移结束！
    boolean finishing = false; 
    // 循环……
    // i = 15     代表当前线程迁移数据的索引值！！
    // bound = 0
    for (int i = 0, bound = 0;;) {
        // f = null
        // fh = 0
        Node<K,V> f; int fh;
        // 当前线程要接收任务
        while (advance) {
            // nextIndex = 16
            // nextBound = 16
            int nextIndex, nextBound;
            // 第一次进来，这两个判断肯定进不去。
            // 对i进行--，并且判断当前任务是否处理完毕！
            if (--i >= bound || finishing)
                advance = false;
            // 判断transferIndex是否小于等于0，代表没有任务可领取，结束了。
            // 在线程领取任务会，会对transferIndex进行修改，修改为transferIndex - stride
            // 在任务都领取完之后，transferIndex肯定是小于等于0的，代表没有迁移数据的任务可以领取
            else if ((nextIndex = transferIndex) <= 0) {
                i = -1;
                advance = false;
            }
            // 当前线程尝试领取任务
            else if (U.compareAndSwapInt
                     (this, TRANSFERINDEX, nextIndex,
                      nextBound = (nextIndex > stride ? nextIndex - stride : 0))) {
                // 对bound赋值
                bound = nextBound;
                // 对i赋值
                i = nextIndex - 1;
                // 设置advance设置为false，代表当前线程领取到任务了。
                advance = false;
            }
        }
        // 开始迁移数据，并且在迁移完毕后，会将advance设置为true
  
    }
}
```

##### 1.3.8 transfer方法-迁移结束操作

```java
// 以32长度扩容到64位为例子
private final void transfer(Node<K,V>[] tab, Node<K,V>[] nextTab) {
    for (int i = 0, bound = 0;;) {
        while (advance) {
        // 判断扩容是否已经结束！
        // i < 0：当前线程没有接收到任务！
        // i >= n: 迁移的索引位置，不可能大于数组的长度，不会成立
        // i + n >= nextn：因为i最大值就是数组索引的最大值，不会成立
        if (i < 0 || i >= n || i + n >= nextn) {
            // 如果进来，代表当前线程没有接收到任务
            int sc;
            // finishing为true，代表扩容结束
            if (finishing) {
                // 将nextTable新数组设置为null
                nextTable = null;
                // 将当前数组的引用指向了新数组~
                table = nextTab;
                // 重新计算扩容阈值    64 - 16 = 48
                sizeCtl = (n << 1) - (n >>> 1);
                // 结束扩容
                return;
            }
            // 当前线程没有接收到任务，让当前线程结束扩容操作。
            // 采用CAS的方式，将sizeCtl - 1，代表当前并发扩容的线程数 - 1
            if (U.compareAndSwapInt(this, SIZECTL, sc = sizeCtl, sc - 1)) {
                // sizeCtl的高16位是基于数组长度计算的扩容戳，低16位是当前正在扩容的线程个数
                if ((sc - 2) != resizeStamp(n) << RESIZE_STAMP_SHIFT)
                    // 代表当前线程并不是最后一个退出扩容的线程，直接结束当前线程扩容
                    return;
                // 如果是最后一个退出扩容的线程，将finishing和advance设置为true
                finishing = advance = true;
                // 将i设置为老数组长度，让最后一个线程再从尾到头再次检查一下，是否数据全部迁移完毕。
                i = n; 
            }
        }
        // 开始迁移数据，并且在迁移完毕后，会将advance设置为true 
    }
}
```

##### 1.3.9 transfer方法-迁移数据（链表）

```
// 以32长度扩容到64位为例子
private final void transfer(Node<K,V>[] tab, Node<K,V>[] nextTab) {
    // 省略部分代码…………
    for (int i = 0, bound = 0;;) {
        // 省略部分代码…………
        if (i < 0 || i >= n || i + n >= nextn) {   
             // 省略部分代码…………
        }
        // 开始迁移数据，并且在迁移完毕后，会将advance设置为true 
        // 获取指定i位置的Node对象，并且判断是否为null
        else if ((f = tabAt(tab, i)) == null)
            // 当前桶位置没有数据，无需迁移，直接将当前桶位置设置为fwd
            advance = casTabAt(tab, i, null, fwd);
        // 拿到当前i位置的hash值，如果为MOVED，证明数据已经迁移过了。
        else if ((fh = f.hash) == MOVED)
            // 一般是给最后扫描时，使用的判断，如果迁移完毕，直接跳过当前位置。
            advance = true; // already processed
        else {
            // 当前桶位置有数据，先锁住当前桶位置。
            synchronized (f) {
                // 判断之前取出的数据是否为当前的数据。
                if (tabAt(tab, i) == f) {
                    // ln：null  - lowNode
                    // hn：null  - highNode
                    Node<K,V> ln, hn;
                    // hash大于0，代表当前Node属于正常情况，不是红黑树，使用链表方式迁移数据
                    if (fh >= 0) {
                        // lastRun机制
                        //   000000000010000
                        // 这种运算结果只有两种，要么是0，要么是n
                        int runBit = fh & n;
                        // 将f赋值给lastRun
                        Node<K,V> lastRun = f;
                        // 循环的目的就是为了得到链表下经过hash & n结算，结果一致的最后一些数据
                        // 在迁移数据时，值需要迁移到lastRun即可，剩下的指针不需要变换。
                        for (Node<K,V> p = f.next; p != null; p = p.next) {
                            int b = p.hash & n;
                            if (b != runBit) {
                                runBit = b;
                                lastRun = p;
                            }
                        }
                        // runBit == 0，赋值给ln
                        if (runBit == 0) {
                            ln = lastRun;
                            hn = null;
                        }
                        // rubBit == n,赋值给hn
                        else {
                            hn = lastRun;
                            ln = null;
                        }
                        // 循环到lastRun指向的数据即可，后续不需要再遍历
                        for (Node<K,V> p = f; p != lastRun; p = p.next) {
                            // 获取当前Node的hash值，key值，value值。
                            int ph = p.hash; K pk = p.key; V pv = p.val;
                            // 如果hash&n为0，挂到lowNode上
                            if ((ph & n) == 0)
                                ln = new Node<K,V>(ph, pk, pv, ln);
                            // 如果hash&n为n，挂到highNode上
                            else
                                hn = new Node<K,V>(ph, pk, pv, hn);
                        }
                        // 采用CAS的方式，将ln挂到新数组的原位置
                        setTabAt(nextTab, i, ln);
                        // 采用CAS的方式，将hn挂到新数组的原位置 + 老数组长度
                        setTabAt(nextTab, i + n, hn);
                        // 采用CAS的方式，将当前桶位置设置为fwd
                        setTabAt(tab, i, fwd);
                        // advance设置为true，保证可以进入到while循环，对i进行--操作
                        advance = true;
                    }
                    // 省略迁移红黑树的操作
                }
            }
        }
    }
}
```

##### 1.3.10 helpTransfer方法-协助扩容

```java
// 在添加数据时，如果插入节点的位置的数据，hash值为-1，代表当前索引位置数据已经被迁移到了新数组
// tab：老数组
// f：数组上的Node节点
final Node<K,V>[] helpTransfer(Node<K,V>[] tab, Node<K,V> f) {
    // nextTab：新数组
    // sc：给sizeCtl做临时变量
    Node<K,V>[] nextTab; int sc;
    // 第一个判断：老数组不为null
    // 第二个判断：新数组不为null  （将新数组赋值给nextTab）
    if (tab != null && 
        (f instanceof ForwardingNode) && (nextTab = ((ForwardingNode<K,V>)f).nextTable) != null) {
        // ConcurrentHashMap正在扩容
        // 基于老数组长度计算扩容戳
        int rs = resizeStamp(tab.length);
        // 第一个判断：fwd中的新数组，和当前正在扩容的新数组是否相等。    相等：可以协助扩容。不相等：要么扩容结束，要么开启了新的扩容
        // 第二个判断：老数组是否改变了。     相等：可以协助扩容。不相等：扩容结束了
        // 第三个判断：如果正在扩容，sizeCtl肯定为负数，并且给sc赋值
        while (nextTab == nextTable && table == tab && (sc = sizeCtl) < 0) {
            // 第一个判断：将sc右移16位，判断是否与扩容戳一致。 如果不一致，说明扩容长度不一样，退出协助扩容
            // 第二个、三个判断是BUG：
            /*
                sc == rs << 16 + 1 ||      如果+1和当前sc一致，说明扩容已经到了最后检查的阶段
                sc == rs << 16 + MAX_RESIZERS ||    判断协助扩容的线程是否已经达到了最大值
            */
            // 第四个判断：transferIndex是从高索引位置到低索引位置领取数据的一个核心属性，如果满足 小于等于0，说明任务被领光了。
            if ((sc >>> RESIZE_STAMP_SHIFT) != rs || 
                sc == rs + 1 ||
                sc == rs + MAX_RESIZERS || 
                transferIndex <= 0)
                // 不需要协助扩容
                break;
            // 将sizeCtl + 1，进来协助扩容
            if (U.compareAndSwapInt(this, SIZECTL, sc, sc + 1)) {
                // 协助扩容
                transfer(tab, nextTab);
                break;
            }
        }
        return nextTab;
    }
    return table;
}
```

#### 1.4 红黑树操作

在前面搞定了关于数据+链表的添加和扩容操作，现在要搞定红黑树。因为红黑树的操作有点乱，先对红黑树结构有一定了解。

##### 1.4.1 什么是红黑树

红黑树是一种特殊的平衡二叉树，首选具备了平衡二叉树的特点：左子树和右子数的高度差不会超过1，如果超过了，平衡二叉树就会基于左旋和右旋的操作，实现自平衡。

红黑树在保证自平衡的前提下，还保证了自己的几个特性：

* 每个节点必须是红色或者黑色。
* 根节点必须是黑色。
* 如果当前节点是红色，子节点必须是黑色
* 所有叶子节点都是黑色。
* 从任意节点到每个叶子节点的路径中，黑色节点的数量是相同的。

当对红黑树进行增删操作时，可能会破坏平衡或者是特性，这是红黑树就需要基于左旋、右旋、变色来保证平衡和特性。

左旋操作：

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1650964041067/ad41d5d6756b40639adb752cc00b7e77.png)

右旋操作：

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1650964041067/c7b59fd5fee948d0be0d3a77b4f4a928.png)

变色操作：节点的颜色从黑色变为红色，或者从红色变为黑色，就成为变色。变色操作是在增删数据之后，可能出现的操作。插入数据时，插入节点的颜色一般是红色，因为插入红色节点的破坏红黑树结构的可能性比较低的。如果破坏了红黑树特性，会通过变色来调整

红黑树相对比较复杂，完整的红黑树代码400~500行内容，没有必要全部记下来，或者首先红黑树。

如果向细粒度掌握红黑树的结构：[https://www.mashibing.com/subject/21?courseNo=339]()

##### 1.4.2 TreeifyBin方法-封装TreeNode和双向链表

```java
// 将链表转为红黑树的准备操作
private final void treeifyBin(Node<K,V>[] tab, int index) {
    // b：当前索引位置的Node
    Node<K,V> b; int sc;
    if (tab != null) {
        // 省略部分代码
        // 开启链表转红黑树操作
        // 当前桶内有数据，并且是链表结构
        else if ((b = tabAt(tab, index)) != null && b.hash >= 0) {
            // 加锁，保证线程安全
            synchronized (b) {
                // 再次判断数据是否有变化，DCL
                if (tabAt(tab, index) == b) {
                    // 开启准备操作，将之前的链表中的每一个Node，封装为TreeNode，作为双向链表
                    // hd：是整个双向链表的第一个节点。 
                    // tl：是单向链表转换双向链表的临时存储变量
                    TreeNode<K,V> hd = null, tl = null;
                    for (Node<K,V> e = b; e != null; e = e.next) {
                        TreeNode<K,V> p = new TreeNode<K,V>(e.hash, e.key, e.val, null, null);
                        if ((p.prev = tl) == null)
                            hd = p;
                        else
                            tl.next = p;
                        tl = p;
                    }
                    // hd就是整个双向链表
                    // TreeBin的有参构建，将双向链表转为了红黑树。
                    setTabAt(tab, index, new TreeBin<K,V>(hd));
                }
            }
        }
    }
}
```

##### 1.4.3 TreeBin有参构造-双向链表转为红黑树

TreeBin中不但保存了红黑树结构，同时还保存在一套双向链表

```java
// 将双向链表转为红黑树的操作。 b：双向链表的第一个节点
// TreeBin继承自Node，root：代表树的根节点，first：双向链表的头节点
TreeBin(TreeNode<K,V> b) {
    // 构建Node，并且将hash值设置为-2
    super(TREEBIN, null, null, null);
    // 将双向链表的头节点赋值给first
    this.first = b;
    // 声明r的TreeNode，最后会被赋值为根节点
    TreeNode<K,V> r = null;
    // 遍历之前封装好的双向链表
    for (TreeNode<K,V> x = b, next; x != null; x = next) {
        next = (TreeNode<K,V>)x.next;

        // 先将左右子节点清空
        x.left = x.right = null;
        // 如果根节点为null，第一次循环
        if (r == null) {
            // 将第一个节点设置为当前红黑树的根节点
            x.parent = null;  // 根节点没父节点
            x.red = false;  // 不是红色，是黑色
            r = x; // 将当前节点设置为r
        }
        // 已经有根节点，当前插入的节点要作为父节点的左子树或者右子树
        else {
            // 拿到了当前节点key和hash值。
            K k = x.key;
            int h = x.hash;
            Class<?> kc = null;
            // 循环？
            for (TreeNode<K,V> p = r;;) {
                // dir：如果为-1，代表要插入到父节点的左边，如果为1，代表要插入的父节点的右边
                // ph：是父节点的hash值
                int dir, ph;
                // pk：是父节点的key
                K pk = p.key;
                // 父节点的hash值，大于当前节点的hash值，就设置为-1，代表要插入到父节点的左边
                if ((ph = p.hash) > h)
                    dir = -1;
                // 父节点的hash值，小于当前节点的hash值，就设置为1，代表要插入到父节点的右边
                else if (ph < h)
                    dir = 1;
                // 父节点的hash值和当前节点hash值一致，基于compare方式判断到底放在左子树还是右子树
                else if ((kc == null &&
                          (kc = comparableClassFor(k)) == null) ||
                         (dir = compareComparables(kc, k, pk)) == 0)
                    dir = tieBreakOrder(k, pk);
                // 拿到当前父节点。
                TreeNode<K,V> xp = p;
                // 将p指向p的left、right，并且判断是否为null
                // 如果为null，代表可以插入到这位置。
                if ((p = (dir <= 0) ? p.left : p.right) == null) {
                    // 进来就说明找到要存放当前节点的位置了
                    // 将当前节点的parent指向父节点
                    x.parent = xp;
                    // 根据dir的值，将父节点的left、right指向当前节点
                    if (dir <= 0)
                        xp.left = x;
                    else
                        xp.right = x;
                    // 插入一个节点后，做一波平衡操作
                    r = balanceInsertion(r, x);
                    break;
                }
            }
        }
    }
    // 将根节点复制给root
    this.root = r;
    // 检查红黑树结构
    assert checkInvariants(root);
}
```

##### 1.4.4 balanceInsertion方法-保证红黑树平衡以及特性

```java
// 红黑树的插入动画：https://www.cs.usfca.edu/~galles/visualization/RedBlack.html
// 红黑树做自平衡以及保证特性的操作。  root：根节点，  x：当前节点
static <K,V> TreeNode<K,V> balanceInsertion(TreeNode<K,V> root, TreeNode<K,V> x) {
    // 先将节点置位红色
    x.red = true;
    // xp：父节点
    // xpp：爷爷节点
    // xppl：爷爷节点的左子树
    // xxpr：爷爷节点的右子树
    for (TreeNode<K,V> xp, xpp, xppl, xppr;;) {
        // 拿到父节点，并且父节点为红
        if ((xp = x.parent) == null) {
            // 当前节点为根节点，置位黑色
            x.red = false;
            return x;
        }
        // 父节点不是红色，爷爷节点为null
        else if (!xp.red || (xpp = xp.parent) == null)
            // 什么都不做，直接返回
            return root;

        // =====================================
        // 左子树的操作
        if (xp == (xppl = xpp.left)) {
            // 通过变色满足红黑树特性
            if ((xppr = xpp.right) != null && xppr.red) {
                // 叔叔节点和父节点变为黑色
                xppr.red = false;
                xp.red = false;
                // 爷爷节点置位红色
                xpp.red = true;
                // 让爷爷节点作为当前节点，再走一次循环
                x = xpp;
            }

            else {
                // 如果当前节点是右子树，通过父节点的左旋，变为左子树的结构
                if (x == xp.right) {、
                    // 父节点做左旋操作
                    root = rotateLeft(root, x = xp);
                    xpp = (xp = x.parent) == null ? null : xp.parent;
                }
                if (xp != null) {
                    // 父节点变为黑色
                    xp.red = false;
                    if (xpp != null) {
                        // 爷爷节点变为红色
                        xpp.red = true;
                        // 爷爷节点做右旋操作
                        root = rotateRight(root, xpp);
                    }
                }
            }
        }

        // 右子树（只讲左子树就足够了，因为业务都是一样的）
        else {
            if (xppl != null && xppl.red) {
                xppl.red = false;
                xp.red = false;
                xpp.red = true;
                x = xpp;
            }
            else {
                if (x == xp.left) {
                    root = rotateRight(root, x = xp);
                    xpp = (xp = x.parent) == null ? null : xp.parent;
                }
                if (xp != null) {
                    xp.red = false;
                    if (xpp != null) {
                        xpp.red = true;
                        root = rotateLeft(root, xpp);
                    }
                }
            }
        }
    }
}
```

##### 1.4.5 putTreeVal方法-添加节点

整体操作就是判断当前节点要插入到左子树，还是右子数，还是覆盖操作。

确定左子树和右子数之后，直接维护双向链表和红黑树结构，并且再判断是否需要自平衡。

TreeBin的双向链表用的头插法。

```java
// 添加节点到红黑树内部
final TreeNode<K,V> putTreeVal(int h, K k, V v) {
    // Class对象
    Class<?> kc = null;
    // 搜索节点
    boolean searched = false;
    // 死循环，p节点是根节点的临时引用
    for (TreeNode<K,V> p = root;;) {
        // dir：确定节点是插入到左子树还是右子数
        // ph：父节点的hash值
        // pk：父节点的key
        int dir, ph; K pk;
        // 根节点是否为诶null，把当前节点置位根节点
        if (p == null) {
            first = root = new TreeNode<K,V>(h, k, v, null, null);
            break;
        }
        // 判断当前节点要放在左子树还是右子数
        else if ((ph = p.hash) > h)
            dir = -1;
        else if (ph < h)
            dir = 1;
        // 如果key一致，直接返回p，由putVal去修改数据
        else if ((pk = p.key) == k || (pk != null && k.equals(pk)))
            return p;
        // hash值一致，但是key的==和equals都不一样，基于Compare去判断
        else if ((kc == null &&
                  (kc = comparableClassFor(k)) == null) ||
                 // 基于compare判断也是一致，就进到if判断
                 (dir = compareComparables(kc, k, pk)) == 0) {
            // 开启搜索，查看是否有相同的key，只有第一次循环会执行。
            if (!searched) {
                TreeNode<K,V> q, ch;
                searched = true;
                if (((ch = p.left) != null &&
                     (q = ch.findTreeNode(h, k, kc)) != null) ||
                    ((ch = p.right) != null &&
                     (q = ch.findTreeNode(h, k, kc)) != null))
                    // 如果找到直接返回
                    return q;
            }
            // 再次判断hash大小，如果小于等于，返回-1
            dir = tieBreakOrder(k, pk);
        }

        // xp是父节点的临时引用
        TreeNode<K,V> xp = p;
        // 基于dir判断是插入左子树还有右子数，并且给p重新赋值
        if ((p = (dir <= 0) ? p.left : p.right) == null) {
            // first引用拿到
            TreeNode<K,V> x, f = first;
            // 将当前节点构建出来
            first = x = new TreeNode<K,V>(h, k, v, f, xp);
            // 因为当前的TreeBin除了红黑树还维护这一个双向链表，维护双向链表的操作
            if (f != null)
                f.prev = x;
            // 维护红黑树操作
            if (dir <= 0)
                xp.left = x;
            else
                xp.right = x;
            // 如果如节点是黑色的，当前节点红色即可，说明现在插入的节点没有影响红黑树的平衡
            if (!xp.red)
                x.red = true;
            else {
                // 说明插入的节点是黑色的
                // 加锁操作
                lockRoot();
                try {
                    // 自平衡一波。
                    root = balanceInsertion(root, x);
                } finally {
                    // 释放锁操作
                    unlockRoot();
                }
            }
            break;
        }
    }
    // 检查一波红黑树结构
    assert checkInvariants(root);
    // 代表插入了新节点
    return null;
}
```

##### 1.4.6 TreeBin的锁操作

TreeBin的锁操作，没有基于AQS，仅仅是对一个变量的CAS操作和一些业务判断实现的。

每次读线程操作，对lockState+4。

写线程操作，对lockState + 1，如果读操作占用着线程，就先+2，waiter是当前线程，并挂起当前线程

```java
// TreeBin的锁操作
// 如果说有读线程在读取红黑树的数据，这时，写线程要阻塞（做平衡前）
// 如果有写线程正在操作红黑树（做平衡），读线程不会阻塞，会读取双向链表
// 读读不会阻塞！
static final class TreeBin<K,V> extends Node<K,V> {
  
    // waiter：等待获取写锁的线程
    volatile Thread waiter;
    // lockState：当前TreeBin的锁状态
    volatile int lockState;
  
    // 对锁状态进行运算的值
    // 有线程拿着写锁
    static final int WRITER = 1; 
    // 有写线程，再等待获取写锁
    static final int WAITER = 2; 
    // 读线程，在红黑树中检索时，需要先对lockState + READER
    // 这个只会在读操作中遇到
    static final int READER = 4; 

    // 加锁-写锁
    private final void lockRoot() {
        // 将lockState从0设置为1，代表拿到写锁成功
        if (!U.compareAndSwapInt(this, LOCKSTATE, 0, WRITER))
            // 如果写锁没拿到，执行contendedLock
            contendedLock(); 
    }

    // 释放写锁
    private final void unlockRoot() {
        lockState = 0;
    }

  
    // 写线程没有拿到写锁，执行当前方法
    private final void contendedLock() {
        // 是否有线程正在等待
        boolean waiting = false;
        // 死循环，s是lockState的临时变量
        for (int s;;) {
            // 
            // lockState & 11111101 ,只要结果为0，说明当前写锁，和读锁都没线程获取
            if (((s = lockState) & ~WAITER) == 0) {
                // CAS一波，尝试将lockState再次修改为1，
                if (U.compareAndSwapInt(this, LOCKSTATE, s, WRITER)) {
                    // 成功拿到锁资源，并判断是否在waiting
                    if (waiting)
                        // 如果当前线程挂起过，直接将之前等待的线程资源设置为null
                        waiter = null;
                    return;
                }
            }
            // 有读操作在占用资源
            // lockState &  00000010,代表当前没有写操作挂起等待。
            else if ((s & WAITER) == 0) {
                // 基于CAS，将LOCKSTATE的第二位设置为1
                if (U.compareAndSwapInt(this, LOCKSTATE, s, s | WAITER)) {
                    // 如果成功，代表当前线程可以waiting等待了
                    waiting = true;
                    waiter = Thread.currentThread();
                }
            }
            else if (waiting)
                // 挂起当前线程！会由写操作唤醒
                LockSupport.park(this);
        }
    }
}   
```

##### 1.4.7 transfer迁移数据

首先红黑结构的数据迁移是基于双向链表封装的数据。

如果高低位的长度小于等于6，封装为链表迁移到新数组

如果高低位的长度大于6，依然封装为红黑树迁移到新数组

```java
// 红黑树的迁移操作单独拿出来，TreeBin中不但有红黑树，还有双向链表，迁移的过程是基于双向链表迁移
TreeBin<K,V> t = (TreeBin<K,V>)f;
// lo，hi扩容后要放到新数组的高低位的链表
TreeNode<K,V> lo = null, loTail = null;
TreeNode<K,V> hi = null, hiTail = null;
// lc，hc在记录高低位数据的长度
int lc = 0, hc = 0;
// 遍历TreeBin中的双向链表
for (Node<K,V> e = t.first; e != null; e = e.next) {
    int h = e.hash;
    TreeNode<K,V> p = new TreeNode<K,V>(h, e.key, e.val, null, null);
    // 与老数组长度做&运算，基于结果确定需要存放到低位还是高位
    if ((h & n) == 0) {
        if ((p.prev = loTail) == null)
            lo = p;
        else
            loTail.next = p;
        loTail = p;
        // 低位长度++
        ++lc;
    }
    else {
        if ((p.prev = hiTail) == null)
            hi = p;
        else
            hiTail.next = p;
        hiTail = p;
        // 高位长度++
        ++hc;
    }
}
// 封装低位节点，如果低位节点的长度小于等于6，转回成链表。 如果长度大于6，需要重新封装红黑树
ln = (lc <= UNTREEIFY_THRESHOLD) ? untreeify(lo) : (hc != 0) ? new TreeBin<K,V>(lo) : t;
// 封装高位节点
hn = (hc <= UNTREEIFY_THRESHOLD) ? untreeify(hi) : (lc != 0) ? new TreeBin<K,V>(hi) : t;
// 低位数据设置到新数组
setTabAt(nextTab, i, ln);
// 高位数据设置到新数组
setTabAt(nextTab, i + n, hn);
// 当前位置数据迁移完毕，设置上fwd
setTabAt(tab, i, fwd);
// 开启前一个节点的数据迁移
advance = true;
```

#### 1.5 查询数据

##### 1.5.1 get方法-查询数据的入口

在查询数据时，会先判断当前key对应的value，是否在数组上。

其次会判断当前位置是否属于特殊情况：数据被迁移、位置被占用、红黑树结构

最后判断链表上是否有对应的数据。

找到返回指定的value，找不到返回null即可

```java
// 基于key查询value
public V get(Object key) {
    // tab：数组，  e：查询指定位置的节点  n：数组长度
    Node<K,V>[] tab; Node<K,V> e, p; int n, eh; K ek;
    // 基于传入的key，计算hash值
    int h = spread(key.hashCode());
    // 数组不为null，数组上得有数据，拿到指定位置的数组上的数据
    if ((tab = table) != null && (n = tab.length) > 0 && (e = tabAt(tab, (n - 1) & h)) != null) {
        // 数组上数据恩地hash值，是否和查询条件key的hash一样
        if ((eh = e.hash) == h) {
            // key的==或者equals是否一致，如果一致，数组上就是要查询的数据
            if ((ek = e.key) == key || (ek != null && key.equals(ek)))
                return e.val;
        }
        // 如果数组上的数据的hash为负数，有特殊情况，
        else if (eh < 0)
            // 三种情况，数据迁移走了，节点位置被占，红黑树
            return (p = e.find(h, key)) != null ? p.val : null;
        // 肯定走链表操作
        while ((e = e.next) != null) {
            // 如果hash值一致，并且key的==或者equals一致，返回当前链表位置的数据
            if (e.hash == h && ((ek = e.key) == key || (ek != null && key.equals(ek))))
                return e.val;
        }
    }
    // 如果上述三个流程都没有知道指定key对应的value，那就是key不存在，返回null即可
    return null;
}
```

##### 1.5.2 ForwardingNode的find方法

在查询数据时，如果发现已经扩容了，去新数组上查询数据

在数组和链表上正常找key对应的value

可能依然存在特殊情况：

* 再次是fwd，说明当前线程可能没有获取到CPU时间片，导致CHM再次触发扩容，重新走当前方法
* 可能是被占用或者是红黑树，再次走另外两种find方法的逻辑

```java
// 在查询数据时，发现当前桶位置已经放置了fwd，代表已经被迁移到了新数组
Node<K,V> find(int h, Object k) {
    // key：get(key)  h：key的hash   tab：新数组
    outer: for (Node<K,V>[] tab = nextTable;;) {
        // n：新数组长度，  e：新数组上定位的位置上的数组
        Node<K,V> e; int n;
        if (k == null || tab == null || (n = tab.length) == 0 || (e = tabAt(tab, (n - 1) & h)) == null)
            return null;
        // 开始在新数组中走逻辑
        for (;;) {
            // eh：新数组位置的数据的hash
            int eh; K ek;
            // 判断hash是否一致，如果一致，再判断==或者equals。
            if ((eh = e.hash) == h && ((ek = e.key) == k || (ek != null && k.equals(ek))))
                // 在新数组找到了数据
                return e;
            // 发现到了新数组，hash值又小于0
            if (eh < 0) {
                // 套娃，发现刚刚在扩容，到了新数组，发现又扩容
                if (e instanceof ForwardingNode) {
                    // 再次重新走最外层循环，拿到最新的nextTable
                    tab = ((ForwardingNode<K,V>)e).nextTable;
                    continue outer;
                }
                else
                    // 占了，红黑树
                    return e.find(h, k);
            }
            // 说明不在数组上，往下走链表
            if ((e = e.next) == null)
                // 进来说明链表没找到，返回null
                return null;
        }
    }
}
```

##### 1.5.3 ReservationNode的find方法

没什么说的，直接返回null

因为当前桶位置被占用的话，说明数据还没放到当前位置，当前位置可以理解为就是null

```java
Node<K,V> find(int h, Object k) {
    return null;
}
```

##### 1.5.4 TreeBin的find方法

在红黑树中执行find方法后，会有两个情况

* 如果有线程在持有写锁或者等待获取写锁，当前查询就要在双向链表中锁检索
* 如果没有线程持有写锁或者等待获取写锁，完全可以对lockState + 4，然后去红黑树中检索，并且在检索完毕后，需要对lockState - 4，再判断是否需要唤醒等待写锁的线程

```java
// 在红黑树中检索数据
final Node<K,V> find(int h, Object k) {
    // 非空判断
    if (k != null) {
        // e：Treebin中的双向链表，
        for (Node<K,V> e = first; e != null; ) {
            int s; K ek;
            // s：TreeBin的锁状态
            // 00000010
            // 00000001
            if (((s = lockState) & (WAITER|WRITER)) != 0) {
                // 如果进来if，说明要么有写线程在等待获取写锁，要么是由写线程持有者写锁
                // 如果出现这个情况，他会去双向链表查询数据
                if (e.hash == h && ((ek = e.key) == k || (ek != null && k.equals(ek))))
                    return e;
                e = e.next;
            }
            // 说明没有线程等待写锁或者持有写锁，将lockState + 4，代表当前读线程可以去红黑树中检索数据
            else if (U.compareAndSwapInt(this, LOCKSTATE, s, s + READER)) {
                TreeNode<K,V> r, p;
                try {
                    // 基于findTreeNode在红黑树中检索数据
                    p = ((r = root) == null ? null : r.findTreeNode(h, k, null));
                } finally {
                    Thread w;
                    // 会对lockState - 4，读线程拿到数据了，释放读锁
                    // 可以确认，如果-完4，等于WAITER，说明有写线程可能在等待，判断waiter是否为null
                    if (U.getAndAddInt(this, LOCKSTATE, -READER) == (READER|WAITER) && (w = waiter) != null)
                        // 当前我是最后一个在红黑树中检索的线程，同时有线程在等待持有写锁，唤醒等待的写线程
                        LockSupport.unpark(w);
                }
                return p;
            }
        }
    }
    return null;
}
```

##### 1.5.6 TreeNode的findTreeNode方法

红黑树的检索方式，套路很简单，及时基于hash值，来决定去找左子树还有右子数。

如果hash值一致，判断是否 == 、equals，满足就说明找到数据

如果hash值一致，并不是找的数据，基于compare方式，再次决定找左子树还是右子数，知道找到当前节点的子节点为null，停住。

```java
// 红黑树中的检索方法
final TreeNode<K,V> findTreeNode(int h, Object k, Class<?> kc) {
    if (k != null) {
        TreeNode<K,V> p = this;
        do  {
            int ph, dir; K pk; TreeNode<K,V> q;
            // 声明左子树和右子数
            TreeNode<K,V> pl = p.left, pr = p.right;
            // 直接比较hash值，来决决定走左子树还是右子数
            if ((ph = p.hash) > h)
                p = pl;
            else if (ph < h)
                p = pr;
            // 判断当前的子树是否和查询的k == 或者equals，直接返回
            else if ((pk = p.key) == k || (pk != null && k.equals(pk)))
                return p;
            else if (pl == null)
                p = pr;
            else if (pr == null)
                p = pl;
            else if ((kc != null ||
                      (kc = comparableClassFor(k)) != null) &&
                     (dir = compareComparables(kc, k, pk)) != 0)
                p = (dir < 0) ? pl : pr;
            // 递归继续往底层找
            else if ((q = pr.findTreeNode(h, k, kc)) != null)
                return q;
            else
                p = pl;
        } while (p != null);
    }
    return null;
}
```

#### 1.6 **ConcurrentHashMap其他方法**

##### 1.6.1 compute方法

修改ConcurrentHashMap中指定key的value时，一般会选择先get出来，然后再拿到原value值，基于原value值做一些修改，最后再存放到咱们ConcurrentHashMap

```java
public static void main(String[] args) {
    ConcurrentHashMap<String,Integer> map = new ConcurrentHashMap();
    map.put("key",1);
    // 修改key对应的value，追加上1

    // 之前的操作方式
    Integer oldValue = (Integer) map.get("key");
    Integer newValue = oldValue + 1;
    map.put("key",newValue);
    System.out.println(map);

    // 现在的操作方式
    map.compute("key",(key,computeOldValue) -> {
        if(computeOldValue == null){
            computeOldValue = 0;
        }
        return computeOldValue + 1;
    });
    System.out.println(map);
}
```

##### 1.6.2 compute方法源码分析

整个流程和putVal方法很类似，但是内部涉及到了占位的情况RESERVED

整个compute方法和putVal的区别就是，compute方法的value需要计算，如果key存在，基于oldValue计算出新结果，如果key不存在，直接基于oldValue为null的情况，去计算新的value。

```java
// compute 方法
public V compute(K key, BiFunction<? super K, ? super V, ? extends V> remappingFunction) {
    if (key == null || remappingFunction == null)
        throw new NullPointerException();
    // 计算key的hash
    int h = spread(key.hashCode());
    V val = null;
    int delta = 0;
    int binCount = 0;
    // 初始化，桶上赋值，链表插入值，红黑树插入值
    for (Node<K,V>[] tab = table;;) {
        Node<K,V> f; int n, i, fh;
        //  初始化
        if (tab == null || (n = tab.length) == 0)
            tab = initTable();
        // 桶上赋值
        else if ((f = tabAt(tab, i = (n - 1) & h)) == null) {
            // 数组指定的索引位置是没有数据，当前数据必然要放到数组上。
            // 因为value需要计算得到，计算的时间不可估计，所以这里并没有通过CAS的方式处理并发操作，直接添加临时占用节点，
            // 并占用当前临时节点的锁资源。
            Node<K,V> r = new ReservationNode<K,V>();
            synchronized (r) {
                // 以CAS的方式将数据放上去
                if (casTabAt(tab, i, null, r)) {
                    binCount = 1;
                    Node<K,V> node = null;
                    try {
                        // 如果ReservationNode临时Node存放成功，直接开始计算value
                        if ((val = remappingFunction.apply(key, null)) != null) {
                            delta = 1;
                            // 将计算的value和传入的key封装成一个新Node，通过CAS存储到当前数组上
                            node = new Node<K,V>(h, key, val, null);
                        }
                    } finally {
                        setTabAt(tab, i, node);
                    }
                }
            }
            if (binCount != 0)
                break;
        }
        else {
            // 省略部分代码。主要是针对在链表上的替换、添加，以及在红黑树上的替换、添加
        }
    }
    if (delta != 0)
        addCount((long)delta, binCount);
    return val;
}
```

##### 1.6.3 computeIfPresent、computeIfAbsent、compute区别

compute的BUG，如果在计算结果的函数中，又涉及到了当前的key，会造成死锁问题。

```java
public static void main(String[] args) {
    ConcurrentHashMap<String,Integer> map = new ConcurrentHashMap();

    map.compute("key",(k,v) -> {
        return map.compute("key",(key,value) -> {
            return 1111;
        });
    });
    System.out.println(map);
}
```

computeIfPresent和computeIfAbsent其实就是将compute方法拆开成了两个方法

compute会在key不存在时，正常存放结果，如果key存在，就基于oldValue计算newValue

computeIfPresent：要求key在map中必须存在，需要基于oldValue计算newValue

computeIfAbsent：要求key在map中不能存在，必须为null，才会基于函数得到value存储进去

computeIfPresent：

```java
// 如果key存在，才执行修改操作
public V computeIfPresent(K key, BiFunction<? super K, ? super V, ? extends V> remappingFunction) {
    for (Node<K,V>[] tab = table;;) {
        Node<K,V> f; int n, i, fh;
        if (tab == null || (n = tab.length) == 0)
            tab = initTable();
        // 如果key不存在，什么事都不做~
        else if ((f = tabAt(tab, i = (n - 1) & h)) == null)
            break;
        else {
            synchronized (f) {
                if (tabAt(tab, i) == f) {
                    if (fh >= 0) {
                        binCount = 1;
                        for (Node<K,V> e = f, pred = null;; ++binCount) {
                            K ek;
                            // 如果查看到有 == 或者equals的key，就直接修改即可
                            if (e.hash == h &&
                                ((ek = e.key) == key ||
                                 (ek != null && key.equals(ek)))) {
                                val = remappingFunction.apply(key, e.val);
                                if (val != null)
                                    e.val = val;
                                else {
                                    delta = -1;
                                    Node<K,V> en = e.next;
                                    if (pred != null)
                                        pred.next = en;
                                    else
                                        setTabAt(tab, i, en);
                                }
                                break;
                            }
                            pred = e;
                            // 走完链表，还是没找到指定数据，直接break;
                            if ((e = e.next) == null)
                                break;
                        }
                    }
        // 省略部分代码
    return val;
}
```

computeIfAbsent核心位置源码：

```java
// key必须不存在才会执行添加操作
public V computeIfAbsent(K key, Function<? super K, ? extends V> mappingFunction) {
    for (Node<K,V>[] tab = table;;) {
        else if ((f = tabAt(tab, i = (n - 1) & h)) == null) {
            // 如果key不存在，正常添加;
            Node<K,V> r = new ReservationNode<K,V>();
            synchronized (r) {
                if (casTabAt(tab, i, null, r)) {
                    binCount = 1;
                    Node<K,V> node = null;
                    try {
                        if ((val = mappingFunction.apply(key)) != null)
                            node = new Node<K,V>(h, key, val, null);
                    } finally {
                        setTabAt(tab, i, node);
                    }
                }
            }
        }
        else {
            boolean added = false;
            synchronized (f) {
                if (tabAt(tab, i) == f) {
                    if (fh >= 0) {
                        binCount = 1;
                        for (Node<K,V> e = f;; ++binCount) {
                            K ek; V ev;
                            // 如果key存在，直接break;
                            if (e.hash == h &&
                                ((ek = e.key) == key ||
                                 (ek != null && key.equals(ek)))) {
                                val = e.val;
                                break;
                            }
                            // 如果没有找到一样的key，计算value结果接口
                            Node<K,V> pred = e;
                            if ((e = e.next) == null) {
                                if ((val = mappingFunction.apply(key)) != null) {
                                    added = true;
                                    pred.next = new Node<K,V>(h, key, val, null);
                                }
                                break;
                            }
                        }
                    }
        // 省略部分代码  
    return val;
}
```

##### 1.6.4 replace方法详解

涉及到类似CAS的操作，需要将ConcurrentHashMap的value从val1改为val2的场景就可以使用replace实现。

replace内部要求key必须存在，替换value值之前，要先比较oldValue，只有oldValue一致时，才会完成替换操作。

```java
// replace方法调用的replaceNode方法， value：newValue，  cv：oldValue
final V replaceNode(Object key, V value, Object cv) {
    int hash = spread(key.hashCode());
    for (Node<K,V>[] tab = table;;) {
        Node<K,V> f; int n, i, fh;
        // 在数组没有初始化时，或者key不存在时，什么都不干。
        if (tab == null || (n = tab.length) == 0 ||
            (f = tabAt(tab, i = (n - 1) & hash)) == null)
            break;
        else if ((fh = f.hash) == MOVED)
            tab = helpTransfer(tab, f);
        else {
            V oldVal = null;
            boolean validated = false;
            synchronized (f) {
                if (tabAt(tab, i) == f) {
                    if (fh >= 0) {
                        validated = true;
                        for (Node<K,V> e = f, pred = null;;) {
                            K ek;
                            // 找到key一致的Node了。
                            if (e.hash == hash && ((ek = e.key) == key || (ek != null && key.equals(ek)))) {
                                // 拿到当前节点的原值。
                                V ev = e.val;
                                // 拿oldValue和原值做比较，如果一致，
                                if (cv == null || cv == ev || (ev != null && cv.equals(ev))) {
                                    // 可以开始替换
                                    oldVal = ev;
                                    if (value != null)
                                        e.val = value;
                                    else if (pred != null)
                                        pred.next = e.next;
                                    else
                                        setTabAt(tab, i, e.next);
                                }
                                break;
                            }
                            pred = e;
                            if ((e = e.next) == null)
                                break;
                        }
                    }
                    else if (f instanceof TreeBin) {
                        validated = true;
                        TreeBin<K,V> t = (TreeBin<K,V>)f;
                        TreeNode<K,V> r, p;
                        if ((r = t.root) != null &&
                            (p = r.findTreeNode(hash, key, null)) != null) {
                            V pv = p.val;
                            if (cv == null || cv == pv ||
                                (pv != null && cv.equals(pv))) {
                                oldVal = pv;
                                if (value != null)
                                    p.val = value;
                                else if (t.removeTreeNode(p))
                                    setTabAt(tab, i, untreeify(t.first));
                            }
                        }
                    }
                }
            }
            if (validated) {
                if (oldVal != null) {
                    if (value == null)
                        addCount(-1L, -1);
                    return oldVal;
                }
                break;
            }
        }
    }
    return null;
}
```

##### 1.6.5 merge方法详解

merge(key,value,Function&#x3c;oldValue,value>);

在使用merge时，有三种情况可能发生：

* 如果key不存在，就跟put(key,value);
* 如果key存在，就可以基于Function计算，得到最终结果
  * 结果不为null，将key对应的value，替换为Function的结果
  * 结果为null，删除当前key

分析merge源码

```java
public V merge(K key, V value, BiFunction<? super V, ? super V, ? extends V> remappingFunction) {
    if (key == null || value == null || remappingFunction == null) throw new NullPointerException();
    int h = spread(key.hashCode());
    V val = null;
    int delta = 0;
    int binCount = 0;
    for (Node<K,V>[] tab = table;;) {
        Node<K,V> f; int n, i, fh;
        if (tab == null || (n = tab.length) == 0)
            tab = initTable();
        // key不存在，直接执行正常的添加操作，将value作为值，添加到hashMap
        else if ((f = tabAt(tab, i = (n - 1) & h)) == null) {
            if (casTabAt(tab, i, null, new Node<K,V>(h, key, value, null))) {
                delta = 1;
                val = value;
                break;
            }
        }
        else if ((fh = f.hash) == MOVED)
            tab = helpTransfer(tab, f);
        else {
            synchronized (f) {
                if (tabAt(tab, i) == f) {
                    if (fh >= 0) {
                        binCount = 1;
                        for (Node<K,V> e = f, pred = null;; ++binCount) {
                            K ek;
                            // 判断链表中，有当前的key
                            if (e.hash == h && ((ek = e.key) == key || (ek != null && key.equals(ek)))) {
                                // 基于函数，计算value
                                val = remappingFunction.apply(e.val, value);
                                // 如果计算的value不为null，正常替换
                                if (val != null)
                                    e.val = val;
                                // 计算的value是null，直接让上一个指针指向我的next，绕过当前节点
                                else {
                                    delta = -1;
                                    Node<K,V> en = e.next;
                                    if (pred != null)
                                        pred.next = en;
                                    else
                                        setTabAt(tab, i, en);
                                }
                                break;
                            }
                            pred = e;
                            if ((e = e.next) == null) {
                                delta = 1;
                                val = value;
                                pred.next =
                                    new Node<K,V>(h, key, val, null);
                                break;
                            }
                        }
                    }
                    else if (f instanceof TreeBin) {
                        binCount = 2;
                        TreeBin<K,V> t = (TreeBin<K,V>)f;
                        TreeNode<K,V> r = t.root;
                        TreeNode<K,V> p = (r == null) ? null :
                            r.findTreeNode(h, key, null);
                        val = (p == null) ? value :
                            remappingFunction.apply(p.val, value);
                        if (val != null) {
                            if (p != null)
                                p.val = val;
                            else {
                                delta = 1;
                                t.putTreeVal(h, key, val);
                            }
                        }
                        else if (p != null) {
                            delta = -1;
                            if (t.removeTreeNode(p))
                                setTabAt(tab, i, untreeify(t.first));
                        }
                    }
                }
            }
            if (binCount != 0) {
                if (binCount >= TREEIFY_THRESHOLD)
                    treeifyBin(tab, i);
                break;
            }
        }
    }
    if (delta != 0)
        addCount((long)delta, binCount);
    return val;
}
```

#### 1.7 **ConcurrentHashMap计数器**

##### 1.7.1 addCount方法分析

addCount方法本身就是为了记录ConcurrentHashMap中元素的个数。

两个方向组成：

- 计数器，如果添加元素成功，对计数器 + 1
- 检验当前ConcurrentHashMap是否需要扩容

计数器选择的不是AtomicLong，而是类似LongAdder的一个功能

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1650964041067/eac3042d4fc1496dab33b1f943c8c39e.png)

addCount源码分析

```java
private final void addCount(long x, int check) {
    // ================================计数=====================================
    // as： CounterCell[]
    // s：是自增后的元素个数
    // b：原来的baseCount
    CounterCell[] as; long b, s;
    // 判断CounterCell不为null，代表之前有冲突问题，有冲突直接进到if中
    // 如果CounterCell[]为null，直接执行||后面的CAS操作，直接修改baseCount
    if ((as = counterCells) != null ||
        // 如果对baseCount++成功。直接告辞。 如果CAS失败，直接进到if中
        !U.compareAndSwapLong(this, BASECOUNT, b = baseCount, s = b + x)) {
        // 导致，说明有并发问题。
        // 进来的方式有两种：
        // 1. counterCell[] 有值。
        // 2. counterCell[] 无值，但是CAS失败。
        // m：数组长度 - 1
        // a：当前线程基于随机数，获得到的数组上的某一个CounterCell
        CounterCell a; long v; int m;
        // 是否有冲突，默认为true，代表没有冲突
        boolean uncontended = true;
        // 判断CounterCell[]没有初始化，执行fullAddCount方法，初始化数组
        if (as == null || (m = as.length - 1) < 0 ||
            // CounterCell[]已经初始化了，基于随机数拿到数组上的一个CounterCell，如果为null，执行fullAddCount方法，初始化CounterCell
            (a = as[ThreadLocalRandom.getProbe() & m]) == null ||
            // CounterCell[]已经初始化了，并且指定索引位置上有CounterCell
            // 直接CAS修改指定的CounterCell上的value即可。
            // CAS成功，直接告辞！
            // CAS失败，代表有冲突，uncontended = false，执行fullAddCount方法
            !(uncontended = U.compareAndSwapLong(a, CELLVALUE, v = a.value, v + x))) {
            fullAddCount(x, uncontended);
            return;
        }
        // 如果链表长度小于等于1，不去判断扩容
        if (check <= 1)
            return;
        // 将所有CounterCell中记录的信累加，得到最终的元素个数
        s = sumCount();
    }

    // ================================判断扩容=======================================
    // 判断check大于等于，remove的操作就是小于0的。 因为添加时，才需要去判断是否需要扩容
    if (check >= 0) {
        // 一堆小变量
        Node<K,V>[] tab, nt; int n, sc;
        // 当前元素个数是否大于扩容阈值，并且数组不为null，数组长度没有达到最大值。
        while (s >= (long)(sc = sizeCtl) && (tab = table) != null &&
               (n = tab.length) < MAXIMUM_CAPACITY) {
            // 扩容表示戳
            int rs = resizeStamp(n);
            // 正在扩容
            if (sc < 0) {
                // 判断是否可以协助扩容
                if ((sc >>> RESIZE_STAMP_SHIFT) != rs || sc == rs + 1 ||
                    sc == rs + MAX_RESIZERS || (nt = nextTable) == null ||
                    transferIndex <= 0)
                    break;
                // 协助扩容
                if (U.compareAndSwapInt(this, SIZECTL, sc, sc + 1))
                    transfer(tab, nt);
            }
            // 没有线程执行扩容，我来扩容
            else if (U.compareAndSwapInt(this, SIZECTL, sc,
                                         (rs << RESIZE_STAMP_SHIFT) + 2))
                transfer(tab, null);
            // 重新计数。
            s = sumCount();
        }
    }
}


//  CounterCell的类，就类似于LongAdder的Cell
@sun.misc.Contended static final class CounterCell {
    // volatile修饰的value，并且外部基于CAS的方式修改
    volatile long value;
    CounterCell(long x) { value = x; }
}
@sun.misc.Contended（JDK1.8）：
这个注解是为了解决伪共享的问题（解决缓存行同步带来的性能问题）。
CPU在操作主内存变量前，会将主内存数据缓存到CPU缓存（L1,L2,L3）中，
CPU缓存L1，是以缓存行为单位存储数据的，一般默认的大小为64字节。
缓存行同步操作，影响CPU一定的性能。
@Contented注解，会将当前类中的属性，会独占一个缓存行，从而避免缓存行失效造成的性能问题。
@Contented注解，就是将一个缓存行的后面7个位置，填充上7个没有意义的数据。
long value;    long l1,l2,l3,l4,l5,l6,l7;


// 整体CounterCell数组数据到baseCount
final long sumCount() {
    // 拿到CounterCell[]
    CounterCell[] as = counterCells; CounterCell a;
    // 拿到baseCount
    long sum = baseCount;
    // 循环走你，遍历CounterCell[]，将值累加到sum中，最终返回sum
    if (as != null) {
        for (int i = 0; i < as.length; ++i) {
            if ((a = as[i]) != null)
                sum += a.value;
        }
    }
    return sum;
}


// CounterCell数组没有初始化
// CounterCell对象没有构建
// 什么都有，但是有并发问题，导致CAS失败
private final void fullAddCount(long x, boolean wasUncontended) {
    // h：当前线程的随机数
    int h;
    // 判断当前线程的Probe是否初始化。
    if ((h = ThreadLocalRandom.getProbe()) == 0) {
        // 初始化一波
        ThreadLocalRandom.localInit();  
        // 生成随机数。
        h = ThreadLocalRandom.getProbe();
        // 标记，没有冲突
        wasUncontended = true;
    }
    // 阿巴阿巴
    boolean collide = false;   
    // 死循环…………   
    for (;;) {
        // as：CounterCell[]
        // a：CounterCell对 null
        // n：数组长度
        // v：value值
        CounterCell[] as; CounterCell a; int n; long v;
        // CounterCell[]不为null时，做CAS操作
        if ((as = counterCells) != null && (n = as.length) > 0) {
            // 拿到当前线程随机数对应的CounterCell对象，为null
            // 第一个if：当前数组已经初始化，但是指定索引位置没有CounterCell对象，构建CounterCell对象放到数组上
            if ((a = as[h & (n - 1)]) == null) {
                // 判断cellsBusy是否为0，
                if (cellsBusy == 0) {  
                    // 构建CounterCell对象
                    CounterCell r = new CounterCell(x); 
                    // 在此判断cellsBusy为0，CAS从0修改为1，代表可以操作当前数组上的指定索引，构建CounterCell，赋值进去
                    if (cellsBusy == 0 &&
                        U.compareAndSwapInt(this, CELLSBUSY, 0, 1)) {
                        // 构建未完成
                        boolean created = false;
                        try {   
                            // 阿巴阿巴 
                            CounterCell[] rs; int m, j;
                            // DCL，还包含复制
                            if ((rs = counterCells) != null && (m = rs.length) > 0 &&
                                // 再次拿到指定索引位置的值，如果为null，正常将前面构建的CounterCell对象，赋值给数组
                                rs[j = (m - 1) & h] == null) {
                                // 将CounterCell对象赋值到数组
                                rs[j] = r;
                                // 构建完成
                                created = true;
                            }
                        } finally {
                            // 归位
                            cellsBusy = 0;
                        }
                        if (created)
                            // 跳出循环，告辞
                            break;
                        continue;           // Slot is now non-empty
                    }
                }
                collide = false;
            }
            // 指定索引位置上有CounterCell对象，有冲突，修改冲突标识
            else if (!wasUncontended)   
                wasUncontended = true;
            // CAS，将数组上存在的CounterCell对象的value进行 + 1操作
            else if (U.compareAndSwapLong(a, CELLVALUE, v = a.value, v + x))
                // 成功，告辞。
                break;
            // 之前拿到的数组引用和成员变量的引用值不一样了，
            // CounterCell数组的长度是都大于CPU内核数，不让CounterCell数组长度大于CPU内核数。
            else if (counterCells != as || n >= NCPU)
                // 当前线程的循环失败，不进行扩容
                collide = false;   
            // 如果没并发问题，并且可以扩容，设置标示位，下次扩容   
            else if (!collide)
                collide = true;
            // 扩容操作
            // 先判断cellsBusy为0，再基于CAS将cellsBusy从0修改为1。
            else if (cellsBusy == 0 &&
                     U.compareAndSwapInt(this, CELLSBUSY, 0, 1)) {
                try {
                    // DCL!
                    if (counterCells == as) {
                        // 构建一个原来长度2倍的数组
                        CounterCell[] rs = new CounterCell[n << 1];
                        // 将老数组数据迁移到新数组
                        for (int i = 0; i < n; ++i)
                            rs[i] = as[i];
                        // 新数组复制给成员变量
                        counterCells = rs;
                    }
                } finally {
                    // 归位
                    cellsBusy = 0;
                }
                // 归位
                collide = false;
                // 开启下次循环
                continue;  
            }
            // 重新设置当前线程的随机数，争取下次循环成功！
            h = ThreadLocalRandom.advanceProbe(h);
        }
        // CounterCell[]没有初始化
        // 判断cellsBusy为0.代表没有其他线程在初始化或者扩容当前CounterCell[]
        // 判断counterCells还是之前赋值的as，代表没有并发问题
        else if (cellsBusy == 0 && counterCells == as &&
            // 修改cellsBusy，从0改为1，代表当前线程要开始初始化了
            U.compareAndSwapInt(this, CELLSBUSY, 0, 1)) {
            // 标识，init未成功
            boolean init = false;
            try {   
                // DCL!  
                if (counterCells == as) {
                    // 构建CounterCell[]，默认长度为2
                    CounterCell[] rs = new CounterCell[2];
                    // 用当前线程的随机数，和数组长度 - 1，进行&运算，将这个位置上构建一个CounterCell对象，赋值value为1
                    rs[h & 1] = new CounterCell(x);
                    // 将声明好的rs，赋值给成员变量
                    counterCells = rs;
                    // init成功
                    init = true;
                }
            } finally {
                // cellsBusy归位。
                cellsBusy = 0;
            }
            if (init)
                // 退出循环
                break;
        }
        // 到这就直接在此操作baseCount。
        else if (U.compareAndSwapLong(this, BASECOUNT, v = baseCount, v + x))
            break;                          // Fall back on using base
    }
}
```

##### 1.7.2 size方法方法分析

size获取ConcurrentHashMap中的元素个数

```java
public int size() {
    // 基于sumCount方法获取元素个数
    long n = sumCount();
    // 做了一些简单的健壮性判断
    return ((n < 0L) ? 0 :
            (n > (long)Integer.MAX_VALUE) ? Integer.MAX_VALUE :
            (int)n);
}

// 整体CounterCell数组数据到baseCount
final long sumCount() {
    // 拿到CounterCell[]
    CounterCell[] as = counterCells; CounterCell a;
    // 拿到baseCount
    long sum = baseCount;
    // 循环走你，遍历CounterCell[]，将值累加到sum中，最终返回sum
    if (as != null) {
        for (int i = 0; i < as.length; ++i) {
            if ((a = as[i]) != null)
                sum += a.value;
        }
    }
    return sum;
}
```


### JDK1.7的HashMap的环形链表

分析扩容的核心代码

```java
// 构建新数组
Entry[] newTable = new Entry[newCapacity];
// 迁移老数组数据到新数组
transfer(newTable, initHashSeedAsNeeded(newCapacity));
// 迁移完毕后，替换老数组
table = newTable;

// 迁移数据的过程
void transfer(Entry[] newTable, boolean rehash) {
    // 省略部分代码
    // 外层遍历数组
    for (Entry<K,V> e : table) {
        // 遍历链表
        // 2号线程走完第二次循环，完成迁移数据（步骤二图）
        // 1号线程走完第二次循环，发现指向的是A（步骤三图）
        // 1号线程走完第三次循环，完成迁移数据（步骤四图）
        while(null != e) {
            Entry<K,V> next = e.next;
            // 1号线程执行到这，停止（步骤一图）
            // 省略部分代码
            e.next = newTable[i];
            newTable[i] = e;
            e = next;
        }
    }
}
// 唤醒链表的发生，是因为并发扩容，加上头插法导致的。
// 在JDK1.8中，头插法被替代，换成了尾插法
```

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1676383299003/9da1a7794f494abc9f5b13fdc8ac84c2.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1676383299003/21e15e115ca54228a0075a8959e4de9c.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1676383299003/bc9a0917bff44189a213d596d802f26b.png)

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1676383299003/571fe4338d2249919860c22232caf279.png)

如果面试被问到了：

因为JDK1.7中的HashMap是线程不安全的，可能会出现并发扩容的操作。

同时JDK1.7中的HashMap在迁移数据时，采用的是头插法，导致节点的next指针会有变化。

先迁移完的线程，可能会导致其他线程在扩容时，扩容到最后，将最开始的节点重新的插入到了头节点的位置，导致指针再次变化，从而形成了一个环形链表。

### **二、CopyOnWriteArrayList**

#### 2.1 CopyOnWriteArrayList介绍

CopyOnWriteArrayList是一个线程安全的ArrayList。

CopyOnWriteArrayList是基于lock锁和数组副本的形式去保证线程安全。

在写数据时，需要先获取lock锁，需要复制一个副本数组，将数据插入到副本数组中，将副本数组赋值给CopyOnWriteArrayList中的array。

因为CopyOnWriteArrayList每次写数据都要构建一个副本，如果你的业务是写多，并且数组中的数据量比较大，尽量避免去使用CopyOnWriteArrayList，因为这里会构建大量的数组副本，比较占用内存资源。

CopyOnWriteArrayList是弱一致性的，写操作先执行，但是副本还有落到CopyOnWriteArrayList的array属性中，此时读操作是无法查询到的。

#### 2.2 核心属性&方法

主要查看2个核心属性，以及2个核心方法，还有无参构造

```java
/** 写操作时，需要先获取到的锁资源，CopyOnWriteArrayList全局唯一的。 */
final transient ReentrantLock lock = new ReentrantLock();

/** CopyOnWriteArrayList真实存放数据的位置，查询也是查询当前array */
private transient volatile Object[] array;

// 获取array属性
final Object[] getArray() {
    return array;
}

// 替换array属性
final void setArray(Object[] a) {
    array = a;
}

/**
 *  默认new的CopyOnWriteArrayList数组长度为0。
 *  不像ArrayList，初始长度是10，每次扩容1/2, CopyOnWriteArrayList不存在这个概念
 *  每次写的时候都会构建一个新的数组
 */
public CopyOnWriteArrayList() {
    setArray(new Object[0]);
}
```

#### 2.3 读操作

CopyOnWriteArrayList的读操作就是get方法，基于数组索引位置获取数据。

方法之所以要差分成两个，是因为CopyOnWriteArrayList中在获取数据时，不单单只有一个array的数组需要获取值，还有副本中数据的值。

```java
// 查询数据时，只能通过get方法查询CopyOnWriteArrayList中的数据
public E get(int index) {
    // getArray拿到array数组，调用get方法的重载
    return get(getArray(), index);
}
// 执行get(int)时，内部调用的方法
private E get(Object[] a, int index) {
    // 直接拿到数组上指定索引位置的值
    return (E) a[index];
}
```

#### 2.4 写操作

CopyOnWriteArrayList是基于lock锁和副本数组的形式保证线程安全。

```java
// 写入元素，不指定索引位置，直接放到最后的位置
public boolean add(E e) {
    // 获取全局锁，并执行lock
    final ReentrantLock lock = this.lock;
    lock.lock();
    try {
        // 获取原数组，还获取了原数组的长度
        Object[] elements = getArray();
        int len = elements.length;
        // 基于原数组复制一份副本数组，并且长度比原来多了一个
        Object[] newElements = Arrays.copyOf(elements, len + 1);
        // 将添加的数据放到副本数组最后一个位置
        newElements[len] = e;
        // 将副本数组，赋值给CopyOnWriteArrayList的原数组
        setArray(newElements);
        // 添加成功，返回true
        return true;
    } finally {
        // 释放锁~
        lock.unlock();
    }
}

// 写入元素，指定索引位置。（不会覆盖数据）
public void add(int index, E element) {
    // 拿锁，加锁~
    final ReentrantLock lock = this.lock;
    lock.lock();
    try {
        // 获取原数组，还获取了原数组的长度
        Object[] elements = getArray();
        int len = elements.length;
        // 如果索引位置大于原数组的长度，或者索引位置是小于0的。
        if (index > len || index < 0)
            throw new IndexOutOfBoundsException("Index: "+index+
                                                ", Size: "+len);
        // 声明了副本数组
        Object[] newElements;
        // 原数组长度 - 索引位置等到numMoved
        int numMoved = len - index;
        // 如果numMoved为0，说明数据要放到最后面的位置
        if (numMoved == 0)
            // 直接走了原生态的方式，正常复制一份副本数组
            newElements = Arrays.copyOf(elements, len + 1);
        else {
            // 数组要插入的位置不是最后一个位置
            // 副本数组长度依然是原长度 + 1
            newElements = new Object[len + 1];
            // 将原数组从0索引位置开始复制，复制到副本数组中的前置位置
            System.arraycopy(elements, 0, newElements, 0, index);
            // 将原数组从index位置开始复制，复制到副本数组的index + 1往后放。
            // 这时，index就空缺出来了。
            System.arraycopy(elements, index, newElements, index + 1,
                             numMoved);
        }
        // 数据正常放到指定的索引位置
        newElements[index] = element;
        // 将副本数组，赋值给CopyOnWriteArrayList的原数组
        setArray(newElements);
    } finally {
        // 释放锁
        lock.unlock();
    }
}
```

#### 2.5 移除数据

关于remove操作，要分析两个方法

* 基于索引位置移除指定数据
* 基于具体元素删除数组中最靠前的数据
  * 当前这种方式，嵌套了一层，导致如果元素存在话，成本是比较高的。
  * 如果元素不存在，这种设计不需要加锁，提升写的效率

```java
// 删除指定索引位置的数据
public E remove(int index) {
    // 拿锁，加锁
    final ReentrantLock lock = this.lock;
    lock.lock();
    try {
        // 获取原数组和原数组长度
        Object[] elements = getArray();
        int len = elements.length;
        // 通过get方法拿到index位置的数据
        E oldValue = get(elements, index);
        // 声明numMoved
        int numMoved = len - index - 1;
        // 如果numMoved为0，说明删除的元素是最后的位置
        if (numMoved == 0)
            // Arrays.copyOf复制一份新的副本数组，并且将最后一个数据不要了
            // 基于setArray将副本数组赋值给array原数组
            setArray(Arrays.copyOf(elements, len - 1));
        else {
            // 删除的元素不在最后面的位置
            // 声明副本数组，长度是原数组长度 - 1
            Object[] newElements = new Object[len - 1];
            // 从0开始复制的index前面
            System.arraycopy(elements, 0, newElements, 0, index);
            // 从index后面复制到最后
            System.arraycopy(elements, index + 1, newElements, index,
                             numMoved);
            setArray(newElements);
        }
        // 返回被干掉的数据
        return oldValue;
    } finally {
        // 释放锁
        lock.unlock();
    }
}

// 删除元素（最前面的）
public boolean remove(Object o) {
    // 没加锁！！！！
    // 获取原数组
    Object[] snapshot = getArray();
    // 用indexOf获取元素在数组的哪个索引位置
    // 没找到的话，返回-1
    int index = indexOf(o, snapshot, 0, snapshot.length);
    // 如果index < 0,说明元素没找到，直接返回false，告辞
    // 如果找到了元素的位置，直接执行remove方法的重载
    return (index < 0) ? false : remove(o, snapshot, index);
}
// 执行remove(Object o)，找到元素位置时，执行当前方法
private boolean remove(Object o, Object[] snapshot, int index) {
    // 拿锁，加锁
    final ReentrantLock lock = this.lock;
    lock.lock();
    try {
        // 拿到原数组和长度
        Object[] current = getArray();
        int len = current.length;
        // findIndex: 是给if起标识，break 标识的时候，直接跳出if的代码块~~
        if (snapshot != current) findIndex: {
            // 如果没进到if，说明数组没变化，按照原来的index位置删除即可
            // 进到这，说明数组有变化，之前的索引位置不一定对
            // 拿到index位置和原数组长度的值
            int prefix = Math.min(index, len);
            // 循环判断，数组变更后，是否影响到了要删除元素的位置
            for (int i = 0; i < prefix; i++) {
                // 如果不相等，说明元素变化了。
                // 同时判断变化的元素是否是我要删除的元素o
                if (current[i] != snapshot[i] && eq(o, current[i])) {
                    // 如果满足条件，说明当前位置就是我要删除的元素
                    index = i;
                    break findIndex;
                }
            }
            // 如果for循环结束，没有退出if，说明元素可能变化了，总之没找到要删除的元素
            // 如果删除元素的位置，已经大于等于数组长度了。
            if (index >= len)
                // 超过索引范围了，没法删除了。
                return false;
            // 索引还在范围内，判断是否是还是原位置，如果是，直接跳出if代码块
            if (current[index] == o)
                break findIndex;
            // 重新找元素在数组中的位置
            index = indexOf(o, current, index, len);
            // 找到直接跳出if代码块
            // 没找到。执行下面的return false
            if (index < 0)
                return false;
        }
        // 删除套路，构建新数组，复制index前的，复制index后的
        Object[] newElements = new Object[len - 1];
        System.arraycopy(current, 0, newElements, 0, index);
        System.arraycopy(current, index + 1,
                         newElements, index,
                         len - index - 1);
        // 复制到array
        setArray(newElements);
        // 返回true，删除成功
        return true;
    } finally {
        lock.unlock();
    }
}
```

#### 2.6 覆盖数据&清空集合

覆盖数据就是set方法，可以将指定位置的数据替换

```java
// 覆盖数据
public E set(int index, E element) {
    // 拿锁，加锁
    final ReentrantLock lock = this.lock;
    lock.lock();
    try {
        // 获取原数组
        Object[] elements = getArray();
        // 获取原数组的原位置数据
        E oldValue = get(elements, index);

        // 原数据和新数据不一样
        if (oldValue != element) {
            // 拿到原数据的长度，复制一份副本。
            int len = elements.length;
            Object[] newElements = Arrays.copyOf(elements, len);
            // 将element替换掉副本数组中的数据
            newElements[index] = element;
            // 写回原数组
            setArray(newElements);
        } else {
            // 原数据和新数据一样，啥不干，把拿出来的数组再写回去
            setArray(elements);
        }
        // 返回原值
        return oldValue;
    } finally {
        // 释放锁
        lock.unlock();
    }
}
```

清空就是清空了~~~

```java
public void clear() {
	// 加锁
    final ReentrantLock lock = this.lock;
    lock.lock();
    try {
		// 扔一个长度为0的数组
        setArray(new Object[0]);
    } finally {
        lock.unlock();
    }
}
```

#### 2.7 迭代器

用ArrayList时，如果想在遍历的过程中去移除或者修改元素，必须使用迭代器才可以。

但是CopyOnWriteArrayList这哥们即便用了迭代器也不让做写操作

不让在迭代时做写操作是因为不希望迭代操作时，会影响到写操作，还有，不希望迭代时，还需要加锁。

```
// 获取遍历CopyOnWriteArrayList的iterator。
public Iterator<E> iterator() {
    // 其实就是new了一个COWIterator对象，并且获取了array，指定从0开始遍历
    return new COWIterator<E>(getArray(), 0);
}

static final class COWIterator<E> implements ListIterator<E> {
    /** 遍历的快照 */
    private final Object[] snapshot;
    /** 游标，索引~~~ */
    private int cursor;

    // 有参构造
    private COWIterator(Object[] elements, int initialCursor) {
        cursor = initialCursor;
        snapshot = elements;
    }

    // 有没有下一个元素，基于遍历的索引位置和数组长度查看
    public boolean hasNext() {
        return cursor < snapshot.length;
    }
    // 有没有上一个元素
    public boolean hasPrevious() {
        return cursor > 0;
    }

    // 获取下一个值，游标动一下
    public E next() {
        // 确保下个位置有数据
        if (! hasNext())
            throw new NoSuchElementException();
        return (E) snapshot[cursor++];
    }

    // 获取上一个值，游标往上移动
    public E previous() {
        if (! hasPrevious())
            throw new NoSuchElementException();
        return (E) snapshot[--cursor];
    }

    // 拿到下一个值的索引，返回游标
    public int nextIndex() {
        return cursor;
    }

    // 拿到上一个值的索引，返回游标
    public int previousIndex() {
        return cursor-1;
    }

    // 写操作全面禁止！！
    public void remove() {
        throw new UnsupportedOperationException();
    }

  
    public void set(E e) {
        throw new UnsupportedOperationException();
    }

  
    public void add(E e) {
        throw new UnsupportedOperationException();
    }

    // 兼容函数式编程
    @Override
    public void forEachRemaining(Consumer<? super E> action) {
        Objects.requireNonNull(action);
        Object[] elements = snapshot;
        final int size = elements.length;
        for (int i = cursor; i < size; i++) {
            @SuppressWarnings("unchecked") E e = (E) elements[i];
            action.accept(e);
        }
        cursor = size;
    }
}
```





## **JUC并发工具**

### 一、**CountDownLatch应用&源码分析**

#### 1.1 CountDownLatch介绍

CountDownLatch就是JUC包下的一个工具，整个工具最核心的功能就是计数器。

如果有三个业务需要并行处理，并且需要知道三个业务全部都处理完毕了。

需要一个并发安全的计数器来操作。

CountDownLatch就可以实现。

给CountDownLatch设置一个数值。可以设置3。

每个业务处理完毕之后，执行一次countDown方法，指定的3每次在执行countDown方法时，对3进行-1。

主线程可以在业务处理时，执行await，主线程会阻塞等待任务处理完毕。

当设置的3基于countDown方法减为0之后，主线程就会被唤醒，继续处理后续业务。

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1663750769045/5e182afaacbb4085985c59b062e86380.png)

当咱们的业务中，出现2个以上允许并行处理的任务，并且需要在任务都处理完毕后，再做其他处理时，可以采用CountDownLatch去实现这个功能。

#### 1.2 CountDownLatch应用

模拟有三个任务需要并行处理，在三个任务全部处理完毕后，再执行后续操作

CountDownLatch中，执行countDown方法，代表一个任务结束，对计数器 - 1

执行await方法，代表等待计数器变为0时，再继续执行

执行await(time,unit)方法，代表等待time时长，如果计数器不为0，返回false，如果在等待期间，计数器为0，方法就返回true

一般CountDownLatch更多的是基于业务去构建，不采用成员变量。

```java
static ThreadPoolExecutor executor = (ThreadPoolExecutor) Executors.newFixedThreadPool(3);

static CountDownLatch countDownLatch = new CountDownLatch(3);

public static void main(String[] args) throws InterruptedException {
    System.out.println("主业务开始执行");
    sleep(1000);
    executor.execute(CompanyTest::a);
    executor.execute(CompanyTest::b);
    executor.execute(CompanyTest::c);
    System.out.println("三个任务并行执行,主业务线程等待");
    // 死等任务结束
    // countDownLatch.await();
    // 如果在规定时间内，任务没有结束，返回false
    if (countDownLatch.await(10, TimeUnit.SECONDS)) {
        System.out.println("三个任务处理完毕，主业务线程继续执行");
    }else{
        System.out.println("三个任务没有全部处理完毕，执行其他的操作");
    }
}

private static void a() {
    System.out.println("A任务开始");
    sleep(1000);
    System.out.println("A任务结束");
    countDownLatch.countDown();
}
private static void b() {
    System.out.println("B任务开始");
    sleep(1500);
    System.out.println("B任务结束");
    countDownLatch.countDown();
}
private static void c() {
    System.out.println("C任务开始");
    sleep(2000);
    System.out.println("C任务结束");
    countDownLatch.countDown();
}

private static void sleep(long timeout){
    try {
        Thread.sleep(timeout);
    } catch (InterruptedException e) {
        e.printStackTrace();
    }
}
```

#### 1.3 CountDownLatch源码分析

保证CountDownLatch就是一个计数器，没有什么特殊的功能，查看源码也只是查看计数器实现的方式

发现CountDownLatch的内部类Sync继承了AQS，CountDownLatch就是基于AQS实现的计数器。

AQS就是一个state属性，以及AQS双向链表

猜测计数器的数值实现就是基于state去玩的。

主线程阻塞的方式，也是阻塞在了AQS双向链表中。

##### 1.3.1 有参构造

就是构建内部类Sync，并且给AQS中的state赋值

```java
// CountDownLatch的有参构造
public CountDownLatch(int count) {
    // 健壮性校验
    if (count < 0) throw new IllegalArgumentException("count < 0");
    // 构建内部类，Sync传入count
    this.sync = new Sync(count);
}

// AQS子类，Sync的有参构造
Sync(int count) {
    // 就是给AQS中的state赋值
    setState(count);
}
```

##### 1.3.2 await方法

await方法就时判断当前CountDownLatch中的state是否为0，如果为0，直接正常执行后续任务

如果不为0，以共享锁的方式，插入到AQS的双向链表，并且挂起线程

```java
// 一般主线程await的方法，阻塞主线程，等待state为0
public void await() throws InterruptedException {
    sync.acquireSharedInterruptibly(1);
}

// 执行了AQS的acquireSharedInterruptibly方法
public final void acquireSharedInterruptibly(int arg) throws InterruptedException {
    // 判断线程是否中断，如果中断标记位是true，直接抛出异常
    if (Thread.interrupted())
        throw new InterruptedException();
    if (tryAcquireShared(arg) < 0)
        // 共享锁挂起的操作
        doAcquireSharedInterruptibly(arg);
}

// tryAcquireShared在CountDownLatch中的实现
protected int tryAcquireShared(int acquires) {
    // 查看state是否为0，如果为0，返回1，不为0，返回-1
    return (getState() == 0) ? 1 : -1;
}

private void doAcquireSharedInterruptibly(int arg) throws InterruptedException {
    // 封装当前先成为Node，属性为共享锁
    final Node node = addWaiter(Node.SHARED);
    boolean failed = true;
    try {
        for (;;) {
            final Node p = node.predecessor();
            if (p == head) {
                int r = tryAcquireShared(arg);
                if (r >= 0) {
                    setHeadAndPropagate(node, r);
                    p.next = null; // help GC
                    failed = false;
                    return;
                }
            }
            // 在这，就需要挂起当前线程。
            if (shouldParkAfterFailedAcquire(p, node) &&
                parkAndCheckInterrupt())
                throw new InterruptedException();
        }
    } finally {
        if (failed)
            cancelAcquire(node);
    }
}
```

##### 1.3.3 countDown方法

countDown方法本质就是对state - 1，如果state - 1后变为0，需要去AQS的链表中唤醒挂起的节点

```java
// countDown对计数器-1
public void countDown() {
    // 是-1。
    sync.releaseShared(1);
}

// AQS提供的功能
public final boolean releaseShared(int arg) {
    // 对state - 1
    if (tryReleaseShared(arg)) {
        // state - 1后，变为0，执行doReleaseShared
        doReleaseShared();
        return true;
    }
    return false;
}
// CountDownLatch的tryReleaseShared实现
protected boolean tryReleaseShared(int releases) {
    // 死循环是为了避免CAS并发问题
    for (;;) {
        // 获取state
        int c = getState();
        // state已经为0，直接返回false
        if (c == 0)
            return false;
        // 对获取到的state - 1
        int nextc = c-1;
        // 基于CAS的方式，将值赋值给state
        if (compareAndSetState(c, nextc))
            // 赋值完，发现state为0了。此时可能会有线程在await方法处挂起，那边挂起，需要这边唤醒
            return nextc == 0;
    }
}

// 如何唤醒在await方法处挂起的线程
private void doReleaseShared() {
    // 死循环
    for (;;) {
        // 拿到head
        Node h = head;
        // head不为null，有值，并且head != tail，代表至少2个节点
        // 一个虚拟的head，加上一个实质性的Node
        if (h != null && h != tail) {
            // 说明AQS队列中有节点
            int ws = h.waitStatus;
            // 如果head节点的状态为 -1.
            if (ws == Node.SIGNAL) {
                // 先对head节点将状态从-1，修改为0，避免重复唤醒的情况
                if (!compareAndSetWaitStatus(h, Node.SIGNAL, 0))
                    continue;  
                // 正常唤醒节点即可，先看head.next,能唤醒就唤醒，如果head.next有问题，从后往前找有效节点
                unparkSuccessor(h);
            }
            // 会在Semaphore中谈到这个位置
            else if (ws == 0 &&
                     !compareAndSetWaitStatus(h, 0, Node.PROPAGATE))
                continue;  
        }
        // 会在Semaphore中谈到这个位置
        if (h == head)  
            break;
    }
}
```

### 二、**CyclicBarrier应用&源码分析**

#### 2.1 CyclicBarrier介绍

从名字上来看CyclicBarrier，就是代表循环屏障

Barrier屏障：让一个或多个线程达到一个屏障点，会被阻塞。屏障点会有一个数值，当达到一个线程阻塞在屏障点时，就会对屏障点的数值进行-1操作，当屏障点数值减为0时，屏障就会打开，唤醒所有阻塞在屏障点的线程。在释放屏障点之后，可以先执行一个任务，再让所有阻塞被唤醒的线程继续之后后续任务。

Cyclic循环：所有线程被释放后，屏障点的数值可以再次被重置。

CyclicBarrier一般被称为栅栏。

CyclicBarrier是一种同步机制，允许一组线程互相等待。现成的达到屏障点其实是基于await方法在屏障点阻塞。

CyclicBarrier并没有基于AQS实现，他是基于ReentrantLock锁的机制去实现了对屏障点--，以及线程挂起的操作。（CountDownLatch本身是基于AQS，对state进行release操作后，可以-1）

CyclicBarrier没来一个线程执行await，都会对屏障数值进行-1操作，每次-1后，立即查看数值是否为0，如果为0，直接唤醒所有的互相等待线程。

**CyclicBarrier对比CountDownLatch区别**

* 底层实现不同。CyclicBarrier基于ReentrantLock做的。CountDownLatch直接基于AQS做的。
* 应用场景不同。CountDownLatch的计数器只能使用一次。而CyclicBarrier在计数器达到0之后，可以重置计数器。CyclicBarrier可以实现相比CountDownLatch更复杂的业务，执行业务时出现了错误，可以重置CyclicBarrier计数器，再次执行一次。
* CyclicBarrier还提供了很多其他的功能：
  * 可以获取到阻塞的现成有多少
  * 在线程互相等待时，如果有等待的线程中断，可以抛出异常，避免无限等待的问题。
* CountDownLatch一般是让主线程等待，让子线程对计数器--。CyclicBarrier更多的让子线程也一起计数和等待，等待的线程达到数值后，再统一唤醒

CyclicBarrier：多个线程互相等待，直到到达同一个同步点，再一次执行。

#### 2.2 CyclicBarrier应用

出国旅游。

导游小姐姐需要等待所有乘客都到位后，发送护照，签证等等文件，再一起出发

比如Tom，Jack，Rose三个人组个团出门旅游

在构建CyclicBarrier可以指定barrierAction，可以选择性指定，如果指定了，那么会在barrier归0后，优先执行barrierAction任务，然后再去唤醒所有阻塞挂起的线程，并行去处理后续任务。

所有互相等待的线程，可以指定等待时间，并且在等待的过程中，如果有线程中断，所有互相的等待的线程都会被唤醒。

如果在等待期间，有线程中断了，唤醒所有线程后，CyclicBarrier无法继续使用。

如果线程中断后，需要继续使用当前的CyclicBarrier，需要调用reset方法，让CyclicBarrier重置。

---

如果CyclicBarrier的屏障数值到达0之后，他默认会重置屏障数值，CyclicBarrier在没有线程中断时，是可以重复使用的。

```java
public static void main(String[] args) throws InterruptedException {
    CyclicBarrier barrier = new CyclicBarrier(3,() -> {
        System.out.println("等到各位大佬都到位之后，分发护照和签证等内容！");
    });

    new Thread(() -> {
        System.out.println("Tom到位！！！");
        try {
            barrier.await();
        } catch (Exception e) {
            System.out.println("悲剧，人没到齐！");
            return;
        }
        System.out.println("Tom出发！！！");
    }).start();
    Thread.sleep(100);
    new Thread(() -> {
        System.out.println("Jack到位！！！");
        try {
            barrier.await();
        } catch (Exception e) {
            System.out.println("悲剧，人没到齐！");
            return;
        }
        System.out.println("Jack出发！！！");
    }).start();
    Thread.sleep(100);
    new Thread(() -> {
        System.out.println("Rose到位！！！");
        try {
            barrier.await();
        } catch (Exception e) {
            System.out.println("悲剧，人没到齐！");
            return;
        }
        System.out.println("Rose出发！！！");
    }).start();
    /*
    tom到位，jack到位，rose到位
    导游发签证
    tom出发，jack出发，rose出发
     */

}
```

#### 2.3 CyclicBarrier源码分析

分成两块内容去查看，首先查看CyclicBarrier的一些核心属性，然后再查看CyclicBarrier的核心方法

##### 2.3.1 CyclicBarrier的核心属性

```java
public class CyclicBarrier {
   // 这个静态内部类是用来标记是否中断的
    private static class Generation {
        boolean broken = false;
    }

    /** CyclicBarrier是基于ReentrantLock实现的互斥操作，以及计数原子性操作 */
    private final ReentrantLock lock = new ReentrantLock();
    /** 基于当前的Condition实现线程的挂起和唤醒 */
    private final Condition trip = lock.newCondition();
    /** 记录有参构造传入的屏障数值，不会对这个数值做操作 */
    private final int parties;
    /** 当屏障数值达到0之后，优先执行当前任务  */
    private final Runnable barrierCommand;
    /** 初始化默认的Generation，用来标记线程中断情况 */
    private Generation generation = new Generation();
    /** 每来一个线程等待，就对count进行-- */
    private int count;
}
```

##### 2.3.2 CyclicBarrier的有参构造

掌握构建CyclicBarrier之后，内部属性的情况

```java
// 这个是CyclicBarrier的有参构造
// 在内部传入了parties，屏障点的数值
// 还传入了barrierAction，屏障点的数值达到0，优先执行barrierAction任务
public CyclicBarrier(int parties, Runnable barrierAction) {
    // 健壮性判
    if (parties <= 0) throw new IllegalArgumentException();
    // 当前类中的属性parties是保存屏障点数值的
    this.parties = parties;
    // 将parties赋值给属性count，每来一个线程，继续count做-1操作。
    this.count = parties;
    // 优先执行的任务
    this.barrierCommand = barrierAction;
}
```

##### 2.3.3 CyclicBarrier中的await方法

在CyclicBarrier中，提供了2个await方法

* 第一个是无参的方式，线程要死等，直屏障点数值为0，或者有线程中断
* 第二个是有参方式，传入等待的时间，要么时间到位了，要不就是直屏障点数值为0，或者有线程中断

无论是哪种await方法，核心都在于内部调用的dowait方法

dowait方法主要包含了线程互相等待的逻辑，以及屏障点数值到达0之后的操作

```
// 包含了线程互相等到的逻辑，以及屏障点数值到达0后的操作
private int dowait(boolean timed, long nanos)throws 
            // 当前新编程中断，抛出这个异常
            InterruptedException, 
            // 其他线程中断，当前线程抛出这个异常
            BrokenBarrierException,
            // await时间到位，抛出这个异常
            TimeoutException {
    // 加锁
    final ReentrantLock lock = this.lock;
    lock.lock();
    try {
        // 拿到Generation对象的引用
        final Generation g = generation;

        // 判断下线程中断了么？如果中断了，直接抛出异常
        if (g.broken)
            throw new BrokenBarrierException();

        // 当前线程中断了么？
        if (Thread.interrupted()) {
            // 做了三个实现，
            // 设置broken为true，将count重置，唤醒其他等待的线程
            breakBarrier();
            // 抛出异常
            throw new InterruptedException();
        }

        // 屏障点做--
        int index = --count;
        // 如果屏障点为0，打开屏障啦！！
        if (index == 0) {  
            // 标记
            boolean ranAction = false;
            try {
                // 拿到有参构造中传递的任务
                final Runnable command = barrierCommand;
                // 任务不为null，优先执行当前任务
                if (command != null)
                    command.run();
                // 上述任务执行没问题，标记位设置为true
                ranAction = true;
                // 执行nextGeneration
                // 唤醒所有线程，重置count，重置generation
                nextGeneration();
                return 0;
            } finally {
                // 如果优先执行的任务出了问题i，就直接抛出异常
                if (!ranAction)
                    breakBarrier();
            }
        }

        // 死循环
        for (;;) {
            try {
                //  如果调用await方法，死等
                if (!timed)
                    trip.await();
                // 如果调用await(time,unit)，基于设置的nans时长决定await的时长
                else if (nanos > 0L)
                    nanos = trip.awaitNanos(nanos);
            } catch (InterruptedException ie) {
                // 到这，说明线程被中断了
                // 查看generation有没有被重置。
                // 并且当前broken为false，需要做线程中断后的操作。
                if (g == generation && ! g.broken) {
                    breakBarrier();
                    throw ie;
                } else {
                    Thread.currentThread().interrupt();
                }
            }
            // 是否是中断唤醒，是就抛异常。
            if (g.broken)
                throw new BrokenBarrierException();
            // 说明被reset了，返回index的数值。或者任务完毕也会被重置
            if (g != generation)
                return index;
            // 指定了等待的时间内，没有等到所有线程都到位
            if (timed && nanos <= 0L) {
                // 中断任务
                breakBarrier();
                // 抛出异常
                throw new TimeoutException();
            }
        }
    } finally {
        lock.unlock();
    }
}
```

### **三、Semaphone应用&源码分析**

#### 3.1 Semaphore介绍

sync，ReentrantLock是互斥锁，保证一个资源同一时间只允许被一个线程访问

Semaphore（信号量）保证1个或多个资源可以被指定数量的线程同时访问

底层实现是基于AQS去做的。

Semaphore底层也是基于AQS的state属性做一个计数器的维护。state的值就代表当前共享资源的个数。如果一个线程需要获取的1或多个资源，直接查看state的标识的资源个数是否足够，如果足够的，直接对state - 1拿到当前资源。如果资源不够，当前线程就需要挂起等待。知道持有资源的线程释放资源后，会归还给Semaphore中的state属性，挂起的线程就可以被唤醒。

Semaphore也分为公平和非公平的概念。

使用场景：连接池对象就可以基础信号量去实现管理。在一些流量控制上，也可以采用信号量去实现。再比如去迪士尼或者是环球影城，每天接受的人流量是固定的，指定一个具体的人流量，可能接受10000人，每有一个人购票后，就对信号量进行--操作，如果信号量已经达到了0，或者是资源不足，此时就不能买票。

#### 3.2 Semaphore应用

以上面环球影城每日人流量为例子去测试一下。

```java
public static void main(String[] args) throws InterruptedException {
    // 今天环球影城还有人个人流量
    Semaphore semaphore = new Semaphore(10);

    new Thread(() -> {
        System.out.println("一家三口要去~~");
        try {
            semaphore.acquire(3);
            System.out.println("一家三口进去了~~~");
            Thread.sleep(10000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }finally {
            System.out.println("一家三口走了~~~");
            semaphore.release(3);
        }
    }).start();

    for (int i = 0; i < 7; i++) {
        int j = i;
        new Thread(() -> {
            System.out.println(j + "大哥来了。");
            try {
                semaphore.acquire();
                System.out.println(j + "大哥进去了~~~");
                Thread.sleep(10000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }finally {
                System.out.println(j + "大哥走了~~~");
                semaphore.release();
            }
        }).start();
    }

    Thread.sleep(10);

    System.out.println("main大哥来了。");
    if (semaphore.tryAcquire()) {
        System.out.println("main大哥进来了。");
    }else{
        System.out.println("资源不够，main大哥进来了。");
    }
    Thread.sleep(10000);

    System.out.println("main大哥又来了。");
    if (semaphore.tryAcquire()) {
        System.out.println("main大哥进来了。");
        semaphore.release();
    }else{
        System.out.println("资源不够，main大哥进来了。");
    }
}
```

其实Semaphore整体就是对构建Semaphore时，指定的资源数的获取和释放操作

获取资源方式：

* acquire()：获取一个资源，没有资源就挂起等待，如果中断，直接抛异常
* acquire(int)：获取指定个数资源，资源不够，或者没有资源就挂起等待，如果中断，直接抛异常
* tryAcquire()：获取一个资源，没有资源返回false，有资源返回true
* tryAcquire(int)：获取指定个数资源，没有资源返回false，有资源返回true
* tryAcquire(time,unit)：获取一个资源，如果没有资源，等待time.unit，如果还没有，就返回false
* tryAcquire(int，time,unit)：获取指定个数资源，如果没有资源，等待time.unit，如果还没有，就返回false
* acquireUninterruptibly()：获取一个资源，没有资源就挂起等待，中断线程不结束，继续等
* acquireUninterruptibly(int)：获取指定个数资源，没有资源就挂起等待，中断线程不结束，继续等

归还资源方式：

* release()：归还一个资源
* release(int)：归还指定个数资源

#### 3.3 Semaphore源码分析

先查看Semaphore的整体结构，然后基于获取资源，以及归还资源的方式去查看源码

##### 3.3.1 Semaphore的整体结构

Semaphore内部有3个静态内类。

首先是向上抽取的Sync

其次还有两个Sync的子类NonFairSync以及FairSync两个静态内部类

Sync内部主要提供了一些公共的方法，并且将有参构造传入的资源个数，直接基于AQS提供的setState方法设置了state属性。

NonFairSync以及FairSync区别就是tryAcquireShared方法的实现是不一样。

##### 3.3.2 Semaphore的非公平的获取资源

在构建Semaphore的时候，如果只设置资源个数，默认情况下是非公平。

如果在构建Semaphore，传入了资源个数以及一个boolean时，可以选择非公平还是公平。

```java
public Semaphore(int permits, boolean fair) {
        sync = fair ? new FairSync(permits) : new NonfairSync(permits);
    }
```

从非公平的acquire方法入手

首先确认默认获取资源数是1个，并且acquire是允许中断线程时，抛出异常的。获取资源的方式，就是直接用state - 需要的资源数，只要资源足够，就CAS的将state做修改。如果没有拿到锁资源，就基于共享锁的方式去将当前线程挂起在AQS双向链表中。如果基于doAcquireSharedInterruptibly拿锁成功，会做一个事情。会执行**setHeadAndPropagate**方法。一会说

```java
// 信号量的获取资源方法（默认获取一个资源）
public void acquire() throws InterruptedException {
    // 跳转到了AQS中提供共享锁的方法
    sync.acquireSharedInterruptibly(1);
}

// AQS提供的
public final void acquireSharedInterruptibly(int arg) throws InterruptedException {
    // 判断线程的中断标记位，如果已经中断，直接抛出异常
    if (Thread.interrupted())
        throw new InterruptedException();
    // 先看非公平的tryAcquireShared实现。
    // tryAcquireShared：
    //     返回小于0，代表获取资源失败，需要排队。
    //     返回大于等于0，代表获取资源成功，直接执行业务代码
    if (tryAcquireShared(arg) < 0)
        doAcquireSharedInterruptibly(arg);
}

// 信号量的非公平获取资源方法
final int nonfairTryAcquireShared(int acquires) {
    // 死循环。
    for (;;) {
        // 获取state的数值，剩余的资源个数
        int available = getState();
        // 剩余的资源个数 - 需要的资源个数
        int remaining = available - acquires;
        // 如果-完后，资源个数小于0，直接返回这个负数
        if (remaining < 0 ||
            // 说明资源足够，基于CAS的方式，将state从原值，改为remaining
            compareAndSetState(available, remaining))
            return remaining;
    }
}
// 获取资源失败，资源不够，当前线程需要挂起等待
private void doAcquireSharedInterruptibly(int arg) throws InterruptedException {
    // 构建Node节点，线程和共享锁标记，并且到AQS双向链表中
    final Node node = addWaiter(Node.SHARED);
    boolean failed = true;
    try {
        for (;;) {
            // 拿到上一个节点
            final Node p = node.predecessor();
            // 如果是head.next，就抢一手
            if (p == head) {
                // 再次基于非公平的方式去获取一次资源
                int r = tryAcquireShared(arg);
                // 到这，说明拿到了锁资源
                if (r >= 0) {
                    setHeadAndPropagate(node, r);
                    p.next = null; 
                    failed = false;
                    return;
                }
            }
            // 如果上面没拿到，或者不是head的next节点，将前继节点的状态改为-1，并挂起当前线程
            if (shouldParkAfterFailedAcquire(p, node) && parkAndCheckInterrupt())
                // 如果线程中断会抛出异常
                throw new InterruptedException();
        }
    } finally {
        if (failed)
            cancelAcquire(node);
    }
}
```

acquire()以及acquire(int)的方式，都是执行acquireSharedInterruptibly方法去尝试获取资源，区别只在于是否传入了需要获取的资源个数。

tryAcquire()以及tryAcquire(int因为这两种方法是直接执行tryAcquire，**只使用非公平的实现**，只有非公平的情况下，才有可能在有线程排队的时候获取到资源

但是tryAcquire(int,time,unit)这种方法是正常走的AQS提供的acquire。因为这个tryAcquire可以排队一会，即便是公平锁也有可能拿到资源。这里的挂起和acquire挂起的区别仅仅是挂起的时间问题。

* acquire是一直挂起直到线程中断，或者线程被唤醒。
* tryAcquire(int,time,unit)是挂起一段时间，直到线程中断，要么线程被唤醒，要么阻塞时间到了

还有acquireUninterruptibly()以及acquireUninterruptibly(int)只是在挂起线程后，不会因为线程的中断而去抛出异常

##### 3.3.3 Semaphore公平实现

公平与非公平只是差了一个方法的实现tryAcquireShared实现

这个方法的实现中，如果是公平实现，需要先查看AQS中排队的情况

```java
// 信号量公平实现
protected int tryAcquireShared(int acquires) {
    // 死循环。
    for (;;) {
        // 公平实现在走下述逻辑前，先判断队列中排队的情况
        // 如果没有排队的节点，直接不走if逻辑
        // 如果有排队的节点，发现当前节点处在head.next位置，直接不走if逻辑
        if (hasQueuedPredecessors())
            return -1;

        // 下面这套逻辑和公平实现是一模一样的。
        int available = getState();
        int remaining = available - acquires;
        if (remaining < 0 ||
            compareAndSetState(available, remaining))
            return remaining;
    }
}
```

##### 3.3.4 Semaphore释放资源

因为信号量从头到尾都是共享锁的实现……

释放资源操作，不区分公平和非公平

```java
// 信号量释放资源的方法入口
public void release() {
    sync.releaseShared(1);
}

// 释放资源不分公平和非公平，都走AQS的releaseShared
public final boolean releaseShared(int arg) {
    // 优先查看tryReleaseShared，这个方法是信号量自行实现的。
    if (tryReleaseShared(arg)) {
        // 只要释放资源成功，执行doReleaseShared，唤醒AQS中排队的线程，去竞争Semaphore的资源
        doReleaseShared();
        return true;
    }
    return false;
}

// 信号量实现的释放资源方法
protected final boolean tryReleaseShared(int releases) {
    // 死循环
    for (;;) {
        // 拿到当前的state
        int current = getState();
        // 将state + 归还的资源个数，新的state要被设置为next
        int next = current + releases;
        // 如果归还后的资源个数，小于之前的资源数。
        // 避免出现归还资源后，导致next为负数，需要做健壮性判断
        if (next < current) 
            throw new Error("Maximum permit count exceeded");
        // CAS操作，保证原子性，只会有一个线程成功的就之前的state修改为next
        if (compareAndSetState(current, next))
            return true;
    }
}
```

#### 3.4 AQS中PROPAGATE节点

为了更好的了解PROPAGATE节点状态的意义，优先从JDK1.5去分析一下释放资源以及排队后获取资源的后置操作

##### 3.4.1 掌握JDK1.5-Semaphore执行流程图

首先查看4个线程获取信号量资源的情况

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1663750769045/ee5b42ed55cb42f0976268401343f274.png)

往下查看释放资源的过程会触发什么问题

首先t1释放资源，做了进一步处理

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1663750769045/bede6f92e21a464a95f81625f0dd3fe2.png)

当线程3获取锁资源后，线程2再次释放资源，因为执行点问题，导致线程4无法被唤醒

##### 3.4.2 分析JDK1.8的变化

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1663750769045/f7093fd73db146658d5f191b5a1a5fe8.png)

```java
====================================JDK1.5实现============================================.
public final boolean releaseShared(int arg) {
    if (tryReleaseShared(arg)) {
        Node h = head;
        if (h != null && h.waitStatus != 0) 
            unparkSuccessor(h);
        return true;
    }
    return false;
}


private void setHeadAndPropagate(Node node, int propagate) {
    setHead(node);
    if (propagate > 0 && node.waitStatus != 0) {
        Node s = node.next; 
        if (s == null || s.isShared())
            unparkSuccessor(node);
    }
}

====================================JDK1.8实现============================================.
public final boolean releaseShared(int arg) {
    if (tryReleaseShared(arg)) {
        doReleaseShared();
        return true;
    }
    return false;
}
private void doReleaseShared() {
    for (;;) {
        // 拿到head节点
        Node h = head;
        // 判断AQS中有排队的Node节点
        if (h != null && h != tail) {
            // 拿到head节点的状态
            int ws = h.waitStatus;
            // 状态为-1
            if (ws == Node.SIGNAL) {
                // 将head节点的状态从-1，改为0
                if (!compareAndSetWaitStatus(h, Node.SIGNAL, 0))
                    continue;  
                // 唤醒后继节点
                unparkSuccessor(h);
            }
            // 发现head状态为0，将head状态从0改为-3，目的是为了往后面传播
            else if (ws == 0 &&
                     !compareAndSetWaitStatus(h, 0, Node.PROPAGATE))
                continue;                // loop on failed CAS
        }
        // 没有并发的时候。head节点没变化，正常完成释放排队的线程
        if (h == head)  
            break;
    }
}

private void setHeadAndPropagate(Node node, int propagate) {
    // 拿到head
    Node h = head; 
    // 将线程3的Node设置为新的head
    setHead(node);
    // 如果propagate 大于0，代表还有剩余资源，直接唤醒后续节点，如果不满足，也需要继续往后判断看下是否需要传播
    // h == null：看成健壮性判断即可
    // 之前的head节点状态为负数，说明并发情况下，可能还有资源，需要继续向后唤醒Node
    // 如果当前新head节点的状态为负数，继续释放后续节点
    if (propagate > 0 || h == null || h.waitStatus < 0 || (h = head) == null || h.waitStatus < 0) {
        // 唤醒当前节点的后继节点
        Node s = node.next;
        if (s == null || s.isShared())
            doReleaseShared();
    }
}
```

## **异步编程**

### 一、**FutureTask应用&源码分析**

#### 1.1 FutureTask介绍

FutureTask是一个可以取消异步任务的类。FutureTask对Future做的一个基本实现。可以调用方法区开始和取消一个任务。

一般是配合Callable去使用。

异步任务启动之后，可以获取一个绑定当前异步任务的FutureTask。

可以基于FutureTask的方法去取消任务，查看任务是否结果，以及获取任务的返回结果。

FutureTask内部的整体结构中，实现了RunnableFuture的接口，这个接口又继承了Runnable, Future这个两个接口。所以FutureTask也可以作为任务直接交给线程池去处理。

#### 1.2 FutureTask应用

大方向是FutureTask对任务的控制：

* 任务执行过程中状态的控制
* 任务执行完毕后，返回结果的获取

FutureTask的任务在执行run方法后，是无法被再次运行，需要使用runAndReset方法才可以。

```java
public static void main(String[] args) throws InterruptedException {
    // 构建FutureTask，基于泛型执行返回结果类型
    // 在有参构造中，声明Callable或者Runnable指定任务
    FutureTask<String> futureTask = new FutureTask<>(() -> {
        System.out.println("任务开始执行……");
        Thread.sleep(2000);
        System.out.println("任务执行完毕……");
        return "OK!";
    });

    // 构建线程池
    ExecutorService service = Executors.newFixedThreadPool(10);

    // 线程池执行任务
    service.execute(futureTask);

    // futureTask提供了run方法，一般不会自己去调用run方法，让线程池去执行任务，由线程池去执行run方法
    // run方法在执行时，是有任务状态的。任务已经执行了，再次调用run方法无效的。
    // 如果希望任务可以反复被执行，需要去调用runAndReset方法
//        futureTask.run();

    // 对返回结果的获取，类似阻塞队列的poll方法
    // 如果在指定时间内，没有拿到方法的返回结果，直接扔TimeoutException
//        try {
//            String s = futureTask.get(3000, TimeUnit.MILLISECONDS);
//            System.out.println("返回结果：" + s);
//        } catch (Exception e) {
//            System.out.println("异常返回：" + e.getMessage());
//            e.printStackTrace();
//        }

    // 对返回结果的获取，类似阻塞队列的take方法，死等结果
//        try {
//            String s = futureTask.get();
//            System.out.println("任务结果：" + s);
//        } catch (ExecutionException e) {
//            e.printStackTrace();
//        }

    // 对任务状态的控制
//        System.out.println("任务结束了么？：" + futureTask.isDone());
//        Thread.sleep(1000);
//        System.out.println("任务结束了么？：" + futureTask.isDone());
//        Thread.sleep(1000);
//        System.out.println("任务结束了么？：" + futureTask.isDone());
}
```

#### 1.3 FutureTask源码分析

看FutureTask的源码，要从几个方向去看：

* 先查看FutureTask中提供的一些状态
* 在查看任务的执行过程

##### 1.3.1 FutureTask中的核心属性

清楚任务的流转流转状态是怎样的，其次对于核心属性要追到是干嘛的。

```java
/**
 FutureTask的核心属性
 FutureTask任务的状态流转
 * NEW -> COMPLETING -> NORMAL           任务正常执行，并且返回结果也正常返回
 * NEW -> COMPLETING -> EXCEPTIONAL      任务正常执行，但是结果是异常
 * NEW -> CANCELLED                      任务被取消   
 * NEW -> INTERRUPTING -> INTERRUPTED    任务被中断
 */
// 记录任务的状态
private volatile int state;
// 任务被构建之后的初始状态
private static final int NEW          = 0;
private static final int COMPLETING   = 1;
private static final int NORMAL       = 2;
private static final int EXCEPTIONAL  = 3;
private static final int CANCELLED    = 4;
private static final int INTERRUPTING = 5;
private static final int INTERRUPTED  = 6;

/** 需要执行任务，会被赋值到这个属性 */
private Callable<V> callable;
/** 任务的任务结果要存储在这几个属性中 */
private Object outcome; // non-volatile, protected by state reads/writes
/** 执行任务的线程 */
private volatile Thread runner;
/** 等待返回结果的线程Node对象， */
private volatile WaitNode waiters;
static final class WaitNode {
    volatile Thread thread;
    volatile WaitNode next;
    WaitNode() { thread = Thread.currentThread(); }
}
```

##### 1.3.2 FutureTask的run方法

任务执行前的一些判断，以及调用任务封装结果的方式，还有最后的一些后续处理

```java
// 当线程池执行FutureTask任务时，会调用的方法
public void run() {
    // 如果当前任务状态不是NEW，直接return告辞
    if (state != NEW ||  
        // 如果状态正确是NEW，这边需要基于CAS将runner属性设置为当前线程
        // 如果CAS失败，直接return告辞
        !UNSAFE.compareAndSwapObject(this, runnerOffset, null, Thread.currentThread()))
        return;

    try {
        // 将要执行的任务拿到
        Callable<V> c = callable;
        // 健壮性判断，保证任务不是null
        // 再次判断任务的状态是NEW（DCL）
        if (c != null && state == NEW) {
            // 执行任务
            // result：任务的返回结果
            // ran：如果为true，任务正常结束。 如果为false，任务异常结束。
            V result;
            boolean ran;
            try {
                // 执行任务
                result = c.call();
                // 正常结果，ran设置为true
                ran = true;
            } catch (Throwable ex) {
                // 如果任务执行期间出了异常
                // 返回结果置位null
                result = null;
                // ran设置为false
                ran = false;
                // 封装异常结果
                setException(ex);
            }
            if (ran)
                // 封装正常结果
                set(result);
        }
    } finally {
        // 将执行任务的线程置位null
        runner = null;
        // 拿到任务的状态
        int s = state;
        // 如果状态大于等于INTERRUPTING
        if (s >= INTERRUPTING)
            // 进来代表任务中断，做一些后续处理
            handlePossibleCancellationInterrupt(s);
    }
}
```

##### 1.3.3 FutureTask的set&setException方法

任务执行完毕后，修改任务的状态以及封装任务的结果

```java
// 没有异常的时候，正常返回结果
protected void set(V v) {
    // 因为任务执行完毕，需要将任务的状态从NEW，修改为COMPLETING
    if (UNSAFE.compareAndSwapInt(this, stateOffset, NEW, COMPLETING)) {
        // 将返回结果赋值给 outcome 属性
        outcome = v;
        // 将任务状态变为NORMAL，正常结束
        UNSAFE.putOrderedInt(this, stateOffset, NORMAL);
        // 一会再说……
        finishCompletion();
    }
}

// 任务执行期间出现了异常，这边要封装结果
protected void setException(Throwable t) {
    // 因为任务执行完毕，需要将任务的状态从NEW，修改为COMPLETING
    if (UNSAFE.compareAndSwapInt(this, stateOffset, NEW, COMPLETING)) {
        // 将异常信息封装到 outcome 属性
        outcome = t;
        // 将任务状态变为EXCEPTIONAL，异常结束
        UNSAFE.putOrderedInt(this, stateOffset, EXCEPTIONAL); 
        // 一会再说……
        finishCompletion();
    }
}
```

##### 1.3.4 FutureTask的cancel方法

任务取消的一个方式

* 任务直接从NEW状态转换为CANCEL
* 任务从NEW状态变成INTERRUPTING，然后再转换为INTERRUPTED

```java
// 取消任务操作
public boolean cancel(boolean mayInterruptIfRunning) {
    // 查看任务的状态是否是NEW，如果NEW状态，就基于传入的参数mayInterruptIfRunning
    // 决定任务是直接从NEW转换为CANCEL，还是从NEW转换为INTERRUPTING
    if (!(state == NEW && 
        UNSAFE.compareAndSwapInt(this, stateOffset, NEW, mayInterruptIfRunning ? INTERRUPTING : CANCELLED)))
        return false;
    try {   
        // 如果mayInterruptIfRunning为true
        // 就需要中断线程
        if (mayInterruptIfRunning) {
            try {
                // 拿到任务线程
                Thread t = runner;
                if (t != null)
                    // 如果线程不为null，直接interrupt
                    t.interrupt();
            } finally { 
                // 将任务状态设置为INTERRUPTED
                UNSAFE.putOrderedInt(this, stateOffset, INTERRUPTED);
            }
        }
    } finally {
        // 任务结束后的一些处理~~ 一会看~~
        finishCompletion();
    }
    return true;
}
```

##### 1.3.5 FutureTask的get方法

这个是线程获取FutureTask任务执行结果的方法

```java
// 拿任务结果
public V get() throws InterruptedException, ExecutionException {
    // 获取任务的状态
    int s = state;
    // 要么是NEW，任务还没执行完
    // 要么COMPLETING，任务执行完了，结果还没封装好。
    if (s <= COMPLETING)
        // 让当前线程阻塞，等待结果
        s = awaitDone(false, 0L);
    // 最终想要获取结果，需要执行report方法
    return report(s);
}

// 线程等待FutureTask结果的过程
private int awaitDone(boolean timed, long nanos) throws InterruptedException {
    // 针对get方法传入了等待时长时，需要计算等到什么时间点
    final long deadline = timed ? System.nanoTime() + nanos : 0L;
    // 声明好需要的Node，queued：放到链表中了么？
    WaitNode q = null;
    boolean queued = false;
    for (;;) {
        // 查看线程是否中断，如果中断，从等待链表中移除，甩个异常
        if (Thread.interrupted()) {
            removeWaiter(q);
            throw new InterruptedException();
        }
        // 拿到状态
        int s = state;
        // 到这，说明任务结束了。
        if (s > COMPLETING) {
            if (q != null)
                // 如果之前封装了WaitNode，现在要清空
                q.thread = null;
            return s;
        }
        // 如果任务状态是COMPLETING，这就不需要去阻塞线程，让步一下，等待一小会，结果就有了
        else if (s == COMPLETING) 
            Thread.yield();
        // 如果还没初始化WaitNode，初始化
        else if (q == null)
            q = new WaitNode();
        // 没放队列的话，直接放到waiters的前面
        else if (!queued)
            queued = UNSAFE.compareAndSwapObject(this, waitersOffset,
                                                 q.next = waiters, q);
        // 准备挂起线程，如果timed为true，挂起一段时间
        else if (timed) {
            // 计算出最多可以等待多久
            nanos = deadline - System.nanoTime();
            // 如果等待的时间没了
            if (nanos <= 0L) {
                // 移除当前的Node，返回任务状态
                removeWaiter(q);
                return state;
            }
            // 等一会
            LockSupport.parkNanos(this, nanos);
        }
        else
            // 死等
            LockSupport.park(this);
    }
}

// get的线程已经可以阻塞结束了，基于状态查看能否拿到返回结果
private V report(int s) throws ExecutionException {
    // 拿到outcome 返回结果
    Object x = outcome;
    // 如果任务状态是NORMAL，任务正常结束，返回结果
    if (s == NORMAL)
        return (V)x;
    // 如果任务状态大于等于取消
    if (s >= CANCELLED)
        // 直接抛出异常
        throw new CancellationException();
    // 到这就是异常结束
    throw new ExecutionException((Throwable)x);
}
```

##### 1.3.6 FutureTask的finishCompletion方法

只要任务结束了，无论是正常返回，异常返回，还是任务被取消都会执行这个方法

而这个方法其实就是唤醒那些执行get方法等待任务结果的线程

```java
// 任务结束后触发
private void finishCompletion() {
    // 在任务结束后，需要唤醒
    for (WaitNode q; (q = waiters) != null;) {
        // 第一步直接以CAS的方式将WaitNode置为null
        if (UNSAFE.compareAndSwapObject(this, waitersOffset, q, null)) {
            for (;;) {
                // 拿到了Node中的线程
                Thread t = q.thread;
                // 如果线程不为null
                if (t != null) {
                    // 第一步先置位null
                    q.thread = null;
                    // 直接唤醒这个线程
                    LockSupport.unpark(t);
                }
                // 拿到当前Node的next
                WaitNode next = q.next;
                // next为null，代表已经将全部节点唤醒了吗，跳出循环
                if (next == null)
                    break;
                // 将next置位null
                q.next = null; 
                // q的引用指向next
                q = next;
            }
            break;
        }
    }

    // 任务结束后，可以基于这个扩展方法，记录一些信息
    done();

    // 任务执行完，把callable具体任务置位null
    callable = null;  
}
```

### 二、**CompletableFuture**应用&源码分析

#### 2.1 CompletableFuture介绍

平时多线程开发一般就是使用Runnable，Callable，Thread，FutureTask，ThreadPoolExecutor这些内容和并发编程息息相关。相对来对来说成本都不高，多多使用是可以熟悉这些内容。这些内容组合在一起去解决一些并发编程的问题时，很多时候没有办法很方便的去完成异步编程的操作。

Thread + Runnable：执行异步任务，但是没有返回结果

Thread + Callable + FutureTask：完整一个可以有返回结果的异步任务

* 获取返回结果，如果基于get方法获取，线程需要挂起在WaitNode里
* 获取返回结果，也可以基于isDone判断任务的状态，但是这里需要不断轮询

上述的方式都是有一定的局限性的。

比如说任务A，任务B，还有任务C。其中任务B还有任务C执行的前提是任务A先完成，再执行任务B和任务C。

如果任务的执行方式逻辑比较复杂，可能需要业务线程导出阻塞等待，或者是大量的任务线程去编一些任务执行的业务逻辑。对开发成本来说比较高。

CompletableFuture就是帮你处理这些任务之间的逻辑关系，编排好任务的执行方式后，任务会按照规划好的方式一步一步执行，不需要让业务线程去频繁的等待

#### 2.2 CompletableFuture应用

CompletableFuture应用还是需要一内内的成本的。

首先对CompletableFuture提供的函数式编程中三个函数有一个掌握

```java
Supplier<U>  // 生产者，没有入参，有返回结果
Consumer<T>  // 消费者，有入参，但是没有返回结果
Function<T,U>// 函数，有入参，又有返回结果

```

##### 2.2.1 supplyAsync

CompletableFuture如果不提供线程池的话，默认使用的ForkJoinPool，而ForkJoinPool内部是守护线程，如果main线程结束了，守护线程会跟着一起结束。

```java
public static void main(String[] args)  {
    // 生产者，可以指定返回结果
    CompletableFuture<String> firstTask = CompletableFuture.supplyAsync(() -> {
        System.out.println("异步任务开始执行");
        System.out.println("异步任务执行结束");
        return "返回结果";
    });

    String result1 = firstTask.join();
    String result2 = null;
    try {
        result2 = firstTask.get();
    } catch (InterruptedException e) {
        e.printStackTrace();
    } catch (ExecutionException e) {
        e.printStackTrace();
    }

    System.out.println(result1 + "," + result2);
}
```

##### 2.2.2 runAsync

当前方式既不会接收参数，也不会返回任何结果，非常基础的任务编排方式

```java
public static void main(String[] args) throws IOException {
    CompletableFuture.runAsync(() -> {
        System.out.println("任务go");
        System.out.println("任务done");
    });

    System.in.read();
}
```

##### 2.2.3 thenApply，thenApplyAsync

有任务A，还有任务B。

任务B需要在任务A执行完毕后再执行。

而且任务B需要任务A的返回结果。

任务B自身也有返回结果。

thenApply可以拼接异步任务，前置任务处理完之后，将返回结果交给后置任务，然后后置任务再执行

thenApply提供了带有Async的方法，可以指定每个任务使用的具体线程池。

```java
public static void main(String[] args) throws IOException {
    ExecutorService executor = Executors.newFixedThreadPool(10);

    /*CompletableFuture<String> taskA = CompletableFuture.supplyAsync(() -> {
        String id = UUID.randomUUID().toString();
        System.out.println("执行任务A：" + id);
        return id;
    });
    CompletableFuture<String> taskB = taskA.thenApply(result -> {
        System.out.println("任务B获取到任务A结果：" + result);
        result = result.replace("-", "");
        return result;
    });

    System.out.println("main线程拿到结果：" + taskB.join());*/

    CompletableFuture<String> taskB = CompletableFuture.supplyAsync(() -> {
        String id = UUID.randomUUID().toString();
        System.out.println("执行任务A：" + id + "," + Thread.currentThread().getName());
        return id;
    }).thenApplyAsync(result -> {
        System.out.println("任务B获取到任务A结果：" + result + "," + Thread.currentThread().getName());
        result = result.replace("-", "");
        return result;
    },executor);

    System.out.println("main线程拿到结果：" + taskB.join());
}
```

##### 2.2.4 thenAccept，thenAcceptAsync

套路和thenApply一样，都是任务A和任务B的拼接

前置任务需要有返回结果，后置任务会接收前置任务的结果，返回后置任务没有返回值

```java
public static void main(String[] args) throws IOException {
    CompletableFuture.supplyAsync(() -> {
        System.out.println("任务A");
        return "abcdefg";
    }).thenAccept(result -> {
        System.out.println("任务b，拿到结果处理：" + result);
    });

    System.in.read();
}
```

##### 2.2.5 thenRun，thenRunAsync

套路和thenApply，thenAccept一样，都是任务A和任务B的拼接

前置任务没有返回结果，后置任务不接收前置任务结果，后置任务也会有返回结果

```java
public static void main(String[] args) throws IOException {
    CompletableFuture.runAsync(() -> {
        System.out.println("任务A！！");
    }).thenRun(() -> {
        System.out.println("任务B！！");
    });
  
    System.in.read();
}
```

##### 2.2.6 thenCombine，thenAcceptBoth，runAfterBoth

比如有任务A，任务B，任务C。任务A和任务B并行执行，等到任务A和任务B全部执行完毕后，再执行任务C。

A+B ------ C

基于前面thenApply，thenAccept，thenRun知道了一般情况三种任务的概念

thenCombine以及thenAcceptBoth还有runAfterBoth的区别是一样的。

```java
public static void main(String[] args) throws IOException {
    CompletableFuture<Integer> taskC = CompletableFuture.supplyAsync(() -> {
        System.out.println("任务A");
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        return 78;
    }).thenCombine(CompletableFuture.supplyAsync(() -> {
        System.out.println("任务B");
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        return 66;
    }), (resultA, resultB) -> {
        System.out.println("任务C");
        int resultC = resultA + resultB;
        return resultC;
    });

    System.out.println(taskC.join());
    System.in.read();
}
```

##### 2.2.7 applyToEither，acceptEither，runAfterEither

比如有任务A，任务B，任务C。任务A和任务B并行执行，只要任务A或者任务B执行完毕，开始执行任务C

A or B ----- C

applyToEither，acceptEither，runAfterEither三个方法拼接任务的方式都是一样的

区别依然是，可以接收结果并且返回结果，可以接收结果没有返回结果，不接收结果也没返回结果

```java
public static void main(String[] args) throws IOException {
    CompletableFuture<Integer> taskC = CompletableFuture.supplyAsync(() -> {
        System.out.println("任务A");
        return 78;
    }).applyToEither(CompletableFuture.supplyAsync(() -> {
        System.out.println("任务B");
        return 66;
    }), resultFirst -> {
        System.out.println("任务C");
        return resultFirst;
    });

    System.out.println(taskC.join());
    System.in.read();
}
```

##### 2.2.8 exceptionally，thenCompose，handle

exceptionally

这个也是拼接任务的方式，但是只有前面业务执行时出现异常了，才会执行当前方法来处理

只有异常出现时，CompletableFuture的编排任务没有处理完时，才会触发

thenCompose，handle

这两个也是异常处理的套路，可以根据方法描述发现，他的功能方向比exceptionally要更加丰富

thenCompose可以拿到返回结果同时也可以拿到出现的异常信息，但是thenCompose本身是Consumer不能返回结果。无法帮你捕获异常，但是可以拿到异常返回的结果。

handle可以拿到返回结果同时也可以拿到出现的异常信息，并且也可以指定返回托底数据。可以捕获异常的，异常不会抛出去。

```java
public static void main(String[] args) throws IOException {
        CompletableFuture<Integer> taskC = CompletableFuture.supplyAsync(() -> {
            System.out.println("任务A");
//            int i = 1 / 0;
            return 78;
        }).applyToEither(CompletableFuture.supplyAsync(() -> {
            System.out.println("任务B");
            return 66;
        }), resultFirst -> {
            System.out.println("任务C");
            return resultFirst;
        }).handle((r,ex) -> {
            System.out.println("handle:" + r);
            System.out.println("handle:" + ex);
            return -1;
        });
        /*.exceptionally(ex -> {
            System.out.println("exceptionally:" + ex);
            return -1;
        });*/
        /*.whenComplete((r,ex) -> {
            System.out.println("whenComplete:" + r);
            System.out.println("whenComplete:" + ex);
        });*/


        System.out.println(taskC.join());
        System.in.read();
    }

```

##### 2.2.9 allOf，anyOf

allOf的方式是让内部编写多个CompletableFuture的任务，多个任务都执行完后，才会继续执行你后续拼接的任务

allOf返回的CompletableFuture是Void，没有返回结果

```java
public static void main(String[] args) throws IOException {
        CompletableFuture.allOf(
                CompletableFuture.runAsync(() -> {
                    try {
                        Thread.sleep(1000);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                    System.out.println("任务A");
                }),
                CompletableFuture.runAsync(() -> {
                    try {
                        Thread.sleep(2000);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                    System.out.println("任务B");
                }),
                CompletableFuture.runAsync(() -> {
                    try {
                        Thread.sleep(3000);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                    System.out.println("任务C");
                })
        ).thenRun(() -> {
            System.out.println("任务D");
        });

        System.in.read();
    }
```

anyOf是基于多个CompletableFuture的任务，只要有一个任务执行完毕就继续执行后续，最先执行完的任务做作为返回结果的入参

```java
public static void main(String[] args) throws IOException {
    CompletableFuture.anyOf(
            CompletableFuture.supplyAsync(() -> {
                try {
                    Thread.sleep(1000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                System.out.println("任务A");
                return "A";
            }),
            CompletableFuture.supplyAsync(() -> {
                try {
                    Thread.sleep(2000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                System.out.println("任务B");
                return "B";
            }),
            CompletableFuture.supplyAsync(() -> {
                try {
                    Thread.sleep(3000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                System.out.println("任务C");
                return "C";
            })
    ).thenAccept(r -> {
        System.out.println("任务D执行，" + r + "先执行完毕的");
    });

    System.in.read();
}
```

#### 2.3 CompletableFuture源码分析

CompletableFuture的源码内容特别多。不需要把所有源码都看了，更多的是要掌握整个CompletableFuture的源码执行流程，以及任务的执行时机。

从CompletableFuture中比较简单的方法作为分析的入口，从而掌握整体执行的流程。

##### 2.3.1 当前任务执行方式

将任务和CompletableFuture封装到一起，再执行封住好的具体对象的run方法即可

```java
// 提交任务到CompletableFuture
public static CompletableFuture<Void> runAsync(Runnable runnable) {
    // asyncPool：执行任务的线程池
    // runnable：具体任务。
    return asyncRunStage(asyncPool, runnable);
}

// 内部执行的方法
static CompletableFuture<Void> asyncRunStage(Executor e, Runnable f) {
    // 对任务做非空校验
    if (f == null) throw new NullPointerException();
    // 直接构建了CompletableFuture的对象，作为最后的返回结果
    CompletableFuture<Void> d = new CompletableFuture<Void>();
    // 将任务和CompletableFuture对象封装为了AsyncRun的对象
    // 将封装好的任务交给了线程池去执行
    e.execute(new AsyncRun(d, f));
    // 返回构建好的CompletableFuture
    return d;
}

// 封装任务的AsyncRun类信息
static final class AsyncRun extends ForkJoinTask<Void> implements Runnable, AsynchronousCompletionTask {
    // 声明存储CompletableFuture对象以及任务的成员变量
    CompletableFuture<Void> dep; 
    Runnable fn;

    // 将传入的属性赋值给成员变量
    AsyncRun(CompletableFuture<Void> dep, Runnable fn) {
        this.dep = dep; 
        this.fn = fn;
    }
    // 当前对象作为任务提交给线程池之后，必然会执行当前方法
    public void run() {
        // 声明局部变量
        CompletableFuture<Void> d; Runnable f;
        // 将成员变量赋值给局部变量，并且做非空判断
        if ((d = dep) != null && (f = fn) != null) {
            // help GC，将成员变量置位null，只要当前任务结束后，成员变量也拿不到引用。
            dep = null; fn = null;
            // 先确认任务没有执行。
            if (d.result == null) {
                try {
                    // 直接执行任务
                    f.run();
                    // 当前方法是针对Runnable任务的，不能将结果置位null
                    // 要给没有返回结果的Runnable做一个返回结果
                    d.completeNull();
                } catch (Throwable ex) {
                    // 异常结束！
                    d.completeThrowable(ex);
                }
            }
            d.postComplete();
        }
    }
}
```

##### 2.3.2 任务编排的存储&执行方式

首先如果要在前继任务处理后，执行后置任务的话。

有两种情况：

* 前继任务如果没有执行完毕，后置任务需要先放在stack栈结构中存储
* 前继任务已经执行完毕了，后置任务就应该直接执行，不需要在往stack中存储了。

如果单独采用thenRun在一个任务后面指定多个后继任务，CompletableFuture无法保证具体的执行顺序，而影响执行顺序的是前继任务的执行时间，以及后置任务编排的时机。

##### 2.3.3 任务编排流程

```java
// 编排任务，前继任务搞定，后继任务再执行
public CompletableFuture<Void> thenRun(Runnable action) {
    // 执行了内部的uniRunStage方法，
    // null：线程池，现在没给。
    // action：具体要执行的任务
    return uniRunStage(null, action);
}

// 内部编排任务方法
private CompletableFuture<Void> uniRunStage(Executor e, Runnable f) {
    // 后继任务不能为null，健壮性判断
    if (f == null) throw new NullPointerException();
    // 创建CompletableFuture对象d，与后继任务f绑定
    CompletableFuture<Void> d = new CompletableFuture<Void>();
    // 如果线程池不为null，代表异步执行，将任务压栈
    // 如果线程池是null，先基于uniRun尝试下，看任务能否执行
    if (e != null || !d.uniRun(this, f, null)) {
        // 如果传了线程池，这边需要走一下具体逻辑
        // e：线程池
        // d：后继任务的CompletableFuture
        // this：前继任务的CompletableFuture
        // f：后继任务
        UniRun<T> c = new UniRun<T>(e, d, this, f);
        // 将封装好的任务，push到stack栈结构
        // 只要前继任务没结束，这边就可以正常的将任务推到栈结构中
        // 放入栈中可能会失败
        push(c);
        // 无论压栈成功与否，都要尝试执行以下。
        c.tryFire(SYNC);
    }
    // 无论任务执行完毕与否，都要返回后继任务的CompletableFuture
    return d;
}
```

##### 2.3.4 查看后置任务执行时机

任务在编排到前继任务时，因为前继任务已经结束了，这边后置任务会主动的执行

```java
// 后置任务无论压栈成功与否，都需要执行tryFire方法
static final class UniRun<T> extends UniCompletion<T,Void> {

    Runnable fn;
    // executor：线程池
    // dep：后置任务的CompletableFuture
    // src：前继任务的CompletableFuture
    // fn：具体的任务
    UniRun(Executor executor, CompletableFuture<Void> dep,CompletableFuture<T> src, Runnable fn) {
        super(executor, dep, src); this.fn = fn;
    }

    final CompletableFuture<Void> tryFire(int mode) {
        // 声明局部变量
        CompletableFuture<Void> d; CompletableFuture<T> a;
        // 赋值局部变量
        // (d = dep) == null：赋值加健壮性校验
        if ((d = dep) == null ||
            // 调用uniRun。
            // a：前继任务的CompletableFuture
            // fn：后置任务
            // 第三个参数：传入的是this，是UniRun对象
            !d.uniRun(a = src, fn, mode > 0 ? null : this))
            // 进到这，说明前继任务没结束，等！
            return null;
        dep = null; src = null; fn = null;
        return d.postFire(a, mode);
    }
}

// 是否要主动执行任务
final boolean uniRun(CompletableFuture<?> a, Runnable f, UniRun<?> c) {
    // 方法要么正常结束，要么异常结束
    Object r; Throwable x;
    // a == null：健壮性校验
    // (r = a.result) == null：判断前继任务结束了么？
    // f == null：健壮性校验
    if (a == null || (r = a.result) == null || f == null)
        // 到这代表任务没结束。
        return false;
    // 后置任务执行了没？ == null，代表没执行
    if (result == null) {
        // 如果前继任务的结果是异常结束。如果前继异常结束，直接告辞，封装异常结果
        if (r instanceof AltResult && (x = ((AltResult)r).ex) != null)
            completeThrowable(x, r);
        else
            // 到这，前继任务正常结束，后置任务正常执行
            try {
                // 如果基于tryFire(SYNC)进来，这里的C不为null，执行c.claim
                // 如果是因为没有传递executor，c就是null，不会执行c.claim
                if (c != null && !c.claim())
                    // 如果返回false，任务异步执行了，直接return false
                    return false;
                // 如果claim没有基于线程池运行任务，那这里就是同步执行
                // 直接f.run了。
                f.run();
                // 封装Null结果
                completeNull();
            } catch (Throwable ex) {
                // 封装异常结果
                completeThrowable(ex);
            }
    }
    return true;
}

// 异步的线程池处理任务
final boolean claim() {
    Executor e = executor;
    if (compareAndSetForkJoinTaskTag((short)0, (short)1)) {
        // 只要有线程池对象，不为null
        if (e == null)
            return true;
        executor = null; // disable
        // 基于线程池的execute去执行任务
        e.execute(this);
    }
    return false;
}
```

前继任务执行完毕后，基于嵌套的方式执行后置。

```java
// A：嵌套了B+C，  B：嵌套了D+E
// 前继任务搞定，遍历stack执行后置任务
// A任务处理完，解决嵌套的B和C
final void postComplete() {
    // f：前继任务的CompletableFuture
    // h：存储后置任务的栈结构
    CompletableFuture<?> f = this; Completion h;
    // (h = f.stack) != null：赋值加健壮性判断，要确保栈中有数据
    while ((h = f.stack) != null ||
            // 循环一次后，对后续节点的赋值以及健壮性判断，要确保栈中有数据
           (f != this && (h = (f = this).stack) != null)) {
        // t：当前栈中任务的后续任务
        CompletableFuture<?> d; Completion t;
        // 拿到之前的栈顶h后，将栈顶换数据
        if (f.casStack(h, t = h.next)) {
            if (t != null) {
                if (f != this) {
                    pushStack(h);
                    continue;
                }
                h.next = null;    // detach
            }
            // 执行tryFire方法，
            f = (d = h.tryFire(NESTED)) == null ? this : d;
        }
    }
}

// 回来了  NESTED == -1
final CompletableFuture<Void> tryFire(int mode) {
    CompletableFuture<Void> d; CompletableFuture<T> a;
    if ((d = dep) == null ||
        !d.uniRun(a = src, fn, mode > 0 ? null : this))
        return null;
    dep = null; src = null; fn = null;
    // 内部会执行postComplete，运行B内部嵌套的D和E
    return d.postFire(a, mode);
}
```

#### 2.4 CompletableFuture执行流程图

![image.png](https://fynotefile.oss-cn-zhangjiakou.aliyuncs.com/fynote/fyfile/2746/1663750769045/d8b1d80750d24e17a4143678f97dafc4.png)
