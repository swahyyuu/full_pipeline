#!/bin/bash -x

function check_kms() {
  aws kms describe-key --key-id alias/my-terra-kms | grep "DeletionDate"
  if [[ $? -eq 0 ]]; then
    cd modules/aws_kms/
    rm main.tf && mv main.tf.kms main.tf 
    rm outputs.tf && mv outputs.tf.kms outputs.tf
    rm variables.tf && mv variables.tf.kms variables.tf
  fi
}

check_kms