@echo off
echo INSTALL CMD_EXTension by adding in reg
REM reg import "%~dp0\all_cmd_ext.reg"
:: Default variant
reg import "%~dp0all_cmd_ext.reg"
:: on the 64-bit variant
:: http://forum.oszone.net/thread-193042.html
:: HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft - to exclude "WOW6432Node"
REM cmd /c "%windir%\system32\cmd.exe" /c "reg import %~dp0all_cmd_ext.reg"
reg import "%~dp0all_cmd_ext.reg" /reg:32
reg import "%~dp0all_cmd_ext.reg" /reg:64

if '%errorlevel%' neq '0' (
	echo Adding FAIL
	color 40 & title=Adding FAIL
) else (
	echo Adding OK
	color 20 & title=Adding OK
)
echo [DONE]
pause