@echo off& call loadE.bat CurS CKey& setlocal enabledelayedexpansion
::˵��
::  ckey��װ, ��key������Ϊ�����б�
::����
::  [keyName0 keyName1 ...]
::      keyName - ������
::key-map
::  [up 38][down 40][enter 13][esc 27]
::external
::  date       2018-01-21 13:55:20
::  face       (����)=͹
::  weather    shanghai С��ת���� 9��/6�� ����ת�޳�������
set _keyNames=
for %%i in (%*) do (
    if %%i==up (
        set _keyNames=!_keyNames! 38
    ) else if %%i==down (
        set _keyNames=!_keyNames! 40
    ) else if %%i==enter (
        set _keyNames=!_keyNames! 13
    ) else if %%i==esc (
        set _keyNames=!_keyNames! 27
    )
)
pause>nul& %CKey% 0 !_keyNames!
endlocal