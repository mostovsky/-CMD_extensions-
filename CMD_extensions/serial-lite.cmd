REM =======
:: WinAVR path-fail fix
set "path=C:\windows\;%path%"
set "path=%system32%;%path%"
set "path=%windir%\System32\;%path%"
::echo "path=%windir%\System32\;%path%"
REM =======
REM In NOTEPAD++ change encoding to "cyrillic 866"
rem ----------------------------------------------------------------------------------------------------------------------------------
REM for color display
REM cls && color 08
rem .... the following line creates a [DEL] [ASCII 8] [Backspace] character to use later
rem .... All this to remove [:]
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (set "DEL=%%a")
rem ----------------------------------------------------------------------------------------------------------------------------------
@echo off
cls && color 08
echo This file is serial-lite.cmd & title=This file is serial-lite.cmd
Setlocal EnableDelayedExpansion
rem examples:
REM Reverie.S01E01.Apertus.1080p.AMZN.WEB-DL.H.264-SDI.mkv
REM Angel.ili.demon.01.serija.(2013).•viD.SATRip.avi
REM Ray.Donovan.S05E01.1080p.AMZN.WEBRip.DD5.1.x264-Jaskier.mkv
REM The Originals S01E01 Always and Forever BDRemux 1080p 2xRus Eng Subs by Stiles RG SerialS.mkv - was problem with spaces
rem ----------------------------------------------------------------------------------------------------------------------------------
rem ----------------------------------------------------------------------------------------------------------------------------------
rem Settings -------------------------------------------------------------------------------------------------------------------------
REM pause
set "pre_name_of_indicator_file="
set "post_name_of_indicator_file=inclusively"
set "type_of_indicator_file=serial" & rem %pre_name_of_indicator_file% %num_of_series_done% %post_name_of_indicator_file%.%type_of_indicator_file%" & rem it must be corresponding with .serial in reg-file
set "delims_of_indicator_file=_"
set "series_max_2_find=40" & rem echo maximum of xx in foramat like SxxExx where xx - current series; number of series always less than 99
REM set "extra_delims_in_file_name=.,_-" & rem echo we expect that pre-delims and post-delims will be the same
set "extra_delims_in_file_name=,_-." & rem echo we expect that pre-delims and post-delims will be the same & rem move dot to end to prevent use by script file-type after 1st item (like in "The Originals S01E01 Always and Forever BDRemux 1080p 2xRus Eng Subs by Stiles RG SerialS.mkv" use only "The" and ".mkv") & rem can't add space - error
set "delims_in_series_num=eE¥…" & rem echo last "e E" in Russian, space use apriori; this symbols must be inside (I hope)
set "delims_in_season_num=sS‘áeE¥…‘¥§®­"
set "Install_commands=Install INSTALL install Inst INST inst"
set "UNinstall_commands=Uninstall UNinstall UNINSTALL uninstall Uninst UNinst UNINST uninst"
set "command2install=serial_lite" & rem This is REG-key for handling to function of this file
set "video_file_types=mkv avi webm mp4 m4a mp2t vob flv wmv mov mpg h264 mpeg ts" & rem video file types for to selective by types files in dir-list
rem Russian word work only 1-st time: after next - not work
set "request_next=next ¤ «¥¥ á«¥¤ãîé more watch see ++ 3 ¥éñ +++ ++++" & rem	text for prompt from user for see next episode
set "request_no=no exit 2 fuckyou - 0 fuckyouspilberg ­¥â ­¥ fuck dick shit" & rem	text for prompt from user for exit without	saving watch-progress !
set "request_yes=yes ok + 1 ¤  done" & rem							text for prompt from user for exit with		saving watch-progress
REM set "RenameFilesWith_=" & rem set to nothing to ignore ( set "RenameFilesWith_=" )
set "RenameFilesWith_=1" & rem set to nothing to ignore ( set "RenameFilesWith_=" )
REM pause
rem ----------------------------------------------------------------------------------------------------------------------------------
REM echo Kakoy-to path = "%~s0"
TITLE=This file is serial-lite.cmd
REM May be substitute with "if defined" instead "if not ""=="%~1""
if not ""=="%~1" echo 1st_parameter="%~1" & rem set "1st_parameter=%~1"
if not ""=="%~2" echo 2nd_parameter="%~2" & rem set "2nd_parameter=%~2"
if not ""=="%~3" echo 3rd_parameter="%~3" & rem set "3rd_parameter=%~3"
REM echo %~3 | find /i /n "KILL_WINDOW_">nul && ( call :Kill_parent_window "!3rd_parameter:KILL_WINDOW_=!" ) & rem hack for close parent window
call :PainText 0F "cd=" & echo "%cd%"
REM echo cd="%cd%"
rem ----------------------------------------------------------------------------------------------------------------------------------
rem Check for EMPTY input file -------------------------------------------------------------------------------------------------------
REM REM if not "%~1"=="watch" ( set "input_parameter=%~1" ) else ( set "input_parameter=%~2" ) & rem For watch we use path to file (video) in second parameter
REM REM if not "%~1"=="open"  ( set "input_parameter=%~1" ) else ( set "input_parameter=%~2" ) & rem For open we use path to file (.serial) in second parameter
REM echo open watch | find /i /n "%~1">nul && ( set "input_parameter=%~2" ) || ( set "input_parameter=%~1" ) & rem For watch and open we use path to file in second parameter

REM if not "%~1"=="watch" ( set "input_parameter=%~1" ) else ( set "input_parameter=%~2" ) & rem For watch we use path to file (video) in second parameter
echo "watch rename" | findstr /i "%~1">nul && ( set "input_parameter=%~2" ) || ( set "input_parameter=%~1" ) & rem For watch we use path to file (video) in second parameter



REM if "%~1"=="open"  ( set /p input_parameter= < "%~2" ) & rem For open we use path to file (.serial) in second parameter, real video-name - inside file
if "%~1"=="open"  (
	if not exist "%~2" (
			REM color 40 & echo While "open" - file "%~2" do not exist & pause & goto :5
			REM echo While "open" - file "%~2" do not exist & pause 5 & color 40 & pause & goto :5
			call :PainText 04 "While open - file '%~2' do not exist" & pause & goto :5
		) else (
			set /p input_parameter= < "%~2" & rem For open we use path to file (.serial) in second parameter, real video-name - inside file
		)
)

	REM ---
call :PainText 0e "input_parameter=" & echo "%input_parameter%"
REM echo input_parameter="%input_parameter%"

rem Check for empty %1 & REM can use "if defined"
REM if %input_parameter%=="" ( echo NO FILE TO INPUT & title=NO FILE TO INPUT & color 40 & pause & exit /b ) else ( echo INPUT FILE OK) & REM it not works without symbols "

REM if "%input_parameter%"=="" ( echo NO FILE TO INPUT & title=NO FILE TO INPUT & color 40 & pause & exit /b ) else ( echo INPUT FILE OK)
if "%input_parameter%"=="" ( call :PainText 04 "NO FILE TO INPUT" & echo. & title=NO FILE TO INPUT & timeout /t 3 /nobreak & pause & color 40 & pause & color 08 & exit /b ) else ( call :PainText 02 "INPUT FILE OK" & echo. )

for /f "tokens=* delims=\" %%i in ("%input_parameter%") do echo input_parameter_in_parse="%%~dpi" & set "file_path_only=%%~dpi" & set "file_name_only=%%~nxi" & set "file_type_only=%%~xi"
echo. & echo file_path_only="%file_path_only%" & echo file_name_only="%file_name_only%" & echo file_type_only="%file_type_only%" & echo.
REM now can use file_path_only, file_name_only and file_type_only everywhere also with watch parameter
rem ----------------------------------------------------------------------------------------------------------------------------------
rem Check for need OPEN --------------------------------------------------------------------------------------------------------------
if "open"=="%~1" goto Open & rem open before check for file-type (because .serial)
rem ----------------------------------------------------------------------------------------------------------------------------------
rem Before watch or add_file_to_already_watched - check for file-type (open=.serial-file not use because name only inside file) ------
set "file_type_only_to_check=!file_type_only:.=!" & rem var video_file_types do not have dots
REM echo %video_file_types% | findstr /i /n "%file_type_only_to_check%">nul && echo ok with input file-type || ( echo BAD FILE-TYPE & title=BAD FILE-TYPE & color 40 & pause & exit /b )
echo %video_file_types% | findstr /i /n "%file_type_only_to_check%">nul && call :PainText 02 "ok with input file-type" || (  call :PainText 04 "BAD FILE-TYPE" & title=BAD FILE-TYPE & pause & exit /b )
rem ----------------------------------------------------------------------------------------------------------------------------------
rem Check for "watch with serial-lite" -----------------------------------------------------------------------------------------------
if "%~1"=="watch" (
	REM set "needed_episode=%~2"
	set "needed_episode=%input_parameter%"
	goto player_run & REM rem we use already exist constructions to run playback
)
rem ----------------------------------------------------------------------------------------------------------------------------------
rem Check for need Install operations ------------------------------------------------------------------------------------------------
echo %Install_commands% | find /i "%~1">nul && goto Install
REM echo NOT install-mode & color 70
color 70 & call :PainText 0e "NOT install-mode"
rem ----------------------------------------------------------------------------------------------------------------------------------
rem Check for need UNinstall operations ----------------------------------------------------------------------------------------------
echo %UNinstall_commands% | find /i "%~1">nul && goto Uninstall
REM echo NOT UNinstall-mode & color 70
color 70 & call :PainText 0e "NOT UNinstall-mode"
rem ----------------------------------------------------------------------------------------------------------------------------------
rem Check for need rename ------------------------------------------------------------------------------------------------------------
rem it is external system-function
echo "ren rename" | find /i "%~1">nul && set NeedToRenameWithFile=1
if defined NeedToRenameWithFile (
	echo "del delete" | findstr /i "%~3">nul && ( call :Raname_file_with_no_symbol "%file_name_only%" "del" ) || ( call :Raname_file_with_no_symbol "%file_name_only%" "add" )
	goto 5 
)
rem ----------------------------------------------------------------------------------------------------------------------------------
rem ----------------------------------------------------------------------------------------------------------------------------------
REM parse here -----------------------------------------------------------------------------------------------------------------------
REM see serial.cmd
REM in CALL procedure returned parameter write without quotes because inside use set %1= where %1 is name of variable
call :parse num_of_series_done "%delims_in_series_num%" "%file_name_only%"
goto final

