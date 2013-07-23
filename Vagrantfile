#
# Puppet environment for Master/Agent testing
#
Vagrant.configure("2") do |config|

  # Set up our environment
  config.vm.provision :shell, :path => "provision.sh"

  # Performance gain
  config.vm.synced_folder ".", "/vagrant", :nfs => true

  # Puppet master
  config.vm.define :master do |master|
    master.vm.box = "centos6"
    master.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-fusion503.box"
    master.vm.hostname = "puppet.forkedprocess.com"
    master.vm.network :private_network, ip: "192.168.33.10"
    master.vm.network :forwarded_port, guest: 80, host: 8080
  end

  # Puppet node
  config.vm.define :node do |node|
    node.vm.box = "centos6"
    node.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-fusion503.box"
    node.vm.hostname = "node.forkedprocess.com"
    node.vm.network :private_network, ip: "192.168.33.11"
  end

end
