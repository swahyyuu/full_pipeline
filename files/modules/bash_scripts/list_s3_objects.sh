#!/bin/bash
set -e

eval "$(jq -r '@sh "BUCKET_NAME=\(.id)"')"

command=$(aws s3api list-objects --bucket skripsi-image-product | jq '.Contents[].Key' | jq -R -s 'split("\n")' | jq '.[:-1]' | awk '{print $1}')

lists=()

for ((i=0; i<${#command[@]}; i++))
do
  lists+=("${command[$i]}")
done

echo ${lists[@]}

jq -n --arg name_list "$lists" '{"Name":$name_list}'