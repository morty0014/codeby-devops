#!/bin/bash

echo "[+] Script start..."
echo "y\n" | HOSTNAME=`hostname` ssh-keygen -t rsa -C "$HOSTNAME" -f "/home/vagrant/.ssh/id_rsa" -P ""
chown vagrant /home/vagrant/.ssh/id_rsa
cp /home/vagrant/.ssh/id_rsa.pub /home/vagrant/temp/id_rsa.pub
echo "[+] Script end !"
