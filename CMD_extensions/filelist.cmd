REM pause
:: ----------------------------------------------------------------------------------------------------------------------------------
:: for color display
:: cls && color 08
:: .... the following line creates a [DEL] [ASCII 8] [Backspace] character to use later
:: .... All this to remove [:]
:: .... do not remove function :PainText in the end of file
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (set "DEL=%%a")
:: call :PainText 02 "OK, we found" & echo _______________________	
:: color 40 & call :PainText 04 "we do not find anything" & pause & exit /b
:: call :PainText 04 "While open - file '%~2' do not exist" & pause & goto :5
:: ----------------------------------------------------------------------------------------------------------------------------------
@echo off
Setlocal EnableDelayedExpansion
cls && color 08
echo. & echo ________________________________________________________
:: ----------------------------------------------------------------------------------------------------------------------------------
:: Settings -------------------------------------------------------------------------------------------------------------------------
call :PainText 0d "Settings"
set "NameToSave=file-list.txt" & 		echo. 
call :PainText 0e "NameToSave = " &		call :PainText 09 " %NameToSave% " & rem echo.

set "SelfFileName=filelist.cmd" & 		echo.
call :PainText 0e "SelfFileName = " &	call :PainText 09 " %SelfFileName% " & rem echo.
REM echo.
if not ""=="%~1" echo. & call :PainText 0e "1st_parameter = " & echo  "%~1" &	rem DO NOT USE set "1st_parameter=%~1"
if not ""=="%~2" call :PainText 0e "2nd_parameter = " & echo  "%~2" &	rem DO NOT USE set "2nd_parameter=%~2"
echo.
call :PainText 0F "cd = " & echo "%cd%"

set "FullFilePath=%~1\%NameToSave%" & 								rem DO NOT USE SPACES NEAR "=" SYMBOL
REM echo.
call :PainText 0e "FullFilePath = " & echo  "%FullFilePath%" & 		rem call :PainText 09 " _%~1_ " & call :PainText 09 " %NameToSave% " & rem echo.

REM pause
:: ----------------------------------------------------------------------------------------------------------------------------------
REM echo This file is
echo.
call :PainText 0e "This file is " & call :PainText 0F " %SelfFileName% "
title = This file is %SelfFileName%
echo. & echo start at %time:~0,-3%
:: ----------------------------------------------------------------------------------------------------------------------------------
:: ----------------------------------------------------------------------------------------------------------------------------------
:: Check for EMPTY input path to dir ------------------------------------------------------------------------------------------------
echo Check for EMPTY input path to dir
if "%~1"=="" (
	call :PainText 04 "NO DIR TO INPUT" 
	echo. 
	title=NO DIR TO INPUT & timeout /t 3 /nobreak 
	pause 
	color 40 
	pause 
	color 08 
	exit /b
) else (
	if "%~1"=="install" (
		goto Install
	) else (
		call :PainText 02 "INPUT DIR OK" & echo.
	)
)
REM pause
:: ----------------------------------------------------------------------------------------------------------------------------------
:: check for output file already exist
echo check for output file already exist
if exist "%FullFilePath%" (
		echo Try to rename now & rem pause
		ren "%FullFilePath%" "%NameToSave%__%TIME::=_%.%NameToSave:*.=%"
		echo Renamed to "%FullFilePath%" "%NameToSave%__%TIME::=_%.%NameToSave:*.=%" & rem pause
		REM copy /Y "%PathTo%\%File%" "%File%__%TIME::=_%.%File:*.=%"
)
REM pause
:: ----------------------------------------------------------------------------------------------------------------------------------
if "%~2"=="sub"  (
	echo File-list of files and dirs [%time:~0,-3%]: >> "%FullFilePath%" 
	dir /b /s >> "%FullFilePath%" 
) else (
	echo File-list of files and dirs with SUB-dirs [%time:~0,-3%]: >> "%FullFilePath%" 
	dir /b >> "%FullFilePath%" 
)
:: ----------------------------------------------------------------------------------------------------------------------------------
:: Check for good creation of file
if not exist "%FullFilePath%" (
	REM color 40 & echo While "open" - file "%~2" do not exist & pause & goto :5
	REM echo While "open" - file "%~2" do not exist & pause 5 & color 40 & pause & goto :5
	REM call :PainText 04 "Problem with create" & echo. & call :PainText 04 " file: '%NameToSave%'" & call :PainText 04 "in path: " & echo '%~1' & pause & rem goto :end
	call :PainText 04 "Problem with create"
) else (
	call :PainText 02 "OK, we saved file '%NameToSave%'" & echo ______________________
)

:: ----------------------------------------------------------------------------------------------------------------------------------
:: Open created file
start "" "%FullFilePath%"


