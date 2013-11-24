

include_recipe 'windows'

#remote_file "#{Chef::Config[:file_cache_path]}/#{node['mysql']['installer_file']}" do
    #source node['mysql']['url']
    #checksum "7ca554bcda5d859e71b97f2ed13ec42b"
#end

windows_package "#{Chef::Config[:file_cache_path]}/#{node['mysql']['installer_file']}" do
  package_name "MySQL Installer"
  source node['mysql']['url']
  checksum node['mysql']['checksum']
  options "/quiet"
  action :install
end

execute "Install mySQL" do
  command "#{node['mysql']['installer_cli']}"
  action :run
end

