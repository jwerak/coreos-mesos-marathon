# Motivation

I want to run marathon-mesos-deimos setup (http://beingasysadmin.wordpress.com/2014/06/27/managing-docker-clusters-using-mesos-and-marathon/) on CoreOS.

I was ispired by Ebay's building from docker using hosts docker setup (http://www.ebaytechblog.com/2014/05/12/delivering-ebays-ci-solution-with-apache-mesos-part-ii/#.U85a4nV53Ua).

I want to enjoy both CoreOS and mesos resource management, in future hopefully kubernetes (https://github.com/mesosphere/kubernetes-mesos).

# Install

 - Start CoreOS cluster
  - for testing I am using vagrant - http://coreos.com/docs/running-coreos/platforms/vagrant/
 - Logon to Cluster and add unit files
 - run units in following order (might work anyway if you change order, I just didn't try it yet):
  - zookeeper
  - mesos-master
  - marathon
  - mesos-slave
 - Test marathon API
  - curl -v -X POST -H "Content-Type: application/json" <marathon-IP>:8080/v2/apps -d@test.json
  - test.json:
	{
	"id": "test",
	"container": {"image": "docker:///debian:jessie", "options" : []},
	"cmd": "while sleep 10; do date -u +%T; done",
	"cpus": "0.5",
	"mem": "268.0",
		"uris": [ ],
		"instances": "1"
	}

# TODO

 - [x] Crate docker images for
  - Zookeeper
  - Mesos-master
  - Mesos-slave
  - Marathon (mesos framework)
 - [ ] Run apps in HA 
  - [ ] Create pattern Unit files
   - [ ] Idealy using some tool (ansible...)
  - [ ] Set dynamic communication between services
   - probably using etcd


