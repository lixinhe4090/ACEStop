@echo off
:: 保证控制台使用 GBK，避免中文乱码
chcp 936 >nul
setlocal enabledelayedexpansion

:: 目标进程
set "p1=SGuardSvc64.exe"
set "p2=SGuard64.exe"
set "pri=Idle"
set "check_interval=3"

:: 获取逻辑核心数（带错误检查）
for /f "skip=1 tokens=2 delims==" %%a in ('wmic cpu get NumberOfLogicalProcessors /value 2^>nul') do set "cpu=%%a"
if not defined cpu (
    for /f "tokens=3 delims= " %%a in ('reg query "HKLM\HARDWARE\DESCRIPTION\System\CentralProcessor" /s 2^>nul ^| find /c "ProcessorNameString"') do set "cpu=%%a"
)
if not defined cpu (
    echo [错误] 无法获取 CPU 逻辑核心数，脚本终止。
    pause
    exit /b 1
)

:: 计算最后一个核心的十进制 affinity
set /a "last_core=cpu-1"
set /a "aff_dec=1<<last_core"

:: 标题
echo ==============================================
echo       ACE 反作弊进程优化工具【实时监控】 By @千河RUAEISA.
echo 目标进程：%p1%  与  %p2%
echo 配置：优先级=最低（Idle） CPU=最后一个核心（共 %cpu% 个）
echo 检查间隔：%check_interval% 秒
echo ==============================================
echo 提示：请保持本窗口运行；退出请按 Ctrl+C → 输入 Y → 回车
echo ==============================================
echo.

:MONITOR
:: 检查进程1
set "pid1="
for /f "tokens=2 delims=," %%a in ('tasklist /fi "imagename eq %p1%" /fo csv /nh 2^>nul') do set "pid1=%%~a"
if defined pid1 (
    powershell -NoProfile -Command "$t=(Get-Date -Format 'HH:mm:ss'); try { \
        $p=Get-Process -Id %pid1% -EA Stop; \
        $p.PriorityClass='%pri%'; \
        $p.ProcessorAffinity=%aff_dec%; \
        Write-Host \"[$t] %p1% (PID: %pid1%) Setting Succeed：优先级=最低，CPU=最后一个核心\" -ForegroundColor Green \
    } catch { \
        Write-Host \"[$t] %p1% (PID: %pid1%) ERROR：$$_\" -ForegroundColor Red \
    }"
) else (
    echo [%time%] 警告：未找到进程 %p1%
)

:: 检查进程2
set "pid2="
for /f "tokens=2 delims=," %%a in ('tasklist /fi "imagename eq %p2%" /fo csv /nh 2^>nul') do set "pid2=%%~a"
if defined pid2 (
    powershell -NoProfile -Command "$t=(Get-Date -Format 'HH:mm:ss'); try { \
        $p=Get-Process -Id %pid2% -EA Stop; \
        $p.PriorityClass='%pri%'; \
        $p.ProcessorAffinity=%aff_dec%; \
        Write-Host \"[$t] %p2% (PID: %pid2%) 设置成功：优先级=最低，CPU=最后一个核心\" -ForegroundColor Green \
    } catch { \
        Write-Host \"[$t] %p2% (PID: %pid2%) 设置失败：$$_\" -ForegroundColor Red \
    }"
) else (
    echo [%time%] 错误：进程不存在 %p2%
)

:: 等待下一轮
timeout /t %check_interval% /nobreak >nul 2>&1 || ping -n %check_interval% 127.0.0.1 >nul 2>&1
goto MONITOR