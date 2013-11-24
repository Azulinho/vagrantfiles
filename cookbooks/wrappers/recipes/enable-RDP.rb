include_recipe 'windows'
include_recipe 'powershell'

powershell "install_iis" do
  flags "#{node.default['rms_IIS']['cmd_flags']}"
  code <<-EOH
    Import-Module ServerManager
    #Check If IIS Services Are Already Installed
    $check = Get-WindowsFeature | Where-Object {$_.Name -eq "Remote-Desktop-Services"}
    If ($check.Installed -ne "True") {
            Add-WindowsFeature Remote-Desktop-Services -IncludeAllSubFeature -Verbose | Out-Null
    }
    else {
            write-output "Remote-Desktop-Services feature already installed"
    }
  EOH
end

powershell "Hack the registry" do
  code <<-EOH
    Set-ItemProperty -Path 'HKLM:\\SYSTEM\\CurrentControlSet\\Control\\Terminal Server' -Name fDenyTSConnections -Value 0
  EOH
  action :run
end

