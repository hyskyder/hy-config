@echo off

SET ScriptLocation="C:\path\to\script.py"

py %ScriptLocation% %*

SET RETCODE=%ERRORLEVEL%
IF %RETCODE% NEQ 0 Exit %RETCODE%
Exit 0