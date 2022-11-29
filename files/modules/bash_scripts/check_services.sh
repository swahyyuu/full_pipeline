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

echo "Setting up firewall configuration using iptables..."
sudo iptables -L -v
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 8080 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 2000 -j ACCEPT
sudo /sbin/iptables-save
sudo iptables -L --line-numbers

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

echo "apache file configuration..."
cat /etc/apache2/sites-available/000-default.conf

ss -tulpn
ls -al /home
ls -al /etc/nginx/

echo "nginx file configuration..."
cat /etc/nginx/nginx.conf