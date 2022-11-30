#!/bin/bash

function check_docker() {
  systemctl is-active --quiet docker 
  if [[ $? -ne 0 ]]; then
    sudo systemctl start docker
  fi
}

sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
wait

sudo apt update
apt-cache policy docker-ce 
wait 

sudo apt install docker-ce -y
check_docker
wait