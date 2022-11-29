#!/bin/bash -x 

echo "Welcome to Packer"
echo "Installing nginx..."
sudo apt-get update 
sudo apt-get install nginx -y

echo "Create nginx folder"
sudo mkdir /home/wahyu
sudo mkdir /var/www/nginx


cat <<EOF >> /etc/nginx/sites-available/example
server{
listen 80;
root /var/www/nginx;
index index.html index.php;
server_name example.com;
location / {
try_files $uri $uri/ /index.html =404;  
}
location ~ \.php$ {
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Forwarded-For $remote_addr;
proxy_set_header Host $host;
proxy_pass http://127.0.0.1:8080;  
}
}
EOF

sudo ln -s /etc/nginx/sites-available/example /etc/nginx/sites-enabled/example
sudo rm /etc/nginx/sites-enabled/default

sudo cp /var/www/html/index* /var/www/nginx/index.html

echo "Check file for nginx configuration..."
ls -al /var/www/nginx
cat /etc/nginx/sites-available/example


echo "Installing apache..."
sudo apt-get install apache2 apache2-bin apache2-utils mime-support ssl-cert -y

sudo apt-get -f install

echo "Create apache folder"
sudo mkdir /var/www/apache
sudo cp /var/www/html/index.html /var/www/apache/

echo "Configuring Apache port..."
sudo sed -i 's/*:80/localhost:8080/' /etc/apache2/ports.conf
sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/site-available/example.conf
sed 's+Document.*+Document /var/www/apache+' /etc/apache2/sites-available/example.conf

echo "Check file for apache configuration..."
cat /etc/apache2/ports.conf
cat /etc/apache2/site-available/example.conf
ls -al /var/www