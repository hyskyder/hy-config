#!/bin/bash

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. $HERE/../common.sh
$INSTALL_DIR="~/tool/hy_scripts"

! [[ -d ~/tool ]] && try mkdir ~/tool
! [[ -d ~/bin ]]  && try mkdir ~/bin

try cp -r $HERE $INSTALL_DIR
try rm $INSTALL_DIR/install.sh

# for i in $(ls -f); do echo ${i%%/}; done