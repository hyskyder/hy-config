#!/bin/bash

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
[[ $1 = "-D" ]] && shift && set -x

function if_is_knwon_command {
    KNOWN_CMD=("msg" "fwd" "fwd_media" "send_audio" "send_document" "send_file" "send_photo" "send_text" "send_video")
    for c in "${KNOWN_CMD[@]}" ; do 
        [[ $1 == $c ]] && return 0
    done 
    return 1
}

TELE_CMD="msg"
if_is_knwon_command $1 && \
    TELE_CMD=$1 && \
    shift

[[ -f ${HERE}/teleself.config.ini ]] && SELF_ID=$(cat teleself.config.ini)
[[ -z ${SELF_ID} ]] && read -p "Your Telegram User id#:" SELF_ID

telegram-cli -W -e "${TELE_CMD} user#${SELF_ID} $*"