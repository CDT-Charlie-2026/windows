# turning on all 3 firewall profiles
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True

# adjust for scored service !
New-NetFirewallRule -DisplayName "Allow-HTTP-Inbound" -Direction Inbound -Protocol TCP -LocalPort 80 -Action Allow
New-NetFirewallRule -DisplayName "Allow-HTTPS-Inbound" -Direction Inbound -Protocol TCP -LocalPort 443 -Action Allow
