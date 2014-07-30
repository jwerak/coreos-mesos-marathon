
for SERVICE in mesos-slave.1.service marathon.1.service mesos-master.1.service zookeeper.1.service zookeepersidekick.1.service
do
	fleetctl stop  $SERVICE
	sleep 5
	fleetctl destroy $SERVICE
done


