
# wrapper::install-mysql

default['mysql']['version'] = "5.6.14.0"
default['mysql']['checksum'] = "7ca554bcda5d859e71b97f2ed13ec42b"

default['mysql']['installer_file'] = \
  "mysql-installer-community-#{node['mysql']['version']}.msi"

default['mysql']['base_url'] =\
  "http://dev.mysql.com/get/Downloads/MySQLInstaller/"

default['mysql']['url'] = \
  "#{node['mysql']['base_url']}/#{node['mysql']['installer_file']}"

default['mysql']['basedir'] = \
  "#{ENV['SYSTEMDRIVE']}\\Program Files (x86)\\MySQL\\"

  default['mysql']['installer_cli'] = %Q[
    c:\\Program\ Files\ (x86)\\mySql\\MySQL\ Installer\\MySQLInstallerConsole.exe
    --config=mysql-server-5.6-winx64:passwd=root
    --product=mysql-server-5.6-winx64
    --catalog=mysql-5.6-winx64
    --action=install
    --type=full
    --nowait ]



# wrapper::install-umbraco

default['umbraco']['url'] = "http://our.umbraco.org/ReleaseDownload?id=92348"
default['umbraco']['zipfile'] = "umbraco.zip"
default['umbraco']['checksum'] = "a555eb2b987ef6962da33e032de1a9e7"


