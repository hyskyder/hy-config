#!/bin/bash
[[ $1 = "-D" ]] && set -x

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. $HERE/common.sh

cd $HERE
for d in $(ls -1d */); do # NOTE: $d contains the tailing /, ${d%%/} does not
    if [[ -r ${d%%/}/install.sh ]]; then
        echo "[INFO] Found ${d%%/}/install.sh, installing:" 
        try bash ${d%%/}/install.sh "$@"
    fi
done