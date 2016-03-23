[string[]]$installFeatures = @()
$hostname = hostname

if ((Get-WindowsFeature Web-Server).installed -eq 0) {
    $installFeatures += "Web-Server"
    Write-Host "Web Server role will be installed"
    }

if ((Get-WindowsFeature SMTP-Server).installed -eq 0) {
    $installFeatures += "SMTP-Server"
    Write-Host "SMTP Server feature will be installed"
    }

switch -wildcard ($hostname) {
    *SQL* {
        if ((Get-WindowsFeature Web-Ftp-Server).installed -eq 0) {
            $installFeatures += "Web-Ftp-Server"
            Write-Host "FTP Server feature will be installed"
            };
            break
        }
    *WEB* {
        if ((Get-WindowsFeature Web-Asp-Net45).installed -eq 0) {
            $installFeatures += "Web-Asp-Net45"
            Write-Host "ASP.NET 4.5 feature will be installed"
            };
            break
        }
    *TEST* {
        if ((Get-WindowsFeature Web-Asp-Net45).installed -eq 0) {
            Write-Host "This is the test case"
            };
            break
        }
    default {"No addition feature will be installed"
        }
}

$startInstall = Read-Host -Prompt "Enter 'YES' to start installation, enter 'NO' to exit"

while ($startInstall -ne 'YES' -and $startInstall -ne 'NO') {
    $startInstall = Read-Host -Prompt "Please enter 'Yes' or 'NO'"
}
if ($startInstall -eq 'YES') {
    <#Install-WindowsFeature $installFeatures#>
    write-host "test YES"
    }
if ($startInstall -eq 'NO') {
    Write-Host "test NO"
    }
