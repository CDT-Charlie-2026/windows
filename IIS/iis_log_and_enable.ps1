# basic config
Set-Service W3SVC -StartupType Automatic
Start-Service W3SVC

# get logging status
Get-WebConfigurationProperty -Filter "system.webServer/httpLogging" -Name "dontLog" -PSPath "IIS:\"

