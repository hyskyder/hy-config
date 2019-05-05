#!/bin/bash

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. $HERE/common.sh

function usage {
    cat << EndOfUsageMsg 
$0 : Intall my_init

Usage: $0 [Option] [folders_list] ...
  Option: 
    -a  Install all folders here.
    -D  Debug flag.
    -h  This help msg.
EndOfUsageMsg
}

while getopts ":aDh" opt; do
case ${opt} in
    a ) TARGET_ALL=true ;;
    D ) DEBUG_FLAG="-D" ; set -x ;;
    h ) usage ;;
    : ) echo "Invalid option: $OPTARG requires an argument" 1>&2 ; exit 1 ;;
    \? ) echo "Invalid Option: -$OPTARG" 1>&2 ; exit 1 ;;
esac done
shift $((OPTIND -1))

TARGET_ALL=${TARGET_ALL:-false}
DEBUG_FLAG=${DEBUG_FLAG:-""}

if ${TARGET_ALL}; then
    find $HERE -mindepth 1 -maxdepth 1 -type d -print0 | while read -d '' -r d; do
        if [[ -r ${d}/install.sh ]]; then
            echo "[INFO] Found ${d}/install.sh, installing:"
            try bash ${d}/install.sh ${DEBUG_FLAG}
        fi
    done
elif [[ $# -gt 0 ]]; then
    for d in "$@" ; do
        if [[ -r ${d}/install.sh ]]; then
            echo "[INFO] Found ${d}/install.sh, installing:"
            try bash ${d}/install.sh ${DEBUG_FLAG}
        fi
    done
else
    usage
fi
