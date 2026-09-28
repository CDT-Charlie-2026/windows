# Usage:
#   .\PasswordReset.ps1 -Users alice,bob            only change these users
#   .\PasswordReset.ps1 -Exclude blueadmin          change everyone except these (and the hardcoded lists)
#   .\PasswordReset.ps1 -Exclude blueadmin -Domain  same, but for domain users
# Import-Module ActiveDirectory needed for -Domain arg

param(
    [string[]] $Users,
    [string[]] $Exclude,
    [switch] $Domain
)

$excludedLocalUsers = @(
    "Guest",
    "DefaultAccount",
    "WDAGUtilityAccount"
)

$excludedDomainUsers = @(
    "notgreyteam",
    "krbtgt"
)

if (-not $Users -and -not $Exclude) {
    Write-Host "Use -Users or -Exclude" -ForegroundColor Red
    exit 1
}
if ($Users -and $Exclude) {
    Write-Host "Use -Users or -Exclude, not both" -ForegroundColor Red
    exit 1
}

$password = Read-Host "New password" -AsSecureString
$confirm  = Read-Host "Confirm password" -AsSecureString

$plain1 = [System.Net.NetworkCredential]::new("", $password).Password
$plain2 = [System.Net.NetworkCredential]::new("", $confirm).Password
if ($plain1 -ne $plain2) {
    Write-Host "Passwords do not match" -ForegroundColor Red
    exit 1
}

# Get all users
if ($Domain) {
    Import-Module ActiveDirectory
    $allUsers = Get-ADUser -Filter * | Select-Object -ExpandProperty SamAccountName
    $excluded = $excludedLocalUsers + $excludedDomainUsers + $Exclude
} else {
    $allUsers = Get-LocalUser | Select-Object -ExpandProperty Name
    $excluded = $excludedLocalUsers + $Exclude
}

# Get the users that are supposed to have password change
if ($Users) {
    $targets = $allUsers | Where-Object { $_ -in $Users }
} else {
    $targets = $allUsers | Where-Object { $_ -notin $excluded }
}

# Change passwords
foreach ($user in $targets) {
    try {
        if ($Domain) {
            Set-ADAccountPassword -Identity $user -Reset -NewPassword $password -ErrorAction Stop
        } else {
            Set-LocalUser -Name $user -Password $password -ErrorAction Stop
        }
        Write-Host "[+] $user" -ForegroundColor Green
    } catch {
        Write-Host "[!] $user - $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "Done." -ForegroundColor Cyan
