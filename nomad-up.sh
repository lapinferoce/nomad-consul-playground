#!/usr/bin/env bash

cd ./terraform
terraform refresh
terraform apply
cd ..
cd ./ansible 
./run.sh
cd -
