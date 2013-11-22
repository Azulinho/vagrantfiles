

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

task :default => [ :install, :up ]

task :install do
  # clean Vagrantfile
  system("rm Vagrantfile")

  # Bindler is going beserk on me, lets fall back to a simple
  # vagrant plugin install
  plugins.each do |x|
    system("vagrant plugin install #{x}")
  end

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
  system("vagrant up")
end

task :destroy do
  system("vagrant destroy -f")
end
