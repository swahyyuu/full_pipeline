#!/bin/bash -x 

echo "Welcome to Packer"
echo "Installing nginx..."
sudo apt-get update 
sudo apt-get install nginx -y

echo "Installing apache..."
sudo apt-get install apache2 -y

echo "Create folder"
sudo mkdir /home/wahyu