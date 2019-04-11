#!/bin/bash
[[ $1 = "-D" ]] && set -x

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. $HERE/../common.sh

LOCAL_REPO_DIR="${HOME}/.config/.bash-git-prompt"

! [[ -d ${HOME}/.config ]] && try mkdir ~/.config
if [[ -d "$LOCAL_REPO_DIR" ]] ; then
     cd $LOCAL_REPO_DIR
     try git pull
     cd $HERE
else
    try git clone https://github.com/magicmonty/bash-git-prompt.git $LOCAL_REPO_DIR --depth=1
fi

try cp -vui $HERE/Single_line_NoExitState_Gentoo_hy.bgptheme ${LOCAL_REPO_DIR}/themes/Single_line_NoExitState_Gentoo_hy.bgptheme

try test -w ${HOME}/.bashrc 
IsBashrcReady=$(grep 'bash-git-prompt/gitprompt.sh' ${HOME}/.bashrc | wc -l)
if [[ $IsBashrcReady -eq 0 ]]; then
    echo "[INFO] Update ~/.bashrc to enable bash-git-prompt."
    cat >> ${HOME}/.bashrc <<EOFbashrc
BASH_GIT_PROMPT_ENTRANCE="$LOCAL_REPO_DIR/gitprompt.sh"
if [ -f \$BASH_GIT_PROMPT_ENTRANCE ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    GIT_PROMPT_FETCH_REMOTE_STATUS=0
    GIT_PROMPT_IGNORE_SUBMODULES=1

    GIT_PROMPT_THEME=Single_line_NoExitState_Gentoo_hy

    source \$BASH_GIT_PROMPT_ENTRANCE
fi
EOFbashrc
fi