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

		echo "Turning off Firewall and setting selinux to Permissive on our Puppet Master..."
		/sbin/service iptables stop > /dev/null && chkconfig iptables off > /dev/null
		/usr/sbin setenforce 0
		echo "Done"

		echo "Installing Puppet Master.."
		/bin/rpm -ivh http://yum.puppetlabs.com/el/6/products/i386/puppetlabs-release-6-7.noarch.rpm \
			> /dev/null 2>&1
		/usr/bin/yum install puppet-server -y > /dev/null 2>&1
		echo "Done"

		echo "Starting Puppet Master Service"
		/usr/bin/puppet resource service puppetmaster ensure=running enable=true > /dev/null 2>&1
		master=$?
		if [ $master -eq 0 ]; then
			echo "Done"
		fi
		;;
	node)
		echo "$HOSTS" >> /etc/hosts

		echo "Turning off Firewall and setting selinux to Permissive on our Puppet Node..."
		/sbin/service iptables stop > /dev/null 2>&1 \
			&& chkconfig iptables off > /dev/null 2>&1
		/usr/sbin setenforce 0
		echo "Done"

		echo "Starting Puppet Agent Service"
		/usr/bin/puppet resource service puppet ensure=running enable=true > /dev/null 2>&1
		agent=$?
		if [ $agent -eq 0 ]; then
			echo "Done"
		fi
		;;
esac 
