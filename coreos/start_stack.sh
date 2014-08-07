cd units

for SERVICE in zookeeper.1.service zookeepersidekick.1.service mesos-master.1.service marathon.1.service mesos-slave.1.service
do
	fleetctl submit $SERVICE
	sleep 5
	fleetctl start $SERVICE
done

