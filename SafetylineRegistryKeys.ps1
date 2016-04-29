#---------------------------------------------------------------------------------------------------------------#
#This script sets up registry keys for servers. 
#To manually configure this:
#Open the registry and navigate to HKEY_LOCAL_MACHINE\SOFTWARE\Tsunami Solutions Ltd.\SafetyLine\CompanyDB. 
#Reference the example below to configure these registry values.
#
#Navigate to HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Tsunami Solutions Ltd.\SafetyLine. Enter the hostname of 
#the SafetyLine server for the "Name" value. 
#
#Navigate to HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Tsunami Solutions Ltd.\SafetyLine\CompanyDB. Reference the
#example below to configure these registry values.
#
#Navigate to HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Tsunami Solutions Ltd.\SafetyLine\Pusher. Set the "AppURL"
#key to www.slmonitor.com
#
#Example:
#DBName = SafetyLine
#DBPassword = (The "sa" password for the safetyLine database)
#DBServer = (Hostname of the SQL server)
#DBUser = ("sa" user for the SafetyLine database)
#---------------------------------------------------------------------------------------------------------------#
$hostName = hostname
$change = $false
while ($change -eq $false) {
    $SQLServerName = Read-Host -Prompt "Enter the hostname of SQL server"
    $saPassword = Read-Host -Prompt "Enter the password for SQL Server sa user"
    $AdminEmail = Read-Host -Prompt "Enter admin email address"
    Write-Host "Your SQL Server Name is $SQLServerName"
    Write-Host "Your sa Password is $saPassword"
    Write-Host "Your AdminEmail is $AdminEmail"
    $flag = Read-Host "Enter 'Yes' if above information is correct, enter anything to correct your information"
    If ($flag -eq 'Yes') {
        $change = $true
        }
    else {
        $change = $false
        }
}
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Tsunami Solutions Ltd.\SafetyLine\CompanyDB' -Name DBName -Value SafetyLine
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Tsunami Solutions Ltd.\SafetyLine\CompanyDB' -Name DBPassword -Value $saPassword
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Tsunami Solutions Ltd.\SafetyLine\CompanyDB' -Name DBServer -Value $SQLServerName
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Tsunami Solutions Ltd.\SafetyLine\CompanyDB' -Name DBUser -Value sa
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Tsunami Solutions Ltd.\SafetyLine\CompanyDB' -Name DBName -Value SafetyLine
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Tsunami Solutions Ltd.\SafetyLine\CompanyDB' -Name DBPassword -Value $saPassword
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Tsunami Solutions Ltd.\SafetyLine\CompanyDB' -Name DBServer -Value $SQLServerName
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Tsunami Solutions Ltd.\SafetyLine\CompanyDB' -Name DBUser -Value sa
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Tsunami Solutions Ltd.\SafetyLine' -Name Name -Value $hostName
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Tsunami Solutions Ltd.\SafetyLine\Pusher' -Name AppUrl -Value 'https://www.slmonitor.com'
Set-ItemProperty -Path 'HKLM:\SOFTWARE\WOW6432Node\Tsunami Solutions Ltd.\SafetyLine' -Name AdminEmail -Value $AdminEmail
Write-Host "Registry keys have been modified"