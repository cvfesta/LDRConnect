@echo off
::version: 3.01 Updated for Windows 7/8
::created by Christian Festa
title LDRConnect

:sub_cleanup
if not exist c:\LeaderConnect md c:\LeaderConnect
if not exist "%HOMEPATH%\LeaderConnect" md "%HOMEPATH%\LeaderConnect"
::if EXIST "c:\LeaderConnect\id.txt" move /y "c:\LeaderConnect\id.txt" "%HOMEPATH%\LeaderConnect"
::if EXIST "c:\icon.ico" move /y "c:\icon.ico c:\LeaderConnect"
if not exist c:\LeaderConnect\icon.ico xcopy \\earth3\unisys\LeaderConnect\Tools\icon.ico c:\LeaderConnect\ /Y
if EXIST "%HOMEPATH%\LeaderConnect\id.txt" goto:sub_run
goto:sub_user

:sub_run
set /p userid= < "%HOMEPATH%\LeaderConnect\id.txt"
if "%userid%"=="" goto sub_user
if "%userid%"=="ECHO is off." goto sub_user
set no_spaces=%userid:~0,-1%
::if exist "%HOMEPATH%\Desktop\LeaderConnect.lnk" xcopy "\\earth3\unisys\LeaderConnect.lnk" "%HOMEPATH%\Desktop" /Y
cls
echo.
echo Please select an option:
echo.
echo   1.  UNI
echo   2.  LTE
echo   3.  BCV
echo   4.  DAT
echo   5.  MSE - Major Mods
echo   6.  SDA
echo   7.  STG
echo   8.  Remove Local 'Version' Files to Force Download
echo   9.  Change LEADER Logon ID (%no_spaces%)
echo   10. Manage Stored Passwords
echo.
set /p id=Enter Number: %=%
if /i "%id%"=="1" goto sub_uni
if /i "%id%"=="2" goto sub_lte
if /i "%id%"=="3" goto sub_bcv
if /i "%id%"=="4" goto sub_dat
if /i "%id%"=="5" goto sub_mse
if /i "%id%"=="6" goto sub_sda
if /i "%id%"=="7" goto sub_stg
if /i "%id%"=="8" goto sub_dlt
if /i "%id%"=="9" goto sub_user
if /i "%id%"=="10" goto sub_psw
::if /i "%id%"=="z" goto sub_uni_noscrchg
goto:sub_error

:sub_error
set /p id=You've entered an incorrect response. Please enter a number between 1-10: %=%
if /i "%id%"=="1" goto sub_uni
if /i "%id%"=="2" goto sub_lte
if /i "%id%"=="3" goto sub_bcv
if /i "%id%"=="4" goto sub_dat
if /i "%id%"=="5" goto sub_mse
if /i "%id%"=="6" goto sub_sda
if /i "%id%"=="7" goto sub_stg
if /i "%id%"=="8" goto sub_dlt
if /i "%id%"=="9" goto sub_user
if /i "%id%"=="10" goto sub_psw
::if /i "%id%"=="z" goto sub_uni_noscrchg
goto:sub_error

:sub_uni
"\\earth3\unisys\LeaderConnect\tools\UNI.cmd"
goto:eof

:sub_LTE
"\\earth3\unisys\LeaderConnect\tools\LTE.cmd"
goto:eof

:sub_BCV
"\\earth3\unisys\LeaderConnect\tools\BCV.cmd"
goto:eof

:sub_DAT
"\\earth3\unisys\LeaderConnect\tools\DAT.cmd"
goto:eof

:sub_DEV
"\\earth3\unisys\LeaderConnect\tools\DEV.cmd"
goto:eof

:sub_MSE
"\\earth3\unisys\LeaderConnect\tools\MSE.cmd"
goto:eof

:sub_SDA
"\\earth3\unisys\LeaderConnect\tools\SDA.cmd"
goto:eof

:sub_STG
"\\earth3\unisys\LeaderConnect\tools\STG.cmd"
goto:eof

:sub_pb5
"\\earth3\unisys\LeaderConnect\tools\pb5.cmd"
goto:eof

:sub_user
"\\earth3\unisys\LeaderConnect\tools\User.cmd"
goto:eof

:sub_uni_noscrchg
"\\earth3\unisys\LeaderConnect\tools\UNI_noscrchg.cmd"
goto:eof

:sub_psw
echo.
echo   **************************************************************************
echo.
echo   When the window pops up, go to the Advanced Tab and click Manage Passwords
echo.
echo   **************************************************************************
echo.
PING 1.1.1.1 -n 1 -w 2000 >NUL
control userpasswords2
set id=""
cls
goto:sub_run

:sub_dlt
cls
if exist c:\ldruni\ver*.txt del c:\ldruni\ver*.txt /Q
if exist c:\ldrtst\ver*.txt del c:\ldrtst\ver*.txt /Q
if exist c:\ldrbcv\ver*.txt del c:\ldrbcv\ver*.txt /Q
if exist c:\ldrtst-da\ver*.txt del c:\ldrtst-da\ver*.txt /Q
if exist c:\ldrdev\ver*.txt del c:\ldrdev\ver*.txt /Q
if exist c:\ldrmse\ver*.txt del c:\ldrmse\ver*.txt /Q
if exist c:\ldrsda\ver*.txt del c:\ldrsda\ver*.txt /Q
if exist c:\ldrstg\ver*.txt del c:\ldrstg\ver*.txt /Q
if exist c:\ldruni_noscrchng\ver*.txt del c:\ldruni_noscrchng\ver*.txt /Q
echo Done!
PING 1.1.1.1 -n 1 -w 500 >NUL
cls
goto:sub_run