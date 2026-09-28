# looping through accounts until 'exit'
Import-Module ActiveDirectory

while ($true) {
    $username = Read-Host "Username (or exit)"
    if ($username -eq "exit") { break }

    $password = Read-Host "New password" -AsSecureString
    Set-ADAccountPassword -Identity $username -NewPassword $password -Reset
}
