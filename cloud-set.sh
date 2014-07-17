#!/bin/bash


if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

if [ -z "$1" ]
  then echo "Pass FQDN and try again, i.e p3nlhcsapp998.prod.phx3.secureserver.net"
  exit
fi

FQDN=$1

mkdir /etc/yum.repos.d/bak
mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/bak
#vim /etc/yum.repos.d/gd-spacewalk-v6.repo
cp /home/sfeltner/dotfiles/gd-spacewalk-v6.repo /etc/yum.repos.d/gd-spacewalk-v6.repo

#hostname p3nlhcsapp998.prod.phx3.secureserver.net
hostname $FQDN
vim /etc/hosts /etc/sysconfig/network

rm -f /etc/cron.d/update-sudoers
rm -f /etc/cron.d/gd-pbis-allow-login
yum -y erase gd-net-snmp-perl gd-net-snmp-libs
yum -y upgrade --exclude=Percona*

yum -y erase puppet
rm -fr /var/lib/puppet/
yum -y install gd-puppet27

cp /etc/puppet/puppet.conf.orig /etc/puppet/puppet.conf
#vim /etc/puppet/puppet.conf
printf "    server = puppetvm.cloud.dev.phx3.gdg\n    environment = site_hosting" >> /etc/puppet/puppet.conf

puppet agent --test --pluginsync

echo "Now go to the puppet master and 'puppet cert sign' the client cert and re-run puppet agent --test --pluginsync" 
