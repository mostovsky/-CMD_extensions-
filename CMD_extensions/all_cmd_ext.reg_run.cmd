REM @echo off
echo INSTALL CMD_EXTension by adding in reg
REM reg import "%~dp0\all_cmd_ext.reg"
reg import "%~dp0all_cmd_ext.reg"
if '%errorlevel%' neq '0' (
	echo Adding FAIL
	color 40 & title=Adding FAIL
) else (
	echo Adding OK
	color 20 & title=Adding OK
)
echo [DONE]
pause