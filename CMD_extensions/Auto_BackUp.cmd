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
			REM � ����� 䠩�� ������ ���� ����஢�� DOS !!! (�ᯮ����, ���ਬ��, Rpad ��� �� ���������. ������ ����� ���: http://mostovsky.narod.ru/Rpad32_v2_0.rar )
			REM ��� 㤠����� (�⤥��� �ࠧ�) ��᫥ ���ந��������, �஬� 䠩�� call_voice.cmd
			REM ����� ��� 䠩��� ���ந�������� ��㪠 (�� ���� "\" �� ���� !): �᫨ ��� "\" �� ���� - � � ����� 䠩�� ⥪�� ������ (ࠡ��ᯮᮡ����� ��࠭����); ��⨭�楩; ��� �஡����
			set Dir=%Temp%\voice_cmd\
			md "%dir%"
			Rem issue: �᫨ %Dir%call_voice.cmd �������� � ����窨 - ��� ����⠭�� ࠡ����
			REM set play=/min "" %Dir%call_voice.cmd
			REM ��� ⠪�� ����: set "play=/min """" %Dir%call_voice.cmd" � ⠪��: set "play=/min "" %Dir%call_voice.cmd"
			set "play=/min "" %Dir%call_voice.cmd"
			echo REM http://www.cyberforum.ru/cmd-bat/thread934553.html#post4923158 > "%Dir%call_voice.cmd"
			echo @echo off >> "%Dir%call_voice.cmd"
			echo mode con: cp select=1251 >> "%Dir%call_voice.cmd"
			echo set text=%%1 >> "%Dir%call_voice.cmd"
			echo Title %%1 >> "%Dir%call_voice.cmd"
			echo if "%%text:~1,-2%%"=="" set text="���⮢�� �ࠧ�" >> "%Dir%call_voice.cmd"
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

REM ����騩 ��⠫��
	REM set "f=%~dp0"
set "f=%~p1"
REM �, �����, cd %f% ��������

REM ���� ��� १�ࢨ஢���� (�஭������)
	REM ���� ��� Pinnacle Studio ����砫쭮 ��������
	REM for /f "delims=" %%i in ('dir /b /a:-d /o:d "%f%*.axp"') do set input_file=%%i
REM set "input_file=%~n1%~x1"
set "input_file=%~nx1"

if not exist "%f%%input_file%" start %play% "�訡�� ���᪠ 䠩��" & echo "�訡�� ���᪠ 䠩��" & start /min "" %tray% trayballoon "�訡�� ���᪠ 䠩��" "���� ~q%input_file%~q~n~n� ����� ~q%f%~q~n~n�� ������." "user32.dll,3" 100000 & pause
	REM pause

REM echo input_file=%input_file%

start %play% "�������� �� 䠩��� %input_file% ����"
echo �������� �� 䠩��� %input_file% ����
start /min "" %tray% trayballoon "��砫�" "�������� �� 䠩��� ~q%input_file%~q ����" "user32.dll,4" 10000
		REM pause
REM ----------------------------------------------------------------------------------------------
REM ----------------------------------------------------------------------------------------------
REM ������ �����
Title=%input_file% -^> Watching......
:Circle

REM Fix ��� ���� 㤠����� %Dir% � ᫥��⢨� ��宦����� �⮩ ��४�ਨ � %temp% �� �६� ���⪨ ���
if not exist "%Dir%" echo ��२��樠������ ����ᮢ��� ����� & goto :voice_init

REM ���� �।��饣� ���� (�� ��������� ��᫥ ��⪨, �.�. ��६���� 䠩�� ᮡࠫ���)
set prev_backup=
for /f "delims=" %%i in ('dir /b /a:-d /o:d "%f%%input_file%*.rar"') do set prev_backup=%%i
	REM Fix ��� ��⮪
	REM �᫨ ᪮��� - � ��⪠ �뫠, �.�. ���७�� 䠩�� �� ᪮��� ���筮 �� �����稢�����
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
		
		REM echo Major vesion ''%metka%'' finded^: & echo [%prev_backup%] & start %play% "������� ����ୠ� ����� � ��⪮� %metka%"
		echo Major vesion ''!metka!'' finded^: & echo [%prev_backup%] & start %play% "������� ����ୠ� �����  � ��⪮� !metka!"
		start /min "" %tray% trayballoon "BackUp" "������� ����ୠ� ����� 䠩�� ~q%input_file%~q~n~n� ��⪮� ~q!metka!~q~n~n(~q%prev_backup%~q)~n~n� ��४�ਨ ~q%f%~q" "user32.dll,4" 100000
		Endlocal
		
		REM set prev_backup= - �� ��� ᮧ����� ����� १�ࢭ�� �����
		set prev_backup=		
			REM pause		
		call :CREATE_BACKUP
		goto :Circle
	)
REM echo BackUp-file: %prev_backup%

REM �஢�ઠ �� ����稥 䠩��-१�ࢠ
if "%prev_backup%"=="" (
	echo BackUp DOES NOT EXIST & start %play% "���� �� �뫮 - ����⪠ ᮧ�����."
	start /min "" %tray% trayballoon "BackUp" "���� �� �뫮 - ����⪠ ᮧ�����." "user32.dll,4" 10000
	call :CREATE_BACKUP
	goto :Circle
)
REM ----------------------------------------------------------------------------------------------
REM ----------------------------------------------------------------------------------------------
	REM ����প� �஢�ન
	call :delay
color F0
cls
REM ----------------------------------------------------------------------------------------------
REM ----------------------------------------------------------------------------------------------
REM ��।������ �६��� ��������� १�࢈������� 䠩��
if exist "%f%%input_file%" ( for %%i in ("%f%%input_file%") do set usrtime=%%~ti )
REM ����: ��ࠢ������� ���� � ���浪� �뢠��� ������: DD-MM-YYYY HH:MM
set usrtime=%usrtime:~6,4%.%usrtime:~3,2%.%usrtime:~0,2%%usrtime:~10,9%
REM echo %usrtime% - ��� ��������� ����� [%input_file%]
echo %usrtime% - ��� ��������� �����
REM --------------------------------------------------
REM --------------------------------------------------
REM ��।������ �६��� ��������� १�ࢍ��� 䠩��
if exist "%f%%prev_backup%" ( for %%i in ("%f%%prev_backup%") do set usrtime_prev_backup=%%~ti )
REM ����: ��ࠢ������� ���� � ���浪� �뢠��� ������: DD-MM-YYYY HH:MM
set usrtime_prev_backup=%usrtime_prev_backup:~6,4%.%usrtime_prev_backup:~3,2%.%usrtime_prev_backup:~0,2%%usrtime_prev_backup:~10,9%
REM echo %usrtime_prev_backup% - ��� ��������� BACKUP [%prev_backup%]
echo %usrtime_prev_backup% - ��� ��������� BACKUP

echo. & echo [%input_file%]
echo [%prev_backup%] & echo.
REM ----------------------------------------------------------------------------------------------
REM ----------------------------------------------------------------------------------------------
REM �ࠢ����� �६��� ��������� ⥪�饣� 䠩�� � ����� ������ ������
REM ���ᨪ�����᪨ �ࠢ������ (��� � ��ப�) - http://forum.script-coding.com/viewtopic.php?id=4106

if "%usrtime_prev_backup%" lss "%usrtime%" (
	REM �������� १�ࢭ�� �����	
	call :CREATE_BACKUP

	REM �����頥��� � ������� �� ��⮩ 䠩��
	goto :Circle
) else (
	REM echo ��� ���� - ᢥ���. �஢�ਬ �६�. & start %play% "��� ���� - ᢥ���. �஢�ਬ �६�."
	echo ����� ���㠫�� �� ������: %TIME: =0%	& Title=%input_file% -^> OK - ����� ���㠫�� & color F0
)
REM ----------------------------------------------------------------------------------------------	
REM ----------------------------------------------------------------------------------------------					

REM ���� 横�
GOTO :Circle

REM ----------------------------------------------------------------------------------------------	
REM ----------------------------------------------------------------------------------------------	
REM ----------------------------------------------------------------------------------------------	
:exit
	REM ��室 �� �������
	REM TODO: ��। �����⨥� �஢����� �� ᥪ㭤 �, �᫨ �㦭�, ᮧ������ 䨭���� १��
start /wait %play% "�����祭� ᫥����� �� 䠩��� %input_file%
start /min "" %tray% trayballoon "BackUp" "�����祭� ᫥����� �� 䠩��� %input_file%" "user32.dll,1" 100000
REM ���⪠ ��४�ਨ ���ந�������� ��㪠
rd /s /q "%Dir%"
goto :EOF
REM -----------------------------------------------------	
:CREATE_BACKUP
	REM ��६�饭�� �।��饩 ���ᨨ � ����� "����� �����" (ᮧ����, �᫨ ����室���)
	set "newdir=����� �����"
	if exist "%f%%prev_backup%" (	
		echo ���� "%prev_backup%" �㤥� ��६��� � ����� "%newdir%" � ⮩ �� ��४�ਨ
		if not exist "%f%%newdir%" ( md "%f%%newdir%" )
		REM ������ �����
		REM attrib -r -s -h "%newdir%\desktop.ini"
		REM �����: �㦭� �� if'�� �஢�����?
		REM if not exist "%f%%newdir%\desktop.ini" ( echo [.ShellClassInfo] > "%f%%newdir%\desktop.ini" && echo IconResource=C:\Windows\system32\SHELL32.dll,32 >> "%f%%newdir%\desktop.ini" )
		REM attrib +r +s +h "%newdir%\desktop.ini"
		move  /Y "%f%%prev_backup%" "%newdir%"
	)
	REM echo CREATE BACKUP
		REM echo "%input_file%.rar"
		REM echo "%f%%input_file%"
	REM ��易⥫쭮 �� ���뢠�� ����窨 ��� ��������� start (� ᠬ�� ��砫�)
	REM �ࠢ��쭠� ��ப� (����)
	start "" /min /wait "C:\Program Files\WinRAR\rar.exe" a /ag__YYYY_MM_DD___HH_MM_SS_ /k /ep /dh /m5 /isnd "%input_file%.rar" "%f%%input_file%"
	REM ��ப� - �訡�� (����)
	REM start "" /wait "C:\Program Files\WinRAR\rar.exe" /a /ag__YYYY_MM_DD___HH_MM_SS_ /k /ep /dh /m5 /isnd "%input_file%.rar" "%f%%input_file%"
			
			REM ���������� ⥪�騩 error_Level
			set current_ErrorLevel=%ErrorLevel%
			REM Fix ��� ��᫥���� �訡��
			if current_ErrorLevel==255 set current_ErrorLevel=11
			echo �������� ��娢�: current_ErrorLevel=%current_ErrorLevel%

			if %current_ErrorLevel% lss 2 (
				echo ������� १�ࢭ�� ����� � %TIME: =0% & start %play% "������� १�ࢭ�� �����"
				start /min "" %tray% trayballoon "BackUp" "������� १�ࢭ�� ����� 䠩��~n~q%input_file%~q" "user32.dll,4" 10000
				color 20 & Title=%input_file% -^> OK - ᮧ����� BackUp
				call :delay
			)
			
			REM ����砥� ����஢�� �訡��/���� �믮������
			call :Error %current_ErrorLevel% frase			
			
			if %current_ErrorLevel% gtr 0 (
				echo �訡�� ᮧ����� ��娢�^: %frase% & start %play% "�訡�� ᮧ����� ��娢�. %frase%"
				start /min "" %tray% trayballoon "BackUp" "�訡�� ᮧ����� ��娢� ��� 䠩��~n~q%input_file%~q.~n~n%frase%" "user32.dll,3" 10000
				color 40 & Title=%input_file% -^> FAIL
				REM call :delay
			)

exit /b
REM -----------------------------------------------------	
:delay
	REM ����প� ᯥ�-�ணࠬ��� ��� �१ 127.0.0.1 ��� at 00:00 my.bat
	REM echo delay
		REM pause>nul
	REM http://otvety.google.ru/otvety/thread?tid=601d4250f169ad18
	REM ��㧠 � 2 ᥪ㭤(�)
	REM timeout /t 2
	
	ping -n 2 127.0.0.1 >nul
exit /b
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
REM ���ᨢ �訡�� - http://www.celitel.info/klad/nhelp/helpbat.php?dcmd=usf_array
REM �訡�� - http://www.cyberforum.ru/cmd-bat/thread765601.html#post4036682
:Error %d% frase
	set map=0-������ �ᯥ譮 �����襭�.;1-�।�०�����. �ந��諨 ������᪨� �訡��.;2-�ந��諠 ����᪠� �訡��.;3-����ୠ� ����஫쭠� �㬬� CRC32. ����� ���०����.;4-�।�ਭ�� ����⪠ �������� �������஢���� ��娢.;5-�ந��諠 �訡�� ����� �� ���.;6-�ந��諠 �訡�� ������ 䠩��.;7-�訡�� �� 㪠����� ��ࠬ��� � ��������� ��ப�.;8-�������筮 ����� ��� �믮������ ����樨.;9-�訡�� �� ᮧ����� 䠩��.;10-��� 䠩���, 㤮���⢮����� 㪠������ ��᪥, � ��ࠬ��஢.;11-������ �뫠 ��ࢠ�� ���짮��⥫��.;
	CALL SET v=%%map:*%1-=%%
	SET v=%v:;=&rem.%
	set %2=%v%
exit /b 0
REM ----------------------------------------------------------------------------------------------	
REM ----------------------------------------------------------------------------------------------	
REM ----------------------------------------------------------------------------------------------	