#!/bin/bash
#===============================================================================
#
#          FILE:  deploy_coreos.sh
# 
#         USAGE:  ./deploy_coreos.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Jakub Veverka (), veverka.kuba@gmail.com
#       VERSION:  1.0
#       CREATED:  07/23/2014 12:37:01 PM CEST
#      REVISION:  ---
#===============================================================================
SCRIPT_DIR="/var/lib/scripts"
SCRIPT_FULL_NAME="${SCRIPT_DIR}/get_zookeeper_endpoints.sh"
ZOOKEEPER_PORT="2181"

# Create script that will return zookeeper IP:PORT, possibly multiple - not implemented yet
mkdir -p -m 755 $SCRIPT_DIR
echo "#!/bin/bash" > $SCRIPT_FULL_NAME
echo "echo \`etcdctl get /services/zookeeper/zookeeper1 | sed -e 's/[\{\}]//g' | awk 'BEGIN{RS=\",\"; FS=\":\";} \$1 ~ /IP/ { print \$2 }' | sed -e 's/ //g'\`:$ZOOKEEPER_PORT" >> $SCRIPT_FULL_NAME

chmod 755 $SCRIPT_FULL_NAME
