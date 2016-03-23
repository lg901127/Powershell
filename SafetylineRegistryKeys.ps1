$hostName = hostname
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Tsunami Solutions Ltd.\SafetyLine\CompanyDB' -Name DBName -Value SafetyLine
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Tsunami Solutions Ltd.\SafetyLine\CompanyDB' -Name DBPassword -Value safenlog
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Tsunami Solutions Ltd.\SafetyLine\CompanyDB' -Name DBServer -Value VM-SQL3
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Tsunami Solutions Ltd.\SafetyLine\CompanyDB' -Name DBUser -Value sn
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Tsunami Solutions Ltd.\SafetyLine\CompanyDB' -Name DBName -Value SafetyLine
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Tsunami Solutions Ltd.\SafetyLine\CompanyDB' -Name DBPassword -Value safenlog
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Tsunami Solutions Ltd.\SafetyLine\CompanyDB' -Name DBServer -Value VM-SQL3
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Tsunami Solutions Ltd.\SafetyLine\CompanyDB' -Name DBUser -Value sn
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Tsunami Solutions Ltd.\SafetyLine' -Name Name -Value $hostName
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Tsunami Solutions Ltd.\SafetyLine\Pusher' -Name AppUrl -Value 'www.slmonitor.com'