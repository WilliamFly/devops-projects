#!/bin/bash
echo "Removing Netdata..."
sudo systemctl stop netdata
sudo apt remove -y netdata
sudo rm -rf /etc/netdata /var/lib/netdata /var/cache/netdata
sudo rm -f /etc/systemd/system/netdata.service
sudo systemctl daemon-reload
echo "Netdata removed successfully."
