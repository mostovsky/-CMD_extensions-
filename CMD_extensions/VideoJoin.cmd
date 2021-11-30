REM =======
:: WinAVR path-fail fix
set "path=C:\windows\;%path%"
set "path=%system32%;%path%"
set "path=%windir%\System32\;%path%"
::echo "path=%windir%\System32\;%path%"
REM =======
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
:: STUB
set "PATH=%windir%;%system32%;%path%"
:: ----------------------------------------------------------------------------------------------------------------------------------
:: Settings -------------------------------------------------------------------------------------------------------------------------
REM call :PainText 0d "Settings"
REM set "NameToSave=file-list.txt" & 		echo. 
REM call :PainText 0e "NameToSave = " &		call :PainText 09 " %NameToSave% " & rem echo.

set "SelfFileName=VideoJoin.cmd" & 		echo.
call :PainText 0e "SelfFileName = " &	call :PainText 09 " %SelfFileName% " & echo.
REM echo.
if not ""=="%~1" (
	echo. & call :PainText 0e "1st_parameter = " & echo  "%~1" &	rem DO NOT USE set "1st_parameter=%~1"
	echo.
) else (
	call :PainText 04 "Nothing input. End now." & echo.
	pause
	REM goto :eof
	REM :: uncomment previous line
)
if not ""=="%~2" call :PainText 0e "2nd_parameter = " & echo  "%~2" &	rem DO NOT USE set "2nd_parameter=%~2"
echo.
:: here need to make cd to path of file
cd /d "%~1"
call :PainText 0F "cd = " & echo "%cd%"
:: ----------------------------------------------------------------------------------------------------------------------------------
:: determine path to ffmpeg
set "name_ffmpeg=ffmpeg.exe"
REM pause
REM for /l {%%|%}<Variable> in (<Start#>,<Step#>,<End#>) do <Command> [<CommandLineOptions>]
REM set "maximum="
call :SomeArray length maximum
echo maximum = %maximum%
pause
REM setlocal enabledelayedexpansion enableextensions
set "TruePath=none"
for /l %%i in (0,1,%maximum%) do (
	call :SomeArray %%i TempPath
	echo for %%i we have path="!TempPath!"
	REM echo if exist "!TempPath!\%name_ffmpeg%"
	if exist "!TempPath!\%name_ffmpeg%" (
		REM pause
		set "TruePath=!TempPath!"
		echo TruePath="!TempPath!"
	)
)
if "%TruePath%"=="" (
	call :PainText 04 "ffmpeg not found. End now." & echo.
	pause
	goto :eof
)
REM call :SomeArray 1 value
REM echo Value = %value%

REM call :SomeArray 3 value
REM echo Value = %value%

REM set "path_to_ffmpeg=D:\prog\ffmpeg-20200403-52523b6-win64-static\bin\"
set "path_to_ffmpeg=%TruePath%"
pause
:: ----------------------------------------------------------------------------------------------------------------------------------
:: determine names
set "file_type_of_input=%~x1"

REM https://coderoad.ru/659647/%D0%9A%D0%B0%D0%BA-%D0%BF%D0%BE%D0%BB%D1%83%D1%87%D0%B8%D1%82%D1%8C-%D0%BF%D1%83%D1%82%D1%8C-%D0%BA-%D0%BF%D0%B0%D0%BF%D0%BA%D0%B5-%D0%B8%D0%B7-%D0%BF%D1%83%D1%82%D0%B8-%D0%BA-%D1%84%D0%B0%D0%B9%D0%BB%D1%83-%D1%81-CMD
REM %~dp1

set "file_name_video="
set "file_name_audio="



pause
:: ----------------------------------------------------------------------------------------------------------------------------------
:: some info
set "m_info="

pause
:: ----------------------------------------------------------------------------------------------------------------------------------
:: make operations with resulted video
REM D:\prog\ffmpeg-20200403-52523b6-win64-static\bin\ffmpeg.exe -i "Billie Eilish - everything i wanted_v_1080p.mp4" -i "Billie Eilish - everything i wanted_a_128k.m4a" -acodec copy -vcodec copy "Billie Eilish - everything i wanted.mp4"  
"%path_to_ffmpeg%\%name_ffmpeg%" -i "%file_name_video%.mp4" -i "%file_name_audio%.m4a" -acodec copy -vcodec copy "%file_name_video%.%m_info%.mp4"  
pause
:: ----------------------------------------------------------------------------------------------------------------------------------
:: ----------------------------------------------------------------------------------------------------------------------------------
:: -----------------------------------------------------------------
exit /b
	color 90 & echo now you in the sky & pause & pause & goto :eof
:: -----------------------------------------------------------------
:SomeArray index returned
REM echo on
set "pre=value"
set "max=5"
set "value_0=D:\prog\ffmpeg-20200403-52523b6-win64-static\bin"
set "value_1=C:\Program Files\ffmpeg-20191226-b0d0d7e-win64-static\bin"
set "%pre%_2=D:\Program Files\ffmpeg-20191226-b0d0d7e-win64-static\bin"
set "value_3=C:\Program Files (x86)\ffmpeg-20191226-b0d0d7e-win64-static\bin"
set "value_4=D:\Program Files (x86)\ffmpeg-20191226-b0d0d7e-win64-static\bin"
set "value_5=C:\prog\ffmpeg-20200403-52523b6-win64-static\bin"

if "%~1"=="length" (
	set "%2=%max%"
) else (
	REM pause
	REM echo val_5 = %value_5%
	call set "%2=%%value_%1%%"
)
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
:: -----------------------------------------------------------------
exit /b
	color 90 & echo now you in the sky & pause & pause & goto :eof
:: ----------------------------------------------------------------------------------------------------------------------------------
:: ----------------------------------------------------------------------------------------------------------------------------------