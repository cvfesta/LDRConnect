@echo off

:sub_run
for /f %%a IN ('dir "\\PMO2SVRSQL1\ldrdist\unitest\leader\ver*.txt" /b') do set file1=%%a
for /f %%b IN ('dir "c:\ldruni_noscrchng\ver*.txt" /b') do set file2=%%b
if %file1%==%file2% goto sub_leader
goto:sub_refresh

:sub_refresh 
echo Checking if LEADER is already running:
taskkill /F /IM leader.exe /T
taskkill /F /IM inter.exe /T
::WAITS 1 SECONDS
PING 1.1.1.1 -n 1 -w 1000 >NUL
del c:\ldruni_noscrchng\*.* /q
if exist C:\WINDOWS\system32\ver*.txt del "C:\WINDOWS\system32\ver*.txt" /q
xcopy \\PMO2SVRSQL1\ldrdist\unitest\leader\*.* c:\ldruni_noscrchng /I /Y
copy "c:\ldruni_noscrchng\ver*.txt" "C:\WINDOWS\system32"
xcopy \\PMO2SVRSQL1\ldrdist\unitest\Help\*.* c:\ldruni_noscrchng\Help /I /Y
xcopy \\PMO2SVRSQL1\ldrdist\systest\Leader\*.exe c:\ldruni_noscrchng /Y /Q
xcopy \\PMO2SVRSQL1\ldrdist\systest\Leader\*.dll c:\ldruni_noscrchng /Y /Q
xcopy \\PMO2SVRSQL1\ldrdist\systest\Leader\*.cnt c:\ldruni_noscrchng /Y /Q
xcopy \\PMO2SVRSQL1\ldrdist\systest\Leader\*.cbl c:\ldruni_noscrchng /Y /Q
cls
runas /user:pmo\%userid% /savecred "C:\ldruni_noscrchng\leader.exe"
goto:eof

:sub_leader
echo Checking if LEADER is already running:
taskkill /F /IM leader.exe /T
taskkill /F /IM inter.exe /T
::WAITS 1 SECOND
PING 1.1.1.1 -n 1 -w 1000 >NUL
echo.
if exist C:\WINDOWS\system32\ver*.txt del "C:\WINDOWS\system32\ver*.txt" /q
copy "c:\ldruni_noscrchng\ver*.txt" "C:\WINDOWS\system32"
cls
runas /user:pmo\%userid% /savecred "C:\ldruni_noscrchng\leader.exe"
goto:eof