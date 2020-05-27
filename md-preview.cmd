
REM https://github.com/joeyespo/grip
set "PathToGrip=C:\Program Files (x86)\Python37-32\Scripts\grip"
cd /d "%~dp0"
echo startting preview at http://localhost:6419/
start "" "%PathToGrip%"
"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" "http://localhost:6419/"
pause