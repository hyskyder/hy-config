#!/bin/bash

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. $HERE/common.sh
[[ $1 = "-D" ]] && set -x

find $HERE -mindepth 1 -maxdepth 1 -type d -print0 | while read -d '' -r d; do
    if [[ -r ${d}/install.sh ]]; then
        echo "[INFO] Found ${d}/install.sh, installing:"
        try bash ${d}/install.sh "$@"
    fi
done
