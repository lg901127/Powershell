$hostName = hostname
$SQLServerName = Read-Host -Prompt "Enter the hostname of SQL server"
$saPassword = Read-Host -Prompt "Enter the password for SQL Server sa user"
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Tsunami Solutions Ltd.\SafetyLine\CompanyDB' -Name DBName -Value SafetyLine
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Tsunami Solutions Ltd.\SafetyLine\CompanyDB' -Name DBPassword -Value $saPassword
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Tsunami Solutions Ltd.\SafetyLine\CompanyDB' -Name DBServer -Value $SQLServerName
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Tsunami Solutions Ltd.\SafetyLine\CompanyDB' -Name DBUser -Value sa
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Tsunami Solutions Ltd.\SafetyLine\CompanyDB' -Name DBName -Value SafetyLine
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Tsunami Solutions Ltd.\SafetyLine\CompanyDB' -Name DBPassword -Value $saPassword
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Tsunami Solutions Ltd.\SafetyLine\CompanyDB' -Name DBServer -Value $SQLServerName
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Tsunami Solutions Ltd.\SafetyLine\CompanyDB' -Name DBUser -Value sa
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Tsunami Solutions Ltd.\Safet