echo.
:sub_idcheck
set /p userid= < "%HOMEPATH%\LeaderConnect\id.txt"
set prodid=%userid:~0,-8%
if /I "%prodid%"=="u" goto sub_newid
goto:sub_ldrcheck

:sub_newid
set /p newid=Please enter a non-PROD user ID: %=%
if "%newid%"=="" goto sub_newid
if "%newid%"=="ECHO is off." goto sub_newid
echo %newid% > "%HOMEPATH%\LeaderConnect\id.txt"
goto:sub_idcheck

:sub_ldrcheck
tasklist /FI "IMAGENAME eq leader.exe" /FO CSV > c:\LeaderConnect\search.log
tasklist /FI "IMAGENAME eq inter.exe" /FO CSV >> c:\LeaderConnect\search.log
FINDSTR leader.exe c:\LeaderConnect\search.log > c:\LeaderConnect\found.log
FINDSTR inter.exe c:\LeaderConnect\search.log > c:\LeaderConnect\found2.log
FOR /F %%A IN (c:\LeaderConnect\found.log) DO IF %%~zA EQU 0 taskkill /F /IM leader.exe /T && PING 1.1.1.1 -n 1 -w 1000 >NUL
FOR /F %%A IN (c:\LeaderConnect\found2.log) DO IF %%~zA EQU 0 taskkill /F /IM inter.exe /T && PING 1.1.1.1 -n 1 -w 1000 >NUL
goto:sub_run

:sub_run
for /f %%a IN ('dir "\\PMO2SVRSQL1\ldrdist\unitest\leader\ver*.txt" /b') do set file1=%%a
for /f %%b IN ('dir "c:\ldruni\ver*.txt" /b') do set file2=%%b
if %file1%==%file2% goto sub_leader
goto:sub_refresh

:sub_refresh 
del c:\ldruni\*.* /q
xcopy \\PMO2SVRSQL1\ldrdist\unitest\leader\*.* c:\ldruni /I /Y
\\earth3\Unisys\LeaderConnect\PsExec\PsExec.exe -accepteula -u pmo\ldrconnect -p leader cmd /c if exist "C:\WINDOWS\syswow64\ver*.txt" del "C:\WINDOWS\syswow64\ver*.txt" /q
\\earth3\Unisys\LeaderConnect\PsExec\PsExec.exe -accepteula -u pmo\ldrconnect -p leader cmd /c copy "c:\ldruni\ver*.txt" "C:\WINDOWS\syswow64"
xcopy \\PMO2SVRSQL1\ldrdist\unitest\Help\*.* c:\ldruni\Help /I /y
cls
runas /user:pmo\%userid% /savecred "C:\ldruni\leader.exe"
goto:sub_find

:sub_leader
echo.
\\earth3\Unisys\LeaderConnect\PsExec\PsExec.exe -accepteula -u pmo\ldrconnect -p leader cmd /c if exist "C:\WINDOWS\syswow64\ver*.txt" del "C:\WINDOWS\syswow64\ver*.txt" /q
\\earth3\Unisys\LeaderConnect\PsExec\PsExec.exe -accepteula -u pmo\ldrconnect -p leader cmd /c copy "c:\ldruni\ver*.txt" "C:\WINDOWS\syswow64"
cls
runas /user:pmo\%userid% /savecred "C:\ldruni\leader.exe"
goto:sub_find

:sub_find
tasklist /FI "IMAGENAME eq leader.exe" /FO CSV > c:\LeaderConnect\search.log
FINDSTR leader.exe c:\LeaderConnect\search.log > c:\LeaderConnect\found.log
FOR /F %%A IN (c:\LeaderConnect\found.log) DO IF %%~zA EQU 0 GOTO eof
goto:sub_error

:sub_error
echo.
::echo You've entered an incorrect password.
::runas /user:pmo\%userid% "C:\ldruni\leader.exe"
Pause
goto:eof