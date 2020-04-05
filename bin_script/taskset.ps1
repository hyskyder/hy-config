Param(
    [Parameter(Position=0,Mandatory=$true)]
    [Int32] $_CoreMask,

    [Parameter(Position=1,Mandatory=$true)]
    [string] $_ExePath,

    [Parameter(Mandatory=$false,ValueFromRemainingArguments)]
    [array] $_ArgumentList
)

$thisProcess = [System.Diagnostics.Process]::GetCurrentProcess();
$thisProcess.ProcessorAffinity = $_CoreMask;
$GotAffinity=Select-Object -inputObject $thisProcess ProcessorAffinity
Write-Verbose ">> Set ProcessorAffinity to $_CoreMask, Got ${GotAffinity}"

if(Get-Command "$_ExePath" -Type Cmdlet -WarningAction:SilentlyContinue -errorAction SilentlyContinue){
    Write-Warning "[WARN] $_ExePath is a cmdlet."
    $args=""
    if($_ArgumentList){
        $args=[string]::Join(" ",$_ArgumentList)
    }
    $cmd+="`"$_ExePath`" "+$args
    Invoke-Expression $cmd
} Elseif ( $_ArgumentList ){
    Write-Verbose ">> <$_ExePath> $_ArgumentList"
    Start-Process -NoNewWindow -Wait "$_ExePath" -ArgumentList $_ArgumentList
} Else {
    Write-Verbose ">> <$_ExePath>"
    Start-Process -NoNewWindow -Wait "$_ExePath"
}

