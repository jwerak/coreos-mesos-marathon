#!/bin/bash
#===============================================================================
#
#          FILE:  deploy_coreos.sh
#·
#         USAGE:  ./deploy_coreos.sh·
#·
#   DESCRIPTION:··
#·
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
echo "echo \`etcdctl ls /services/zookeeper/ | while read KEY; do etcdctl get \$KEY| sed -r 's/.*IP:\ ([0-9,.]*),.*/\1/'; done | tr \"\n\" \" \" | sed 's/\ /:$ZOOKEEPER_PORT,/g'| sed 's/,\$//' \`" >> $SCRIPT_FULL_NAME

chmod 755 $SCRIPT_FULL_NAME

echo "net.ipv6.conf.all.disable_ipv6=1" > /etc/sysctl.d/disable_ipv6.conf
sysctl -w net.ipv6.conf.all.disable_ipv6=1
