#!/usr/bin/env bash

# vagrant by default creates its own keypair for all the machines.
# Password based authentication will be disabled by default and enabling it so password based auth can be done.

sudo sed -i 's/^#PasswordAuthentication/PasswordAuthentication/g' /etc/ssh/sshd_config
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

sudo sed -i 's/^#KbdInteractiveAuthentication/KbdInteractiveAuthentication/g' /etc/ssh/sshd_config
sudo sed -i 's/^KbdInteractiveAuthentication no/KbdInteractiveAuthentication yes/' /etc/ssh/sshd_config

#sudo sed -i '/^PasswordAuthentication/i ChallengeResponseAuthentication yes' /etc/ssh/sshd_config

echo "Ensure vagrant user password"
echo "vagrant:vagrant" | sudo chpasswd
sudo systemctl restart sshd

echo "Suppresing banned message"
touch /home/vagrant/.hushlogin

# Updating the hosts file for all nodes with the IP given in Vagrantfile

sudo echo -e "192.168.57.3 hostmgr.home-lab.com hostmgr\n192.168.57.4 srv01.home-lab.com srv01\n192.168.57.5 srv02.home-lab.com srv02\n192.168.57.6 srv03.home-lab.com srv03" >> /etc/hosts

# Setting up time zone
echo "Setting up Time Zone"
sudo timedatectl set-timezone America/Chicago

# Install ansible using pip only in master node
echo "Updating system and installing required packages"

if [[ $(hostname) = "hostmgr.home-lab.com" ]]; then
  sudo yum update -y
  sudo yum install curl gpg wget net-tools iputils python3-pip sshpass -y
  sudo pip3 install ansible
  echo "vagrant:vagrant" | sudo chpasswd
fi
