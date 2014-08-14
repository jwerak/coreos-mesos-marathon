# DOCKER-VERSION 1.0.1
# VERSION        0.5
# mesos
FROM debian:jessie
MAINTAINER Jakub Veverka <jveverkal@vendavo.com>

RUN apt-get clean && apt-get update && apt-get install -y default-jre python-setuptools python-protobuf wget libcurl3
RUN wget http://downloads.mesosphere.io/master/debian/7/mesos_0.19.1-1.0.debian75_amd64.deb -c -O /tmp/mesos.deb
RUN wget http://downloads.mesosphere.io/master/debian/7/mesos-0.19.1-py2.7-linux-x86_64.egg -c -O /tmp/mesos.egg

RUN dpkg -i /tmp/mesos.deb
RUN easy_install /tmp/mesos.egg