:: ----------------------------------------------------------------------------------------------------------------------------------
REM This is END
echo exit now & timeout /t 2 & pause
exit /b

	color 90 & echo now you in the sky & pause & pause & goto :eof

:: ----------------------------------------------------------------------------------------------------------------------------------
:: ----------------------------------------------------------------------------------------------------------------------------------
:: ----------------------------------------------------------------------------------------------------------------------------------

REM file-list
REM todo*************************************************************************************************************

REM !CRITICAL! ******************************************************************************************************
REM * 
REM * 



REM NOT_critical *****************************************************************************************************
REM *
REM * 



REM IN_FUTURE ********************************************************************************************************
REM * 
REM * 


REM NOT_IMPLEMENTED
REM * 
REM * 

rem OK of todo *********************************************************************************************************


REM OK_ALL *************************************************************************************************************
REM * 
REM * 

:: ----------------------------------------------------------------------------------------------------------------------------------
:: ----------------------------------------------------------------------------------------------------------------------------------
:: ----------------------------------------------------------------------------------------------------------------------------------

rem -----------------------------------------------------------------

rem -----------------------------------------------------------------
rem -----------------------------------------------------------------
rem -----------------------------------------------------------------
:Install
call :PainText 02 "INSTALL mode" & echo.
:: STUB
:: ----------------------------------------------------------------
echo exit now & timeout /t 2 & pause
exit /b

	color 90 & echo now you in the sky & pause & pause & goto :eof
:: ----------------------------------------------------------------


pause
:: ----------------------------------------------------
:: Administrator privileges----------------------------
:Begin
pause
REM set "title_saved=%TIME:,=_%" && TITLE=%title_saved% & rem Add by mostovsky (for auto-close)
net session >NUL 2>&1
if %errorlevel% neq 0 (
    REM echo Administrator privileges required!
    call :PainText 04 "Administrator privileges required!"
	goto Check_for_permissions
    REM exit
)
:gotAdmin
pause
pushd %~dp0
:: ----------------------------------------------------
REM echo This file is update_''serials-lite.cmd''.bat
set "PathTo=%ProgramFiles%\CMD_extensions"
REM set "File=serial-lite.cmd"
set "File=%NameToSave%"
rem NameToSave

REM Check for empty
if "%File%"=="" (
	color 40 & call :PainText 0F "File" & call :PainText 04 " is empty" & timeout /t 3 /nobreak & pause & pause & color 08 & exit /b 
) else (
	REM if not exist "%~dp0%File%" (
	if not exist "%File%" (
		REM call :PainText 0F "File" & call :PainText 04 " not exist" & timeout /t 3 /nobreak >nul & pause & color 40 & pause & color 08 & exit /b 
		REM call :PainText 0F "File" & call :PainText 04 " not exist" & timeout /t 3 /nobreak & pause & color 40 & pause & color 08 & exit /b 
		color 40 & call :PainText 0F "File" & call :PainText 04 " not exist" & timeout /t 3 /nobreak & pause & pause & color 08 & exit /b 
	) else (
		call :PainText 02 "INPUT FILE OK" & echo.
	)
)
rem add not exist
:: ----------------------------------------------------
If exist "%PathTo%\%File%" (
	REM Use BackUpWithDate here!
	echo Rename now & rem pause
	ren "%PathTo%\%File%" "%File%__%TIME::=_%.%File:*.=%"
	echo Renamed to "%PathTo%\%File%" "%File%__%TIME::=_%.%File:*.=%" & rem pause
	rem add var for display true 
	REM copy /Y "%PathTo%\%File%" "%File%__%TIME::=_%.%File:*.=%"
)
:: ----------------------------------------------------
echo CopYing...))
xcopy /F /Y "%File%" "%PathTo%"
REM copy serial-lite.cmd
REM check for OK and IF Yes close another window
REM pause
if '%errorlevel%' NEQ '0' (
	echo Copy FAIL
	color 40 & title=Copy FAIL
) else (
	echo Copy OK
	color 20 & title=Copy OK
	timeout /t 1
	REM echo Now try to kill window with WINDOWTITLE=%input_parameter%
	echo Now try to kill window with WINDOWTITLE=%~2
	echo Now killing & pause
	REM taskkill /f /FI "WINDOWTITLE eq %input_parameter%*" | findstr /i /n "Успе">nul && ( echo Process closed & color 30 & echo. ) || ( echo Proc NOT closed [NOT FOUND] & color 50 & echo. )
	taskkill /f /FI "WINDOWTITLE eq %~2*" | findstr /i /n "Успе">nul && ( echo Process closed & color 30 & echo. ) || ( echo Proc NOT closed [NOT FOUND] & color 50 & echo. )
)
:: ----------------------------------------------------
popd
echo end at %time:~0,-3%
REM pause
timeout /t 3
exit
REM todo
REM Do check for not diff file or use BackUpWithDate!!!!
REM taskkill unical Akceptor WindowTitle if operations in Admin permission done right
:: ---------------------------------------------------------------------------------------------------------------------

