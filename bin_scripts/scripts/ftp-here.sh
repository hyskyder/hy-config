#!/bin/bash
#

OPEN_FTP_ID=hyhy
OPEN_FTP_PWD=12341234
OPEN_R_PORTS="2220-2230"

echo "[Start pyFTPD Server] ID: $OPEN_FTP_ID Pwd: $OPEN_FTP_PWD"
python3 -m pyftpdlib -V -w -u "$OPEN_FTP_ID" -P "$OPEN_FTP_PWD" -r "$OPEN_R_PORTS"
echo "program return: " $?
