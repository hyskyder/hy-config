#!/bin/bash

ABS_SCRIPT_PATH="$(dirname "$(readlink --canonicalize "${BASH_SOURCE[0]}")" )"
. "${ABS_SCRIPT_PATH}/../../common.sh"

TMPFS_FILE="/mnt/ramdisk"
TMPFS_SIZE="2G"
MODE="mount"

function usage {
    cat << EndOfUsageMsg 
$0 : Mount tmpfs

Usage: $0 [Option]
  Option:
    -f <file> Use a different file. (defualt: $TMPFS_FILE)
    -s <size> Set swap size. (defualt: $TMPFS_SIZE)
    -r        Remove the added tmpfs.
    -D        Debug flag.
    -h        This help msg.
EndOfUsageMsg
}

while getopts ":f:s:rDh" opt; do
case ${opt} in
    f ) TMPFS_FILE=$OPTARG ;;
    s ) TMPFS_SIZE=$OPTARG ;;
    r ) MODE="remove" ;;
    D ) set -x ;;
    h ) usage; exit 0 ;;
    : ) echo "Invalid option: $OPTARG requires an argument" 1>&2 ; exit 1 ;;
    \? ) echo "Invalid Option: -$OPTARG" 1>&2 ; exit 1 ;;
esac done
shift $((OPTIND -1))
[[ $# -gt 0 ]] && usage && error "Positional arguments \"$*\" unsupported."

if [[ $MODE == "mount" ]]; then
    Detect_Mount=$(df "${TMPFS_FILE}" | grep -c "${TMPFS_FILE}" )
    [[ $Detect_Mount -ne 0 ]] && error "${TMPFS_FILE} already mounted. Abort."
    try sudo mount -t tmpfs -o "size=${TMPFS_SIZE}" tmpfs "${TMPFS_FILE}"
    df -h "${TMPFS_FILE}"
else
    try sudo umount "${TMPFS_FILE}"
fi

