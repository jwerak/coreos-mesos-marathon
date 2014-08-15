#!/bin/bash

# SETUP ENV
COREOS_IPXE_SERVER_BASE_URL="10.102.11.42:4777"
COREOS_IPXE_SERVER_LISTEN_ADDR="0.0.0.0:4777"
VERSIONS=("367.1.0" "379.3.0")

# PREPARE DIRECTORY STRUCTURE
mkdir -p {configs,images,profiles,sshkeys}

# DOWNLOAD IMAGES
for VERSION in "${VERSIONS[@]}"
do
	echo "Downloading files for version ${VERSION}"
	mkdir -p images/amd64-usr/$VERSION
	wget -nc http://storage.core-os.net/coreos/amd64-usr/$VERSION/coreos_production_pxe_image.cpio.gz -O images/amd64-usr/${VERSION}/coreos_production_pxe_image.cpio.gz
	wget -nc http://storage.core-os.net/coreos/amd64-usr/$VERSION/coreos_production_pxe.vmlinuz -O images/amd64-usr/${VERSION}/coreos_production_pxe.vmlinuz
done

# CUSTOMIZE COREOS SERVER CONFIGURATION
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCXIsw4GsfZjGkxjIKBTrywwT/rjSd+gID6V4xKswZVOmWVg5gzBI48XdV93v7gFXnq3FIR61pxlcDP06EYFcp3jXGebhUS/7TbSUb1wIRVAtucvTzPfhlASjt94wmNo7Ckrpm9alBYnURGsBfcITr7dgS9aCOXgwhkA9h9FGHI6uM36LiXT4AFssS3wSbI9dPS2iOEHTDIs3cIxJh2nNdqVO1axjHU1p1XQQbQIFlWfHnMHtk38dhqx4+4mZVzBb80DhReh5ti+pcR8U3CsVwTTrf2x+cwa7fuvZbFZf5caHyGknFI0zmN5GXubAbvUV7m//DnBlZnjG4QbBKoHt3X jveverka@jveverkalaptop.vendavo.com" > sshkeys/coreos.pub


cat > configs/development.yml <<EOF
#cloud-config

ssh_authorized_keys:
  - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCXIsw4GsfZjGkxjIKBTrywwT/rjSd+gID6V4xKswZVOmWVg5gzBI48XdV93v7gFXnq3FIR61pxlcDP06EYFcp3jXGebhUS/7TbSUb1wIRVAtucvTzPfhlASjt94wmNo7Ckrpm9alBYnURGsBfcITr7dgS9aCOXgwhkA9h9FGHI6uM36LiXT4AFssS3wSbI9dPS2iOEHTDIs3cIxJh2nNdqVO1axjHU1p1XQQbQIFlWfHnMHtk38dhqx4+4mZVzBb80DhReh5ti+pcR8U3CsVwTTrf2x+cwa7fuvZbFZf5caHyGknFI0zmN5GXubAbvUV7m//DnBlZnjG4QbBKoHt3X jveverka@jveverkalaptop.vendavo.com

coreos:
  etcd:
      # generate a new token for each unique cluster from https://discovery.etcd.io/new
      # WARNING: replace each time you 'vagrant destroy'
      discovery: https://discovery.etcd.io/a1efed8239a47c98c12ce07e2b67f0ed
      addr: $public_ipv4:4001
      peer-addr: $public_ipv4:7001
  units:
    - name: etcd.service
      command: start
    - name: fleet.service
      command: start
      runtime: no
      content: |
        [Unit]
        Description=fleet

        [Service]
        Environment=FLEET_PUBLIC_IP=$public_ipv4
        ExecStart=/usr/bin/fleet
    - name: docker-tcp.socket
      command: start
      enable: true
      content: |
        [Unit]
        Description=Docker Socket for the API

        [Socket]
        ListenStream=2375
        Service=docker.service
        BindIPv6Only=both

        [Install]
        WantedBy=sockets.target
EOF

for VERSION in "${VERSIONS[@]}"
do
	cat > profiles/development_${VERSION}.json <<EOF
{
    "cloud_config": "development",
    "root": "/dev/sda",
    "sshkey": "coreos",
    "version": "${VERSION}"
}
EOF
done

# BUILD DOCKER
docker build -t jveverka/ipxe .

# RUN DOCKER
docker run -d -p 4777:4777 -e "COREOS_IPXE_SERVER_BASE_URL=${COREOS_IPXE_SERVER_BASE_URL}" -e "COREOS_IPXE_SERVER_LISTEN_ADDR=${COREOS_IPXE_SERVER_LISTEN_ADDR}" jveverka/ipxe

