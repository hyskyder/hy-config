Param(
    [Parameter(Mandatory=$true)]
    [Int32] $CoreMask,

    [Parameter(Mandatory=$true)]
    [string] $ExePath,

    [Parameter(Mandatory=$false,ValueFromRemainingArguments)]
    [array] $ArgumentList
)

$thisProcess = [System.Diagnostics.Process]::GetCurrentProcess();
$thisProcess.ProcessorAffinity = $CoreMask;


if(Get-Command $ExePath -Type Cmdlet -WarningAction:SilentlyContinue -errorAction SilentlyContinue){
    Write-Warning "[WARN] $ExePath is a cmdlet."
    $args=""
    if($ArgumentList){
        $args=[string]::Join(" ",$ArgumentList)
    }
    $cmd+="$ExePath "+$args
    Invoke-Expression $cmd
} Elseif ( $ArgumentList ){
    Write-Verbose ">> $ExePath $ArgumentList"
    Start-Process -NoNewWindow -Wait $ExePath -ArgumentList $ArgumentList
} Else {
    Write-Verbose ">> $ExePath"
    Start-Process -NoNewWindow -Wait $ExePath
}

