#!/bin/bash

date
echo "[+] Start backup"

sudo mkdir -p /opt/mysql_backup
sudo mysqldump codeby > /opt/mysql_backup/db_backup.sql

echo "[+] Backup end"
date
