#!/bin/bash

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. "${HERE}/../common.sh"
[[ -f ${HERE}/dependency.sh ]] && try "${HERE}/dependency.sh"

while getopts ":Dct:" opt; do
case ${opt} in
    c ) COPY_DIR=$OPTARG ;;
    t ) BIN_DIR=$OPTARG  ;;
# s ) SUDO_PRIFIX=sudo  ;;
    D ) set -x ;;
    : ) echo "Invalid option: $OPTARG requires an argument" 1>&2 ; exit 1 ;;
    \? ) echo "Invalid Option: -$OPTARG" 1>&2 ; exit 1 ;;
esac done
shift $((OPTIND -1))

COPY_DIR=${COPY_DIR:-${HERE}/scripts}
BIN_DIR=${BIN_DIR:-"${HOME}/bin"}

[[ ! -d $COPY_DIR ]] && try mkdir -p "${COPY_DIR}"
[[ ! -d $BIN_DIR  ]] && try mkdir -p "${BIN_DIR}"
[[ $HERE/scripts != "$COPY_DIR" ]] && try cp -r "${HERE}/scripts" "${COPY_DIR}"

find "${COPY_DIR}" -mindepth 1 -name '*.sh' -or -name '*.py' -type f -print0 | while read -d '' -r s; do
    n=$(basename "$s")
    n=${n/%.sh}
    n=${n/%.py}

    #[[ -f ${BIN_DIR}/${n} ]] && error "${BIN_DIR}/${n} is a regular file, stop creating symlink on it."
    if [[ -L ${BIN_DIR}/${n} ]] ; then
        echo "[NOTE] ${BIN_DIR}/${n} exists. Force replacing symlink."
        try ln -sf "${s}" "${BIN_DIR}/${n}" 
    elif [[ ! -e ${BIN_DIR}/${n} ]] ; then
        echo "[LINK] Making symlink: ${BIN_DIR}/${n}"
        try ln -s "${s}" "${BIN_DIR}/${n}"
    else
        error "Abnormal target location ${BIN_DIR}/${n}. Please check."
    fi
done 

