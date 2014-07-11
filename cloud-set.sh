#!/bin/bash

FQDN=$1

mkdir /etc/yum.repos.d/bak
mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/bak
#vim /etc/yum.repos.d/gd-spacewalk-v6.repo
cp ~/dotfiles/gd-spacewalk-v6.repo /etc/yum.repos.d/gd-spacewalk-v6.repo

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
printf "    server = puppetvm.ddns.lxpro.com\n    environment = site_hosting" >> /etc/puppet/puppet.conf

puppet agent --test --pluginsync        <= to create the SSL cert on the puppetmaster

echo "No go to the puppet master and 'puppet cert sign' the client cert and re-run puppet agent --test --pluginsync" 
