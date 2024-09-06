#!/usr/bin/env bash

# THIS SCRIPT WILL CREATE SSH KEYPAIR AND DISTRIBUTE ACROSS ALL NODES

ssh-keygen -b 2048 -t rsa -f /home/vagrant/.ssh/id_rsa -q -N ""

# LOOPING THROUGH AND DISTRIBUTING THE KEY

for val in hostmgr srv01 srv02 srv03; do 
	echo "-------------------- COPYING KEY TO ${val^^} NODE ------------------------------"
	sshpass -p 'vagrant' ssh-copy-id -o "StrictHostKeyChecking=no" vagrant@$val 
done

# CREATE THE INVENTORY FILE

PROJECT_DIRECTORY="/home/vagrant/ansible_projects/"

mkdir -p $PROJECT_DIRECTORY
cd $PROJECT_DIRECTORY

# Creating the inventory file for all 3 nodes to run some adhoc command.

echo -e "hostmgr\n\n[debian]\nsrv01\n[opensuse]\nsrv02\n[jammy]\nsrv03\n" > inventory
echo -e "[defaults]\ninventory = inventory" > ansible.cfg
echo -e "-------------------- RUNNING ANSBILE ADHOC COMMAND - UPTIME ------------------------------"
echo

# running adhoc command to see if everything is fine
ansible all -i inventory -m "ping"
ansible all -i inventory -m "shell" -a "uptime"
echo
