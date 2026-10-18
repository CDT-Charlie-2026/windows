$Path = "C:\Windows\System32\CertLog"

Get-ChildItem $Path -Force |
    Select Name, Length, CreationTime, LastWriteTime |
    Sort LastWriteTime -Descending |
    Format-Table -AutoSize