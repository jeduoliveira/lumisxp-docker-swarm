# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_NO_PARALLEL'] = 'yes'

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "centos/7"

  boxes = [
    { :name => "manager",           :ip => "192.168.50.10", :memory => 1256 },
    { :name => "worker1",           :ip => "192.168.50.11", :memory => 1256 },
    { :name => "worker2",           :ip => "192.168.50.12", :memory => 1256 },
    { :name => "worker3",           :ip => "192.168.50.13", :memory => 1256 },
  ]

  # Provision each of the VMs.
  boxes.each do |opts|
    config.vm.define opts[:name] do |config|
      config.vm.hostname = opts[:name]
      config.vm.network :private_network, ip: opts[:ip]
      config.vm.provision "shell", inline: "sudo setenforce 0 && yum update -y"
      
      config.vm.provider :virtualbox do |v|
        v.memory = opts[:memory]
        v.cpus = 1
        v.linked_clone = true
      end
    end
  end
end
