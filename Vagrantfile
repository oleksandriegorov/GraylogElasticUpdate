# -*- mode: ruby -*-
# vi: set ft=ruby et sw=2 ts=2 ai :
Vagrant.configure("2") do |config|
  GL_MEM_MBytes = 1024
  ESD_MEM_MBytes = 2048
  ESM_MEM_MBytes = 2048
  ES_NODE_COUNT=2
  ESM_NODE_COUNT=2
  config.vm.box = "bento/centos-7"

  config.vm.provision "Main shell", type: "shell", inline: <<-SHELL
  rpm -Uvh https://yum.puppet.com/puppet6-release-el-7.noarch.rpm
  yum install -y puppet telnet nc net-tools bind-utils bash-completion vim
  SHELL

  (1..ESM_NODE_COUNT).each do |i|
    config.vm.define "esm-#{i}" do |esmaster|
      esmaster.vm.hostname = "esm-#{i}"
      esmaster.vm.network :private_network, ip: "10.17.17.3#{i}"
      esmaster.vm.provider :virtualbox do |v|
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--memory", ESM_MEM_MBytes]
        v.customize ["modifyvm", :id, "--name", "esm-#{i}"]
      end
      esmaster.vm.provision "Elastic Master shell node #{i}",type: "shell", inline: <<-SHELL
        PATH=${PATH}:/opt/puppetlabs/bin
        puppet module install elastic-elasticsearch 
        puppet module install puppetlabs/java
        #puppet module install elastic-elastic_stack
      SHELL
      esmaster.vm.provision "Puppet ES Master node #{i}", type: "puppet" do |puppet|
        puppet.manifests_path = "manifests"
        puppet.manifest_file = "elastic_master.pp"
      end
    end
  end
  
  (1..ES_NODE_COUNT).each do |i|
    config.vm.define "es-#{i}" do |es|
      es.vm.hostname = "es-#{i}"
      es.vm.network :private_network, ip: "10.17.17.2#{i}"
      es.vm.provider :virtualbox do |v|
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--memory", ESD_MEM_MBytes]
        v.customize ["modifyvm", :id, "--name", "es-#{i}"]
      end
      es.vm.provision "Elastic shell data node #{i}",type: "shell", inline: <<-SHELL
        PATH=${PATH}:/opt/puppetlabs/bin
        puppet module install elastic-elasticsearch
        puppet module install puppetlabs/java
        #puppet module install elastic-elastic_stack
      SHELL
      es.vm.provision "Puppet ES DATA node #{i}", type: "puppet" do |puppet|
        puppet.manifests_path = "manifests"
        puppet.manifest_file = "elastic_data.pp"
      end
    end
  end

  config.vm.define "gl" do |gl|
    gl.vm.hostname = 'gl'
    gl.vm.network :private_network, ip: "10.17.17.10"
    gl.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", GL_MEM_MBytes]
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


end
