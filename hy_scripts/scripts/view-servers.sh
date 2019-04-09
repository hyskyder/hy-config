#!/bin/bash

function usage {
    cat << EndOfUsageMsg 
$0 : Easy monitor your servers

Usage: $0 [Option] ServerList ...
  Option: 
    -a  Add all servers mentioned in ~/.ssh/config to ServerList
    -l  Equivalent to specify "localhost" in ServerList
    -h  This help msg.
EndOfUsageMsg
}

SESSION_NAME=ViewServers
MAINWINDOW_NAME=View

MONITOR_TOOL=htop
SERVER_LIST=()

while getopts ":aDlh" opt; do
case ${opt} in
    # t )
    #   target=$OPTARG
    #   ;;
    a )
        if [[ -r ~/.ssh/config ]]; then
            HOSTS_IN_CONFIG=( ` grep -i "^[\t ]*Host " ~/.ssh/config | awk '{print $2}' ` )
            [[ ${#HOSTS_IN_CONFIG[@]} -eq 0 ]] && 
                echo "NOTE: " 1>&2
            SERVER_LIST+=("${HOSTS_IN_CONFIG[@]}")
        else
            echo "NOTE: Cannot access ~/.ssh/config. Ignored." 1>&2
        fi
        ;;
    l )
        SERVER_LIST+=("localhost")
        ;;
    h )
        usage
        exit 0
        ;;    
    D )
        set -x
        ;;
    : )
        echo "Invalid option: $OPTARG requires an argument" 1>&2
        ;;
    \? )
        echo "Invalid Option: -$OPTARG" 1>&2
        usage
        exit 1
        ;;
esac
done
shift $((OPTIND -1))

[[ $# -gt 0 ]] && SERVER_LIST+=("$@")
if [[ ${#SERVER_LIST[@]} -gt 0 ]] ; then
    tmux new-session -d -s $SESSION_NAME -n $MAINWINDOW_NAME -x 1000 -y 1000
    for s in "${SERVER_LIST[@]}" ; do
        CMD="ssh $s -t $MONITOR_TOOL"
        [[ $s = "localhost" ]] && CMD=$MONITOR_TOOL
        tmux split-window -d -t $SESSION_NAME:$MAINWINDOW_NAME "echo Connecting...; $CMD"
        tmux select-layout   -t $SESSION_NAME:$MAINWINDOW_NAME tiled
    done
    tmux kill-pane -t "$SESSION_NAME:$MAINWINDOW_NAME.0"

    tmux new-window -d -t $SESSION_NAME -n layout \
    "echo 'This window maintains layout of the previous one'; while tmux select-layout -t $SESSION_NAME:$MAINWINDOW_NAME tiled; do sleep 1; done"
    tmux attach -t $SESSION_NAME:$MAINWINDOW_NAME
else
    usage
fi
