#!/bin/bash

echo "Waiting for mysql"
host="$1"
port="$2"
root_pwd="$3"
until mysql -h"$host" -P"$port" -uroot -p"root_pwd" &> /dev/null
do
  printf "."
  sleep 1
done

echo -e "\nmysql ready"
