@echo off
REM ----------------------------------------------------------------------------------------------
REM known issue
REM fail to start if major version has symbol "(" or ")"

REM ----------------------------------------------------------------------------------------------
REM http://forum.oszone.net/thread-287598-2.html


REM ----------------------------------------------------------------------------------------------
REM Init

REM http://forum.script-coding.com/viewtopic.php?id=2485
set tray="%ProgramFiles%\CMD_extensions\3rd_party\nircmd\nircmd.exe"


REM ----------------------------------------------------------------------------------------------	
:voice_init
			REM VOICE - source code
			REM у ЭТОГО файла должна быть кодировка DOS !!! (испоользуй, например, Rpad для её изменения. Скачать можно отсюда: http://mostovsky.narod.ru/Rpad32_v2_0.rar )
			REM Всё удаляется (отдельные фразы) после воспроизведения, кроме файла call_voice.cmd
			REM Папка для файлов воспроизведения звука (СО слэшэм "\" на конце !): если без "\" на конце - то к имени файла текст пойдёт (работоспособность сохраняется); латиницей; без пробелов
			set Dir=%Temp%\voice_cmd\
			md "%dir%"
			Rem issue: если %Dir%call_voice.cmd заключить в кавычки - всё перестанет работать
			REM set play=/min "" %Dir%call_voice.cmd
			REM Вот такое катит: set "play=/min """" %Dir%call_voice.cmd" и такое: set "play=/min "" %Dir%call_voice.cmd"
			set "play=/min "" %Dir%call_voice.cmd"
			echo REM http://www.cyberforum.ru/cmd-bat/thread934553.html#post4923158 > "%Dir%call_voice.cmd"
			echo @echo off >> "%Dir%call_voice.cmd"
			echo mode con: cp select=1251 >> "%Dir%call_voice.cmd"
			echo set text=%%1 >> "%Dir%call_voice.cmd"
			echo Title %%1 >> "%Dir%call_voice.cmd"
			echo if "%%text:~1,-2%%"=="" set text="Тестовая фраза" >> "%Dir%call_voice.cmd"
			rem echo echo %%text%% >> "%Dir%call_voice.cmd"
			echo Setlocal EnableDelayedExpansion >> "%Dir%call_voice.cmd"
			echo set modul_in=/* >> "%Dir%call_voice.cmd"
			echo set modul_out=*/ >> "%Dir%call_voice.cmd"
			echo set now=%%text: =_%%>> "%Dir%call_voice.cmd"
			echo set now=%%now:^"=%%>> "%Dir%call_voice.cmd"
			echo echo %%modul_in%% ^> "%Dir%voice_%%now%%.cmd" >> "%Dir%call_voice.cmd"
			echo echo cls^& @echo off ^>^> "%Dir%voice_%%now%%.cmd" >> "%Dir%call_voice.cmd"
			rem echo echo start /min cscript //nologo /e:jscript "%Dir%voice_%%now%%.cmd" ^>^> "%Dir%voice_%%now%%.cmd" >> "%Dir%call_voice.cmd"
			echo echo start /wait /min cscript //nologo /e:jscript "%Dir%voice_%%now%%.cmd" ^>^> "%Dir%voice_%%now%%.cmd" >> "%Dir%call_voice.cmd"
			rem echo ^<nul set /p strTemp=^>^> "%Dir%voice_%%now%%.cmd">> "%Dir%call_voice.cmd"
			REM http://forum.sources.ru/index.php?showtopic=285900
			echo echo start /min cmd.exe /C del "%Dir%voice_%%now%%.cmd" ^>^> "%Dir%voice_%%now%%.cmd" >> "%Dir%call_voice.cmd"
			echo	echo exit /b ^>^> "%Dir%voice_%%now%%.cmd" >> "%Dir%call_voice.cmd"
			echo	echo %%modul_out%% ^>^> "%Dir%voice_%%now%%.cmd" >> "%Dir%call_voice.cmd"
			rem echo mode con: cp select=1251 >> "%Dir%call_voice.cmd"
			echo	echo new ActiveXObject("SAPI.SpVoice").Speak (%%text%%); ^>^> "%Dir%voice_%%now%%.cmd" >> "%Dir%call_voice.cmd"
			rem echo mode con: cp select=866 >> "%Dir%call_voice.cmd"
			echo echo text=%%text%% >> "%Dir%call_voice.cmd"
			echo call "%Dir%voice_%%now%%.cmd" >> "%Dir%call_voice.cmd"
			echo exit >> "%Dir%call_voice.cmd"
REM ----------------------------------------------------------------------------------------------

REM Текущий каталог
	REM set "f=%~dp0"
set "f=%~p1"
REM Сюда, может, cd %f% добавить

REM Файл для резервирования (хронологии)
	REM Просто для Pinnacle Studio изначально делалось
	REM for /f "delims=" %%i in ('dir /b /a:-d /o:d "%f%*.axp"') do set input_file=%%i
REM set "input_file=%~n1%~x1"
set "input_file=%~nx1"

if not exist "%f%%input_file%" start %play% "Ошибка поиска файла" & echo "Ошибка поиска файла" & start /min "" %tray% trayballoon "Ошибка поиска файла" "Файл ~q%input_file%~q~n~nв папке ~q%f%~q~n~nНЕ найден." "user32.dll,3" 100000 & pause
	REM pause

REM echo input_file=%input_file%

start %play% "Слежение за файлом %input_file% начато"
echo Слежение за файлом %input_file% начато
start /min "" %tray% trayballoon "Начало" "Слежение за файлом ~q%input_file%~q начато" "user32.dll,4" 10000
		REM pause
REM ----------------------------------------------------------------------------------------------
REM ----------------------------------------------------------------------------------------------
REM НАЧАЛО ЦИКЛА
Title=%input_file% -^> Watching......
:Circle

REM Fix для случая удаления %Dir% в следствие нахождения этой директории в %temp% во время очистки кэша
if not exist "%Dir%" echo Переинициализация голосового модуля & goto :voice_init

REM Файл предыдущего бэкапа (эта конструкция после метки, т.к. перемещать файлы собрались)
set prev_backup=
for /f "delims=" %%i in ('dir /b /a:-d /o:d "%f%%input_file%*.rar"') do set prev_backup=%%i
	REM Fix для меток
	REM Если скобка - то метка была, т.к. расширение файла на скобку обычно не заканчивается
		REM echo on	
	set "qwe=%prev_backup:.rar=%"

	if "%qwe:~-1%" =="]" (
		Setlocal EnableDelayedExpansion	
		REM set "qwe=%qwe:*[=%"
		set "qwe=!qwe:*[=!"
		
		REM set "qwe=%qwe:~0,-1%"
		set "qwe=!qwe:~0,-1!"
		
		REM set "metka=%qwe%"
		set "metka=!qwe!"
		
		REM echo Major vesion ''%metka%'' finded^: & echo [%prev_backup%] & start %play% "Найдена мажорная версия с меткой %metka%"
		echo Major vesion ''!metka!'' finded^: & echo [%prev_backup%] & start %play% "Найдена мажорная версия  с меткой !metka!"
		start /min "" %tray% trayballoon "BackUp" "Найдена мажорная версия файла ~q%input_file%~q~n~nс меткой ~q!metka!~q~n~n(~q%prev_backup%~q)~n~nв директории ~q%f%~q" "user32.dll,4" 100000
		Endlocal
		
		REM set prev_backup= - Это для создания новой резервной копии
		set prev_backup=		
			REM pause		
		call :CREATE_BACKUP
		goto :Circle
	)
REM echo BackUp-file: %prev_backup%

REM Проверка на наличие файла-резерва
if "%prev_backup%"=="" (
	echo BackUp DOES NOT EXIST & start %play% "Бэкапа не было - попытка создания."
	start /min "" %tray% trayballoon "BackUp" "Бэкапа не было - попытка создания." "user32.dll,4" 10000
	call :CREATE_BACKUP
	goto :Circle
)
REM ----------------------------------------------------------------------------------------------
REM ----------------------------------------------------------------------------------------------
	REM Задержка проверки
	call :delay
color F0
cls
REM ----------------------------------------------------------------------------------------------
REM ----------------------------------------------------------------------------------------------
REM Определение времени изменения резервИРУЕМОГО файла
if exist "%f%%input_file%" ( for %%i in ("%f%%input_file%") do set usrtime=%%~ti )
REM ФАЙЛ: Выравнивание даты в порядке убывания ФОРМАТ: DD-MM-YYYY HH:MM
set usrtime=%usrtime:~6,4%.%usrtime:~3,2%.%usrtime:~0,2%%usrtime:~10,9%
REM echo %usrtime% - дата изменения ФАЙЛА [%input_file%]
echo %usrtime% - дата изменения ФАЙЛА
REM --------------------------------------------------
REM --------------------------------------------------
REM Определение времени изменения резервНОГО файла
if exist "%f%%prev_backup%" ( for %%i in ("%f%%prev_backup%") do set usrtime_prev_backup=%%~ti )
REM ФАЙЛ: Выравнивание даты в порядке убывания ФОРМАТ: DD-MM-YYYY HH:MM
set usrtime_prev_backup=%usrtime_prev_backup:~6,4%.%usrtime_prev_backup:~3,2%.%usrtime_prev_backup:~0,2%%usrtime_prev_backup:~10,9%
REM echo %usrtime_prev_backup% - дата изменения BACKUP [%prev_backup%]
echo %usrtime_prev_backup% - дата изменения BACKUP

echo. & echo [%input_file%]
echo [%prev_backup%] & echo.
REM ----------------------------------------------------------------------------------------------
REM ----------------------------------------------------------------------------------------------
REM Сравнение времени изменения текущего файла и ФАЙЛА ВНУТРИ АРХИВА
REM лексикографически сравнивать (прям в строке) - http://forum.script-coding.com/viewtopic.php?id=4106

if "%usrtime_prev_backup%" lss "%usrtime%" (
	REM Создадим резервную копию	
	call :CREATE_BACKUP

	REM Возвращаемся к наблюдению за датой файла
	goto :Circle
) else (
	REM echo Дата бэкапа - свежая. Проверим время. & start %play% "Дата бэкапа - свежая. Проверим время."
	echo Резерв актуален на момент: %TIME: =0%	& Title=%input_file% -^> OK - Резерв актуален & color F0
)
REM ----------------------------------------------------------------------------------------------	
REM ----------------------------------------------------------------------------------------------					

REM Вечный цикл
GOTO :Circle

REM ----------------------------------------------------------------------------------------------	
REM ----------------------------------------------------------------------------------------------	
REM ----------------------------------------------------------------------------------------------	
:exit
	REM Выход из наблюдения
	REM TODO: перед закрытием проверять до секунд и, если нужно, создавать финальный резерв
start /wait %play% "Закончено слежение за файлом %input_file%
start /min "" %tray% trayballoon "BackUp" "Закончено слежение за файлом %input_file%" "user32.dll,1" 100000
REM очистка директории воспроизведения звука
rd /s /q "%Dir%"
goto :EOF
REM -----------------------------------------------------	
:CREATE_BACKUP
	REM Перемещение предыдущей версии в папку "Новая папка" (создать, если необходимо)
	set "newdir=Новая папка"
	if exist "%f%%prev_backup%" (	
		echo Файл "%prev_backup%" будет перемещён в папку "%newdir%" в той же директории
		if not exist "%f%%newdir%" ( md "%f%%newdir%" )
		REM Иконка папки
		REM attrib -r -s -h "%newdir%\desktop.ini"
		REM Здесь: нужно ли if'ом проверять?
		REM if not exist "%f%%newdir%\desktop.ini" ( echo [.ShellClassInfo] > "%f%%newdir%\desktop.ini" && echo IconResource=C:\Windows\system32\SHELL32.dll,32 >> "%f%%newdir%\desktop.ini" )
		REM attrib +r +s +h "%newdir%\desktop.ini"
		move  /Y "%f%%prev_backup%" "%newdir%"
	)
	REM echo CREATE BACKUP
		REM echo "%input_file%.rar"
		REM echo "%f%%input_file%"
	REM Обязательно не забываем кавычки для заголовка start (в самом начале)
	REM Правильная строка (ниже)
	start "" /min /wait "C:\Program Files\WinRAR\rar.exe" a /ag__YYYY_MM_DD___HH_MM_SS_ /k /ep /dh /m5 /isnd "%input_file%.rar" "%f%%input_file%"
	REM Строка - ошибка (ниже)
	REM start "" /wait "C:\Program Files\WinRAR\rar.exe" /a /ag__YYYY_MM_DD___HH_MM_SS_ /k /ep /dh /m5 /isnd "%input_file%.rar" "%f%%input_file%"
			
			REM Запоминаем текущий error_Level
			set current_ErrorLevel=%ErrorLevel%
			REM Fix для последней ошибки
			if current_ErrorLevel==255 set current_ErrorLevel=11
			echo Создание архива: current_ErrorLevel=%current_ErrorLevel%

			if %current_ErrorLevel% lss 2 (
				echo Создана резервная копия в %TIME: =0% & start %play% "Создана резервная копия"
				start /min "" %tray% trayballoon "BackUp" "Создана резервная копия файла~n~q%input_file%~q" "user32.dll,4" 10000
				color 20 & Title=%input_file% -^> OK - создание BackUp
				call :delay
			)
			
			REM Получаем расшифровку ошибки/кода выполнения
			call :Error %current_ErrorLevel% frase			
			
			if %current_ErrorLevel% gtr 0 (
				echo Ошибка создания архива^: %frase% & start %play% "Ошибка создания архива. %frase%"
				start /min "" %tray% trayballoon "BackUp" "Ошибка создания архива для файла~n~q%input_file%~q.~n~n%frase%" "user32.dll,3" 10000
				color 40 & Title=%input_file% -^> FAIL
				REM call :delay
			)

exit /b
REM -----------------------------------------------------	
:delay
	REM Задержка спец-программой или через 127.0.0.1 или at 00:00 my.bat
	REM echo delay
		REM pause>nul
	REM http://otvety.google.ru/otvety/thread?tid=601d4250f169ad18
	REM пауза в 2 секунд(ы)
	REM timeout /t 2
	
	ping -n 2 127.0.0.1 >nul
exit /b
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
REM Массив ошибок - http://www.celitel.info/klad/nhelp/helpbat.php?dcmd=usf_array
REM Ошибки - http://www.cyberforum.ru/cmd-bat/thread765601.html#post4036682
:Error %d% frase
	set map=0-Операция успешно завершена.;1-Предупреждение. Произошли некритические ошибки.;2-Произошла критическая ошибка.;3-Неверная контрольная сумма CRC32. Данные повреждены.;4-Предпринята попытка изменить заблокированный архив.;5-Произошла ошибка записи на диск.;6-Произошла ошибка открытия файла.;7-Ошибка при указании параметра в командной строке.;8-Недостаточно памяти для выполнения операции.;9-Ошибка при создании файла.;10-Нет файлов, удовлетворяющих указанной маске, и параметров.;11-Операция была прервана пользователем.;
	CALL SET v=%%map:*%1-=%%
	SET v=%v:;=&rem.%
	set %2=%v%
exit /b 0
REM ----------------------------------------------------------------------------------------------	
REM ----------------------------------------------------------------------------------------------	
REM ----------------------------------------------------------------------------------------------	