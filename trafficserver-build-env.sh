#!/bin/bash

#sudo yum install -y centos-release-scl
#sudo yum-config-manager --enable rhel-server-rhscl-7-rpms
#sudo yum-config-manager --enable epel
#sudo yum -y install scl-utils

#sudo yum install -y devtoolset-7

# Optionally, install ASAN
sudo yum install -y devtoolset-7-libasan-devel.x86_64

sudo yum install -y gcc gcc-c++ pkgconfig pcre-devel tcl-devel expat-devel openssl-devel
sudo yum install -y libcap libcap-devel hwloc hwloc-devel ncurses-devel libcurl-devel
sudo yum install -y libunwind libunwind-devel
sudo yum install -y autoconf automake libtool
gcc -v

mkdir -p ~/projects/
cd ~/projects

git clone https://github.com/apache/trafficserver.git
cd ~/projects/trafficserver

git remote add reveller https://github.com/reveller/trafficserver.git
git fetch --all
