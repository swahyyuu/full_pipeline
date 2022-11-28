#!/bin/bash -x

function check_kms() {
  aws kms list-aliases --query 'Aliases[].AliasName' | grep my-terra-kms
  if [[ $? -gt 0 ]]; then 
    sed -i '7s/resource/data' ./modules/aws_kms/main.tf
    sed -i '3s/aws_kms_alias/data.aws_kms_alias' ./modules/aws_kms/outputs.tf
  fi
}

check_kms