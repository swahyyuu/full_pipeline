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
sudo ufw enable 

sudo sed -i 's/80/2000/' /etc/apache2/sites-available/000-default.conf
sudo ufw allow 2000
sudo systemctl disable apache2
sudo ufw allow 'Apache'
sudo systemctl enable apache2
check_apache

sudo systemctl stop nginx
sudo ufw allow 'Nginx HTTP'
check_nginx

curl localhost
curl localhost:2000

cat /etc/apache2/sites-available/000-default.conf