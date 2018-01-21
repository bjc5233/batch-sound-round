@echo off& set base=%~d0%~p0loadFuncs
for %%i in (%*) do (
    if %%i==_setGridPos (
        set %%i=start /b "" %base%\%%i.bat
    ) else if %%i==_setCmdBg (
        set %%i=start /b "" %base%\%%i.bat
    ) else if %%i==_playMusicMini (
        set %%i=start /i /min %base%\%%i.bat
    ) else (
        set %%i=%base%\%%i.bat
    )
)
::Author[Allen]    邮箱[bjc5233@gmail.com]    扣扣[692008411]    words[有共同兴趣,有建议,有bug都欢迎来联系我哦~]
::介绍
::  load.bat中是内敛函数[内向函数], 可以将整个函数在一个变量中体现, 速度是call方式的10倍左右
::  loadF.bat中是管理无法被laod.bat接纳的函数[外向函数], 如需要代码标签的函数, 速度与直接call xx.exe几乎无差别
::  loadF.bat中可以对第三方命令进行包装，使得调用方更加简洁
::使用方式
::  call loadF.bat _fun1 _func2...   将参数映射为函数路径
::  call %_fun1% param1 param2...