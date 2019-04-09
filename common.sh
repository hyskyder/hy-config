
function try { 
    "$@" 
    local status=$?
    if [ $status -ne 0 ]; then
        local func_caller=$(caller 0)
        echo "[ERROR] Failed (retcode=$status) on cmd: $* at line $func_caller. Abort." >&2
        exit $status
    fi
}

function error {
    local -r func_caller=$(caller 0)
    echo "[Error] Line $func_caller:" "$@" >&2
    exit 1
}