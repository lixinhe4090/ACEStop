@echo off
chcp 437 >nul 2>&1
setlocal enabledelayedexpansion

::---  basic settings  ---
set "procA=SGuardSvc64.exe"
set "procB=SGuard64.exe"
set "prio=Idle"
set "scan=3"
set "core=0"

::---  affinity mask for chosen core  ---
set /a "mask=1<<core"

::---  detect cpu count  ---
for /f "skip=1 tokens=2 delims==" %%a in ('wmic cpu get NumberOfLogicalProcessors /value') do set "cpus=%%a"
if not defined cpus (
    for /f "tokens=3 delims= " %%a in ('reg query "HKLM\HARDWARE\DESCRIPTION\System\CentralProcessor" /s ^| find /c "ProcessorNameString"') do set "cpus=%%a"
)
if not defined cpus set "cpus=1"

::---  header  ---
echo ==============================================
echo SimpleProcTuner - Auto Config Tool
echo Targets: 1.%procA%  2.%procB%
echo Config : Priority=%prio% , CPU=Core %core% (Total: %cpus%)
echo Scan   : every %scan%s
echo ==============================================
echo Tip: Keep running, then launch your game/app.
echo Exit : Ctrl+C -^> Y -^> Enter
echo ==============================================
echo.

:LOOP
::--- procA ---
set "idA="
for /f "tokens=2 delims=," %%a in ('tasklist /fi "imagename eq %procA%" /fo csv /nh 2^>nul') do set "idA=%%~a"
if defined idA (
    powershell -Command "(Get-Date -Format 'HH:mm:ss') | ForEach-Object { $t=$_; $p=Get-Process -Id !idA! -EA SilentlyContinue; if($p){$p.PriorityClass='%prio%'; $p.ProcessorAffinity=%mask%; write-host '['$t'] %procA% (PID: !idA!) Done'}}"
)

::--- procB ---
set "idB="
for /f "tokens=2 delims=," %%a in ('tasklist /fi "imagename eq %procB%" /fo csv /nh 2^>nul') do set "idB=%%~a"
if defined idB (
    powershell -Command "(Get-Date -Format 'HH:mm:ss') | ForEach-Object { $t=$_; $p=Get-Process -Id !idB! -EA SilentlyContinue; if($p){$p.PriorityClass='%prio%'; $p.ProcessorAffinity=%mask%; write-host '['$t'] %procB% (PID: !idB!) Done'}}"
)

timeout /t %scan% /nobreak >nul 2>&1 || ping -n %scan% 127.0.0.1 >nul 2>&1
goto LOOP