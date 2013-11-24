#MS download is failing if the URL is lowercase... weird
node.override['ms_dotnet45']['http_url'] = "http://download.microsoft.com/download/B/A/4/BA4A7E71-2906-4B2D-A0E1-80CF16844F5F/dotNetFx45_Full_setup.exe"
include_recipe "ms_dotnet45"

