#!/bin/bash 
function check_kms(kms_name) {
  aws kms list-aliases --query 'Aliases[]/AliasName' | grep $kms_name
  if [[ $? -gt 0 ]]; then 
    continue
  else
    sudo sed -i '7s/resource/data' terraform-plan
    sudo sed -i '3s/aws_kms_alias/data.aws_kms_alias' terraform-plan
  fi
}

check_kms($1)