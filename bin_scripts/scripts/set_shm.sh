#!/bin/bash

ABS_SCRIPT_PATH="$(dirname "$(readlink --canonicalize "${BASH_SOURCE[0]}")" )"
. ${ABS_SCRIPT_PATH}/../../common.sh

SHM_FILE="/dev/shm"

function usage {
    cat << EndOfUsageMsg 
$0 : Set shm Size

Usage: $0 [Option] <Size>
    <size> Set shm size.
  Option:
    -f <file> Use a different file. (defualt: $SHM_FILE)
    -D        Debug flag.
    -h        This help msg.
EndOfUsageMsg
}

while getopts ":f:Dh" opt; do
case ${opt} in
    f ) SHM_FILE=$OPTARG ;;
    D ) set -x ;;
    h ) usage; exit 0 ;;
    : ) echo "Invalid option: $OPTARG requires an argument" 1>&2 ; exit 1 ;;
    \? ) echo "Invalid Option: -$OPTARG" 1>&2 ; exit 1 ;;
esac done
shift $((OPTIND -1))

[[ -z $SHM_FILE ]] && error "SHM_FILE is empty."
[[ $# -eq 0 ]] && usage && error "Size Unspecified."
[[ $# -gt 1 ]] && usage && error "$0 only accept one positional argument (size)."

ASSIGN_SIZE="$1"
sudo mount -o "remount,size=${ASSIGN_SIZE}" "${SHM_FILE}"

df -h "${SHM_FILE}"