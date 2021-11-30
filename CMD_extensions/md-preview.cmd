@echo off
REM =======
:: WinAVR path-fail fix
set "path=C:\windows\;%path%"
set "path=%system32%;%path%"
set "path=%windir%\System32\;%path%"
::echo "path=%windir%\System32\;%path%"
REM =======
echo START -------------------------------------------------------------------------
echo Start "%~nx0"
REM https://github.com/joeyespo/grip
rem or use https://jbt.github.io/markdown-editor/ for md-files
:: Start readme.md
:: Browsers: FF="FireFox", CH="Chrome", YA="Yandex", OP="Opera", SA="Safari"(NoNow), IE="InternetExplorer", ED="Edge", AV="Avast"

set "PathToGrip=C:\Program Files (x86)\Python37-32\Scripts\grip"
set "NameOfGripExe=grip.exe"
::---
if "%~1"=="" (
	cd /d "%~dp0"
	echo Default cmd-file_path use "%~dp0"
) else (
	cd /d "%~1"
	echo For current path use input parameter "%~1"
)
set "page_path=localhost:6419"
echo startting preview at "http://%page_path%/"

REM echo Press any key to continue && pause && rem ---------------------------------------------------------------
echo ---
::------------------------------------------------------------------------------------------------------------
echo Restart grip
taskkill /f /t /im "%NameOfGripExe%"
REM grip-script.py
REM tasklist /fi "imagename eq python.exe" /v
REM https://stackoverflow.com/questions/49677623/find-windows-pid-of-a-python-script-with-windows-command-prompt?rq=1
start "" /min "%PathToGrip%"
::------------------------------------------------------------------------------------------------------------
echo ---
echo 1="%~1"
set "First=%~1"
echo 2="%~2"
set "Second=%~2"
::------------------------------------------------------------------------------------------------------------
set "isAll="
set "NeededBrowser="
echo ---
setlocal enabledelayedexpansion
::---
if "%Second%"=="DEF" (
	set "NeededBrowser=CH"
	echo Will be open only one browser - chrome now
	goto NotAllBrowsers
)
::---
if NOT "%Second%"=="" (
	if NOT "%Second%"=="ALL" (
		rem NotAllBrowsers
		set "NeededBrowser=%Second%"
		echo Will be open only one browser
		echo Needed browser is "!NeededBrowser!"
		echo isAll is "!isAll!"
		REM echo Needed browser is "!NeededBrowser!"
		goto NotAllBrowsers
	)
)
:AllBrowsers
set "isAll=true"
echo isAll is "%isAll%"
echo All browsers will be opened
::---
:NotAllBrowsers

