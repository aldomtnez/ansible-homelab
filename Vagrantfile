# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  
  config.vm.provider "virtualbox" do |rs|
    rs.memory = 2048
    rs.cpus = 2
  end

  # Skip box updates cheking every startup.
  config.vm.box_check_update = false

  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.boot_timeout = 900

  # master node where ansible will be installed
  config.vm.define "hostmgr_rocky" do |hostmgr_rocky|
    hostmgr_rocky.vm.box = "boxen/rockylinux-9"
    hostmgr_rocky.vm.box_version = "2024.07.24.10"
    hostmgr_rocky.vm.hostname = "hostmgr.home-lab.com"
    hostmgr_rocky.vm.network "private_network", ip: "192.168.57.3"
    hostmgr_rocky.vm.provision "shell", path: "global.sh"
    hostmgr_rocky.vm.provision "file", source: "keygen.sh", destination: "/home/vagrant/"
  end

  # managed server01
  config.vm.define "srv01_bookworm" do |srv01_bookworm|
    srv01_bookworm.vm.box = "debian/bookworm64"
    srv01_bookworm.vm.hostname = "srv01.home-lab.com"
    srv01_bookworm.vm.network "private_network", ip: "192.168.57.4"
    srv01_bookworm.vm.provision "shell", path: "global.sh"
  end

  # managed server02
  config.vm.define "srv02_rpm" do |srv02_rpm|
    srv02_rpm.vm.box = "opensuse/Leap-15.6.x86_64"
    srv02_rpm.vm.hostname = "srv02.home-lab.com"
    srv02_rpm.vm.network "private_network", ip: "192.168.57.5"
    srv02_rpm.vm.provision "shell", path: "global.sh"
  end

  # managed server03
  config.vm.define "srv03_jammy" do |srv03_jammy|
    srv03_jammy.vm.box = "ubuntu/jammy64"
    srv03_jammy.vm.hostname = "srv03.home-lab.com"
    srv03_jammy.vm.network "private_network", ip: "192.168.57.6"
    srv03_jammy.vm.provision "shell", path: "global.sh"
  end

end
