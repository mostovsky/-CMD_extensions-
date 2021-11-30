@echo off
REM =======
:: WinAVR path-fail fix
set "path=C:\windows\;%path%"
set "path=%system32%;%path%"
set "path=%windir%\System32\;%path%"
::echo "path=%windir%\System32\;%path%"
REM =======
set entername=%1
echo entername=%entername%
echo Тип операции: %2
set nameonly=%~n1
set typeonly=%~x1
set secondparametr=%2

REM ДОБАВИТЬ РУЧНОЙ ВВОД ЕСЛИ ТОЛЬКО ВХОДНОЙ ПАРАМЕТР ПУСТ (пускай 3-м парметром будет) <- как проверить на не ""???

set /P metka="Введите имя метки (для отмены - нажмите enter или введите ''exit'', ''abort'' или ''no'' в любом виде):" 
rem  
rem А кавычка та просто ошибку даст?
rem Выбеливание метки


::ALLTRIM
:: Источник:
:: http://www.celitel.info/klad/nhelp/helpbat.php?dcmd=ex_string
:: -----------------------
:: Krasner B.
:: -----------------------
:: -----------------------
SetLocal EnableDelayedExpansion
set /a firstnoblank=-1
set /a lastnoblank=0
set /a curpos=1
rem set "str=Q!%metka%!"
set "str=Q!metka! "
:StringLenLoop
    set SUBD=!str:~%curpos%,1!
    if  "!SUBD!" == "" GoTo :formrez
    if  NOT "!SUBD!" == " " (
        if !firstnoblank! == -1 set firstnoblank=!curpos!
        set lastnoblank=!curpos!
    )
    set /a curpos = !curpos!+1
GoTo :StringLenLoop
:formrez
set /a n1=!firstnoblank!-1
set /a n2=!lastnoblank!-!firstnoblank!+1

if !firstnoblank! == -1 (set "rez=") else (set rez=!metka:~%n1%,%n2%!)
ENDLOCAL & SET metka=%rez%
rem exit /b 0
)





echo metka=%metka%

rem в случае отмены
if /i "%metka%"=="abort" goto end
if /i "%metka%"=="фищке" goto end
if /i "%metka%"=="no" goto end
if /i "%metka%"=="тщ" goto end
if /i "%metka%"=="exit" goto end
if /i "%metka%"=="учше" goto end
if /i "%metka%"=="" goto end

rem папка ли
if %2=="dir" goto papka

ECHO Переименование файла
rem set nameonly=%nameonly:%typeonly%=""%
set newname=%nameonly%.[%metka%]%typeonly%
ren %1 "%newname%"
goto theend

goto end
:papka
ECHO Переименование ПАПКИ
rem set newpath=%entername%.[%metka%]
set newpath=%nameonly%%typeonly%.[%metka%]
move %1 "%newpath%"
rem Добавить возвращаемый параметр
goto theend

rem  отмена действий
:end
color 0C
echo Aborted by user
pause
exit

rem Самый конец
:theend
color F0
ECHO END OF OPERATIONS
pause

