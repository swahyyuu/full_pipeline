#!/bin/bash

function check_kms() {
  aws kms list-aliases --query 'Aliases[]/AliasName' | grep my-terra-kms
  if [[ $? -gt 0 ]]; then 
    sudo sed -i '7s/resource/data' ./modules/aws_kms/main.tf
    sudo sed -i '3s/aws_kms_alias/data.aws_kms_alias' ./modules/aws_kms/outputs.tf
  fi
}

check_kms()