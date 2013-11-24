include_recipe "windows"
include_recipe 'iis'
include_recipe 'iis::mod_mvc3'
include_recipe 'iis::mod_urlrewrite'
include_recipe 'iis::mod_aspnet'

node.override['iis']['accept_eula'] = true
%w(IIS-WebServerRole
   IIS-WebServer
   IIS-ApplicationDevelopment
   IIS-ISAPIFilter
   IIS-ISAPIExtensions)
   .each do |f|
      windows_feature f do
        action :install
      end
   end
