# -*- mode: ruby -*-
# vi: set ft=ruby :

Dotenv.load

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  #config.vm.box = "ubuntu/trusty64"
  config.vm.box = "opscode-centos-6.5"
  config.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-6.5_chef-provisionerless.box"
  #config.ssh.max_tries = 40
  #config.ssh.timeout   = 120
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.provider :digital_ocean do |provider, override|
    override.ssh.username = "vagrant"
    override.ssh.private_key_path = "~/.ssh/id_rsa"
    override.vm.box = 'digital_ocean'
    override.vm.box_url = "https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box"

    override.ssh.pty       = true

    provider.token = ENV["DIGITALOCEAN_TOKEN"]
#    provider.image = 'ubuntu-14-10-x64'
    provider.image = 'centos-6-5-x64'
    provider.region = 'nyc3'
    provider.size = '1GB'

    if ENV['WERCKER'] == "true"
      provider.ssh_key_name = "wercker chef"
    else
      provider.ssh_key_name = "My MacBook Air"
    end

    # use vagrant-omnibus
    # issue https://github.com/opscode/vagrant-omnibus/issues/96
    # override.omnibus.chef_version = :latest
    override.omnibus.chef_version = "11.16.0"

    override.vm.provision "chef_solo" do |chef|
      chef.custom_config_path = "Vagrantfile.chef"
      chef.cookbooks_path = ["cookbooks"]
      chef.roles_path = "./roles"
      chef.data_bags_path = "./data_bags"
      chef.node_name = "webapp"
      chef.run_list  = %w[
        role[base]
        role[web]
        role[db]
        role[app]
      ]
    end
  end
end
