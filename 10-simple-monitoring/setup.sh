#!/bin/bash
echo "Installing Netdata..."
wget -O /tmp/netdata-kickstart.sh https://get.netdata.cloud/kickstart.sh
sh /tmp/netdata-kickstart.sh
echo "Netdata installed. Access dashboard at http://$(hostname -I | awk '{print $1}'):19999"
