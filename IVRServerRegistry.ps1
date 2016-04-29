#---------------------------------------------------------------------------------------------------------------#
#This script will make the following settings:
#
#1. Remove the SQL dependency from IVR Service.
#To manually configure this, navigate to HKLM:\SYSTEM\CurrentControlSet\Services\SafetyLineIVRService and delete
#"MSSQLServer" value from DependOnService.
#
#2. Set Dialogic System Service to start automatically
#To manually configure this, go to Services snap-in and find "Dialogic System Service", change its startup type 
#to automatic.
#
#3. Set Dialogic Runtime Tracing Dispatcher to start automatically
#To manually configure this, go to Services snap-in and find "Dialogic Runtime Tracing Dispatcher", change its
#startup type to automatic.
#
#4. Enable Interactive Services Detection
#To manually configure this, navigate to HKLM:\SYSTEM\CurrentControlSet\Control\Windows, change "NoInteractiveServices"
#to 0, then go to Services snap-in to start "Interactive Services Detection" and set the startup type to Automatic.
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
#Delete MSSQLServer dependency for SafetyLine IVR Service
$SafetyLineIVR = 'HKLM:\SYSTEM\CurrentControlSet\Services\SafetyLineIVRService'
Remove-MSSQLServer($SafetyLineIVR)
#Wait a bit
Start-Sleep -Seconds 2

#Set Dialogic System Service to start automatically
$DialogicSystemService = 'HKLM:\SYSTEM\CurrentControlSet\Services\Dialogic'

#Set Dialogic Runtime Tracing Dispatcher to start automatically
$DialogicRuntimeTracingDispatcher = 'HKLM:\SYSTEM\CurrentControlSet\Services\RtfDispatcher'

#Set Interactive Services Detection to start automatically
$InteractiveServicesDetection = 'HKLM:\SYSTEM\CurrentControlSet\Control\Windows'
$InteractiveServicesDetectionStart = 'HKLM:\SYSTEM\CurrentControlSet\Services\UI0Detect'

Set-ItemProperty -Path $DialogicSystemService -Name Start -Value 2
Set-ItemProperty -Path $DialogicRuntimeTracingDispatcher -Name Start -Value 2
Set-ItemProperty -Path $InteractiveServicesDetection -Name NoInteractiveServices -Value 0
Set-ItemProperty -Path $InteractiveServicesDetectionStart -Name Start -Value 2