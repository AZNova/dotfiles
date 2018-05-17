#!/bin/bash

sudo yum install -y centos-release-scl
sudo yum-config-manager --enable rhel-server-rhscl-7-rpms
#sudo yum-config-manager --enable epel
sudo yum -y install scl-utils

sudo yum install -y devtoolset-7

# Optionally, install ASAN
sudo yum install -y devtoolset-7-libasan-devel.x86_64

mkdir -p ~/projects/
cd ~/projects

git clone https://github.com/apache/trafficserver.git
cd ~/projects/trafficserver

git remote add reveller https://github.com/reveller/trafficserver.git
git fetch --all
