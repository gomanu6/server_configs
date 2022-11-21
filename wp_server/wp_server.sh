
. ./webserver_settings.config

# https://tonyteaches.tech/aws-ec2-wordpress/
# www.dnschecker.org


## Update System
sudo apt update && sudo apt upgrade -y

sudo apt install git gzip


## open ports in iptables
sudo iptables -I INPUT 6 -m state --state NEW -p tcp --dport 80 -j ACCEPT
sudo iptables -I INPUT 6 -m state --state NEW -p tcp --dport 443 -j ACCEPT


## Install basic dependencies
sudo apt install nginx mariadb-server php-fpm php-mysql


## Download Wordpress

cd /var/www

sudo wget https://wordpress.org/latest.tar.gz

sudo tar -xzvf latest.tar.gz

sudo rm latest.tar.gz

sudo chown -R www-data:www-data wordpress/

### directory permissions for Wordpress
sudo find wordpress/ -type d -exec chmod 755 {} \;
sudo find wordpress/ -type f -exec chmod 644 {} \;

## configure database
sudo mysql_secure_installation

sudo mysql -u root -p

create database webdb default character set utf8 collate utf8_unicode_ci;
create user 'manu'@'localhost' identified by 'manumysql';
grant all privileges on webdb.* TO 'manu'@'localhost';
flush privileges;
exit


## Configure Nginx


tee -a "${nginx_web_config_file}" > /dev/null << EOF
upstream php-handler {
        server unix:/var/run/php/php${php_ver}-fpm.sock;
}
server {
        listen 80;
        server_name ${domain} ${www_domain};
        root ${wp_dir};
        index index.php;
        location / {
                try_files $uri $uri/ /index.php?$args;
        }
        location ~ \.php$ {
                include snippets/fastcgi-php.conf;
                fastcgi_pass php-handler;
        }
}

# This config file has been created automatically by wp_server.sh
# $(date)
EOF

sudo ln -s "${nginx_web_config_file}" "${ngin_enabled_dir}"

sudo nginx -t

sudo systemctl restart nginx

sudo apt install php-curl php-dom php-mbstring php-imagick php-zip php-gd php${php_ver}-intl


## SSL with Certbot and Letsencrypt

sudo snap install core
sudo snap refresh core

sudo snap install --classic certbot

sudo ln -s /snap/bin/certbot /usr/bin/certbot

sudo certbot --nginx

systemctl list-timers




## DB backups

cd "${wp_db_backup_dir}"

mysqldump --add-drop-table -h localhost -u "${mysql_username}" -p "${mysql_db_name}" > ${mysql_db_name}.bak.$(date +%Y%m%d).sql



