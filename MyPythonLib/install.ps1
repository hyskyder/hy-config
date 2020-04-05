

# HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# . "${HERE}/../common.sh"

# if [[ -d ${HERE}/myPythonLib ]] ; then
#     try git -C "${HERE}/myPythonLib" pull
# else
#     try git clone https://gitlab.com/lshhwj/myPythonLib.git "${HERE}/myPythonLib" --depth=1
# fi

# cd "${HERE}/myPythonLib" || error "Failed to cd into $HERE/myPythonLib"
# try python3 setup.py --quiet install --user
# echo "[INFO] myPythonLib installed."

$HERE=$PSScriptRoot
$Repo=$HERE+"\myPythonLib"
if ( Test-Path $Repo -PathType:Container){
    git -C "$Repo" pull
} else {
    git clone https://gitlab.com/lshhwj/myPythonLib.git "$Repo" --depth=1
}
Set-Location $Repo
python3 setup.py --quiet install --user
Write-Host "[INFO] myPythonLib installed."