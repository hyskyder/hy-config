
Param(
    [Parameter(Mandatory=$true)]
    [String]
    $Target
)

$hash = @{ 
    proj = "C:\project\"; 
    THIS_IS_LAST_ELEMENT = ".";
}

If ( $hash.Contains($Target) ) {
    $cd_target=$hash[$Target]
    cd "$cd_target"
} Else {
    echo "$Target not found."
}