@echo off
setlocal enabledelayedexpansion
title System Dashboard v3.2
mode con lines=32 cols=100
color 0A

:MENU
cls
echo.
echo   ========================================================================================
echo      S Y S T E M   D A S H B O A R D   ^|   %DATE%   ^|   %TIME:~0,5%
echo   ========================================================================================
echo.
echo     [1] SYSTEM SPECS       - CPU, RAM, and GPU Detection
echo     [2] TASK MANAGER       - View Top Processes ^& Kill Tasks
echo     [3] MAINTENANCE        - Clear Temp Files ^& Empty Trash
echo     [4] APPS FOLDER        - Open Windows Applications Folder
echo     [5] WINDOWS SETTINGS   - Open System Settings Menu
echo     [6] TOGGLE COLOR       - Cycle Dashboard Theme
echo     [7] POWER OPTIONS      - Shutdown, Restart, Sleep
echo     [8] EXIT
echo.
echo   ========================================================================================
echo.

choice /c 12345678 /n /m "  Select an option (1-8): "

if errorlevel 8 exit
if errorlevel 7 goto POWER
if errorlevel 6 goto COLOR_TOGGLE
if errorlevel 5 goto OPEN_SETTINGS
if errorlevel 4 goto OPEN_APPS
if errorlevel 3 goto CLEAN
if errorlevel 2 goto TASKMAN
if errorlevel 1 goto SPECS

:: --- [1] SYSTEM SPECS ---
:SPECS
cls
echo.
echo   [ FETCHING SYSTEM HARDWARE ]
echo   ------------------------------------------------------------
for /f "delims=" %%a in ('powershell -NoProfile -Command "(Get-CimInstance Win32_Processor).Name"') do set "cpu=%%a"
for /f "delims=" %%a in ('powershell -NoProfile -Command "[math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB)"') do set "ram=%%a"
for /f "delims=" %%a in ('powershell -NoProfile -Command "(Get-CimInstance Win32_VideoController).Name"') do set "gpu=%%a"

echo   CPU:  !cpu!
echo   RAM:  !ram! GB
echo   GPU:  !gpu!
echo   ------------------------------------------------------------
echo.
pause
goto MENU

:: --- [2] TASK MANAGER ---
:TASKMAN
cls
echo.
echo   [ TOP 12 PROCESSES BY MEMORY ]
echo   ------------------------------------------------------------------------------------
echo   NAME                     RAM (MB)     ID
echo   ------------------------------------------------------------------------------------
powershell -NoProfile -Command "Get-Process | Sort-Object WorkingSet64 -Descending | Select-Object -First 12 | ForEach-Object { '{0,-24} {1,-12} {2,-8}' -f $_.Name, [math]::round($_.WorkingSet64/1MB), $_.Id }"
echo   ------------------------------------------------------------------------------------
echo   [K] KILL PROCESS   [R] REFRESH   [B] BACK
echo.
choice /c KRB /n
if errorlevel 3 goto MENU
if errorlevel 2 goto TASKMAN
if errorlevel 1 (
    set /p "target=  Enter Process Name or ID: "
    taskkill /F /IM "!target!" 2>nul || taskkill /F /PID "!target!" 2>nul
    goto TASKMAN
)

:: --- [3] MAINTENANCE ---
:CLEAN
cls
echo.
echo   [ RUNNING SYSTEM CLEANUP ]
echo   ------------------------------------------------------------
echo   - Emptying Recycle Bin...
powershell -NoProfile -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue"
echo   - Deleting Temp Files...
del /s /f /q %temp%\*.* >nul 2>&1
echo   ------------------------------------------------------------
echo   Done!
timeout /t 2 >nul
goto MENU

:: --- [4] OPEN APPS ---
:OPEN_APPS
start shell:AppsFolder
goto MENU

:: --- [5] WINDOWS SETTINGS ---
:OPEN_SETTINGS
echo Opening Windows Settings...
:: This uses the URI scheme to launch the Settings app
start ms-settings:
timeout /t 2 >nul
goto MENU

:: --- [6] COLOR TOGGLE ---
:COLOR_TOGGLE
if "%c%"=="" set "c=A"
if "%c%"=="A" (color 0B & set "c=B" & goto MENU)
if "%c%"=="B" (color 0E & set "c=E" & goto MENU)
if "%c%"=="E" (color 0F & set "c=F" & goto MENU)
if "%c%"=="F" (color 0A & set "c=A" & goto MENU)
goto MENU

:: --- [7] POWER OPTIONS ---
:POWER
cls
echo.
echo   [ POWER CONTROL ]
echo   ------------------------------------------------------------
echo   [S] SHUTDOWN   [R] RESTART   [L] SLEEP   [B] BACK
echo   ------------------------------------------------------------
echo.
choice /c SRLB /n
if errorlevel 4 goto MENU
if errorlevel 3 (rundll32.exe powrprof.dll,SetSuspendState 0,1,0 & goto MENU)
if errorlevel 2 shutdown /r /t 0
if errorlevel 1 shutdown /s /t 0
goto MENU