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

echo "Setting up inside the server..."
sudo sed -i 's/80/2000/' /etc/apache2/sites-available/000-default.conf
sudo ufw allow 2000

echo "Apache being set up..."
sudo systemctl disable apache2
sudo ufw allow 'Apache'
sudo systemctl enable apache2
check_apache

echo "Nginx being set up..."
sudo systemctl stop nginx
sudo ufw allow 'Nginx HTTP'
check_nginx

curl localhost
curl localhost:2000

cat /etc/apache2/sites-available/000-default.conf