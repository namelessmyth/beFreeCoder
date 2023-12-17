#!/bin/bash

# 启动Zookeeper
cd /www/wwwroot/install/apache-zookeeper-3.7.1-bin/bin
# 检查Zookeeper是否启动成功
if ./zkServer.sh status | grep "Mode: "; then
	echo "Zookeeper is started.";
else
	echo "Zookeeper is Starting ...";
	./zkServer.sh start zoo.cfg
	while true; do
	  if ./zkServer.sh status | grep "Mode: "; then
		echo "Zookeeper started successfully.";
		break
	  else
		sleep 1
	  fi
	done
fi

# 启动Kafka
cd /www/wwwroot/install/kafka_2.12-3.5.0
# 检查Zookeeper是否启动成功
if ./bin/kafka-topics.sh  --list --bootstrap-server dev-study:9092 >/dev/null 2>&1; then
	echo "Kafka is started.";
else
	echo "Kafka is starting...";
	./bin/kafka-server-start.sh -daemon config/server.properties
	while true; do
	  if ./bin/kafka-topics.sh  --list --bootstrap-server dev-study:9092 >/dev/null 2>&1; then
		echo "Kafka started successfully.";
		break
	  else
		sleep 1
	  fi
	done
fi

# 启动Kafka Eagle
cd /www/wwwroot/install/kafka-eagle
# 检查Zookeeper是否启动成功
if bin/ke.sh status | grep "is running"; then
	echo "Eagle is started.";
else
	echo "Eagle is starting...";
	./bin/ke.sh start
	while true; do
	  if bin/ke.sh status | grep "is running"; then
		echo "Eagle started successfully.";
		break
	  else
		sleep 1
	  fi
	done
fi

echo "All services started successfully.";
