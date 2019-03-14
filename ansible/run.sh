#!/usr/bin/env bash 

export ANSIBLE_TF_DIR=../terraform  
export ANSIBLE_HOST_KEY_CHECKING=false  
ansible-playbook   -i /opt/bin/terraform.py  ./playbook.yml --private-key=../keys/key/sshkey -u fedora
#ANSIBLE_TF_DIR=../terraform  ANSIBLE_HOST_KEY_CHECKING=false  ansible -i /opt/bin/terraform.py  all -m ping --private-key=../keys/key/sshkey -u fedora
