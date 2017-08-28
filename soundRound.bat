@echo off& title soundRound& call lib\load.bat _readConfig _writeConfig& call lib\loadE.bat CurS CKey gplay disableX echox setWT cmdow& setlocal enabledelayedexpansion
cd data& %CurS% /crv 0& %disableX%& %setWT% soundRound,200


set soundBase=D:\music\环境音
set soundIndex=0& for /r "%soundBase%" %%i in (*) do set soundName[!soundIndex!]=%%~ni& set soundState[!soundIndex!]=0& set /a soundIndex+=1
set /a soundIndexMax=soundIndex-1, winHeight=soundIndex+4
(%_call% ("conf.txt pointer") %_readConfig%)
mode 45,!winHeight!

for /l %%i in () do (
    %CurS% /pos 0 1
    for /l %%i in (0,1,!soundIndexMax!) do (
        set soundName=!soundName[%%i]!& set soundState=!soundState[%%i]!
        if %%i==!pointer! (if !soundState!==0 (echo  → !soundName!) else (%echox% -c 0C " → !soundName!")) else (if !soundState!==0 (echo     !soundName!) else (%echox% -c 0C "    !soundName!"))
    )
    
    REM [1上]  [2下] [3Enter] [4Esc]
    pause>nul& %CKey% 0 38 40 13 27
    (if !errorlevel!==1 set /a pointer-=1)& (if !errorlevel!==2 set /a pointer+=1)& (if !pointer! LSS 0 set pointer=!soundIndexMax!)& (if !pointer! GTR !soundIndexMax! set pointer=0)
    if !errorlevel!==3 (
        for %%i in (!pointer!) do (
            set soundName=!soundName[%%i]!& set soundState=!soundState[%%i]!
            if !soundState!==0 (
				REM 打开新窗口，隐藏自身，循环播放
                set soundState[%%i]=1& start /i /min "soundRound_!soundName!" cmd /q /c "%cmdow% @ /HID& for /l %%# in () do %gplay% !soundBase!\!soundName!.mp3>nul 2>nul"
            ) else (
                set soundState[%%i]=0& taskkill /fi "WINDOWTITLE eq soundRound_!soundName!" >nul 2>nul
            )
        )
    )
    if !errorlevel!==4 (
        (%_call% ("conf.txt pointer !pointer!") %_writeConfig%)
        taskkill /fi "WINDOWTITLE eq soundRound_*" >nul 2>nul& exit
    )
)