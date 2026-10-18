$Serial = Read-Host "Enter broken certificate serial number"

certutil -view `
    -restrict "SerialNumber=$Serial"