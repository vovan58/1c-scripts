rem ���஢���� 䠩����� ���ଠ樮���� ����
set prmfiles=C:\Program Files\1cv8\8.3.18.1520\bin\1cv8.exe
set IB_files=D:\1CBase\�祡���ࠡ�⪠\SmallBusiness\
set outfiles=out.txt
echo %IB_files%
set logfile=%IB_files%\gvklog\log.txt
set outfile=%IB_files%\gvklog\out.txt
set resultfile=%IB_files%\gvklog\result.txt
::  - ��砫� ࠡ��� �ਯ�
chdir %IB_files% 
mkdir gvklog
chdir %~dp0 
echo %~n0 Start %date% %time% >> %logfile%
"%prmfiles%" DESIGNER /Out %outfile% -NoTruncate /F %IB_files% /N gvk /P 274573 /DumpResult %resultfile% /DisableStartupDialogs ^
/IBCheckAndRepair -ReIndex -LogIntegrity -LogAndRefsIntegrity -RecalcTotals -IBCompression -TestOnly 
echo ��� �����襭�� %errorlevel% >> %logfile%
echo %~n0 Stop %date% %time% >> %logfile%