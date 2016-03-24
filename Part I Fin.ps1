Write-host "Please select from the following tasks:
1. Set Interactive Services Detection service to start automatically. (10)
2. Set SMTP Service to start automatically. (11)
3. Create event log for SafetyLine in Event Viewer.(15)
4. Configure Local DTC settings.(16-18)
5. Configure DTC Firewall settings (19-20)
6. Restart computer "

$selection = 0
while ($selection -ne 'EXIT') {
    $selection = Read-Host "Please enter number 1-6, enter 'EXIT' to exit. "
    Switch ($selection) {
        1 {
            Write-Host "Interactive Services Detection service will set to start automatically."
            set-itemproperty -Path HKLM:\system\CurrentControlSet\Services\ui0detect -Name "start" -value 2;
            break
        }
        2 {
            Write-Host "SMTP Service will set to start automatically."
            Set-Service -Name SMTPSVC -StartupType Automatic;
            break
        }
        3 {
            Write-Host "Creating SafetyLine event log"
            New-EventLog -LogName SafetyLine -Source WebApp;
            break
        }
        4 {
            Write-Host "Configuring local DTC settings"
            Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\MSDTC\Security -Name NetworkDtcAccessTransactions -Value 1
            Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\MSDTC\Security -Name NetworkDtcAccess -Value 1
            Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\MSDTC\Security -Name NetworkDtcAccessOutbound -Value 1
            Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\MSDTC\Security -Name NetworkDtcAccessClients -Value 1
            Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\MSDTC\Security -Name NetworkDtcAccessInbound -Value 1
            Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\MSDTC\Security -Name NetworkDtcAccessAdmin -Value 1;
            break
        }
        5 {
            Write-Host "Configuring firewall settings"
            Set-NetFirewallRule -Name MSDTC-KTMRM-IN-TCP -Enabled True
            Set-NetFirewallRule -Name MSDTC-RPCSS-IN-TCP -Enabled True
            Set-NetFirewallRule -Name MSDTC-IN-TCP -Enabled True;
            break
        }
        6 {
            Write-Host "Computer is going to restart in 5 seconds"
            Start-Sleep -Seconds 5
            Restart-Computer
        }
        'EXIT' {
            Write-Host "Exit"
            Write-Host "Powershell is about to exit"
            Start-Sleep -Seconds 3
            exit
        }
        default {
            write-host "Please enter number 1-6 or enter exit
            1. Set Interactive Services Detection service to start automatically. (10)
            2. Set SMTP Service to start automatically. (11)
            3. Create event log for SafetyLine in Event Viewer.(15)
            4. Configure Local DTC settings.(16-18)
            5. Configure DTC Firewall settings (19-20)
            6. Restart computer "
        }
            
    }

    
}


