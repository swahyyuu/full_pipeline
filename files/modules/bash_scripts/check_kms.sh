#!/bin/bash -x

function check_kms() {
  aws kms list-aliases --query 'Aliases[].AliasName' | grep my-terra-kms
  if [[ $? -eq 0 ]]; then
    cd modules/aws_kms/
    rm main.tf && mv main.tf.kms main.tf 
    rm outputs.tf && mv outputs.tf.kms outputs.tf
  fi
}

check_kms