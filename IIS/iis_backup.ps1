# backing up IIS configuration
Backup-WebConfiguration -Name “baseline” 
Copy-Item “C:\Windows\System32\inetsrv\backup\baseline” “C:\Program Files\Windows Explorer\” -Recurse -Force

# backing up log and website files
Copy-Item “C:\inetpub\logs\LogFiles” “C:\Program Files\Windows Explorer\” -Recurse -Force
Copy-Item “C:\inetpub\wwwroot\” “C:\Program Files\Windows Explorer\” -Recurse -Force

# restricting access to the backups to SYSTEM and Admins
icacls “C:\Program Files\Windows Explorer” /inheritance:r
icacls "C:\Program Files\Windows Explorer" /grant:r "Administrators:(OI)(CI)F" "SYSTEM:(OI)(CI)F"

