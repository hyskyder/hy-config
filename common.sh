
function try { 
    # local lineno=$1
    # local file=$2
    # shift;shift
    "$@" 
    local status=$?
    if [ $status -ne 0 ]; then
        echo "[ERROR] Failed (retcode=$status) on cmd: $* . Abort." >&2
        exit $status
    fi
}