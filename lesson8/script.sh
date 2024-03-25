#!/bin/bash

echo "[+] Script start..."
echo "192.168.100.20	apache.local	apache" >> /etc/hosts
echo "192.168.100.20	www.apache.local	www.apache" >> /etc/hosts

cp /home/vagrant/temp/apache.crt /usr/local/share/ca-certificates/apache.crt
rm /home/vagrant/temp/apache.crt
sudo update-ca-certificates
echo "[+] Script end !"
