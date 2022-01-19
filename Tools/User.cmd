:sub_subcheck
if "%userid%"=="" goto sub_iderror
if "%userid%"=="ECHO is off." goto sub_iderror
if NOT EXIST "%HOMEPATH%\LeaderConnect\id.txt" goto sub_iderror
goto:sub_newid

:sub_iderror
echo.
set /p newid=Please enter your LEADER user ID: %=%
if "%newid%"=="" goto sub_iderror
echo %newid% > "%HOMEPATH%\LeaderConnect\id.txt"
cls
"\\earth3\unisys\LeaderConnect\LeaderConnect.cmd"
goto:eof

:sub_newid
echo.
set /p newid=Please enter your LEADER user ID:
if "%newid%"=="" goto sub_newid
if "%newid%"=="ECHO is off." goto sub_newid
echo %newid% > "%HOMEPATH%\LeaderConnect\id.txt"
set id=""
cls
"\\earth3\unisys\LeaderConnect\LeaderConnect.cmd"
goto:eof