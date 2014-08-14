# DOCKER-VERSION 1.0.1
# VERSION        0.7
# marathon
FROM dockerregistry:5000/mesos
MAINTAINER Jakub Veverka <jveverkal@vendavo.com>

RUN apt-get update && apt-get install -y default-jre wget

RUN wget -O /tmp/marathon.tgz -c http://downloads.mesosphere.io/marathon/marathon-0.6.1/marathon-0.6.1.tgz
RUN tar xzf /tmp/marathon.tgz -C /usr/local/
RUN ln -s /usr/local/marathon-0.6.1 /usr/local/marathon

EXPOSE 8080

CMD /usr/local/marathon/bin/start --master "zk://${ZOOKEEPER_ENDPOINTS}/mesos" --zk "zk://${ZOOKEEPER_ENDPOINTS}/marathon"
