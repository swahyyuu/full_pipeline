#!/bin/bash -x 

echo "Welcome to Packer"
echo "Installing nginx..."
sudo apt-get update 
sudo apt-get install nginx -y

echo "Installing apache..."
sudo apt-get install apache2 apache2-bin apache2-utils mime-support ssl-cert -y

sudo apt-get -f install 

echo "Create folder"
sudo mkdir /home/wahyu
ls -al /home

echo "Configuring Nginx port..."
sudo sed -i 's/80/8080/' /etc/nginx/nginx.conf
cat /etc/nginx/nginx.conf

echo "Configuring Apache port..."
sudo sed -i 's/80/2000/' /etc/apache2/sites-available/000-default.conf
cat /etc/apache2/sites-available/000-default.conf