echo.
echo ---
REM echo Press any key to continue && pause && rem ---------------------------------------------------------------
:: Browser start based on FGquest
::------------------------------------------------------------------------------------------------------------
::------------------------------------------------------------------------------------------------------------
if "%isAll%"=="" (
	if not "%NeededBrowser%"=="SA" (
		echo SafariBrowser will not be used
		goto after_SA
	)
)
::---
REM taskkill /f /im Safari.exe
set "SAFARI_path=%ProgramFiles%\Safari\Safari.exe"
if exist "%SAFARI_path%" (
	start "" "%SAFARI_path%" "http://%page_path%/"
	echo -^> Safari started (if exist)
) else echo _Safari NOT installed or NOT found
:after_SA
REM echo Press any key to continue && pause && rem ---------------------------------------------------------------
::------------------------------------------------------------------------------------------------------------
if "%isAll%"=="" (
	if not "%NeededBrowser%"=="OP" (
		echo OperaBrowser will not be used
		goto after_OP
	)
)
::---
set "OPERA_path=%appdata%\..\Local\Programs\Opera\launcher.exe"
if exist "%OPERA_path%" (
	start "" "%OPERA_path%" "http://%page_path%/"
	echo -^> OPERA started
) else echo _OPERA NOT installed or NOT found
:after_OP
REM echo Press any key to continue && pause && rem ---------------------------------------------------------------
::------------------------------------------------------------------------------------------------------------
if "%isAll%"=="" (
	if not "%NeededBrowser%"=="FF" (
		echo FireFoxBrowser will not be used
		goto after_FF
	)
)
::---
set "FF_path=%ProgramFiles%\Mozilla Firefox\firefox.exe"
if exist "%FF_path%" (
	start "" "%FF_path%" "http://%page_path%/"
	echo -^> FF started
) else echo _FF NOT installed or NOT found
::---
set "FF_path=%ProgramFiles(x86)%\Mozilla Firefox\firefox.exe"
if exist "%FF_path%" (
	start "" "%FF_path%" "http://%page_path%/"
	echo -^> FFx86 started
) else echo _FFx86 NOT installed or NOT found
::---
set "FF_path=%ProgramW6432%\Mozilla Firefox\firefox.exe"
if exist "%FF_path%" (
	start "" "%FF_path%" "http://%page_path%/"
	echo -^> FFx64 started
) else echo _FFx64 NOT installed or NOT found
::---
:after_FF
REM echo Press any key to continue && pause && rem ---------------------------------------------------------------
::------------------------------------------------------------------------------------------------------------
if "%isAll%"=="" (
	if not "%NeededBrowser%"=="YA" (
		echo YandexBrowser will not be used
		goto after_YA
	)
)
::---
set "YA_path=%appdata%\..\Local\Yandex\YandexBrowser\Application\browser.exe"
if exist "%YA_path%" (
	start "" "%YA_path%" "http://%page_path%/"
	echo -^> YANDEX started
) else echo _YandexBrowser NOT installed or NOT found
:after_YA
REM echo Press any key to continue && pause && rem ---------------------------------------------------------------
::------------------------------------------------------------------------------------------------------------
if "%isAll%"=="" (
	if not "%NeededBrowser%"=="IE" (
		echo MS_InternetExplorer_Browser will not be used
		goto after_IE
	)
)
::---
REM taskkill /f /im iexplore.exe
start "" "iexplore.exe" "http://%page_path%/"
echo -^> IE started
:after_IE
REM echo Press any key to continue && pause && rem ---------------------------------------------------------------
::------------------------------------------------------------------------------------------------------------
if "%isAll%"=="" (
	if not "%NeededBrowser%"=="ED" (
		echo MS_Edge_Browser will not be used
		goto after_EDGE
	)
)
::---
set "EDGE_path=%appdata%\..\Local\Microsoft\WindowsApps\MicrosoftEdge.exe"
if exist "%EDGE_path%" (
	start "" "%EDGE_path%" "http://%page_path%/"
	echo -^> EDGE started
) else echo _EDGE NOT installed or NOT found
:after_EDGE
REM echo Press any key to continue && pause && rem ---------------------------------------------------------------
::------------------------------------------------------------------------------------------------------------
if "%isAll%"=="" (
	if not "%NeededBrowser%"=="AV" (
		echo AvastBrowser will not be used
		goto after_AV
	)
)
::---
set "AV_path=%ProgramFiles(x86)%\AVAST Software\Browser\Application\AvastBrowser.exe"
if exist "%AV_path%" (
	start "" "%AV_path%" "http://%page_path%/"
	echo -^> AvastBrowser_x86 started
) else echo _AvastBrowser_x86 NOT installed or NOT found
::---
set "AV_path=%ProgramW6432%\AVAST Software\Browser\Application\AvastBrowser.exe"
if exist "%AV_path%" (
	start "" "%AV_path%" "http://%page_path%/"
	echo -^> AvastBrowser_x64 started
) else echo _AvastBrowser_x64 NOT installed or NOT found
::---
set "AV_path=%ProgramFiles%\AVAST Software\Browser\Application\AvastBrowser.exe"
if exist "%AV_path%" (
	start "" "%AV_path%" "http://%page_path%/"
	echo -^> AvastBrowser started
) else echo _AvastBrowser NOT installed or NOT found
:after_AV
REM echo Press any key to continue && pause && rem ---------------------------------------------------------------
::------------------------------------------------------------------------------------------------------------
if "%isAll%"=="" (
	if not "%NeededBrowser%"=="CH" (
		echo ChromeBrowser will not be used
		goto after_CH
	)
)
::---
set "CHROME_path=%ProgramFiles%\Google\Chrome\Application\chrome.exe"
if exist "%CHROME_path%" (
	start "" "%CHROME_path%" "http://%page_path%/"
	echo -^> CHROME started
) else echo _CHROME NOT installed or NOT found
::---
set "CHROME_path=%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"
if exist "%CHROME_path%" (
	start "" "%CHROME_path%" "http://%page_path%/"
	echo -^> CHROMEx86 started
) else echo _CHROMEx86 NOT installed or NOT found
::---
set "CHROME_path=%ProgramW6432%\Google\Chrome\Application\chrome.exe"
if exist "%CHROME_path%" (
	start "" "%CHROME_path%" "http://%page_path%/"
	echo -^> CHROMEx64 started
) else echo _CHROMEx64 NOT installed or NOT found
::---
:after_CH
REM echo Press any key to continue && pause && rem ---------------------------------------------------------------
::------------------------------------------------------------------------------------------------------------
::------------------------------------------------------------------------------------------------------------
echo Start edit file
set "EditPath=C:\Program Files\Notepad++\notepad++.exe"

if "%Second%"=="DEF" (
	start "" "%EditPath%" "%~1"
	echo start "" "%EditPath%" "%~1"
) else (
	start "" "%EditPath%" "%~1\README.md"
	echo start "" "%EditPath%" "%~1\README.md"
)
REM start "" "%EditPath%" "%~1"
REM echo start "" "%EditPath%" "%~1"
::------------------------------------------------------------------------------------------------------------
echo END ---------------------------------------------------------------------------
pause