# DOCKER-VERSION 1.0.1
# VERSION        0.5
# mesos
FROM debian:jessie
MAINTAINER Jakub Veverka <jveverkal@vendavo.com>

RUN apt-get update && apt-get install -y default-jre python-setuptools python-protobuf wget libcurl3
RUN wget http://downloads.mesosphere.io/master/debian/7/mesos_0.19.0~debian7.1%2B1_amd64.deb -c -O /tmp/mesos.deb
RUN wget http://downloads.mesosphere.io/master/debian/7/mesos-0.19.0_rc2-py2.7-linux-x86_64.egg -c -O /tmp/mesos.egg

RUN dpkg -i /tmp/mesos.deb
RUN easy_install /tmp/mesos.egg

