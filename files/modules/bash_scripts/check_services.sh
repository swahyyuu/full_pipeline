#!/bin/bash

function check_nginx() {
  systemctl is-active --quiet nginx 
  if [[ $? -ne 0 ]]; then
    sudo systemctl start nginx 
  fi
}


function check_apache() {
  systemctl is-active --quiet apache2
  if [[ $? -ne 0 ]]; then
    sudo systemctl start apache2
  fi
}

echo "Configuring server firewall"
sudo ufw enable
sudo ufw allow 80
sudo ufw allow 2000
sudo ufw allow 22

echo "Nginx shutting down..."
sudo systemctl stop nginx
echo "Apache shutting down..."
sudo systemctl disable apache2


echo "Activate Apache..."
sudo systemctl enable apache2
check_apache


echo "Allow Nginx..."
check_nginx

echo "curl nginx server..."
curl localhost:8080

echo "curl apache server..."
curl localhost:2000

cat /etc/apache2/sites-available/000-default.conf
ss -tulpn
sudo ufw status
ls -al /home