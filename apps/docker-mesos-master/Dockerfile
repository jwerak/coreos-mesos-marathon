# DOCKER-VERSION 1.0.1
# VERSION        0.5
# mesos-master
FROM jveverka/mesos
MAINTAINER Jakub Veverka <jveverkal@vendavo.com>

RUN mkdir -p -m 755 /var/lib/mesos

# http
EXPOSE 5050 

CMD /usr/local/sbin/mesos-master --zk="zk://$ZOOKEEPER_ENDPOINTS/mesos" --quorum=1 --work_dir=/var/lib/mesos
