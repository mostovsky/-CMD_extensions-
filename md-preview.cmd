@echo off
REM https://github.com/joeyespo/grip
rem or use https://jbt.github.io/markdown-editor/ for md-files

set "PathToGrip=C:\Program Files (x86)\Python37-32\Scripts\grip"
cd /d "%~dp0"
set "page_path=localhost:6419"
echo startting preview at "http://%page_path%/"
start "" "%PathToGrip%"
REM "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" "http://localhost:6419/"
REM pause





:: Browser start based on FGquest

set "FF_path=%ProgramFiles%\Mozilla Firefox\firefox.exe"
if exist "%FF_path%" (
	start "" "%FF_path%" "http://%page_path%/"
	echo FF start
)
set "FF_path=%ProgramFiles(x86)%\Mozilla Firefox\firefox.exe"
if exist "%FF_path%" (
	start "" "%FF_path%" "http://%page_path%/"
	echo FFx86 start
)
set "FF_path=%ProgramW6432%\Mozilla Firefox\firefox.exe"
if exist "%FF_path%" (
	start "" "%FF_path%" "http://%page_path%/"
	echo FFx64 start
)

REM taskkill /f /im Safari.exe
REM set "SAFARI_path=%ProgramFiles%\Safari\Safari.exe"
REM if exist "%SAFARI_path%" (
	REM start "" "%SAFARI_path%" "http://%page_path%/"
REM )

set "OPERA_path=%appdata%\..\Local\Programs\Opera\launcher.exe"
if exist "%OPERA_path%" (
	start "" "%OPERA_path%" "http://%page_path%/"
	echo OPERA start
)
set "YA_path=%appdata%\..\Local\Yandex\YandexBrowser\Application\browser.exe"
if exist "%YA_path%" (
	start "" "%YA_path%" "http://%page_path%/"
	echo YANDEX start
)

	
REM taskkill /f /im iexplore.exe
start "" "iexplore.exe" "http://%page_path%/"
echo IE start


set "EDGE_path=%appdata%\..\Local\Microsoft\WindowsApps\MicrosoftEdge.exe"
if exist "%EDGE_path%" (
	start "" "%EDGE_path%" "http://%page_path%/"
	echo EDGE start
)



set "CHROME_path=%ProgramFiles%\Google\Chrome\Application\chrome.exe"
if exist "%CHROME_path%" (
	start "" "%CHROME_path%" "http://%page_path%/"
	echo CHROME start
)
set "CHROME_path=%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"
if exist "%CHROME_path%" (
	start "" "%CHROME_path%" "http://%page_path%/"
	echo CHROMEx86 start
)
set "CHROME_path=%ProgramW6432%\Google\Chrome\Application\chrome.exe"
if exist "%CHROME_path%" (
	start "" "%CHROME_path%" "http://%page_path%/"
	echo CHROMEx64 start
)

pause