#!/bin/bash -x 

echo "Welcome to Packer"
echo "Installing nginx..."
sudo apt-get update 
sudo apt-get install nginx -y
wait

echo "Create nginx folder"
sudo mkdir /home/wahyu
sudo mv /home/ubuntu/nginx.conf /home/wahyu
sudo cp /home/wahyu/nginx.conf /etc/nginx/sites-available/example
sudo mkdir /var/www/nginx


sudo ln -s /etc/nginx/sites-available/example /etc/nginx/sites-enabled/example
sudo rm /etc/nginx/sites-enabled/default

sudo cp /var/www/html/index* /var/www/nginx/index.html

echo "Check file for nginx configuration..."
ls -al /var/www/nginx
cat /var/www/nginx/index.html
cat /etc/nginx/sites-available/example


echo "Installing apache..."
sudo apt-get install apache2 apache2-bin apache2-utils mime-support ssl-cert -y
wait
sudo apt-get -f install
wait

echo "Create apache folder"
sudo mkdir /var/www/apache
sudo cp /var/www/html/index.html /var/www/apache/

echo "Configuring Apache port..."
sudo sed -i 's+*:80+localhost:8080+' /etc/apache2/ports.conf
sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/example.conf
sudo sed 's+Document.*+Document /var/www/apache+' /etc/apache2/sites-available/example.conf

echo "Check file for apache configuration..."
cat /etc/apache2/ports.conf
cat /etc/apache2/sites-available/example.conf

echo "check folder..."
ls -al /var/www
ls -al /etc/apache2/
echo "Check detail folder..."
ls -al /etc/apache2/sites-available/