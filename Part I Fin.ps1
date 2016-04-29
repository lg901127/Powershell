#---------------------------------------------------------------------------------------------------------------#
#This script will make the following settings:
#
#1. Set the Interactive Services Detection service to start automatically. 
#To manually configure this, go to regedit and modify the registry key:
#HKEY_LOCAL_MACHINE_SYSTEM\SYSTEM\CurrentControlSet\Services\UI0Detect, change the "Start" value to 2.
#
#2. Set the SMTP Service to start automatically.
#To manually configure this, navigate to "Services" snap-in, find "Simple Mail Transfer Protocol (SMTP)" and change its Startup Type
#to Automatic.
#
#3. Create an event log source for SafetyLine in Event Viewer.
#To manually configure this, open a Powershell window and enter command: "New-EventLog -LogName SafetyLine -Source WebApp".
#
#4. Setup the Distributed Transaction Coordinator. 
#This step is critical to the entire app environment because it is responsible for distributing the various SafetyLine
#services accross multiple servers.
#To manually configure this, open the Local DTC within the Component Services snap-in and enable
#"Network DTC Access" under the Security tab. 
#Check "Allow Remote Clients" under the Client and Administration heading.
#Check "Allow Inbound" and "Allow Outbound" and choose "No Authentication Required" under the Transaction Manager Communication
#heading and click apply.
#
#5. Configure DTC Firewall Seetings.
#To manually configure this, navigate to Windows Firewall with Advanced Security, enable the Distributed Transaction Coordinator RPC,
#RPC-EPMAP and TCP-in inbound rules. 
#Limit DTC dynamic port allocation by editing the registry. Navigate to 
#HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc and create a new key called "Internet". Create the following values for the new registry.
#Name: Ports   Type: REG_MULTI_SZ   Data: 4000-5000
#Name: PortsInternetAvailable   Type: REG_SZ   Data: Y
#Name: UseInternetPorts   Type: REG_SZ   Data: Y
#
#After finish all above configurations, you need to restart the server. 
#---------------------------------------------------------------------------------------------------------------#

Write-host "Please select from the following tasks:
1. Set Interactive Services Detection service to start automatically.
2. Set SMTP Service to start automatically.
3. Create event log for SafetyLine in Event Viewer.
4. Configure Local DTC settings.
5. Configure DTC Firewall settings.
6. Restart computer."

$selection = 0
while ($selection -ne 'EXIT') {
    $selection = Read-Host "Please enter number 1-6, enter 'EXIT' to exit. "
    Switch ($selection) {
    #Set the Interactive Services Detection service to start automatically
        1 {
            Write-Host "Interactive Services Detection service will set to start automatically."
            set-itemproperty -Path HKLM:\system\CurrentControlSet\Services\ui0detect -Name Start -value 2
            Write-Host "Interactive Services Detection service has been set to start automatically";
            break
        }
    #Set the SMTP service to start automatically
        2 {
            Write-Host "SMTP Service will set to start automatically."
            Set-Service -Name SMTPSVC -StartupType Automatic
            Write-Host "SMTP Service has been set to start automatically.";
            break
        }
    #Create an event log source for SafetyLine in Event Viewer
        3 {
            New-EventLog -LogName SafetyLine -Source WebApp
            Write-Host "SafetyLine event log has been created";
            break
        }
    #Enable "Network DTC Access, allow remote clients for both client and administrator, allow inbound and outbound transaction with no authentication required
        4 {
            Write-Host "Configuring local DTC settings"
            Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\MSDTC\Security -Name NetworkDtcAccessTransactions -Value 1
            Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\MSDTC\Security -Name NetworkDtcAccess -Value 1
            Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\MSDTC\Security -Name NetworkDtcAccessOutbound -Value 1
            Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\MSDTC\Security -Name NetworkDtcAccessClients -Value 1
            Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\MSDTC\Security -Name NetworkDtcAccessInbound -Value 1
            Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\MSDTC\Security -Name NetworkDtcAccessAdmin -Value 1
            Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\MSDTC -Name AllowOnlySecureRpcCalls -Value 0
            Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\MSDTC -Name TurnOffRpcSecurity -Value 1;
            Start-Sleep -Seconds 1
            Write-Host "Done"
            break
        }
    #Enable the Distributed Transaction Coordinator RPC, RPC-EPMAP, TCP-in inbound rules
    #Limit DTC dynamic port allocation by creating a new key "Internet" in registry.
        5 {
            Write-Host "Configuring firewall settings"
            Set-NetFirewallRule -Name MSDTC-KTMRM-IN-TCP -Enabled True
            Set-NetFirewallRule -Name MSDTC-RPCSS-IN-TCP -Enabled True
            Set-NetFirewallRule -Name MSDTC-IN-TCP -Enabled True
            New-Item -Path HKLM:\SOFTWARE\Microsoft\Rpc\Internet
            New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Rpc\Internet -Name Ports -PropertyType MultiString -Value 4000-5000
            New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Rpc\Internet -Name PortsInternetAvailable -PropertyType String -Value Y
            New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Rpc\Internet -Name UseInternetPorts -PropertyType String -Value Y;
            Write-Host "Done"
            break
        }
    #Restart
        6 {
            Write-Host "Computer is going to restart in 5 seconds"
            Start-Sleep -Seconds 5
            Restart-Computer
        }
        'EXIT' {
            Write-Host "Exit"
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


