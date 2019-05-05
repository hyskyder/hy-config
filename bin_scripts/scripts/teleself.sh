#!/bin/bash

function get_abosolute_path {
    local SOURCE="${1}"
    local DIR=""
    while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
        DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
        SOURCE="$(readlink "$SOURCE")"
        [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
    done
    DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
    echo $DIR
}

[[ $1 = "-D" ]] && shift && set -x
HERE=$(get_abosolute_path ${BASH_SOURCE[0]})
. ${HERE}/../../common.sh
(
    cd $HERE
    try bash teleself.sh.real "${@}"
)