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
::Author[Allen]    ����[bjc5233@gmail.com]    �ۿ�[692008411]    words[�й�ͬ��Ȥ,�н���,��bug����ӭ����ϵ��Ŷ~]
::����
::  load.bat������������[������], ���Խ�����������һ������������, �ٶ���call��ʽ��10������
::  loadF.bat���ǹ����޷���laod.bat���ɵĺ���[������], ����Ҫ�����ǩ�ĺ���, �ٶ���ֱ��call xx.exe�����޲��
::  loadF.bat�п��ԶԵ�����������а�װ��ʹ�õ��÷����Ӽ��
::ʹ�÷�ʽ
::  call loadF.bat _fun1 _func2...   ������ӳ��Ϊ����·��
::  call %_fun1% param1 param2...