@echo off

rem Перенос файла баз данных ibases.v8i из текущей директории 
rem в директорию где этот файл располагается по умолчанию
rem gvk gvk@gvk-it.ru  gvk-it@gvk
rem echo off 
rem добавить _годмесяцдень  :
rem for /F "delims=. tokens=1-3" %%a in ('echo %date%') do rename 1.txt "1_%%c%%b%%a.txt"
rem echo on

if exist ibases.v8i (
   @echo begin record...
) else (
	@echo not find file
	goto onexit
)

if exist "%APPDATA%\1C\1CEstart\ibases.old"  (
    @echo can't rename old file
	goto onexit
   )


if exist %APPDATA%\1C\1CEstart\ibases.v8i (
    echo rename old file
    rename %APPDATA%\1C\1CEstart\ibases.v8i ibases.old
   )
copy  ibases.v8i %APPDATA%\1C\1CEstart\ibases.v8i
@echo success

:onexit
  
pause