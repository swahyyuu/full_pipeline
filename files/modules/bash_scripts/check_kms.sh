#!/bin/bash 
function check_kms(kms_name) {
  aws kms list-aliases --query 'Aliases[]/AliasName' | grep $kms_name
  if [[ $? -gt 0 ]]; then 
    continue
  else
    sudo sed -i '7s/resource/data' ./modules/aws_kms/main.tf
    sudo sed -i '3s/aws_kms_alias/data.aws_kms_alias' ./modules/aws_kms/outputs.tf
  fi
}

check_kms($1)