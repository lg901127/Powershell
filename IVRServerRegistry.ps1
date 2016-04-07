function Remove-MSSQLServer ([string]$arg) {
    #Read in specific value of a registry key:
    $v = Get-ItemProperty -Path $arg -Name DependOnService 
    #Transfer the value to System Collections ArrayList to make it an editable array:
    $v_new = [System.Collections.ArrayList](Select-Object -InputObject $v -ExpandProperty DependOnService)
    #Remove specific value from array:
    $v_new.Remove('aaa')
    #Set the value in registry with the new array:
    Set-ItemProperty -Path $arg -Name DependOnService -Value $v_new

}
$SafetyLineIVR = 'HKLM:\SYSTEM\CurrentControlSet\Services\SafetyLineIVRService'
Remove-MSSQLServer($SafetyLineIVR)
Start-Sleep -Seconds 1
$DialogicSystemService = 'HKLM:\SYSTEM\CurrentControlSet\Services\Dialogic'
$DialogicRuntimeTracingDispatcher = 'HKLM:\SYSTEM\CurrentControlSet\Services\RtfDispatcher'
$InteractiveServicesDetection = 'HKLM:\SYSTEM\CurrentControlSet\Control\Windows'
$InteractiveServicesDetectionStart = 'HKLM:\SYSTEM\CurrentControlSet\Services\UI0Detect'
Set-ItemProperty -Path $DialogicSystemService -Name Start -Value 2
Set-ItemProperty -Path $DialogicRuntimeTracingDispatcher -Name Start -Value 2
Set-ItemProperty -Path $InteractiveServicesDetection -Name NoInteractiveServices -Value 0
Set-ItemProperty -Path $InteractiveServicesDetectionStart -Name Start -Value 2