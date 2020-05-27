# CMD_extensions
***
Target:			`Windows` (any (_i hope_))\
Tested:			`Win10`\
Install-file:	`.exe [rar-sfx]`

[Download last release](/../../raw/master/CMD_extensions_release.exe) ([absolute link to github](https://github.com/mostovsky/-CMD_extensions-/raw/master/CMD_extensions_release.exe))
***
This is a small progect which add special menus to the context menu of Windows explorer.\
Last source code may be not inside last release (last release - only stable version).
***
After install in context menu will be created menu like this:
***
**DIR-MENU:**\
`CMD_extensions`\
&emsp;	-> `dir_menu`\
&emsp;&emsp;		-> `Create_reserve_archive`			[create .rar-file with full-date-time name]\
&emsp;&emsp;		-> `Start CMD in current dir`		[start CMD with cd=%CurrentDir%]\
&emsp;&emsp;		-> `Create file-list`				[create .txt-file with name of files in dir]\
&emsp;&emsp;		-> `Create file-list with sub-dir`	[create .txt-file with name of files in dir and in sub-dirs]\
&emsp;&emsp;		-> `Add Label (DIR)`				[rename dir with entered name]\
&emsp;	-> `dir_menu_special`\
&emsp;&emsp;		-> `CreateRepo`						[create repo and todo.txt file]
***
**FILE-MENU:**\
`CMD_extensions`\
&ensp;	-> `file_menu`\
&emsp;&emsp;		-> `Create_reserve_archive`		[create .rar-file with full-date-time name]\
&emsp;&emsp;		-> `Auto-reserve`				[create .rar-file with full-date-time name when file changed; full-compatible with `add_label` function]\
&emsp;&emsp;		-> `Add Label (FILE)`			[rename file with entered name]\
&emsp;	-> `serial_menu`	[progect `serial_lite` now part of this progect] (_it starts play episode and than, after player closed, ask for next episode or only save progress (or not save)_)\
&emsp;&emsp;		-> `Episode_done`				[rename episode of serial with prefix `_`; update count of %episode_done%]\
&emsp;&emsp;		-> `Start_with_serial`			[play episode and than if user answer `+` increment of %episode_done%]\
&emsp;&emsp;		-> `RenameBackWithNo_`\
&emsp;&emsp;		-> `Add_symbol_`
***
***
