# DOCKER-VERSION 1.0.1
# VERSION        0.5
# mesos-slave
FROM dockerregistry:5000/mesos
MAINTAINER Jakub Veverka <jveverkal@vendavo.com>

RUN mkdir -p -m 755 /var/lib/mesos

RUN apt-get install -y python-pip

RUN pip install deimos

ADD docker /usr/bin/docker
RUN mkdir /usr/lib64/
ADD deimos.cfg /etc/deimos.cfg
RUN chmod 755 /usr/bin/docker

EXPOSE 5051

CMD /usr/local/sbin/mesos-slave --master="zk://$ZOOKEEPER_ENDPOINTS/mesos" --ip="${IP}" --work_dir=/var/lib/mesos --logging_level=INFO --log_dir=/var/log --containerizer_path=/usr/local/bin/deimos --isolation=external
