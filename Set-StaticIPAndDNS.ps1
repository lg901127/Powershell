$hostname = hostname
function Set-StaticIPAndDNS {
    $staticIP = Read-Host -Prompt "Enter the static IP address for $hostname :"
    $interfaceAlias = Read-Host -Prompt "Enter network adapter name :"
    New-NetIPAddress -AddressFamily IPv4 -IPAddress $staticIP -PrefixLength 8 -DefaultGateway '10.0.0.101' -InterfaceAlias $interfaceAlias
    Set-DnsClientServerAddress -InterfaceAlias $interfaceAlias -ServerAddresses ('10.0.0.1','10.0.0.2')
    }