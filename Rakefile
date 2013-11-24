

plugins = [
  "chef",
  "sahara",
  "vagrant-berkshelf",
  "vagrant-cachier",
  "vagrant-chefzero",
  "vagrant-cucumber",
  "vagrant-docker",
  "vagrant-global-status",
  "vagrant-hostmanager",
  "vagrant-lxc",
  "vagrant-multiprovider-snap",
  "vagrant-ohai",
  "vagrant-omnibus",
  "vagrant-persistent-storage",
  "vagrant-pristine",
  "vagrant-reload",
  "vagrant-vbguest",
  "vagrant-vbox-snapshot",
  "vagrant-windows",
  "vocker"
]

boxes = {
  :precise64 => "http://files.vagrantup.com/precise64.box",
  :WIN2K8R2 => "https://dl.dropboxusercontent.com/u/183941/WIN2K8R2.box"
}


task :default do
  puts "available tasks:"
  puts "setup           -> downloads boxes, installs plugins"
  puts "up              -> vagrant up but not provision"
  puts "provision       -> berks update and vagrant provision"
  puts "install         -> install vagrant plugins"
  puts "download_boxes  -> download the vagrant boxes"
  puts "clean_boxes     -> remove the downloaded vagrant boxes"
  puts "uninstall       -> destroy the VMs and uninstall the vagrant plugins"
  puts "destroy         -> destroy the VMs"
end

task :setup => [
  :install, :download_boxes, :import_boxes ]

task :install do
  # clean Vagrantfile
  system("rm Vagrantfile")

  # Bindler is going beserk on me, lets fall back to a simple
  # vagrant plugin install
  plugins.each do |x|
    system("vagrant plugin install #{x}")
  end

  # we need the latest vagrant-vbguest
  system("vagrant plugin install --plugin-source http://rubygems.org/ --plugin-prerelease vagrant-vbguest")

  # install good vagrantfile
  system("cp Vagrantfile.latest Vagrantfile")
end


task :uninstall => [:destroy ] do
  # clean Vagrantfile
  system("rm Vagrantfile")

  plugins.each do |x|
    system("vagrant plugin uninstall #{x}")
  end

end

task :provision do
  system("berks update")
  system("vagrant provision")
end

task :up do
  system("vagrant up --no-provision")
end

task :destroy do
  system("vagrant destroy -f")
end

task :download_boxes do
  boxes.each_pair do |name,url|
    system("wget #{url}")
  end
end

task :import_boxes do
  boxes.each_pair do |name,url|
    system("vagrant box add #{name} #{url}")
  end
end


task :clean_boxes do
  boxes.each_pair do |name,url|
    system("rm #{name}.box")
  end
end
