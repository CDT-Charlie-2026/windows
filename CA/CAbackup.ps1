$BackupRoot = "C:\Program Files\Windows Explorer\$(Get-Date -Format 'yyyyMMdd-HHmmss')"

# Create folder 
New-Item -Path $BackupRoot -ItemType Directory -Force | Out-Null
icacls $BackupRoot /inheritance:r | Out-Null
icacls $BackupRoot /grant:r "Administrators:(OI)(CI)F" "SYSTEM:(OI)(CI)F" | Out-Null

# CA database
certutil -backupDB "$BackupRoot\CA-Database"

# CA cert + private key (prompts for password unless you add -p)
certutil -backupKey "$BackupRoot\CA-Key"

# CA registry configuration
reg export "HKLM\SYSTEM\CurrentControlSet\Services\CertSvc\Configuration" `
    "$BackupRoot\CA-Configuration.reg" /y

# CAPolicy.inf, if present
if (Test-Path "C:\Windows\CAPolicy.inf") {
    Copy-Item "C:\Windows\CAPolicy.inf" $BackupRoot
}

# Event logs (optional)
foreach ($log in "Application","Security","System") {
    wevtutil epl $log "$BackupRoot\$log.evtx"
}