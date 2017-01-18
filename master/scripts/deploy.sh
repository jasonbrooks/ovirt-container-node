#!/bin/sh

# Waiting until vdsmd is up.. better to check service status before running
sleep 10

# setting link name - vdsm recognize veth_* prefix as veth type device
ip link set eth0 down
ip link set eth0 name veth_name0
ip link set veth_name0 up
# in our cluster 10.32.0.1 is the default gateway
ip route add default via $CLUSTER_GATEWAY dev veth_name0
#

python /root/add_network.py

# ovirt registration flow.
vdsm-tool register --engine-fqdn $ENGINE_FQDN --check-fqdn false
