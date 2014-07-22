# DOCKER-VERSION 1.0.1
# VERSION        0.5
# mesos
FROM jveverka/mesos
MAINTAINER Jakub Veverka <jveverkal@vendavo.com>

RUN apt-get update && apt-get install -y default-jre wget

RUN wget -O /tmp/marathon.tgz -c http://downloads.mesosphere.io/marathon/marathon-0.6.0/marathon-0.6.0.tgz
RUN tar xzf /tmp/marathon.tgz -C /usr/local/
RUN ln -s /usr/local/marathon-0.6.0 /usr/local/marathon

EXPOSE 8080

CMD /usr/local/marathon/bin/start --master zk://172.17.8.102:2181/mesos --zk zk://172.17.8.102:2181/marathon
