
@echo off
setlocal enabledelayedexpansion

SET key[0]=project
SET val[0]=C:\project\

SET key[1]=THIS_IS_THE_LAST_ELEMENT
SET val[1]=C:\whatever\etc 

SET LAST_ELEMENT=1

SET found=

FOR /l %%i in (0,1,%LAST_ELEMENT%) do (
    if /I {%1}=={!key[%%i]!} (
        SET "found=%%i"
        goto :do_cd
    )
)

ECHO Dest "%1" not found.
ECHO Usage: %0 [dest in lower case]. Avaiable dest:

FOR /l %%a in (0,1,%LAST_ELEMENT%) DO (
    echo !key[%%a]! -- !val[%%a]!
)
goto :eof

:do_cd
SET tgt=!val[%found%]!
(
  endlocal
  set addr=%tgt%
)
cd %addr%

:eof