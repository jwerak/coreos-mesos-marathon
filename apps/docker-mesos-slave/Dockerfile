# DOCKER-VERSION 1.0.1
# VERSION        0.5
# mesos
FROM jveverka/mesos
MAINTAINER Jakub Veverka <jveverkal@vendavo.com>

RUN mkdir -p -m 755 /var/lib/mesos

RUN apt-get install -y python-pip
RUN pip install deimos

ADD docker /usr/bin/docker
RUN chmod 755 /usr/bin/docker

EXPOSE 5051


CMD ["/usr/local/sbin/mesos-slave", "--master=zk://172.17.8.103:2181/mesos", "--work_dir=/var/lib/mesos"]
