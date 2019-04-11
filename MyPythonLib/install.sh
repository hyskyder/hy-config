#!/bin/bash

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. $HERE/../common.sh

if [[ -d ${HERE}/myPythonLib ]] ; then
    try git -C ${HERE}/myPythonLib pull
else
    try git clone https://gitlab.com/lshhwj/myPythonLib.git $HERE/myPythonLib --depth=1
fi

cd $HERE/myPythonLib;
try python3 setup.py install --user
