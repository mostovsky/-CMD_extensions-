:: ----------------------------------------------------------------------------------------------------------------------------------
:: ----------------------------------------------------------------------------------------------------------------------------------
REM pause
:: ----------------------------------------------------------------------------------------------------------------------------------
:: for color display
:: cls && color 08
:: .... the following line creates a [DEL] [ASCII 8] [Backspace] character to use later
:: .... All this to remove [:]
:: .... do not remove function :PainText in the end of file
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (set "DEL=%%a")
:: 				call :PainText 0F "cd = " & echo "%cd%"
:: 				call :PainText 02 "OK"	
:: color 40 & 	call :PainText 04 "nooooo" & pause & exit /b
:: ----------------------------------------------------------------------------------------------------------------------------------
@echo off
Setlocal EnableDelayedExpansion
cls && color 08
echo. & echo ________________________________________________________
:: ----------------------------------------------------------------------------------------------------------------------------------
:: Settings -------------------------------------------------------------------------------------------------------------------------
REM set "todo_prefix=TODO__" & set "todo_postfix="
set "todo_prefix=" & set "todo_postfix=__TODO"
:: ----------------------------------------------------------------------------------------------------------------------------------
:: Begin ----------------------------------------------------------------------------------------------------------------------------
call :PainText 0d "CreateRepo" & echo.
REM pause
if not ""=="%~1" (
	echo.
	call :PainText 0e "1st_parameter = " & echo  "%~1"
	cd /d "%~1"
	echo Current dir changed to input parameter "%~1"
) else (
	call :PainText f4 "Current dir NOT specified." & echo. & echo To use file-path "%~dp0" dir press any-key twice or  & call :PainText 0F "close window" & echo  or ctrl+c in cmd.
	pause & pause & pause
)
if not ""=="%~2" call :PainText 0e "2nd_parameter = " & echo  "%~2" &	rem DO NOT USE set "2nd_parameter=%~2"
echo.
REM pause
call :PainText 0F "cd =" & echo  "%cd%"
call :DetermineDirName "%CD%"
call :PainText 0F "dir is" & echo  "%name_dir%"
REM pause
set "ToDoName=%todo_prefix%%name_dir:]=%%todo_postfix%"
set "ToDoName=%ToDoName:[=%"
set "ToDoName_txt=%ToDoName%.txt"
REM if not exist "%ToDoName_txt%" (
if not exist "%cd%\%ToDoName_txt%" (
	call :PainText 02 "Create TODO file" & echo.
	echo %todo_prefix%%name_dir%%todo_postfix% >> "%ToDoName_txt%"
	echo. >> "%ToDoName_txt%"
	echo _____________________________________ >> "%ToDoName_txt%"
	echo. >> "%ToDoName_txt%"
	echo links: >> "%ToDoName_txt%"
	echo * >> "%ToDoName_txt%"
	echo. >> "%ToDoName_txt%"
	echo _____________________________________ >> "%ToDoName_txt%"
	echo _____________________________________ >> "%ToDoName_txt%"
	
) else (
	call :PainText 04 "ToDo file already exist. Do nothing." & echo.
)
echo starting todo file...
start "" "%ToDoName_txt%"
echo ToDo operations DONE
REM pause
if exist .git ( 
	REM echo Repo already exist. Do nothing
	call :PainText 04 "Repo already exist. Do nothing. " & echo.
) else (
	REM echo Create Repo
	call :PainText 02 "Create Repo" & echo.
	REM pause
	git init
)
echo Repo operations DONE



:: ----------------------------------------------------------------------------------------------------------------------------------
echo END
pause
goto:eof
:: ----------------------------------------------------------------------------------------------------------------------------------
:: ----------------------------------------------------------------------------------------------------------------------------------


exit /b
	color 90 & echo now you in the sky & pause & pause & goto :eof
:: ----------------------------------------------------------------------------------------------------------------------------------
:: http://forum.oszone.net/post-2463458-2.html
:DetermineDirName
set "name_dir=%~nx1"

exit /b
	color 90 & echo now you in the sky & pause & pause & goto :eof
:: -----------------------------------------------------------------
:PainText
rem need string like this on the beginning: for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (set "DEL=%%a")
rem call :PainText 02 "GREEN" && call :PainText 0e "YELLOW" & call :PainText F0 " BLACK " & call :PainText 04 " RED " & call :PainText 0F "WHITE " & call :PainText 09 "BLUE"
<nul set /p "=%DEL%" > "%~2"
findstr /v /a:%1 /R "+" "%~2" nul
del "%~2" > nul

exit /b
	color 90 & echo now you in the sky & pause & pause & goto :eof

:: ----------------------------------------------------------------------------------------------------------------------------------
:: ----------------------------------------------------------------------------------------------------------------------------------