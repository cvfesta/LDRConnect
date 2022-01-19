echo.
::sub_idcheck
::set /p userid= < "%HOMEPATH%\LeaderConnect\id.txt"
::set prodid=%userid:~0,-8%
::if /I "%prodid%"=="u" goto sub_ldrcheck
::goto:sub_newid

:sub_ldrcheck
tasklist /FI "IMAGENAME eq leader.exe" /FO CSV > c:\LeaderConnect\search.log
tasklist /FI "IMAGENAME eq inter.exe" /FO CSV >> c:\LeaderConnect\search.log
FINDSTR leader.exe c:\LeaderConnect\search.log > c:\LeaderConnect\found.log
FINDSTR inter.exe c:\LeaderConnect\search.log > c:\LeaderConnect\found2.log
FOR /F %%A IN (c:\LeaderConnect\found.log) DO IF %%~zA EQU 0 taskkill /F /IM leader.exe /T && PING 1.1.1.1 -n 1 -w 1000 >NUL
FOR /F %%A IN (c:\LeaderConnect\found2.log) DO IF %%~zA EQU 0 taskkill /F /IM inter.exe /T && PING 1.1.1.1 -n 1 -w 1000 >NUL
goto:sub_run

:sub_run
for /f %%a IN ('dir "\\Pmo2svrsql1\ldrdist\BCVTest\Leader\ver*.txt" /b') do set file1=%%a
for /f %%b IN ('dir "c:\ldrbcv\ver*.txt" /b') do set file2=%%b
if %file1%==%file2% goto sub_leader
goto:sub_refresh

:sub_refresh 
del c:\ldrbcv\*.* /q
xcopy \\Pmo2svrsql1\ldrdist\BCVTest\Leader\*.* c:\ldrbcv /I /Y
\\earth3\Unisys\LeaderConnect\PsExec\PsExec.exe -accepteula -u pmo\ldrconnect -p leader cmd /c if exist "C:\WINDOWS\syswow64\ver*.txt" del "C:\WINDOWS\syswow64\ver*.txt" /q
\\earth3\Unisys\LeaderConnect\PsExec\PsExec.exe -accepteula -u pmo\ldrconnect -p leader cmd /c copy "c:\ldrbcv\ver*.txt" "C:\WINDOWS\syswow64"
cls
runas /user:prod\%userid% /savecred "C:\ldrbcv\leader.exe"
goto:sub_find

:sub_leader
\\earth3\Unisys\LeaderConnect\PsExec\PsExec.exe -accepteula -u pmo\ldrconnect -p leader cmd /c if exist "C:\WINDOWS\syswow64\ver*.txt" del "C:\WINDOWS\syswow64\ver*.txt" /q
\\earth3\Unisys\LeaderConnect\PsExec\PsExec.exe -accepteula -u pmo\ldrconnect -p leader cmd /c copy "c:\ldrbcv\ver*.txt" "C:\WINDOWS\syswow64"
cls
runas /user:prod\%userid% /savecred "C:\ldrbcv\leader.exe"
goto:sub_find

:sub_error
echo.
::echo You've entered an incorrect password.
::runas /profile /env /user:prod\%userid% /savecred "C:\ldrbcv\leader.exe"
Pause
goto:eof

:sub_find
tasklist /FI "IMAGENAME eq leader.exe" /FO CSV > c:\LeaderConnect\search.log
FINDSTR leader.exe c:\LeaderConnect\search.log > c:\LeaderConnect\found.log
FOR /F %%A IN (c:\LeaderConnect\found.log) DO IF %%~zA EQU 0 GOTO eof
goto:sub_error

:sub_newid
set /p newid=Please enter your PROD user ID: %=%
if "%newid%"=="" goto sub_newid
if "%newid%"=="ECHO is off." goto sub_newid
echo %newid% > "%HOMEPATH%\LeaderConnect\id.txt"
goto:sub_idcheck