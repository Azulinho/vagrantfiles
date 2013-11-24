

include_recipe 'windows'

windows_package "#{Chef::Config[:file_cache_path]}/#{node['mysql']['installer_file']}" do
  package_name "MySQL Installer"
  source node['mysql']['url']
  checksum node['mysql']['checksum']
  options "/quiet"
  action :install
  notifies :run , "execute[Install mySQL]"
end

execute "Install mySQL" do
  command "#{node['mysql']['installer_cli']}"
  action :nothing
end

