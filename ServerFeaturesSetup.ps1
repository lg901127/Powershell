#---------------------------------------------------------------------------------------------------------------#
#This script installs necessary features and roles to specific servers.
#All servers will have Web Server role and SMTP Server role.
#For web server VM-WEB(#), it will install ASP.NET 4.5 feature and IIS Management Console feature.
#For SQL server VM-SQL(#), it will install FTP Server role and .NET Framework 3.5 feature. 
#Open Server Manager and use Add roles and features wizard to manually install features and roles.
#---------------------------------------------------------------------------------------------------------------#
[string[]]$installFeatures = @()
$hostname = hostname

#Install Web Server
if ((Get-WindowsFeature Web-Server).installed -eq 0) {
    $installFeatures += "Web-Server"
    Write-Host "Web Server role will be installed"
    }

#Install SMTP Server
if ((Get-WindowsFeature SMTP-Server).installed -eq 0) {
    $installFeatures += "SMTP-Server"
    Write-Host "SMTP Server feature will be installed"
    }
#Detect hostname
switch -wildcard ($hostname) {
    #if it is a SQL server, install FTP Server
    *SQL* {
        if ((Get-WindowsFeature Web-Ftp-Server).installed -eq 0) {
            $installFeatures += "Web-Ftp-Server"
            $installFeatures += "NET-Framework-core"
            Write-Host "FTP Server feature will be installed"
            Write-Host ".NET Framework 3.5 will be installed"
            };
            break
        }
    #if it is a Web server, install ASP.NET
    *WEB* {
        if ((Get-WindowsFeature Web-Asp-Net45).installed -eq 0) {
            $installFeatures += "Web-Asp-Net45"
            $installFeatures += "Web-Mgmt-Console"
            Write-Host "ASP.NET 4.5 feature will be installed"
            Write-Host "IIS Management Console will be installed"
            };
            break
        }
    #Testing case
    *TEST* {
        if ((Get-WindowsFeature Web-Asp-Net45).installed -eq 0) {
            Write-Host "This is a testing case"
            };
            break
        }
    default {Write-Host "No addition feature will be installed"
        }
}

$startInstall = Read-Host -Prompt "Enter 'YES' to start installation, enter 'NO' to exit"

while ($startInstall -ne 'YES' -and $startInstall -ne 'NO') {
    $startInstall = Read-Host -Prompt "Please enter 'Yes' or 'NO'"
}
if ($startInstall -eq 'YES') {
    Write-Host "Installation is starting in 3 seconds"
    Start-Sleep -Seconds 3
    Install-WindowsFeature $installFeatures
    
    }
if ($startInstall -eq 'NO') {
    Write-Host "Powershell will exit in 3 seconds"
    Start-Sleep -Seconds 3
    Exit
    }
