# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # NAT port forwarding
  config.vm.network :forwarded_port, guest: 22, host: 2200
  config.vm.network :forwarded_port, guest: 80, host: 80
  config.vm.network :forwarded_port, guest: 443, host: 443

  # synced/shared folders
  config.vm.synced_folder "L:\\CP2", "/var/www/CP2"
  #config.vm.synced_folder "c:\\certificates", "/usr/share/tomcat7/certs"

  # settings for vm
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048", "--cpus", "4", "--ioapic", "on"]
  end

  config.vm.provision :puppet do |puppet|
    puppet.module_path = "modules"
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "railo.pp"
  end

  config.vm.provision :puppet do |puppet|
    puppet.module_path = "modules"
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "railo-conf.pp"
  end


end
