#!/bin/bash

echo "[+] Script2..."
sed -i "s/#PubkeyAuthentication yes/PubkeyAuthentication yes/g" "/etc/ssh/sshd_config"
sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/g" "/etc/ssh/sshd_config"
systemctl restart ssh
cat /home/vagrant/temp/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
rm /home/vagrant/temp/id_rsa.pub
echo "[+] Script2 end !"