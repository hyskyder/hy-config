@echo off

py C:\project\ocl_prj\ocl_compile\winbin2asm.py %*
SET RETCODE=%ERRORLEVEL%
IF %RETCODE% NEQ 0 Exit %RETCODE%
Exit 0