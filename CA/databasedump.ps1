$Out = "C:\CA-Check"
New-Item $Out -ItemType Directory -Force | Out-Null

certutil -view Log csv > "$Out\All.csv"
certutil -view Revoked csv > "$Out\Revoked.csv"
certutil -view LogFail csv > "$Out\Failed.csv"

Write-Host "Database dumped to C:\CA-Check"