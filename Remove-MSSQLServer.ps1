function Remove-MSSQLServer ([string]$arg) {
    #Read in specific value of a registry key:
    $v = Get-ItemProperty -Path $arg -Name DependOnService 
    #Transfer the value to System Collections ArrayList to make it an editable array:
    $v_new = [System.Collections.ArrayList](Select-Object -InputObject $v -ExpandProperty DependOnService)
    #Remove specific value from array:
    $v_new.Remove('MSSQLServer')
    #Set the value in registry with the new array:
    Set-ItemProperty -Path $arg -Name DependOnService -Value $v_new

}


$SafetyLineMaintenance = 'HKLM:\SYSTEM\CurrentControlSet\Services\SafetyLineMaintenance'
$SafetyLinePusher = 'HKLM:\SYSTEM\CurrentControlSet\Services\SafetyLinePusher'
$SafetyLineSatelliteEmailService = 'HKLM:\SYSTEM\CurrentControlSet\Services\SatelliteEmailService'

Remove-MSSQLServer($SafetyLineMaintenance)
Remove-MSSQLServer($SafetyLinePusher)
Remove-MSSQLServer($SafetyLineSatelliteEmailService)
