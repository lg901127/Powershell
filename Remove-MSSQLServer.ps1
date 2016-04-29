#---------------------------------------------------------------------------------------------------------------#
#This script removes SQL dependencies for SafetyLine services by editing the registry. 
#To manually configure this, configure the "DependOnService" value to delete "MSSQLServer".
#This must be set on:
#HKLM:\SYSTEM\CurrentControlSet\Services\SafetyLineMaintenance
#HKLM:\SYSTEM\CurrentControlSet\Services\SafetyLinePusher
#HKLM:\SYSTEM\CurrentControlSet\Services\SatelliteEmailService
#If you see error information after running this script, that's because some specific registry doesn't have 
#"MSSQLServer" value in it, this won't affect the final configuration result. 
#---------------------------------------------------------------------------------------------------------------#

function Remove-MSSQLServer ([string]$arg) {
    #Read in specific value of a registry key:
    $v = Get-ItemProperty -Path $arg -Name DependOnService 
    #Transfer the value to System Collections ArrayList to make it an editable array:
    $v_new = [System.Collections.ArrayList](Select-Object -InputObject $v -ExpandProperty DependOnService)
    #Remove specific value from array:
    $v_new.Remove('MSSQLServer')
    $v_new.Remove('MSSQLSERVER')
    #Set the value in registry with the new array:
    Set-ItemProperty -Path $arg -Name DependOnService -Value $v_new

}

#Delete MSSQLServer dependency for SafetyLine Maintenance Service
$SafetyLineMaintenance = 'HKLM:\SYSTEM\CurrentControlSet\Services\SafetyLineMaintenance'

#Delete MSSQLServer dependency for SafetyLine Pusher Service
$SafetyLinePusher = 'HKLM:\SYSTEM\CurrentControlSet\Services\SafetyLinePusher'

#Delete MSSQLServer dependency for Satellite Email Service
$SafetyLineSatelliteEmailService = 'HKLM:\SYSTEM\CurrentControlSet\Services\SatelliteEmailService'

Remove-MSSQLServer($SafetyLineMaintenance)
Remove-MSSQLServer($SafetyLinePusher)
Remove-MSSQLServer($SafetyLineSatelliteEmailService)
