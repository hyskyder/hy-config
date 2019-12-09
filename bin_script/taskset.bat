@echo off

REM I am not content with current solusion. Better solusion is welcomed.

REM START ["title"] [/D path] [/I] [/MIN] [/MAX] [/SEPARATE | /SHARED]
REM       [/LOW | /NORMAL | /HIGH | /REALTIME | /ABOVENORMAL | /BELOWNORMAL]
REM       [/NODE <NUMA node>] [/AFFINITY <hex affinity mask>] [/WAIT] [/B]
REM       [command/program] [parameters]

START "" /I /WAIT /B /AFFINITY %*
EXIT