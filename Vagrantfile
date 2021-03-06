# vim: ai ts=2 sts=2 et sw=2 ft=ruby
# vim: autoindent tabstop=2 shiftwidth=2 expandtab softtabstop=2 filetype=ruby
#
# Intall required vagrant plugins using:
#   vagrant plugin install bindler
#   vagrant bindler setup
#   vagrant plugin bundle
#


chef0_ip = '172.16.1.2'
chef0_port = '4000'

cookbook_testers = {
  #:archlinux => {
  #  :hostname => "archlinux-cookbook-test",
  #  :ipaddress => "172.16.1.5",
  #  :run_list => "recipe[vagrant-httpproxy]"
 # },
  #:centos64 => {
    #:vmbox_url => "https://github.com/2creatives/vagrant-centos/releases/" +
    #"download/v0.1.0/centos64-x86_64-20131030.box",
    #:hostname => "centos64-cookbook-test",
    #:ipaddress => "172.16.1.10",
    #:disks => {
      #:disk1 => {
        #:size => "50",
        #:filesystem => "ext4",
        #:mountname => "mnt1",
        #:mountpoint => "/mnt/mnt1",
        #:volgroupname => "vg01"
      #}
    #},
    #:run_list => "recipe[apache]"
  #},
  :precise => {
    :vmbox_name => 'precise64',
    :vmbox_url => 'http://files.vagrantup.com/precise64.box',
    :hostname => "precise-cookbook-test",
    :ipaddress => "172.16.1.11",
    :run_list => "recipe[app-wordpress]",
    :on_boot => [ "apt-get update",
                     "echo -e 'vagrant\nvagrant' | passwd root "
                   ],
    :os_type => "linux"
  },
  :WIN2K8R2 => {
    :vmbox_name => 'WIN2K8R2',
    :vmbox_url => 'FILL ME IN',
    :hostname => "win2k8-cookbook-test",
    :ipaddress => "172.16.1.12",
    :run_list => "recipe[app-umbraco]",
    :on_boot => [],
    :os_type => "windows"
    }
}

Vagrant.require_plugin "vagrant-chefzero"
Vagrant.require_plugin "vagrant-berkshelf"
Vagrant.require_plugin "vagrant-omnibus"

Vagrant.configure("2") do |global_config|

  global_config.vm.define :chefzero do |vbox|
    vbox.vm.network :private_network, ip: chef0_ip
    vbox.vm.hostname = "chefzero"
    vbox.vm.box = 'precise64'
    vbox.vm.box_url = 'http://files.vagrantup.com/precise64.box'

    vbox.vm.provision :chefzero do |vm|
      vm.ip = chef0_ip
      vm.port = chef0_port
      vm.setup do |p|
        p.import_berkshelf_cookbooks
      end
    end
  end

  cookbook_testers.each_pair do |name, options|

    global_config.vm.define name do |config|
      vm_name = "#{name}-cookbook-test"
      ipaddress = options[:ipaddress]

      #configuration for vagrant plugins:
      # (cachier, berkshelf, hostmanager, omnibus, vbox, chef_zero)
      config.berkshelf.enabled = true
      config.cache.auto_detect = true
      config.hostmanager.enabled = true
      config.hostmanager.ignore_private_ip = false
      config.hostmanager.include_offline = true
      config.hostmanager.manage_host = true
      config.vbguest.auto_update = true
      config.vm.boot_timeout = 300
      config.vm.box = options[:vmbox_name]
      config.vm.box_url = options[:vmbox_url]
      config.vm.hostname = name.to_s
      config.vm.network "private_network", ip: ipaddress
      config.vm.synced_folder ".", "/vagrant", disabled:  true

      config.vm.provider "virtualbox" do |v|
        v.gui = false
      end

      case options[:os_type]
      when "windows"

        config.windows.halt_timeout = 25
        config.winrm.username = "vagrant"
        config.winrm.password = "vagrant"
        config.vm.guest = :windows
        # Port forward WinRM and RDP
        config.vm.network :forwarded_port, guest: 3389, host: 3389
        config.vm.network :forwarded_port, guest: 5985, host: 5985

      when "linux"

      config.omnibus.chef_version = :latest

        unless options[:disks].nil?
          options[:disks].each_pair do |disk_name, disk_options|
            config.persistent_storage.enabled = true
            config.persistent_storage.location = "./#{name.to_s}-#{disk_name}"
            config.persistent_storage.size = disk_options[:size]
            config.persistent_storage.mountname = disk_options[:mountname]
            config.persistent_storage.filesystem = disk_options[:filesystem]
            config.persistent_storage.mountpoint = disk_options[:mountpoint]
            config.persistent_storage.volgroupname = disk_options[:volgroupname]
          end
        end

        unless options[:on_boot].nil?
          options[:on_boot].each do |action|
            config.vm.provision "shell" do |s|
              s.inline = action
            end
          end
        end

      end

      config.vm.provision :chef_client do |chef|
        chef.node_name = vm_name
        chef.provisioning_path = "/etc/chef"
        chef.chef_server_url = "http://#{chef0_ip}:#{chef0_port}"
        chef.validation_key_path = Vagrant::ChefzeroPlugin.pemfile
        chef.client_key_path = Vagrant::ChefzeroPlugin.pemfile
        chef.log_level = :info
        #run_list = ['recipe[vagrant-httpproxy]']
        run_list = []
        run_list << ENV['CHEF_RUN_LIST'].split(",") if ENV.has_key?('CHEF_RUN_LIST')
        chef.run_list = [options[:run_list].split(","), run_list].flatten

        chef.json = {
          'vagrant-httpproxy' => {
            'proxy-host' => "172.16.1.1",
            'proxy-port' => "8123"
          }
        }
      end
    end
  end
end


