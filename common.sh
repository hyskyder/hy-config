#!/bin/bash

function try { 
    "$@" 
    local status=$?
    if [ $status -ne 0 ]; then
        local func_caller
        func_caller=$(caller 0)
        echo "[ERROR] Failed (retcode=$status) on cmd: $* at line $func_caller. Abort." >&2
        exit $status
    fi
}

function error {
    local -r func_caller=$(caller 0)
    echo "[Error] Line $func_caller:" "$@" >&2
    exit 1
}

function get_abosolute_path {
    local SOURCE="${1}"
    while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
        local DIR
        DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
        SOURCE="$(readlink "$SOURCE")"
        [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
    done
    DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
    return "${DIR}"
}