:parse number2find %uses_delims% input_file_name %token_num%
		echo in "parse": 1="%~1"; 2="%~2"; 3="%~3"; 4="%~4"
		set "file_name_only_temp=%~3"
		echo file_name_only_temp="%file_name_only_temp%"
	set "num_of_series_done_temp=none" & rem For 1-st find
	rem space delims; 10 delims in file_name
	for /L %%p in (1,1,10) do (
		set "cur_num=%%p"
			echo. & echo _______________________
			echo cur_num=!cur_num!
		REM set "file_name_only_spec=%file_name_only_temp:)=^)%" & rem hack for symbols "()" inside
		set "file_name_only_spec=!file_name_only_temp:)=^)!" & rem hack for symbols "()" inside
		set "file_name_only_spec=!file_name_only_spec: =_!" & rem hack for space-symbol " " inside (some times uses by users as separator)
		set "file_name_only_spec=!file_name_only_spec:(=^(!"
		REM for /f "tokens=*" %%i in ('"cmd/v/c for /F "tokens^=!cur_num! delims^=." %%I in ("!file_name_only_spec!") do echo %%I" ') do ( echo found_i=%%i & set "current_part=%%i" )
		for /f "tokens=*" %%i in ('"cmd/v/c for /F "tokens^=!cur_num! delims^=!extra_delims_in_file_name!" %%I in ("!file_name_only_spec!") do echo %%I" ') do ( echo found_i=%%i & set "current_part=%%i" )
			echo i=!current_part!
		rem check here --------------------------------------------------------------------
		REM call :more_check "!current_part!" num_of_series_done_temp "%~2" "%~3" "%~4"
		call :more_check "!current_part!" num_of_series_done_temp "%~2" "%~4"

		if "!num_of_series_done_temp!"=="none" (
			echo still finding...
		) else (
			REM echo OK, we found & echo _______________________
			call :PainText 02 "OK, we found" & echo _______________________
			rem pause
			REM goto :final & rem Get out there to exit (first find)
				set "%1=!num_of_series_done_temp!" & exit /b & rem It string create when parse goes call-function from easy-code
		)
		rem end check here ----------------------------------------------------------------
	)
exit /b & rem stub just in case
:final		
rem pause
	REM if "!num_of_series_done!"=="none" ( echo we do not find anything & color 40 & pause & exit /b )
	if "!num_of_series_done!"=="none" ( color 40 & call :PainText 04 "we do not find anything" & pause & exit /b )
	REM If number still not found - we must try to find without delims
	
	
	
	rem pause
	


	REM set "num_of_series_done=4" & REM indusish_code: 4 - random digit
	REM set "num_of_series_done=4" & REM indusish_code: 4 - random digit
