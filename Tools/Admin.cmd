\\earth3\Unisys\LeaderConnect\PsExec\PsExec.exe -accepteula -u pmo\ldrconnect -p leader cmd /c if exist "C:\WINDOWS\syswow64\ver*.txt" del "C:\WINDOWS\syswow64\ver*.txt" /q
\\earth3\Unisys\LeaderConnect\PsExec\PsExec.exe -accepteula -u pmo\ldrconnect -p leader cmd /c copy "c:\ldrtst-da\ver*.txt" "C:\WINDOWS\syswow64"
Pause