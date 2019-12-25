@echo off

REM I am not content with current solusion. Better solusion is welcomed.

REM START ["title"] [/D path] [/I] [/MIN] [/MAX] [/SEPARATE | /SHARED]
REM       [/LOW | /NORMAL | /HIGH | /REALTIME | /ABOVENORMAL | /BELOWNORMAL]
REM       [/NODE <NUMA node>] [/AFFINITY <hex affinity mask>] [/WAIT] [/B]
REM       [command/program] [parameters]

echo %1%| findstr /r "^0[xX][0123456789][0123456789]*$ ^[0123456789][0123456789]*$" > NUL & IF ERRORLEVEL 1 (
    ECHO [Error] invalid core_mask: %1%
    ECHO usage: %0% ^<core_mask^> ^<cmd [args]^> 
    EXIT 1
)

START "" /I /WAIT /B /AFFINITY %*
EXIT