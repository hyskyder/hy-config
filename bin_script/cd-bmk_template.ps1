
Param(
    [Parameter(Mandatory=$true)]
    [String]
    $Target
)

$hash = @{ 
    proj = "C:\project\";
    onedrive=$env:OneDrive;
    THIS_IS_LAST_ELEMENT = ".";
}

If ( $hash.Contains($Target) ) {
    $cd_target=$hash[$Target]
    cd "$cd_target"
} Else {
    echo "$Target not found."
}