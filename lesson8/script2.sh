#!/bin/bash

echo "[+] Script2..."
sudo apt update && sudo apt install apache2 -y
sudo echo "192.168.100.20	apache.local	apache" >> /etc/hosts
sudo echo "192.168.100.20	www.apache.local	www.apache" >> /etc/hosts

sudo openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=apache.local" -addext 'subjectAltName = DNS:*.apache.local, DNS:apache.local' -keyout /etc/ssl/private/apache.key  -out /etc/ssl/certs/apache.crt

sudo cat <<EOT > "/etc/apache2/conf-available/ssl-params.conf"
SSLCipherSuite EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH
SSLProtocol All -SSLv2 -SSLv3 -TLSv1 -TLSv1.1
SSLHonorCipherOrder On
# Disable preloading HSTS for now.  You can use the commented out header line that includes
# the "preload" directive if you understand the implications.
# Header always set Strict-Transport-Security "max-age=63072000; includeSubDomains; preload"
Header always set X-Frame-Options DENY
Header always set X-Content-Type-Options nosniff
# Requires Apache >= 2.4
SSLCompression off
SSLUseStapling on
SSLStaplingCache "shmcb:logs/stapling-cache(150000)"
# Requires Apache >= 2.4.11
SSLSessionTickets Off
EOT

sudo cat <<EOT > "/etc/apache2/sites-available/default-ssl.conf"
<IfModule mod_ssl.c>
        <VirtualHost _default_:443>
	RewriteCond %{HTTP_HOST} ^www\.(.*)$ [NC]
	RewriteRule ^(.*)$ https://%1/$1 [R=301,L]

                ServerAdmin morty0014@apache.local
                ServerName apache.local

                DocumentRoot /var/www/html

                ErrorLog ${APACHE_LOG_DIR}/error.log
                CustomLog ${APACHE_LOG_DIR}/access.log combined

                SSLEngine on

                SSLCertificateFile      /etc/ssl/certs/apache.crt
                SSLCertificateKeyFile /etc/ssl/private/apache.key

                <FilesMatch "\.(cgi|shtml|phtml|php)$">
                                SSLOptions +StdEnvVars
                </FilesMatch>
                <Directory /usr/lib/cgi-bin>
                                SSLOptions +StdEnvVars
                </Directory>
		<Directory /var/www/html>
				Options Indexes FollowSymLinks MultiViews
				AllowOverride All
				Order allow,deny
				allow from all
		</Directory>
        </VirtualHost>
</IfModule>
EOT

sudo cat << EOT > "/etc/apache2/sites-available/000-default.conf"
<VirtualHost *:80>
        Redirect "/" "https://apache.local/"
        ServerAdmin morty0014@apache.local
        ServerName apache.local

        DocumentRoot /var/www/html

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOT

sudo cp /etc/ssl/certs/apache.crt /home/vagrant/temp/apache.crt

sudo systemctl restart apache2

sudo a2enmod ssl
sudo a2enmod headers
sudo a2enmod rewrite
sudo a2ensite default-ssl
sudo a2enconf ssl-params

sudo systemctl restart apache2

echo "[+] Script2 end !"


