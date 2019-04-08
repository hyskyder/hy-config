#!/bin/bash

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. $HERE/../common.sh


try sudo apt-get install \
    git \
    htop \
    aptitude \
    python3-pip \
#End apt-get

try sudo -H pip3 install \
    requests \
    matplotlib \
    argcomplete \
#End pip3
