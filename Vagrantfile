# -*- mode: ruby -*-
# vi: set ft=ruby et sw=2 ts=2 ai :
Vagrant.configure("2") do |config|
  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "Main shell", type: "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  rpm -Uvh https://yum.puppet.com/puppet6-release-el-7.noarch.rpm
  yum install -y puppet telnet nc net-tools bind-utils bash-completion vim
  SHELL
  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  config.vm.box = "bento/centos-7"
  config.vm.define "gl" do |gl|
    gl.vm.hostname = 'gl'

    gl.vm.network :private_network, ip: "10.17.17.10"

    gl.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 1024]
      v.customize ["modifyvm", :id, "--name", "gl"]
    end
    gl.vm.provision "Graylog shell",type: "shell", inline: <<-SHELL
      PATH=${PATH}:/opt/puppetlabs/bin
	  puppet module install graylog/graylog
          puppet module install puppet-mongodb
          puppet module install puppetlabs/java
          puppet module install philomory/graylog_api

    SHELL
  gl.vm.network "forwarded_port", guest: 9000, host: 8081

  end

  config.vm.define "es" do |es|
    es.vm.hostname = 'es'

    es.vm.network :private_network, ip: "10.17.17.20"

    es.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 1024]
      v.customize ["modifyvm", :id, "--name", "es"]
    end
    es.vm.provision "Elastic shell",type: "shell", inline: <<-SHELL
      PATH=${PATH}:/opt/puppetlabs/bin
	  puppet module install elastic/elasticsearch
          puppet module install puppetlabs/java
    SHELL
    es.vm.provision "Puppet ES DATA", type: "puppet" do |puppet|
      puppet.manifests_path = "manifests"
      puppet.manifest_file = "elastic_data_6.pp"
    end

  end

  config.vm.define "es2" do |es2|
    es2.vm.hostname = 'es2'

    es2.vm.network :private_network, ip: "10.17.17.23"

    es2.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 4096]
      v.customize ["modifyvm", :id, "--name", "es2"]
    end
    es2.vm.provision "Elastic 2 shell",type: "shell", inline: <<-SHELL
      PATH=${PATH}:/opt/puppetlabs/bin
	    puppet module install elastic/elasticsearch
      puppet module install puppetlabs/java
    SHELL
    es2.vm.provision "Puppet ES DATA 2", type: "puppet" do |puppet|
      puppet.manifests_path = "manifests"
      puppet.manifest_file = "elastic_data2_6.pp"
    end
  end


  config.vm.define "esm" do |esm|
    esm.vm.hostname = 'esm'

    esm.vm.network :private_network, ip: "10.17.17.21"

    esm.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "esm"]
    end
    esm.vm.provision "Elastic Master shell",type: "shell", inline: <<-SHELL
      PATH=${PATH}:/opt/puppetlabs/bin
	  puppet module install elastic/elasticsearch
      puppet module install puppetlabs/java
    SHELL
    esm.vm.provision "Puppet ES Master", type: "puppet" do |puppet|
      puppet.manifests_path = "manifests"
      puppet.manifest_file = "elastic_master_6.pp"
    end

  end

  config.vm.define "esm2" do |esm2|
    esm2.vm.hostname = 'esm2'

    esm2.vm.network :private_network, ip: "10.17.17.22"

    esm2.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 4096]
      v.customize ["modifyvm", :id, "--name", "esm2"]
    end
    esm2.vm.provision "Elastic Master2 shell",type: "shell", inline: <<-SHELL
      PATH=${PATH}:/opt/puppetlabs/bin
	  puppet module install elastic/elasticsearch
      puppet module install puppetlabs/java
    SHELL
    esm2.vm.provision "Puppet ES Master 2", type: "puppet" do |puppet|
      puppet.manifests_path = "manifests"
      puppet.manifest_file = "elastic_master2_6.pp"
    end

  end


end
