#!/bin/bash -x

function check_kms() {
  aws kms describe-key --key-id alias/my-terra-kms | grep "DeletionDate"
  if [[ $? -eq 0 ]]; then
    cd modules/aws_kms/
    rm variables.tf && mv variables.tf.new_kms variables.tf
  fi
}

check_kms