# Read zookeeper info from etcd
 - using environment variable in systemd unit file
  - https://github.com/veverjak/coreos-mesos-marathon/commit/d30d7a371044c53f56888372e53da588575f3ef1#diff-8d7c512dced74961f707b0df991788cdR9

# Connect to mesos-master from mesos-slaves on all hosts

## Description
 - mesos-master container starts listening on it's containers IP
 - info is saved to zookeeper
 - slave on same host can connect to master because its routed via same bridge device
 - slave from different host can't connect to master because it's not routed via same bridge device

## Solution
 1. Use some etcd based proxy 
  - http://coreos.com/blog/docker-dynamic-ambassador-powered-by-etcd/
 2. Can mesos-master write custom IP to zookeeper???
  - using parameter --hostname for startup of mesos-master service
