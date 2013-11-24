include_recipe 'windows'

remote_file "#{Chef::Config[:file_cache_path]}/#{node['umbraco']['zipfile']}" do
    source node['umbraco']['url']
    checksum node['umbraco']['checksum']

end

windows_zipfile "#{node['iis']['docroot']}" do
  source "#{Chef::Config[:file_cache_path]}/#{node['umbraco']['zipfile']}"
  action :unzip
  not_if {::File.exists?("#{node['iis']['docroot']}/Umbraco")}
end


windows_batch 'set folder permissions' do
  cwd "#{node['iis']['docroot']}"
  code  <<-EOH
    REM Following line in original script incorrectly sets all child folder permissions
    REM icacls . /grant "IIS_IUSRS":(OI)(CI)M
    icacls app_code /grant "IIS_IUSRS":(OI)(CI)RX
    icacls app_browsers /grant "IIS_IUSRS":(OI)(CI)RX
    icacls app_data /grant "IIS_IUSRS":(OI)(CI)M
    icacls bin /grant "IIS_IUSRS":(OI)(CI)R
    icacls config /grant "IIS_IUSRS":(OI)(CI)M
    icacls css /grant "IIS_IUSRS":(OI)(CI)M
    icacls data /grant "IIS_IUSRS":(OI)(CI)M
    icacls masterpages /grant "IIS_IUSRS":(OI)(CI)M
    icacls media /grant "IIS_IUSRS":(OI)(CI)M
    icacls python /grant "IIS_IUSRS":(OI)(CI)M
    icacls scripts /grant "IIS_IUSRS":(OI)(CI)M
    icacls umbraco /grant "IIS_IUSRS":(OI)(CI)M
    icacls usercontrols /grant "IIS_IUSRS":(OI)(CI)R
    icacls xslt /grant "IIS_IUSRS":(OI)(CI)M
    icacls views /grant "IIS_IUSRS":(OI)(CI)M
    icacls web.config /grant "IIS_IUSRS":(OI)(CI)M
    icacls web.config /grant "IIS_IUSRS":M
  EOH
end
