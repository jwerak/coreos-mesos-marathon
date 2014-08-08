# DOCKER-VERSION 1.0.1
# VERSION        0.5

FROM debian:jessie
MAINTAINER Justin Plock <justin@plock.net>

RUN apt-get update && apt-get install -y openjdk-7-jre-headless wget
RUN wget -q -O - http://apache.mirrors.pair.com/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz | tar -xzf - -C /opt
ADD setup_zoo_conf.sh /opt/zookeeper-3.4.6/bin/setup_zoo_conf.sh
RUN mkdir -p -m 755 /var/zookeeper
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

EXPOSE 2181 2888 3888
WORKDIR /opt/zookeeper-3.4.6
CMD echo ${ZOO_NODE_NUM} > /var/zookeeper/myid && /opt/zookeeper-3.4.6/bin/setup_zoo_conf.sh /opt/zookeeper-3.4.6/conf/zoo.cfg $ZOO_HOSTS_INFO  && /opt/zookeeper-3.4.6/bin/zkServer.sh start-foreground
