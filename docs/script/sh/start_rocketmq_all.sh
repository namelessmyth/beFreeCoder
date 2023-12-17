#!/bin/bash

#软件安装目录设置，先读环境变量，读不到则用默认值
ROCKETMQ_HOME=$ROCKETMQ_HOME
if [ -z $ROCKETMQ_HOME]; then
	echo "ROCKETMQ_HOME is not set! the program will use default value"
	ROCKETMQ_HOME=/www/wwwroot/install/rocketmq-all-4.9.7-bin-release
fi
echo "ROCKETMQ_HOME=$ROCKETMQ_HOME"


# 启动rocketmq nameserver
cd ${ROCKETMQ_HOME}/bin
# 检查Zookeeper是否启动成功
if jps -ml | grep "namesrv.NamesrvStartup"; then
	echo "rocketmq nameserver is running.";
else
	echo "rocketmq nameserver is Starting ...";
	rm -rf nohup.out;
	nohup sh mqnamesrv &
	count=0
	while [ $count -le 10 ]; do
	  if tail -100 nohup.out | grep "Name Server boot success"; then
		echo "rocketmq nameserver has been started successfully";
		break
	  else
		count=$((count+1))
		sleep 2
	  fi
	done
fi

# 启动rocketmq broker
# 检查Zookeeper是否启动成功
if jps -ml | grep "org.apache.rocketmq.broker.BrokerStartup"; then
	echo "rocketmq broker is running.";
else
	echo "rocketmq broker is Starting ...";
	rm -rf nohup.out;
	nohup sh mqbroker -c ../conf/broker.conf -n dev-study:9876 autoCreateTopicEnable=true &  
	count=0
	while [ $count -le 10 ]; do
	  if tail -100 nohup.out | grep "broker.*success"; then
		echo "rocketmq broker has been started successfully";
		break
	  else
		count=$((count+1))
		sleep 2
	  fi
	done
fi

# 启动rocketmq dashboard
cd ${ROCKETMQ_HOME}/dashboard
if jps -ml | grep "rocketmq-dashboard"; then
	echo "rocketmq dashboard is running.";
else
	echo "rocketmq dashboard is Starting ...";
	rm -rf nohup.out;
	nohup java -jar rocketmq-dashboard-1.0.0.jar & 
	count=0
	while [ $count -le 10 ]; do
	  if tail -100 nohup.out | grep "Tomcat started on port(s)"; then
		echo "rocketmq dashboard has been started successfully";
		break
	  else
		count=$((count+1))
		sleep 2
	  fi
	done
fi

echo "All services started.";
