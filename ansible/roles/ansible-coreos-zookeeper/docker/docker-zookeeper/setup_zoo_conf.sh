#!/bin/bash

# Usage: 
# Configuration file path 
CONF_FILE="${1}"
shift
# Rest of arguments has to be only connection info in shape 
# [hostname]:nnnnn[:nnnnn]
# which creates server.x=[hostname]:nnnnn[:nnnnn]
INSTANCE_CONN_INFO="${@}"

cat > $CONF_FILE <<EOF
tickTime=2000
initLimit=10
syncLimit=5
dataDir=/var/zookeeper
clientPort=2181
EOF

#for ((i=1;i<=$NO_OF_INSTANCES;i++))
count=1
for INFO in $INSTANCE_CONN_INFO
do
	echo server.${count}=${INFO} >> $CONF_FILE
	((count++))
done
