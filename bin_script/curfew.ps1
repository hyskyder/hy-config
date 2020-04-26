#Requires -RunAsAdministrator

Param(
    [Parameter(Mandatory=$false)]
    [switch] $Lift
)

try {
    if ( $Lift ) {
        Enable-NetAdapter -Name UST-Net -Confirm:$false
        # Set-MpPreference -DisableRealtimeMonitoring $false
    } else {
        Disable-NetAdapter -Name UST-Net -Confirm:$false
        # Set-MpPreference -DisableRealtimeMonitoring $true
    }
}
catch {
    Write-Error "An error occurred" 
    Write-Error $_.ScriptStackTrace
    Write-Error $_
}
