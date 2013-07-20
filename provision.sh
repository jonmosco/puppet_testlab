#!/usr/bin/env bash
# 
# Set up the Master and Agent Nodes to talk with each other
# Purpose: Learning Puppet
# 
# Master: 
# - Edit /etc/hosts
# - Turn off iptables
# Node:
# - Edit /etc/hosts
# - Turn off iptables

HOSTS="192.168.33.10 puppet.forkedprocess.com puppet
192.168.33.11 node.forkedprocess.com node"

NAME=$( hostname -s )

if [ "$NAME" = "puppet" ]; then
	echo "$HOSTS" >> /etc/hosts
	/sbin/service iptables stop && chkconfig iptables off
	/bin/rpm -ivh http://yum.puppetlabs.com/el/6/products/i386/puppetlabs-release-6-7.noarch.rpm
	/usr/bin/yum install puppet-server -y
	/usr/bin/puppet resource service puppetmaster ensure=running enable=true
elif [ "$NAME" = "node" ]; then
	echo "$HOSTS" >> /etc/hosts
	/sbin/service iptables stop && chkconfig iptables off
	/usr/bin/puppet resource service puppet ensure=running enable=true
fi