exit /b
	color 90 & echo now you in the sky & pause & pause & goto :eof
:: -----------------------------------------------------------------
:: -----------------------------------------------------------------
:CheckForPermissions_______ %start_with%
REM There method without temp.vbs: http://qaru.site/questions/10738/how-can-i-auto-elevate-my-batch-file-so-that-it-requests-from-uac-administrator-rights-if-required
REM net file 1>nul 2>nul && goto :run || powershell -ex unrestricted -Command "Start-Process -Verb RunAs -FilePath '%comspec%' -ArgumentList '/c %~fnx0 %*'"
REM goto :eof
REM :run
REM :: TODO: Put code here that needs elevation


		chcp | find /i /n "1251">nul || chcp 1251 & rem chande codepage to see Russian symbols & REM Added by mostovsky (for Russian language) & rem It need here because inside second IF writing to getadmin.vbs work not properly
REM >nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
net session >NUL 2>&1
REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
	echo:
	echo   Requesting Administrative Privileges...
	echo   Press YES in UAC Prompt to Continue
	echo:
	timeout /t 3
	if "%FirstStart%"=="no" ( echo You must accept "UAC Prompt"! & echo. & echo Close window to exit & echo. & echo Press ANY KEY to try again) & rem pause 
	set "title_saved=%SelfFileName%__install_mode_%TIME::=_%" & set "title_saved=!title_saved:,=_!" & TITLE=!title_saved! & rem Add by mostovsky (for auto-close)
	chcp | find /i /n "1251">nul || chcp 1251 & rem chande codepage to see Russian symbols & REM Added by mostovsky (for Russian language) - it need to use in parent if more than one constructions like "if" use simultaneously (odnovremenno)
	echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
	
	REM chcp 866
	REM echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs" & rem Add by mostovsky (for auto-close)
	echo UAC.ShellExecute "%~s0", "%~1 !title_saved!", "", "runas", 1 >> "%temp%\getadmin.vbs"
	REM pause
	REM chcp 866 & REM Added by mostovsky (for return from Russian language in file to norm print in cmd)
	REM Title=%Title2kill% & 
	set FirstStart=no
	start "" /wait "%temp%\getadmin.vbs"
)
exit /b
	color 90 & echo now you in the sky & pause & pause & goto :eof
:: -----------------------------------------------------------------
:: ---------------------------------------------------------------------------------------------------------------------
:Check_for_permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
echo:
echo   Requesting Administrative Privileges...
echo   Press YES in UAC Prompt to Continue
echo:
timeout /t 2

		 goto UACPrompt
) else ( goto gotAdmin )
exit /b
	color 90 & echo now you in the sky & pause & pause & goto :eof
:: -----------------------------------------------------------------
:: ---------------------------------------------------------------------------------------------------------------------
:UACPrompt
REM pause
		if "%FirstStart%"=="no" ( echo You must accept "UAC Prompt"! & echo. & echo Close window to exit & echo. & echo Press ANY KEY to try again & pause )
			set "title_saved=%TIME::=_%" && TITLE=%title_saved% & rem Add by mostovsky (for auto-close)
		echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
		chcp 1251 & REM Added by mostovsky (for Russian language)
		REM echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs" & rem Add by mostovsky (for auto-close)
		REM echo UAC.ShellExecute "%~s0", "%title_saved%", "", "runas", 1 >> "%temp%\getadmin.vbs"
		REM echo UAC.ShellExecute "%~s0", "%~1", "", "runas", 1 >> "%temp%\getadmin.vbs"
		echo UAC.ShellExecute "%~s0", "%~1 %title_saved%", "", "runas", 1 >> "%temp%\getadmin.vbs"
		REM pause
		REM Title=%Title2kill%
		set FirstStart=no
		start "" /wait "%temp%\getadmin.vbs"
goto Begin
:: ---------------------------------------------------------------------------------------------------------------------
:: -----------------------------------------------------------------
exit /b
	color 90 & echo now you in the sky & pause & pause & goto :eof
:: -----------------------------------------------------------------
:PainText
rem need string like this on the beginning: for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (set "DEL=%%a")
rem call :PainText 02 "GREEN" && call :PainText 0e "YELLOW" & call :PainText F0 " BLACK " & call :PainText 04 " RED " & call :PainText 0F "WHITE " & call :PainText 09 "BLUE"
<nul set /p "=%DEL%" > "%~2"
findstr /v /a:%1 /R "+" "%~2" nul
del "%~2" > nul
REM echo.
REM @echo off
exit /b
	color 90 & echo now you in the sky & pause & pause & goto :eof
:: -----------------------------------------------------------------
:: -----------------------------------------------------------------