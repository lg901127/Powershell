Write-host "Please select from the following tasks:
1. Set Interactive Services Detection service to start automatically. (10)
2. Set SMTP Service to start automatically. (11)
3. Create event log for SafetyLine in Event Viewer.(15)
4. Configure Local DTC settings.(16-18)
5. Configure DTC Firewall settings (19-20)
6. Restart computer "

$selection = Read-Host "Please enter number 1-6, enter 'EXIT' to exit"  #declare the selection, do not read in value

while ($selection -ge 1 -and $selection -le 6) {
                                                                        #read in value here
    Switch ($selection) {
        1 {
            Write-Host "option 1"
            #set-itemproperty -Path HKLM:\system\CurrentControlSet\Services\ui0detect -Name "start" -value 2;
            #break
        }
        2 {
            Write-Host "option 2"
            #Set-Service -Name SMTPSVC -StartupType Automatic;
            #break
        }
        3 {
            Write-Host "option 3"
            #New-EventLog -LogName SafetyLine -Source WebApp;
            #break
        }
        4 {
            Write-Host "option 4"
            #Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\MSDTC\Security -Name NetworkDtcAccessTransactions -Value 1
            #Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\MSDTC\Security -Name NetworkDtcAccess -Value 1
            #Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\MSDTC\Security -Name NetworkDtcAccessOutbound -Value 1
            #Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\MSDTC\Security -Name NetworkDtcAccessClients -Value 1
            #Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\MSDTC\Security -Name NetworkDtcAccessInbound -Value 1
            #Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\MSDTC\Security -Name NetworkDtcAccessAdmin -Value 1;
            #break
        }
        5 {
            Write-Host "option 5"
            #Set-NetFirewallRule -Name MSDTC-KTMRM-IN-TCP -Enabled True
            #Set-NetFirewallRule -Name MSDTC-RPCSS-IN-TCP -Enabled True
            #Set-NetFirewallRule -Name MSDTC-IN-TCP -Enabled True;
            #break
        }
        6 {
            Write-Host "option 6"
            #Restart-Computer
        }
        'EXIT' {
            Write-Host "Powershell is about to exit"
            Start-Sleep -Seconds 3
            exit
        }
        default {
            write-host "Please enter number 1-6 or enter exit"
        }
            
    }
        $selection = write-host "Please enter number 1-6, or enter 'EXIT' to exit'"    #delete
    
}


