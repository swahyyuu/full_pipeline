#!/bin/bash 
function library_install() {
  pip install boto3
  message=$(pip install boto3 2>&1)
  if [[ $? -ne 0 ]]; then 
    echo "$message"
    python3 -m pip install boto3
  fi
}

library_install
python3 ./clean_ami.py 
wait 
python3 ./clean_snapshot.py