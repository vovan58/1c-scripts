rem @echo off
rem \\----- начало скрипт остановки и запуска агента сервера 1С Предприятия----\\
set logfile="stopstartlog.txt"
set timeout=20
echo %date% %time% >>%logfile%
net stop "1C:Enterprise 8.1 Server Agent" >>%logfile%
c:\scripts\sleep %timeout%
echo %date% %time% >>%logfile%
net start "1C:Enterprise 8.1 Server Agent" >>%logfile%
c:\scripts\sleep %timeout%
rem  \\----- конец скрипт остановки и запуска агента сервера 1С Предприятия----\\
   