@echo off& title soundRound& call load.bat _strlen2 _getRandomNum& call loadE.bat CurS CKey gplay disableX cmdow gotoxy& call loadF.bat _key& setlocal enabledelayedexpansion
%CurS% /crv 0& %disableX%


set soundBase=D:\music\环境音
set /a soundIndex=0, winWidth=0
for /r "%soundBase%" %%i in (*) do (
    set soundName=%%~ni& set soundName[!soundIndex!]=!soundName!& set soundState[!soundIndex!]=0& set /a soundIndex+=1
    (%_call% ("soundName soundNameLen") %_strlen2%)& if !soundNameLen! GTR !winWidth! set winWidth=!soundNameLen!
)
set /a soundIndexMax=soundIndex-1, preBlankLen=10, winWidth+=preBlankLen*2, topBlankLen=2, winHeight=soundIndex+topBlankLen*2
mode !winWidth!,!winHeight!
(%_call% ("0 !soundIndexMax! pointer") %_getRandomNum%)


for /l %%i in () do (
    set soundStr=
    for /l %%i in (0,1,!soundIndexMax!) do (
        set soundName=!soundName[%%i]!& set soundState=!soundState[%%i]!
        if %%i==!pointer! (
            if !soundState!==0 (set soundStr=!soundStr!\E0  !soundName!  \n) else (set soundStr=!soundStr!\C0  !soundName!  \n)
        ) else (
            if !soundState!==0 (set soundStr=!soundStr!\uU!soundName!  \n) else (set soundStr=!soundStr!\C0!soundName!  \n)
        )
    )
    %gotoxy% 0 0 "\p!preBlankLen!;!topBlankLen!!soundStr!"
    
    call %_key% up down enter esc
    if !errorlevel!==1 (
        set /a pointer-=1
    ) else if !errorlevel!==2 (
        set /a pointer+=1
    ) else if !errorlevel!==3 (
        for %%i in (!pointer!) do (
            set soundName=!soundName[%%i]!& set soundState=!soundState[%%i]!
            if !soundState!==0 (
				REM 打开新窗口，隐藏自身，循环播放
                set soundState[%%i]=1& start /i /min "soundRound_!soundName!" cmd /q /c "%cmdow% @ /HID& for /l %%# in () do %gplay% !soundBase!\!soundName!.mp3>nul 2>nul"
            ) else (
                set soundState[%%i]=0& taskkill /fi "WINDOWTITLE eq soundRound_!soundName!" >nul 2>nul
            )
        )
    ) else if !errorlevel!==4 (
        taskkill /fi "WINDOWTITLE eq soundRound_*" >nul 2>nul& exit
    )
    (if !pointer! LSS 0 set pointer=!soundIndexMax!)& (if !pointer! GTR !soundIndexMax! set pointer=0)
)