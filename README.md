Puppet Demo Lab
===============================================================================

Purpose
-------------------------------------------------------------------------------

This Vagrant file will set up a complete Puppet Master and Agent 
environment provisioned for proper communication between the two. 

This is a demo lab for learning Puppet 

Usage
-------------------------------------------------------------------------------

provision.sh provides configuration to setup a master/agent

	- Install the PuppetLabs Yum Repo
	- Download and install Puppet
	- Adds correct entries in /etc/hosts
	- Stops firewall on both hosts
	- Installs and starts the Puppet Master
	- Installs and starts the Puppet Agent
