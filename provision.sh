#!/usr/bin/env bash
# 
# Set up the Master and Agent Nodes to talk with each other
# Purpose: Learning Puppet
# 
# Master: 
# - Edit /etc/hosts
# - Turn off iptables
# - set selinux to permissive mode
# Node:
# - Edit /etc/hosts
# - Turn off iptables
# - set selinux to permissive mode
# 
# TODO
# - turn if into case [DONE 7/22/13]

HOSTS="192.168.33.10 puppet.forkedprocess.com puppet
192.168.33.11 node.forkedprocess.com node"

# Get out hostname
NAME=$( hostname -s )

case $NAME in 
	puppet)
		echo "$HOSTS" >> /etc/hosts
		/sbin/service iptables stop && chkconfig iptables off
		/usr/sbin setenforce 0
		/bin/rpm -ivh http://yum.puppetlabs.com/el/6/products/i386/puppetlabs-release-6-7.noarch.rpm
		/usr/bin/yum install puppet-server -y
		/usr/bin/puppet resource service puppetmaster ensure=running enable=true
		;;
	node)
		echo "$HOSTS" >> /etc/hosts
		/sbin/service iptables stop && chkconfig iptables off
		/usr/sbin setenforce 0
		/usr/bin/puppet resource service puppet ensure=running enable=true
		;;
esac 
