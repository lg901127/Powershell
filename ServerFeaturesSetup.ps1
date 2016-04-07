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
            Write-Host "FTP Server feature will be installed"
            };
            break
        }
    #if it is a Web server, install ASP.NET
    *WEB* {
        if ((Get-WindowsFeature Web-Asp-Net45).installed -eq 0) {
            $installFeatures += "Web-Asp-Net45"
            Write-Host "ASP.NET 4.5 feature will be installed"
            };
            break
        }
    #Test case
    *TEST* {
        if ((Get-WindowsFeature Web-Asp-Net45).installed -eq 0) {
            Write-Host "This is the test case"
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
