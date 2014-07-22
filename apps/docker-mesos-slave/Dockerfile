# DOCKER-VERSION 1.0.1
# VERSION        0.5
# mesos
FROM jveverka/mesos
MAINTAINER Jakub Veverka <jveverkal@vendavo.com>

RUN mkdir -p -m 755 /var/lib/mesos

#RUN apt-get install -y python-pip docker.io supervisor rsyslog
RUN apt-get install -y python-pip supervisor rsyslog

RUN pip install deimos

ADD docker /usr/bin/docker
RUN mkdir /usr/lib64/
ADD deimos.cfg /etc/deimos.cfg
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN chmod 755 /usr/bin/docker

RUN echo /usr/local/bin/deimos > /etc/mesos-slave/containerizer_path && echo external > /etc/mesos-slave/isolation

EXPOSE 5051


#CMD /usr/local/sbin/mesos-slave --master="zk://172.17.8.102:2181/mesos" --work_dir="/var/lib/mesos" --logging_level="INFO" --log_dir="/var/log"
CMD /usr/bin/supervisord