rem ----------------------------------------------------------------------------------------------------------------------------------
echo Create or change ]VIEWED[
	set "type_of_indicator_file=%type_of_indicator_file: =%" & rem Just in case
if "%pre_name_of_indicator_file%"=="" ( echo no pre_name_of_indicator_file ) else ( set "pre_name_of_indicator_file=%pre_name_of_indicator_file%%delims_of_indicator_file%" )
if "%post_name_of_indicator_file%"=="" ( echo no post_name_of_indicator_file ) else ( set "post_name_of_indicator_file=%delims_of_indicator_file%%post_name_of_indicator_file%" )
set "name_of_indicator_file=%pre_name_of_indicator_file%%num_of_series_done%%post_name_of_indicator_file%.%type_of_indicator_file%"
REM pause
	echo name_of_indicator_file="%name_of_indicator_file%"
REM Need delete previously files
del /q *.%type_of_indicator_file%
chcp | find /i /n "1251">nul || chcp 1251 & rem chande codepage to see Russian symbols	

REM echo %file_name_only% > "%file_path_only%\%name_of_indicator_file%"

set "file_name_only_to_write=%file_name_only%"
REM if "%file_name_only:~0,1%"=="_" ( set "file_name_only_to_write=%file_name_only:~1,255%" ) & rem Hack for symbol "_" in start (when use)
if "!file_name_only_to_write:~0,1!"=="_" ( set "file_name_only_to_write=!file_name_only_to_write:~1,255!" ) & rem Hack for symbol "_" in start (when use)

echo !file_name_only_to_write! > "%file_path_only%\%name_of_indicator_file%"

if defined RenameFilesWith_ (
	REM echo Need to add rename another files
	echo NEED TO RENAME [in "final" calling]
	rem check for not rename yet
	if not "!file_name_only:~0,1!"=="_" (
		rem Here must check for true rename (because errlevel of ren can be 0 if there are no privilegies)
		REM echo %video_file_types% | findstr /i /n "!file_type_only!">nul && ( ren "!file_name_only!" "_!file_name_only!" & echo renamed "!file_name_only!" to "_!file_name_only!" )
			REM echo "file_name_only=%file_name_only%" & echo "file_type_only=%file_type_only%"
		set "file_type_only_2_check=%file_type_only:.=%"
		REM echo %video_file_types% | findstr /i /n "%file_type_only%">nul && ( ren "%file_name_only%" "_%file_name_only%" & echo renamed "%file_name_only%" to "_%file_name_only%" ) || ( echo ___NOT renamed because not video )
		echo %video_file_types% | findstr /i /n "!file_type_only_2_check!">nul && ( ren "%file_name_only%" "_%file_name_only%" & echo renamed "%file_name_only%" to "_%file_name_only%" ) || ( echo ___NOT renamed because not video )
	) else (
		echo File already with symbol "_"
	)
)

REM This is END
echo exit now & timeout /t 2 & rem pause

exit /b

	color 90 & echo now you in the sky & pause & pause & goto :eof

rem ----------------------------------------------------------------------------------------------------------------------------------
rem ----------------------------------------------------------------------------------------------------------------------------------
rem ----------------------------------------------------------------------------------------------------------------------------------

REM Serial-lite
REM todo*************************************************************************************************************
REM See also todo_I_do_it_(by_Most).txt
REM !CRITICAL! ******************************************************************************************************
REM * [RENAME] When only 2 ep. ok and user mark on 4 "already watched" we need mark ep.3 too
REM * [RENAME] If fail with rename - ask from user to try again or not or taskkill. Check for bad with rename (other application use file).
REM +=* do it only after watching: on start watching - ignore failyre access.
REM * need to add rename operation in "INCREMENT" in calling (inside, for operation "already watched")
REM * Check for issue with empty num_series " Increment "" "
REM * For list file when finding next use construction like "for %i in (*!episode_num!*) do echo %i" for smaller time to treatment={time in seconds to start video} (but rename all other episode will be lost; but rename other can do after watching or start another instation of file with special key of renames files)
REM +=* [RENAME]: need to make external function to true-rename (with parallel starting) for command "Already watched" and "next" (when see not for last file with "_"-symbol, ex.: when already 4 episodes, but user start watch from 2-d: ep. 3 and 4 must be not have "_"-symbol). Maybe in last case use special .log events file? Or make this file full time? - but now we can watch with different names, it's not a mistake.
REM * ADD Revers-rename while open!!! ( delete "_" if GTR ). May be do this in background by "start /nowait check names" - it allow start watching and do what need to do.
REM * ADD while yes and episode_done
REM * to true-open - FIND in any video-file in dir 1-st symbol "_": if founded - use function new_check (slowly), if not - use old_check (quickly). To determine use construction "for %i in (_*) do echo %i" => if {left} goto :new else goto :old
REM * Add check-delete all of special symbols!!!! in more_ckeck function
REM * Before parse dell all not_interesting_words like in "serch for next season" (but it need a lot of time)
REM * not_interesting_words_1 to begin=settings
REM * Check set "needed_last_path_for_find=!needed_last_path_for_find:(=^(!" on the "€­£¥«ë ¨ ¤¥¬®­ë" and (for example) _Lady Gaga - Paparazzi (Explicit) [360p].mp4
REM * IN CONTEXT MENU: MAKE SPANSHOT WITH FILE-NAMES OF ALL FILES IN ALL SUB-DIRS (use double confirmation from user) AND save here list with one example of each file-name of episodes
REM * Check for already see more than this episode: color_not_red=yellow, prompt from user "what person need": add this or nothing
REM * Symbol "-" in answer not work
REM * Add Registration .serial type in install (now it in serial-lite.reg) and deleting in uninstall-mode
REM * move context menu to 2-nd menu "Serial"
REM * Add INSTALL [completely] to start_with_serial
REM +=* create dir CMD_extensions in program_files if not exist
REM *! RE-DESIGN :str_length do not use file in file-system ("$")
REM *! Check for last episode (last file in dir) - special name add to file .serial
REM +=* search next season (if last) in .\ directory
REM +=* when start next check for NOT_LAST!!!!
REM *! On INSTALL (registration in REG-key) use ~dp0 path (actual physical), not absolutely, but notify about abnormal-path
REM +=* Check path for 64: https://stackoverflow.com/questions/12322308/batch-file-to-check-64bit-or-32bit-os
REM +=*! On INSTALL copy this file to needed directory and than use new_path in ProgramFiles directory instead ~dp0 (warning: check than it file and destination file not 1 file, do not copy in itself)
REM * use count of delims in dir-name while finding next_season (or may be episode) with non_important_words to do not find a lot of words when only one stay
REM * make full documentation = description of functions (with arguments) and graf of calling, maybe by Doxygen
REM * 
REM * 
REM * 



REM NOT_critical *****************************************************************************************************
REM * use colours in echo (see end of this file)
REM +=* make function with name of colors and type of message: mistake or info
REM * on the end show FINDED/writen name on the title before exit
REM * For [INSTALL] and [UNINSTALL] remake check for input word - check for true find whole ininstall, not install inside uninstall
REM * [INSTAL] Raname_file_with_no_symbol - add install
REM *! [INSTALL] Need to check other commands in list of SubCommands? (if they do not exist - all commmands in context menu will be lost=not work in explorer)
REM * if check with no multi-if, use find /i "str"
REM *! Add check for operation done (with find word "“á¯¥") english-word (for english cmd)
REM * in generate in REG-file use type_of_indicator_file=serial
REM * need check for privilegies in worked directory: it maybe network path with no access to write: maybe use user_documets path with name of Whole_video (not only episode) with full path inside
REM * delete un-important echo by >nul or another method
REM * 
REM * 
REM * 
REM * 
REM * 
REM * 



REM IN_FUTURE ********************************************************************************************************
REM * make preview of file .series with number_or_episodes_done (like video preview)
REM *! add in DIR "saw series +1" (in contradistiction to for file "look to this file series")
REM +=* when in dir click "now in player" (like in serial find for different open players and files inside)
REM * {If user want in settings} Rename (or delete) watched files (what about torrent? Maybe check for torrent and notify user?)
REM * Show and say in start what files already watched (and say that last episode)
REM * Open .serial with specific app (make menu for choose or system menu OR START WITH NORMAL APP) = [OPEN][Add to install command with .serial-file]
REM * [INSTALL] Some settings can apply from install parameter (during install)
REM * Can listen sound (system) to check for playback or stop; can use title of window (as in serial not lite): in VLC in taskbar text is "... - à¨®áâ ­®¢«¥­®" (it is not quite title, it is title_of_taskbar)
REM +=* or can use system Windows parameters of playback (all players support it, but what when all players simultaneously)
REM * Rename .srt file with finded video-file (only for .srt file-types)
REM * Add "again" to answer for start episode again; also - need previous and etc.
REM * [SAVE] in global paths_of_serial-files for generate global report about serils; need confirmation from user (privacy politics)
REM * 
REM * 
REM * Search all .serial files and create html-report of watched, unwatched files and size of files to delete
REM * Is need to check right-install when command install start when installation is already OK? - not REG-keys write again on install
REM += * maybe by write to reserved REG-branch and than REG COMPARE needed branch with Reserved
REM * After player closed makes window of serial-lite to front
REM * 


REM HZ ***************************************************************************************************************
REM * check for the work with key [HKEY_CLASSES_ROOT\SystemFileAssociations\.mkv] for Windows less than 10-
REM * make window choose types of files (add type, or for all file-types) - for settings?
REM * Is re-install command need?
REM * 
REM * 
REM * 
REM * 



REM NOT_IMPLEMENTED
REM * add function for prepare names inside for: replace ")" with "^)" and "(" with "^(" - MORE GLOBAL = it refers to spaces in names
REM * with use not true path in shell_open we can open nemu of choose app in win10 (but after mouse d-click in explorer): how to inialise this menu by cmd?
REM * make help like Hex_Dump http://www.cyberforum.ru/post3685665.html and exept all tags (like ":more") with digits (show only non-system_circle_for tags=marks)
REM +=* can generate .hta (or .html) to show help
REM * 
REM * 
REM * 
REM * 
REM * 
REM * 



rem OK of todo *********************************************************************************************************

REM CHECK IT FIRSTLY - REM *!!! We need delete only last spaces (in filenames), not all spaces - check for files with spaces!!!!!!!!!!!!!!! - If "%last_episode:~-1%"==" " Set "=%last_episode:~1,-1%" & REM http://forum.oszone.net/thread-99354.html - http://forum.oszone.net/post-729005-3.html - OK (by replace spaces in var "file_name_only_spec" to symbol "_")
REM * to true search episode maybe need search next digit, because when we rename to _%filename% simple search is hard to use: current file will be at the end; or search by make list of files and than delete symbol "_" at the beginning and than sort files, after this search next - OK
REM +=* when save do not save with symbol "_" (or delete symbol) - ok



REM OK_ALL *************************************************************************************************************
REM * !!! do not create with none!!! - ok
REM * delete previously files - ok
REM Trouble with Russian Symboll: if fail in start next video - use only digit and english letters. May try chcp 866 or 1251 - OK by 1251
REM * start next video by starting .serial (use single file: second param of cmd) - ok
REM *! rec file-name inside file.serial and than start this file - ok
REM * work or not system paths inside regedit keys: work only for icon, not for prog-path
REM * In context menu "start watch with serial-lite" (on the end of watch ask for add) - ok
REM *! need hack for .str dublicate when wrong file input (str instead avi or etc): check for exist video-file by different types ("avi mkv mp4 etc...") - it can make by list files without type (with check all files with this name but another types like this: NAME.* will be show .mkv and .srt) - maybe trouble with start next (check for file-type) - have trouble in "Žáâ âª¨ (‘¥§®­ 1) Amedia" - OK
REM * Need to start more than one episode after watching? (do not close, next or continue track user actions/behavior) - ok (by entering next, watch, more or ++)
REM * make function for AnyLowUpperCaseDeleteStringInsideString - NO (Automated inside functions on Windows)
REM * IN "SEE WITH SERIAL-LITE" CHECK FOR FILE-TYPE (VIDEO ONLY!!!) - OK

rem ----------------------------------------------------------------------------------------------------------------------------------
rem ----------------------------------------------------------------------------------------------------------------------------------
rem ----------------------------------------------------------------------------------------------------------------------------------

rem -----------------------------------------------------------------

rem -----------------------------------------------------------------
:str_length %input_string% len_out
REM http://www.cyberforum.ru/cmd-bat/thread1671608.html
	set "s=%1"
	for /f %%i in ('">$ cmd/v/c echo.!s!& echo $"') do set/a l=%%~zi-2& del $
	set "%2=%l%"
exit /b
rem -----------------------------------------------------------------
:more_check current_part num_of_series_done %uses_delims% %token_num%
	REM echo.
	set "token_num_temp=%~4"
	if "%~4"=="" set "token_num_temp=2" & rem for case finding for episode in str like "s02e04" (for season need %4=1)
	echo inside "more_check" input_parameter="%~1"; 2="%~2"; 3="%~3"; 4="%token_num_temp%"
	set "temp_1=%~1" & rem hack for length
	If "%temp_1:~-1%"==" " Set "temp_1=%temp_1:~,-1%" & REM http://forum.oszone.net/thread-99354.html & rem check for only last spaces (in filenames), not all spaces
	set "temp_1=!temp_1:[=!" & rem hack for special symbols (like in "Ray.Donovan.[S04E01].XviD.Amedia.[qqss44].avi")
	set "temp_1=!temp_1:]=!" & rem hack for special symbols (like in "Ray.Donovan.[S04E01].XviD.Amedia.[qqss44].avi")
	REM Add here check-delete all of special symbols!!!!
	
	echo temp_1="!temp_1!" & rem pause
	
	call :str_length !temp_1! len_out
	REM pause
		echo current_part_LEN=!len_out!
	
	REM if !len_out! LSS 7 (
	if !len_out! GEQ 7 ( echo sorry & exit /b )
		echo len_out less 7
	rem check for needed
	set "part_of_part=none"

	REM for /f "tokens=*" %%i in ('"cmd/v/c for /F "tokens^=2 delims^=%~3" %%I in ("!temp_1!") do echo %%I" ') do ( echo i_inside="%%i" & set "part_of_part=%%i" )
	REM for /f "tokens=*" %%i in ('"cmd/v/c for /F "tokens^=2 delims^=%~3" %%I in ("!temp_1!") do echo %%I" ') do ( set "part_of_part=%%i" )
	for /f "tokens=*" %%i in ('"cmd/v/c for /F "tokens^=%token_num_temp% delims^=%~3" %%I in ("!temp_1!") do echo %%I" ') do ( set "part_of_part=%%i" )
	
	rem hack for spaces
	set "part_of_part=!part_of_part: =!"
	
	rem hack for symbols "(" and ")"
	set "part_of_part=!part_of_part:^)=!"
	set "part_of_part=!part_of_part:^(=!"
	
		echo after delims(%~3): part_of_part="!part_of_part!" 
	
	if "!part_of_part!"=="none" (
		echo no part_of_part & rem this case if previous operation has no effect
		REM set "part_of_part=%~1" & echo check for simple digit without delims__
		set "part_of_part=!temp_1!" & echo check for simple digit without delims__
	)
	
	REM check for isDigit and less than %series_max_2_find% 
	call :isDigit_func !part_of_part! isDigit_result

	if "!isDigit_result!"=="False" ( echo Not integer & exit /b )

	rem check for isInteger
	if !part_of_part! LSS %series_max_2_find% (
		echo Evrika, part_of_part=!part_of_part!
		REM set "%2=!part_of_part!" & color 20 
		set "%2=!part_of_part!" & call :PainText 0F "..." 
	) else (
		echo Not Evrika, not ("!part_of_part!" more than "%series_max_2_find%")
	)
exit /b
rem -----------------------------------------------------------------
:isDigit_func !part_of_part! isDigit_result
REM need to make this func with no file creation
set "%2=False"
echo Input parameter inside isDigit_func: 1="%1" 2="%2"
REM http://www.cyberforum.ru/post8635821.html
REM set /p "v=‚¢¥¤¨â¥ ç¨á«®: "
REM echo for /f "delims=" %%A in ('echo.%1^| findstr "[^0-9]"') do set "nv=%%~A"
for /f "delims=" %%A in ('echo.%1^| findstr "[^0-9]"') do set "nv=%%~A"
REM echo nv="%nv%"
if not "%1"=="%nv%" ( set "%2=True" & echo "%1" - digit )
exit /b
rem -----------------------------------------------------------------
rem -----------------------------------------------------------------
rem -----------------------------------------------------------------
:Install
echo Install-mode & color 60
if not defined FirstStart title=Install-mode & rem Sorry for strange, but this condition cause isFirst_start
echo Press anykey to continue Install operations & pause
REM Need for ADMIN permissions? - yes
REM call :CheckForPermissions
call :CheckForPermissions "%~1" & rem 2ME: please, always delete symbol " from input and output parameters by using symbol ~
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
	goto Install & rem We need starting with permissions in new window
)
REM INSTALL-------------------------------------------------------------------------------------------------------

REM read all sub commands for try to find serial-lite: if cannot find serial-lite - add to end of list, else (if founded) - no operations
For /F "Tokens=2*" %%I In ('reg query ^"HKEY_CLASSES_ROOT\^*\shell\MenuOfVariousCMD^" /v SubCommands') Do set cur_tmp=%%J
echo REG-key [SubCommands]="%cur_tmp%" | findstr /I "%command2install%" && ( echo serial-lite already registered ) || ( echo serial-lite not registered & set "isNoRegistered=True" )

if defined isNoRegistered (
	REM Inside reg-file
	REM ;Ž¡é ï ª®¬ ­¤  § ¯ãáª  -----
	REM [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\serial_lite]
	REM @="‘¥à¨ï ¯à®á¬®âà¥­ "
	REM "Icon"="%windir%\\system32\\SHELL32.dll,144"

	REM [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\serial_lite\command]
	REM @="\"C:\\Program Files\\CMD_extensions\\serial-lite.cmd\" \"%1\""
	REM End text of reg-file

	REM In cmd it will be like this:
		REM http://forum.oszone.net/nextoldesttothread-201130.html
	REM ( REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\serial_lite" /ve /t REG_SZ /d [This_episode_DONE] /f ) && ( echo REG-key [caption of serial_lite] is added & color 30) || ( Echo NO!! REG-key [caption of serial_lite] no added & color 50 & timeout /t 1 & goto Install )
	REM REM pause
	REM ( REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\serial_lite" /v Icon /t REG_SZ /d %%windir%%\\system32\\SHELL32.dll,144 /f ) && ( echo REG-key [Icon of serial_lite] is added & color 30) || ( Echo NO!! REG-key [Icon of serial_lite] no added & color 50 & timeout /t 1 & goto Install )
	REM REM pause
	REM ( REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\serial_lite\command" /ve /t REG_SZ /d "\"C:\\Program Files\\CMD_extensions\\serial-lite.cmd\" \"%%1\"" /f ) && ( echo REG-key [command of serial_lite] is added & color 30) || ( Echo NO!! REG-key [command of serial_lite] no added & color 50 & timeout /t 1 & goto Install )

	rem Check for 1st time CMD_extensions or need add (all this block can replace with "set "cur_tmp=%cur_tmp%;%command2install%"")
	if "%cur_tmp%"=="" (
		echo SubCommands string is empty
		set "cur_tmp=%command2install%"
	) else (
		echo SubCommands string is NOT empty & rem add this item to the end
		set "cur_tmp=%cur_tmp%;%command2install%"
	)

	REM --------------------
	REM part of CMD_extensions
	REM [HKEY_CLASSES_ROOT\*\shell\MenuOfVariousCMD]
	REM "MUIVerb"="CMD_extensions"
	REM "SubCommands"="serial_lite"
	REM ; "Icon"="C:\\Windows\\system32\\SHELL32.dll,169"
	REM "Icon"="%system32%\\SHELL32.dll,169"
	REM "Position"="Top"
	REM "CommandFlags"=dword:00000040
	REM --------------------
	
	echo Will be use cur_tmp=!cur_tmp!
	
	REM ( REG ADD "HKEY_CLASSES_ROOT\*\shell\MenuOfVariousCMD" /v SubCommands /t REG_SZ /d !cur_tmp! /f ) && ( echo REG-key [SubCommands of CMD_extensions] is added & color 30) || ( Echo NO!! REG-key [SubCommands of CMD_extensions] no added & color 50 & timeout /t 1 & goto Install )
			
	REM REM need added standart CMD_extensions key menu (in true way only if they not exist)
	REM ( REG ADD "HKEY_CLASSES_ROOT\*\shell\MenuOfVariousCMD" /v MUIVerb /t REG_SZ /d CMD_extensions /f ) && ( echo REG-key [MUIVerb of CMD_extensions] is added & color 30) || ( Echo NO!! REG-key [MUIVerb of CMD_extensions] no added & color 50 & timeout /t 1 & goto Install )
	REM ( REG ADD "HKEY_CLASSES_ROOT\*\shell\MenuOfVariousCMD" /v Icon /t REG_SZ /d %%system32%%\\SHELL32.dll,169 /f ) && ( echo REG-key [Icon of CMD_extensions] is added & color 30) || ( Echo NO!! REG-key [Icon of CMD_extensions] no added & color 50 & timeout /t 1 & goto Install )
	REM ( REG ADD "HKEY_CLASSES_ROOT\*\shell\MenuOfVariousCMD" /v Position /t REG_SZ /d Top /f ) && ( echo REG-key [Position of CMD_extensions] is added & color 30) || ( Echo NO!! REG-key [Position of CMD_extensions] no added & color 50 & timeout /t 1 & goto Install )	
	
) else (
	REM echo already registered (nothing to do, not checked, if have problem - reinstall by uninstall and than install)
	echo already registered (install again now...)
)

rem write this for re-install if wrong

( REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\serial_lite" /ve /t REG_SZ /d [This_episode_DONE] /f ) && ( echo REG-key [caption of serial_lite] is added & color 30) || ( Echo NO!! REG-key [caption of serial_lite] no added & color 50 & timeout /t 1 & goto Install )
REM pause
( REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\serial_lite" /v Icon /t REG_SZ /d %%windir%%\\system32\\SHELL32.dll,144 /f ) && ( echo REG-key [Icon of serial_lite] is added & color 30) || ( Echo NO!! REG-key [Icon of serial_lite] no added & color 50 & timeout /t 1 & goto Install )
REM pause
( REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\serial_lite\command" /ve /t REG_SZ /d "\"C:\\Program Files\\CMD_extensions\\serial-lite.cmd\" \"%%1\"" /f ) && ( echo REG-key [command of serial_lite] is added & color 30) || ( Echo NO!! REG-key [command of serial_lite] no added & color 50 & timeout /t 1 & goto Install )


( REG ADD "HKEY_CLASSES_ROOT\*\shell\MenuOfVariousCMD" /v SubCommands /t REG_SZ /d !cur_tmp! /f ) && ( echo REG-key [SubCommands of CMD_extensions] is added & color 30) || ( Echo NO!! REG-key [SubCommands of CMD_extensions] no added & color 50 & timeout /t 1 & goto Install )
		
REM need added standart CMD_extensions key menu (in true way only if they not exist)
( REG ADD "HKEY_CLASSES_ROOT\*\shell\MenuOfVariousCMD" /v MUIVerb /t REG_SZ /d CMD_extensions /f ) && ( echo REG-key [MUIVerb of CMD_extensions] is added & color 30) || ( Echo NO!! REG-key [MUIVerb of CMD_extensions] no added & color 50 & timeout /t 1 & goto Install )
( REG ADD "HKEY_CLASSES_ROOT\*\shell\MenuOfVariousCMD" /v Icon /t REG_SZ /d %%system32%%\\SHELL32.dll,169 /f ) && ( echo REG-key [Icon of CMD_extensions] is added & color 30) || ( Echo NO!! REG-key [Icon of CMD_extensions] no added & color 50 & timeout /t 1 & goto Install )
( REG ADD "HKEY_CLASSES_ROOT\*\shell\MenuOfVariousCMD" /v Position /t REG_SZ /d Top /f ) && ( echo REG-key [Position of CMD_extensions] is added & color 30) || ( Echo NO!! REG-key [Position of CMD_extensions] no added & color 50 & timeout /t 1 & goto Install )	


REM pause

call :Kill_parent_window "%~2"
echo exit now & timeout /t 2 & pause
exit /b
rem -----------------------------------------------------------------
:Uninstall
echo UNinstall-mode - part "serial-lite" of CMD_extensions will be unregistered & color 01
if not defined FirstStart title=UNinstall-mode - part "serial-lite" of CMD_extensions will be unregistered 
echo Press anykey at twice to continue UNinstall operations & pause & echo again to start delete & pause
REM Need for ADMIN permissions? - yes
call :CheckForPermissions "%~1" & rem 2ME: please, always delete symbol " from input and output parameters by using symbol ~
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
	goto Uninstall & rem We need starting with permissions in new window
)
REM pause
echo REM read all sub commands for try to find more than serial-lite only: if nomore than serial-lite - delete all CMD_extensions
For /F "Tokens=2*" %%I In ('reg query ^"HKEY_CLASSES_ROOT\^*\shell\MenuOfVariousCMD^" /v SubCommands') Do set cur_tmp=%%J
set "cur_tmp=%cur_tmp: =%" & rem this hack requires to no spaces in names inside SubCommands of CMD_extensions
echo cur_tmp="%cur_tmp%"
REM pause
echo REG-key [SubCommands]="%cur_tmp%" | findstr /I "%command2install%" && ( echo %command2install% registered, need to delete ) || ( echo %command2install% not registered & set "isNoFounded=True" )

rem in previous string we can get out from, but we want to check for rigth install of CMD_extensions (if empty - we delete all)
REM pause
REM echo test
REM echo on
if defined isNoFounded (
	echo serial-lite do NOT registered: cann't delete anything, but if no more of CMD_extensions - last will be deleted
) else (
	echo now delete "%command2install%" from SubCommands
	REM for /f "tokens=*" %%i in ('"%%cur_tmp:serial_lite^=%%>&2"') do ( set "cur_tmp=%%i" )

	REM echo %cur_tmp:serial_lite=%
	REM echo %cur_tmp:%command2install%=%
	
	REM call echo set "qwe=%%cur_tmp:serial_lite=%%"
	REM call set "qwe=%%cur_tmp:serial_lite=%%"
	REM echo qwe=!qwe!

	
	REM echo set "cur_tmp_new=%%cur_tmp:%command2install%;=%%" & rem hack for symbol ";" in item
	rem It's important to keep order of operations below
	rem if in post or middle
	call set "cur_tmp_new=%%cur_tmp:;%command2install%=%%" & rem hack for symbol ";" in item
	rem if in pre
	echo "!cur_tmp_new!" | findstr /I "%command2install%" && ( call set "cur_tmp_new=%%cur_tmp:%command2install%;=%%" )
	rem if alone
	echo "!cur_tmp_new!" | findstr /I "%command2install%" && ( call set "cur_tmp_new=%%cur_tmp:%command2install%=%%" )
	
	
	
	REM echo set "cur_tmp_new=%%cur_tmp:%command2install%=%%"
	REM call set "cur_tmp_new=%%cur_tmp:%command2install%=%%"
	REM echo cur_tmp_new=!cur_tmp_new!	
	echo cur_tmp_new=!cur_tmp_new!	
	
	REM call set "cur_tmp_new=%%cur_tmp:serial_lite=%%"
	REM echo cur_tmp_new=!cur_tmp_new!
	
	REM ‡„…‘œ …™ð H“†HŽ “„€‹ˆ’œ H…H“†H›… ’Ž—Šˆ ‘ ‡€Ÿ’›Œˆ, …‘‹ˆ Œ…˜€ž’‘Ÿ
		set "cur_tmp=!cur_tmp_new!"	
	REM set "cur_tmp_new=%cur_tmp_new:;;=;%" & rem hack for delete inside string between elements in front of and on the back off
	echo cur_tmp="%cur_tmp%"
	echo cur_tmp_new=!cur_tmp_new!
	echo New SubCommands="!cur_tmp_new!": must be without "%command2install%"

)

echo cur_tmp="%cur_tmp%"
REM but if SubCommands is Empty (including after delete this_item=%command2install%), than delete CMD_extensions
REM pause
REM echo Need for ADMIN permissions anyway
		
if "%cur_tmp%"=="" (
	echo SubCommands string is empty: need to delete whole CMD_extensions
	( REG DELETE "HKEY_CLASSES_ROOT\*\shell\MenuOfVariousCMD" /f ) && ( echo REG-key [all of CMD_extensions] is deleted & color 30) || ( Echo NO!! REG-key [all of CMD_extensions] no deleted & color 50 & timeout /t 1 & goto Uninstall )
) else (
	if not defined isNoFounded (
		rem in this way we or re-write SubCommands, or write new without %command2install%
		echo SubCommands string is NOT empty
		rem SubCommands already changed in previous block_of_operations
		( REG ADD "HKEY_CLASSES_ROOT\*\shell\MenuOfVariousCMD" /v SubCommands /t REG_SZ /d %cur_tmp% /f ) && ( echo REG-key [SubCommands of CMD_extensions] is changed & color 30) || ( Echo NO!! REG-key [SubCommands of CMD_extensions] no changed & color 50 & timeout /t 1 & goto Uninstall )
		REM we may do not delete key [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\serial_lite] because this has no effect
		( REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\serial_lite" /f ) && ( echo REG-key [serial_lite of CMD_extensions] is deleted & color 30) || ( Echo NO!! REG-key [serial_lite of CMD_extensions] no deleted & color 50 & timeout /t 1 & goto Uninstall )
	)
)

call :Kill_parent_window "%~2"
echo exit now & timeout /t 2 & pause
exit /b
rem -----------------------------------------------------------------
:CheckForPermissions %start_with%
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
	set "title_saved=serial-lite__install_mode_%TIME::=_%" & set "title_saved=!title_saved:,=_!" & TITLE=!title_saved! & rem Add by mostovsky (for auto-close)
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
rem -----------------------------------------------------------------
:Kill_parent_window %Title2kill%
	echo Now try to kill window with WINDOWTITLE="%~1"
	timeout /t 1
	REM echo on
	chcp | find /i /n "866">nul || chcp 866 & rem chande codepage to see Russian symbols & REM Added by mostovsky (for parse answer from taskkill on Russian language)
	taskkill /f /FI "WINDOWTITLE eq %~1*" | findstr /i /n "“á¯¥">nul && ( echo Process closed & color 30 & echo. ) || ( echo Proc NOT closed [NOT FOUND] & color 50 & echo. )
	rem here must add in english message-parse “á¯¥å
	timeout /t 1
exit /b
rem -----------------------------------------------------------------
:Open
echo Need open file now
REM echo Do not can open next yet, but can open last
chcp | find /i /n "1251">nul || chcp 1251 & rem chande codepage to see Russian symbols & rem Hach for Russian words
	REM set /p last_episode= < "%~2"
	set "last_episode=%input_parameter%"
REM set "last_episode=%last_episode: =%" & rem We need delete only last spaces (in filenames), not all spaces
If "%last_episode:~-1%"==" " Set "last_episode=%last_episode:~,-1%" & REM http://forum.oszone.net/thread-99354.html & rem check for only last spaces (in filenames), not all spaces
REM pause
echo last_episode="%last_episode%"
rem here we must find next episode

set "needed_episode=%last_episode%"

goto :new_check & rem Stub for new_check
		:old_check
		REM ************
		REM echo on
		set NextOurNeed=
		for %%i in (*) do (
			rem check for NOT (.srt or another file)
			for /f %%i in ("%%~i") do set "current_file_type=%%~xi" & echo "current_file_type=!current_file_type!" & rem FUck_me: I use %%i at twice in single command. Tyler, it's Robert Polsen.
			set "current_file_type=!current_file_type:.=!" & rem var video_file_types do not have dots & rem here now because check for all files
			if defined NextOurNeed (
				REM echo %video_file_types% | findstr /i /n "%current_file_type%">nul && echo ok || echo no
					REM echo %video_file_types% | findstr /i /n "!current_file_type!">nul && ( echo ok with type of file & set NextOurNeed_TrueType=1 ) || ( set "NextOurNeed_TrueType=" )
					echo %video_file_types% | findstr /i /n "!current_file_type!">nul && ( call :PainText 02 "ok with type of file" & set NextOurNeed_TrueType=1 ) || ( set "NextOurNeed_TrueType=" )
				if defined NextOurNeed_TrueType (
					set "needed_episode=%%~i"
					set "NextOurNeed=" & rem old hack with call instead goto use
									REM echo [TEST] if "!needed_episode!"=="%last_episode%" & pause
					REM if "!needed_episode!"=="%last_episode%" ( echo new series in this season not found [maybe not down load or season over] & goto find_new_season )
					REM echo FOUNDED
					call :PainText 02 "FOUNDED"
					REM goto :player_run & rem for do not do unnecessary operation of finding
					goto :pre_player_run & rem for do not do unnecessary operation of finding
				)
			)
			if "%%~i"=="%last_episode%" set "NextOurNeed=Yes"
			if "%%~i"=="_%last_episode%" set "NextOurNeed=Yes" & rem Hack for "rename with _ option"
			set "i_temp=%%~i"
			rem current episode will be rename at the end of, not here
			if not defined NextOurNeed (
				if defined RenameFilesWith_ (
					echo Need for rename [in old_check calling]
					REM echo Rename & pause
					rem check for not rename yet
					if not "!i_temp:~0,1!"=="_" (
						rem Here must check for true rename (because errlevel of ren can be 0 if there are no privilegies)
						REM echo %video_file_types% | findstr /i /n "!current_file_type!">nul && ( ren "!i_temp!" "_!i_temp!" & echo renamed "!i_temp!" to "_!i_temp!" ) || ( echo ___NOT renamed because not video )
						echo %video_file_types% | findstr /i /n "!current_file_type!">nul && ( ren "!i_temp!" "_!i_temp!" & echo renamed "!i_temp!" to "_!i_temp!" ) || ( call :PainText 04 "___NOT renamed because not video" )
					) else (
						REM echo File already with symbol "_"
						call :PainText 0e "File already with symbol '_'"
					)
				)
			)
			echo i="%%~i"
			REM pause
			REM set LIST=!LIST! %i
		)
		REM ************
goto :pre_player_run & rem stub for old method

:new_check
REM Start of new_check -------------------------------------------------
echo NEW CHECK............

set "num_of_episode_done=" & rem for First start
REM call :parse num_of_series_done "%delims_in_series_num%" "%file_name_only%"
call :parse num_of_episode_done  "%delims_in_series_num%" "%file_name_only%"
if "!num_of_episode_done!"=="none" (
	REM echo we do not find anything (for num_of_episode_done) & color 40 & pause & goto :pre_player_run & rem exit /b
	call :PainText 04 "we do not find anything (for num_of_episode_done)" & pause & color 40 & pause & goto :pre_player_run & rem exit /b
) else (
	echo num_of_episode_done="!num_of_episode_done!"
)
rem -----------------------------
REM Increment num_of_episode_done
echo _______________________
echo Increment "!num_of_episode_done!"
if "!num_of_episode_done:~0,1!"=="0" set "num_of_episode_done=!num_of_episode_done:~1,1!" & rem Because 08 - bad integer in 8-like system, but number_of_season can be more 7
echo num_of_episode_done_WITHOUT_1st_ZERO="!num_of_episode_done!"
set /a num_of_episode_done=!num_of_episode_done!+1
echo We will be finding "episode #!num_of_episode_done!"


for %%i in (*) do (
	rem check for NOT (.srt or another file)
	REM for /f %%i in ("%%~i") do set "current_file_type=%%~xi" & echo "current_file_type=!current_file_type!" & rem FUck_me: I use %%i at twice in single command. Tyler, it's Robert Polsen.
	REM set "current_file_type=!current_file_type:.=!" & rem var video_file_types do not have dots & rem here now because check for all files
REM HERE SEE TYPE OF FILE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	echo. & echo.
	echo parse NEXT file "%%i"
	call :parse num_of_episode_here "%delims_in_series_num%" "%%~i"
	
	if "!num_of_episode_here!"=="none" (
		echo we do not find episode_num for file "%%~i"
	) else (
		if "!num_of_episode_here:~0,1!"=="0" set "num_of_episode_here=!num_of_episode_here:~1,1!" & rem Because 08 - bad integer in 8-like system, but number_of_season can be more 7
		REM echo num_of_episode_here_WITHOUT_1st_ZERO="!num_of_episode_here!"
		echo Current episode is "!num_of_episode_here!"
	)
	
	if "!num_of_episode_here!"=="!num_of_episode_done!" (
		REM echo OK & set "needed_episode=%%~i" & goto :pre_player_run
		call :PainText 02 "OK" & echo. & set "needed_episode=%%~i" & goto :pre_player_run
	) else (
			REM echo NOT OUR EPISODE at yet
			call :PainText 0e "NOT OUR EPISODE at yet" & echo.
			if "!num_of_episode_here!" LSS "!num_of_episode_done!" (
				echo Episode smaller than our - rename if need
				if defined RenameFilesWith_ (
					echo need for rename [in new_check calling]
					REM Need to add rename another files
					rem check for not rename yet
					set "temp_file=%%~i"
					if not "!temp_file:~0,1!"=="_" (
						rem Here must check for true rename (because errlevel of ren can be 0 if there are no privilegies)
						echo i="%%~i"
						
						
						REM REM set "file_type_only_temp=%%~xi"
						REM echo %video_file_types% | findstr /i /n "%%~xi">nul && ( ren "!temp_file!" "_!temp_file!" & echo renamed "!temp_file!" to "_!temp_file!" ) || ( echo Not video )
						
						set "file_type_only_temp=%%~xi"
						set "file_type_only_temp=!file_type_only_temp:.=!"
						echo %video_file_types% | findstr /i /n "!file_type_only_temp!">nul && ( ren "!temp_file!" "_!temp_file!" & echo renamed "!temp_file!" to "_!temp_file!" ) || ( echo Not video = not renamed )
						
						
					) else (
						echo Already renamed WAS
					)
				)
			)
	)

)

REM END of new_check ----------------------------------------------------

:pre_player_run
if "!needed_episode!"=="%last_episode%" (
	echo new episode in this season not found [maybe not download or season over] - try to find next season
	title=Last episode. Try to find next season
	goto find_new_season
)

:player_run
echo Next episode founded as "%needed_episode%" & title=Next episode founded as "%needed_episode%"
start  "needed_episode" /wait "%needed_episode%"
echo Player closed
rem in this place need to determine file (by path in process player, time, etc.)(how many episode is now watched) and add it to watched list
echo Need for increment episode "%needed_episode%"? & echo. & echo It means add this file to already watched (by starting another environment of this cmd-file)
:prompt_from_user
REM chcp | find /i /n "866">nul && echo dos || echo win
chcp | find /i /n "866">nul || chcp 866 & rem chande codepage to see Russian symbols
REM chcp | find /i /n "1251">nul || chcp 1251 & rem chande codepage to see Russian symbols	 / test
set "Plusing=" & rem Hack when use call (really need?)
REM set /p Plusing=["1,+,yes or ok" to increment, "2,no or exit" to exit or "more, watch or 3" to see next episode]
set /p Plusing=["%request_yes: =,%" to increment, "%request_no: =,%" to exit or "%request_next: =,%" to see next episode]
echo entering by user "!Plusing!"
rem Russian answer not work
REM if "%Plusing%"=="+" ( goto 1 ) else ( if "%Plusing%"=="1" ( goto 1) else ( if "%Plusing%"=="Yes" ( goto 1 ) else ( if "%Plusing%"=="yes" ( goto 1 ) else ( if "%Plusing%"=="YES" ( goto 1 ) else ( if "%Plusing%"=="„ " ( goto 1 ) else ( if "%Plusing%"=="„€" ( goto 1 ) else ( if "%Plusing%"=="¤ " ( goto 1 ) else ( goto 2 ) ) ) ) ) ) ) )
REM if "!Plusing!"=="" call :prompt_from_user & rem hack for not check empty string
if "!Plusing!"=="" goto :prompt_from_user & rem hack for not check empty string

rem [TODO]: make defenition at start
echo "again repeat reiterative iteration repetition ¯®¢â®à"  | findstr /i /n "!Plusing!">nul && ( echo Start again same episode & title=Start again same episode & goto :player_run )
echo "open folder dir files ¤¨à¥ªâ®à¨ï ¯ãâì"  | findstr /i /n "!Plusing!">nul && ( echo Open folder & title=Open folder & start "" explorer.exe "%file_path_only%" & goto :prompt_from_user )

REM echo !request_yes!  | findstr /i /n ""!Plusing!"">nul && ( call :1 ) || ( call :2 )
					REM echo on

REM if "!Plusing!"=="-" goto :3 & rem hack for symbol "-" - not work
if "!Plusing!"=="-" goto :5 & rem hack for symbol "-" - not work
REM echo command: findstr /i /n "!Plusing!"
echo !request_yes!  | findstr /i /n "!Plusing!">nul && ( goto :1 ) || ( goto :2 )
REM echo !request_yes!  | findstr /i /n "!Plusing!" && ( PAUSE & goto :1 ) || ( PAUSE & goto :2 )
exit /b
:1
	echo Increment now
	rem increment procedure
	REM pause
	REM start "" /I explorer.exe "%~fnx0" "%needed_episode%"
	REM start "" /I "%~fnx0" "%needed_episode%"
	REM start "" /I cmd.exe "%~fnx0" "%needed_episode%"
	rem create .serial file
	REM echo need_next_episode="%need_next_episode%" & pause
	REM call "%~fnx0" "%needed_episode%"
	
		REM echo "need_next_episode=!need_next_episode!"	
	
	rem need to add rename operation in here in calling (inside, for operation "already watched")
	call "%~fnx0" "!needed_episode!"
	
		REM echo calling over & pause
		echo "need_next_episode=!need_next_episode!"
	if defined need_next_episode (
		echo next episode now 
		set "need_next_episode=" & rem zeroing check for defined var need_next_episode
		rem start from new instantion

		rem need find name of .serial-file
		For %%I in (*.!type_of_indicator_file!) do set "indicator_file_founded_name=%%~I"
		
		echo OPEN will be next
		call  "%~fnx0" "open" "!indicator_file_founded_name!"
		REM call  "%~fnx0" "open" "!indicator_file_founded_name!" "KILL_WINDOW_close_me"
		REM echo after call & pause
	) else (
		echo no need next episode
	)
	REM echo 2-nd calling done & pause
	
	
	REM goto :5 & rem comment in 2018.09.04 - 03:00
	REM goto :EOF
	exit /b
		color 90 & echo now you in the sky & pause & pause & goto :eof
:2
	REM if (("%Plusing%"=="no")||("%Plusing%"=="exit")||("%Plusing%"=="NO")||("%Plusing%"=="EXIT")||("%Plusing%"=="Exit")||("%Plusing%"=="No")) (
	REM if "%Plusing%"=="no" ( goto 3 ) else ( if "%Plusing%"=="exit" ( goto 3 ) else ( if "%Plusing%"=="NO" ( goto 3 ) else ( if "%Plusing%"=="EXIT" ( goto 3 ) else ( if "%Plusing%"=="Exit" ( goto 3 ) else ( if "%Plusing%"=="No" ( goto 3 ) else ( if "%Plusing%"=="­¥â" ( goto 3 ) else ( if "%Plusing%"=="…’" ( goto 3 ) else ( if "%Plusing%"=="¥â" ( goto 3 ) else ( if "%Plusing%"=="2" ( goto 3 ) else ( if "%Plusing%"=="-" ( goto 3 ) else ( goto 4 ) ) ) ) ) ) ) ) ) ) )
	REM set "request_no=no ­¥â exit" & rem defined in start
	REM echo !request_no!  | findstr /i /n "!Plusing!">nul && ( call :3 ) || ( call :4 )
	REM chcp | find /i /n "866">nul || chcp 866 & rem chande codepage to see Russian symbols / test (after calling) - not help (all work only 1-st time)
	REM chcp | find /i /n "1251">nul || chcp 1251 & rem chande codepage to see Russian symbols	 / test no
	REM echo !request_no!  | findstr /i /n "!Plusing!">nul && ( goto :3 ) || ( goto :4 )
	echo !request_no!  | findstr /i /n "!Plusing!">nul && ( goto :5 ) || ( goto :4 )
	exit /b
	:3
		echo Exit
		REM goto 5
		goto :EOF
		exit /b
			color 90 & echo now you in the sky & pause & pause & goto :eof
	:4
		rem check for some episode else
		REM set "request_next=next" & rem defined in start
		REM echo !request_next!  | findstr /i /n "%Plusing%">nul && ( echo USER NEED MORE EPISODES AT ONCE & echo. & set "need_next_episode=1" & call :1 )		
		REM echo !request_next!  | findstr /i /n "%Plusing%">nul && ( echo USER NEED MORE EPISODES AT ONCE & echo. & set "need_next_episode=1" & call :1 & exit /b )		
		REM echo !request_next!  | findstr /i /n "!Plusing!">nul && ( echo USER NEED MORE EPISODES AT ONCE & echo. & set "need_next_episode=1" & call :1 & goto :EOF ) & rem Try to kill parent window after call (inside call-command)
		REM chcp | find /i /n "866">nul || chcp 866 & rem chande codepage to see Russian symbols / test (after calling) - not help (all work only 1-st time)
		REM chcp | find /i /n "1251">nul || chcp 1251 & rem chande codepage to see Russian symbols	 / test no
		echo !request_next!  | findstr /i /n "!Plusing!">nul && ( echo USER NEED MORE EPISODES AT ONCE & echo. & set "need_next_episode=1" & goto :1 )
		echo Now goto prompt_from_user & rem pause
		REM call :prompt_from_user
		goto :prompt_from_user
		exit /b
			color 90 & echo now you in the sky & pause & pause & goto :eof
:5

echo All operations done. Now exit.
echo exit now & timeout /t 2 & rem pause
exit /b
	color 90 & echo now you in the sky & pause & pause & goto :eof
rem -----------------------------------------------------------------
:find_new_season
echo. & echo FIND NEW SEASON
REM Setlocal EnableDelayedExpansion
REM * Need find num of current season (example 02=2) = maybe by list current dir with separator "/", when only last will be saved
REM * in current dir use:
REM 						dir /a:d /b ".." | FINDSTR /I "á¥§®­" - here need think about it
REM 						dir /a:d /b ".." | FINDSTR /I "s02"
REM 						dir /a:d /b ".." | FINDSTR /I "s2"
REM 						dir /a:d /b ".." | FINDSTR /I "2"
REM * next to help best comparation - in each file/dir name delete all like
set "not_interesting_words_1=bdrip _fl H264 h.264 x264 DTS Rus Eng RusEng 2xRus 3xRus 4xRus 5xRus 6xRus DVO MVO VO DUB AVO SUB subs AMZN WEB-DL web-dlrip WEB-DLRip WEBRip SATRip 720p 1080p" & rem in start of file it must be (inside settings) & rem 8184 symbols max in each var in cmd
set "not_interesting_words_2=[teko] HDTV hd-tv nHD HDCLUB Bluray BDRemux XviD •viD DivX Div• DD5.1 HULU PAL SECAM -sdi RG_SerialS RG.SerialS SerialS OmskBird NhaNc3 whip93 Goblin [qqss44]" & rem in start of file it must be (inside settings) & rem 8184 symbols max in each var in cmd
set "not_interesting_words_3=Amedia NovaFilm NovaFilm.tv .tv AlexFilm NewStudio CasStudio LostFilm Wanterlude Šã¡¨ª_¢_ªã¡¥ Jaskier BaibaKo Profix.Media 400" & rem in start of file it must be (inside settings) & rem 8184 symbols max in each var in cmd

REM in lower and upper case (automated inside function of windows) (or skip them during parsing with "find /i" ) (in "Angel.ili.demon" we have two different "XviD" formats with Russian "X" in one of them)
REM and dates "2003 2004 2005 2006   2018" and etc. (exept 1408, 11:14, 2049, 2050 and etc.)
REM * next use auto-correlation function: dir-name of current_season and all dir-names of finded dirs AND use adaptive threshold or maximum (if a lot of equal maximum - ask user for choose)

REM *********************************************************************************
REM Example dir-command results:
REM A Series of Unfortunate Events (Season 1) WEBRip 720p
REM American.Horror.Story.S06.1080p.WEB-DL.H264
REM American.Horror.Story.S07.1080p.AMZN.WEB-DL.H.264-Amedia
REM Barry.S01.1080p.WEB-DL.OmskBird
REM Big Little Lies (Season 01) 1080
REM Carnivale.2003.web-dlrip_[teko]
REM Castle.Rock.s01.720p.WEBRip.Rus.Eng.BaibaKo
REM Condor S01 WEBRip 1080p (OMSKBIRD)
REM Dark.s01.WEBDL.1080p.NewStudio.Wanterlude
REM DEADWOOD
REM Deadwood.S1.720p.Bluray.nHD.x264-NhaNc3.Rus.Eng.NovaFilm.tv
REM Elementary.s01.1080p.WEB-DL.Rus.Eng.NewStudio
REM Falling.Water.S01.WEB-DLRip.RusEng.NewStudio
REM Hidden
REM Hidden - Season 1 (AlexFilm) HDTV 720p
REM Hidden Palms
REM Mindhunter - Žå®â­¨ª §  à §ã¬®¬. ‘¥§®­ 1. LostFilm. 1080p
REM Ray.Donovan. Season 5 (WEBRip l 1080p l Jaskier)
REM Reverie.S01.1080p.AMZN.WEB-DL.H.264-SDI
REM Sharp.Objects.2018.S01.1080p.AMZN.WEB-DL.DD5.1.H.264.Amedia.PAL
REM Stranger Things (NS) 720
REM Succession.2018.S01.1080p.AMZN.WEB-DL.DD5.1.H.264.Amedia.PAL
REM The Leftovers (Season 03) 1080 AMZN
REM The Originals S01 BDRemux 1080p 2xRus Eng Subs by Stiles RG SerialS
REM The.Godless.S01.WEB-DL.1080p.Rus.Eng
REM The.Handmaid's.Tale.S01.1080p.HULU.WEBRip
REM The.Leftovers.S02.1080p.HDTV.DD5.1.x264-CasStudio
REM True.Blood.S01.BDRip.1080p.FL
REM True.Blood.S02.BDRip.1080p.FL
REM True.Blood.S03.BDRip.1080p.FL
REM True.Blood.S04.1080p.BDRemux.2xRus.Eng.HDCLUB
REM Utopia - The Complete Series - whip93
REM €­£¥« ¨«¨ ¤¥¬®­
	REM Angel.ili.demon.1.(2013).XviD.SATRip
	REM Angel.ili.demon.2 (2013).•viD.SATRip
REM Žáâ âª¨ (‘¥§®­ 1) Amedia

REM Ash vs Evil Dead (Season 01)
REM Ash.vs.Evil.Dead.(Season.02).Goblin
REM Falling.Water.S02.WEBRip.RusEng.Profix.Media
REM RD_4
REM The Blacklist.S01.XviD

REM Ray.Donovan.[S04E01].XviD.Amedia.[qqss44].avi
REM *********************************************************************************


echo. & echo _______________________ & echo _______________________
echo find_new_season
	REM pause
rem -----------------------------
REM Check for season_num --------
REM delims_in_season_num
set "num_of_seasons_done=" & rem for First start
REM call :more_check current_part num_of_seasons_done
REM call :parse num_of_series_done "%delims_in_series_num%"
call :parse num_of_seasons_done "%delims_in_season_num%" "%file_name_only%" 1
if "!num_of_seasons_done!"=="none" (
	REM echo we do not find anything (for season_num) & color 40 & pause & rem exit /b & rem What we will be doing during epic fail?
	call :PainText 04 "we do not find anything (for season_num)" & pause & color 40 & pause & rem exit /b & rem What we will be doing during epic fail?
	REM echo we do not find anything (for season_num) & color 40 & pause & exit /b
) else (
	echo num_of_seasons_done="!num_of_seasons_done!"
)
rem -----------------------------
REM Increment season_num --------
echo _______________________
echo Increment !num_of_seasons_done!
if "!num_of_seasons_done:~0,1!"=="0" set "num_of_seasons_done=!num_of_seasons_done:~1,1!" & rem Because 08 - bad integer in 8-like system, but number_of_season can be more 7
echo num_of_seasons_done_WITHOUT_1st_ZERO="!num_of_seasons_done!"
set /a num_of_seasons_done=%num_of_seasons_done%+1
	echo We will be finding "season #!num_of_seasons_done!"

rem -----------------------------
REM Define current_dir_of_file --
echo _______________________
echo Define dir of season (to determine keywords of name_of_serial)
REM example:
REM REM D:\[downloads]\[DONE]>set "cur_p=%cd%"
REM REM D:\[downloads]\[DONE]>echo cur_p=%cur_p%
REM REM cur_p=D:\[downloads]\[DONE]
REM REM D:\[downloads]\[DONE]>pushd %cd% \.. & REM REM D:\[downloads]\[DONE]>cd /d ..
REM REM D:\[downloads]>set "new_p=%cd%"
REM REM D:\[downloads]>echo new_p=%new_p%
REM REM new_p=D:\[downloads]
REM REM D:\[downloads]>popd
rem here must be goto prev_path
REM REM D:\[downloads]>echo %%cur_p:%new_p%=%%
REM REM %%cur_p:D:\[downloads]=%%
REM REM D:\[downloads]>call echo %%cur_p:%new_p%=%%
REM REM %\[DONE]%
REM REM D:\[downloads]>call echo %cur_p:%new_p%=%
REM REM \[DONE]
REM REM d:\>call set "needed_last_path=%cur_p:%new_p%=%" in batch-file need use double "%" at the edges
REM REM d:\>echo needed_last_path="%needed_last_path%"
REM REM needed_last_path="\[DONE]"
REM REM d:\>echo needed_last_path="%needed_last_path:\=%"
REM REM needed_last_path="[DONE]"

REM echo on

set "cur_p=%cd%" & echo cur_p="!cur_p!"
pushd %cd% \..
set "new_p=%cd%" & echo new_p="!new_p!"
call set "needed_last_path=%%cur_p:%new_p%=%%" & rem we not use symbol "\" in replace, because in root (like "d:\") command "cd" return path with it symbol
set "needed_last_path=%needed_last_path:\=%"
REM echo needed_last_path="%needed_last_path%"
echo Path of season of serial is "%needed_last_path%"
REM set "needed_last_path_for_find=%needed_last_path: =_%" & rem hack for processing & already do in next step

rem -----------------------------
REM Try to delete not_importand_words --
echo _______________________
echo Try to delete not_importand_words
REM not_interesting_words

REM We have problem here with "(" symbols!!!!!!!!!!!!!!!!!!!!
set "needed_last_path_for_find=%needed_last_path:)=^)%" & rem hack for symbols "()" inside
set "needed_last_path_for_find=!needed_last_path_for_find:(=^(!"
REM set "needed_last_path_for_find=%needed_last_path_for_find: =_%" & rem hack for space-symbol " " inside (some times uses by users as separator)
set "needed_last_path_for_find=!needed_last_path_for_find: =_!" & rem hack for space-symbol " " inside (some times uses by users as separator)

	REM echo Before function: needed_last_path_for_find="!needed_last_path_for_find!"

REM Here increment+goto instead "for /L" construction for have possibilities for exit from circle before (without waiting) all steps over
set k=0 & rem For circle
set num_of_replacement=0 & set "needed_last_path_for_find_before=needed_last_path_for_find" & rem For progress
echo end now (next season not found)
rem here list with directories?
pause
exit /b
:for_10
set /a k=!k!+1
	call set "not_interesting_words=%%not_interesting_words_!k!%%"
		echo not_interesting_words="!not_interesting_words!"
	if not defined not_interesting_words ( echo exit_for_10 & goto exit_for_10 )

	for /L %%p in (1,1,200) do (
		set "cur_num=%%p"
			echo. & echo _______________________
			echo cur_num=!cur_num!
		for /f "tokens=*" %%i in ('"cmd/v/c for /F "tokens^=!cur_num! delims^= " %%I in ("!not_interesting_words!") do echo %%I" ') do ( set "current_part=%%~i" ) & rem In delims use only spaces (it's our var): hardly ever we use dots for not_important_words
		set "current_part=!current_part: =!" & rem hack for space in the end
			echo not_importand_word="!current_part!"
			
			echo prev_cur_part="!prev_cur_part!"
			REM if "!prev_cur_part!"=="!current_part!" goto exit_for_200 else set "prev_cur_part=!current_part!" & rem condition for do not do not necessary operation (exit from for)
		if "!prev_cur_part!"=="!current_part!" ( echo exit_for_200 & goto exit_for_200 )
		set "prev_cur_part=!current_part!" & rem condition for do not do not necessary operation (exit from for)
			
			REM echo set "needed_last_path_for_find=%%needed_last_path_for_find:!current_part!=%%"

		REM REM call set "needed_last_path_for_find=%%needed_last_path_for_find:!current_part!=%%"
		call :Str_del "!needed_last_path_for_find!" "!current_part!" needed_last_path_for_find
			REM echo needed_last_path_for_find="!needed_last_path_for_find!"

		rem Hacks for some symbols
		echo !current_part! | find /i "." >nul && ( echo check for "!current_part:.=_!" too & call :Str_del "!needed_last_path_for_find!" "!current_part:.=_!" needed_last_path_for_find )
		echo !current_part! | find /i "_" >nul && ( echo check for "!current_part:_=.!" too & call :Str_del "!needed_last_path_for_find!" "!current_part:_=.!" needed_last_path_for_find )
			
		REM CALL :UCase current_part _RESULTS
			REM echo not_importand_word_UCase="!_RESULTS!"
		REM REM call set "needed_last_path_for_find=^!needed_last_path_for_find:!_RESULTS!=^!"
		REM call :Str_del "!needed_last_path_for_find!" "!_RESULTS!" needed_last_path_for_find
			REM echo needed_last_path_for_find="!needed_last_path_for_find!"
		
		REM CALL :LCase current_part _RESULTS
			REM echo not_importand_word_LCase="!_RESULTS!"
		REM REM call set "needed_last_path_for_find=^!needed_last_path_for_find:!_RESULTS!=^!"
		REM call :Str_del "!needed_last_path_for_find!" "!_RESULTS!" needed_last_path_for_find
			REM echo needed_last_path_for_find="!needed_last_path_for_find!"	
		
		set "needed_last_path_for_find=!needed_last_path_for_find:..=.!" & rem hack for after deleting
			echo needed_last_path_for_find="!needed_last_path_for_find!"
			REM echo needed_last_path_for_find="%needed_last_path_for_find%"
			
		if not "!needed_last_path_for_find_before!"=="!needed_last_path_for_find!" set /a num_of_replacement=!num_of_replacement!+1
		set "needed_last_path_for_find_before=!needed_last_path_for_find!"
		title=In search for season !num_of_seasons_done! makes !num_of_replacement! replacement in dir_name
	)
	:exit_for_200
goto for_10
:exit_for_10
echo _______________________ & echo.

echo Path of season of serial ("%needed_last_path%") & echo without not_important_words is "!needed_last_path_for_find!"
rem -----------------------------
rem -----------------------------
rem -----------------------------

REM Here we have problem like this: "^"
		REM Path of season of serial is "Ash vs Evil Dead (Season 01)"
		REM _______________________
		REM Try to delete not_importand_words
		REM not_interesting_words="bdrip _fl H264 h.264 x264 DTS Rus Eng RusEng 2xRus 3xRus 4xRus 5xRus 6xRus DVO MVO VO DUB AVO SUB subs AMZN WEB-DL web-dlrip WEB-DLRip WEBRip SATRip 720p 1080p"

		REM _______________________
		REM cur_num=1
		REM not_importand_word="bdrip"
		REM prev_cur_part=""
		REM needed_last_path_for_find="Ash_vs_Evil_Dead_^^(Season_01^^)"

		REM _______________________
		REM cur_num=2
		REM not_importand_word="_fl"
		REM prev_cur_part="bdrip"
		REM check for ".fl" too
		REM needed_last_path_for_find="Ash_vs_Evil_Dead_^^^^^^^^(Season_01^^^^^^^^)"

pause
goto 5 & rem instead easy exit
exit /b
	color 90 & echo now you in the sky & pause & pause & goto :eof
rem -----------------------------------------------------------------
REM REM http://www.robvanderwoude.com/battech_convertcase.php
REM :LCase
REM :UCase
REM :: Converts to upper/lower case variable contents
REM :: Syntax: CALL :UCase _VAR1 _VAR2
REM :: Syntax: CALL :LCase _VAR1 _VAR2
REM :: _VAR1 = Variable NAME whose VALUE is to be converted to upper/lower case
REM :: _VAR2 = NAME of variable to hold the converted value
REM :: Note: Use variable NAMES in the CALL, not values (pass "by reference")

REM SET _UCase=A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
REM SET _LCase=a b c d e f g h i j k l m n o p q r s t u v w x y z
REM SET _Lib_UCase_Tmp=!%1!
REM IF /I "%0"==":UCase" SET _Abet=%_UCase%
REM IF /I "%0"==":LCase" SET _Abet=%_LCase%
REM FOR %%Z IN (%_Abet%) DO SET _Lib_UCase_Tmp=!_Lib_UCase_Tmp:%%Z=%%Z!
REM SET %2=%_Lib_UCase_Tmp%
REM REM GOTO:EOF
REM exit /b
rem -----------------------------------------------------------------
:Str_del str str2delete result
	set "tmp=%~1"
	set "%3=!tmp:%~2=!"
exit /b
	color 90 & echo now you in the sky & pause & pause & goto :eof
rem -----------------------------------------------------------------

rem -----------------------------------------------------------------
REM http://qaru.site/questions/28719/how-to-echo-with-different-colors-in-the-windows-command-line
REM @echo off
REM cls && color 08

REM rem .... the following line creates a [DEL] [ASCII 8] [Backspace] character to use later
REM rem .... All this to remove [:]
REM for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (set "DEL=%%a")

REM echo.

REM <nul set /p="("
REM call :PainText 09 "BLUE is cold"    && <nul set /p=")  ("
REM call :PainText 02 "GREEN is earth"  && <nul set /p=")  ("
REM call :PainText F0 "BLACK is night"  && <nul set /p=")"
REM echo.
REM <nul set /p="("
REM call :PainText 04 "RED is blood"    && <nul set /p=")  ("
REM call :PainText 0e "YELLOW is pee"   && <nul set /p=")  ("
REM call :PainText 0F "WHITE all colors"&& <nul set /p=")"

REM goto :end

REM :PainText
REM <nul set /p "=%DEL%" > "%~2"
REM findstr /v /a:%1 /R "+" "%~2" nul
REM del "%~2" > nul
REM goto :eof

REM :end
REM echo.
REM pause
	color 90 & echo now you in the sky & pause & pause & goto :eof
rem -----------------------------------------------------------------
rem -----------------------------------------------------------------
:Raname_file_with_no_symbol InputShortFileName TypeOfOperation
REM echo on
	echo rename file "%~1" with "%~2" operation of 1-st symbol "_"
	set "i_temp=%~1" & rem 1-st input parameter for call-operaation is the name of file to rename
	rem second parameter is determined type of operation (the following types are supported: del, add)
	REM if not ""="%~2" ( echo "%~2" | findstr /i "add">nul || set isDeleteOperation=1 ) & rem this string destroy whole file
	REM if defined "%~2" ( echo "%~2" | findstr /i "add">nul || set isDeleteOperation=1 )
	REM echo "%~2" | findstr /i "add">nul || set isDeleteOperation=1
	REM if defined isDeleteOperation (
	if "%~2"=="del" (
		echo del operation
		if "!i_temp:~0,1!"=="_" (
			rem Here must check for true rename (because errlevel of ren can be 0 if there are no privilegies)
			echo "%video_file_types%" | findstr /i /n "%file_type_only%">nul && ( ren "!i_temp!" "!i_temp:~1,255!" & echo renamed "!i_temp!" to "!i_temp:~1,255!" ) || ( echo Not video file-type )
		) else (
			echo No symbol "_" inside start of filename "!i_temp!" to delete
		)
	) else (
		echo add operation
		rem ADD, not delete (it's easy)
		if not "!i_temp:~0,1!"=="_" (
			rem Here must check for true rename (because errlevel of ren can be 0 if there are no privilegies)
			echo "%video_file_types%" | findstr /i /n "%file_type_only%">nul && ( ren "!i_temp!" "_!i_temp!" & echo renamed "!i_temp!" to "_!i_temp!" ) || ( echo Not video file-type )
		) else (
			echo Symbol "_" inside start of filename "!i_temp!" already exist
		)
	)
REM echo off
exit /b
	color 90 & echo now you in the sky & pause & pause & goto :eof
rem -----------------------------------------------------------------
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
rem -----------------------------------------------------------------
rem -----------------------------------------------------------------
REM 1149 - 2018.09.02
REM 1211 - 2018.12.15 _ before improove = start pre-NY KY