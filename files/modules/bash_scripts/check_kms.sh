#!/bin/bash -x

function check_kms() {
  aws kms describe-key --key-id alias/my-terra-kms | grep "DeletionDate"
  if [[ $? -eq 0 ]]; then
    cd modules/aws_kms/
    sed -i '4s/my-terra-kms/remove-delayed' variables.tf
  fi
}

check_kms