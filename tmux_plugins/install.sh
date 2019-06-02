#!/bin/bash

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. "${HERE}/../common.sh"
[[ -f $HERE/dependency.sh ]] && try "${HERE}/dependency.sh"

while getopts ":D" opt; do
case ${opt} in
    D ) set -x ;;
    : ) echo "Invalid option: $OPTARG requires an argument" 1>&2 ; exit 1 ;;
    \? ) echo "Invalid Option: -$OPTARG" 1>&2 ; exit 1 ;;
esac done
shift $((OPTIND -1))

LOCAL_REPO_DIR="${HOME}/.config/tmux/plugins/tpm"
if [[ -d ${LOCAL_REPO_DIR} ]] ; then
    try git -C "${LOCAL_REPO_DIR}" pull
else
    try git clone https://github.com/tmux-plugins/tpm "${LOCAL_REPO_DIR}" --depth 1
fi

try cp -uvi "${HERE}/tmux.conf" "${HOME}/.tmux.conf"

try "${LOCAL_REPO_DIR}/bin/install_plugins"
