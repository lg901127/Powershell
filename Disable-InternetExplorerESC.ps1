#---------------------------------------------------------------------------------------------------------------#
#This script disables Internet Explorer Enhanced Security Configuraiton for Administrators only. 
#To manually configure this, go to Server Manager and select Local Server, you can find the option "IE 
#Enhanced Security Configuration" in the PROPERTIES block. 
#---------------------------------------------------------------------------------------------------------------#
function Disable-InternetExplorerESC
{
    $AdminKey = 'HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}'
    Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0
    Write-Host "IE Enhanced Security Configuration has been disabled for administrator only."
}

Disable-InternetExplorerESC