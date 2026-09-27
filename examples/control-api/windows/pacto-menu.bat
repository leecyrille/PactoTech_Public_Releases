@echo off
rem ============================================================================
rem  Pacto Tech - pick a controller mode from a menu (Windows)
rem  Double-click it. Needs the Pacto Tech Utility running. No token, no setup.
rem  Docs: https://leecyrille.github.io/PactoTech_Public_Releases/control-api.html
rem ============================================================================
setlocal
set "PACTO=http://127.117.73.87:47391"
title Pacto Tech modes

:menu
cls
echo.
echo   Pacto Tech - controller mode
echo   ----------------------------
echo    1  2 Player              6  Analog Fast
echo    2  4 Player              7  Analog Slow
echo    3  Twinstick             8  Keyboard mode ON
echo    4  Twinstick 1P          9  Keyboard mode OFF
echo    5  D-Pad                 0  8to6 toggle...
echo    Q  Quit
echo.
choice /c 1234567890Q /n /m "  Choose: "
set "N=%errorlevel%"
if "%N%"=="11" exit /b 0
if "%N%"=="10" goto m86
for /f "tokens=%N%" %%M in ("2p 4p twinstick twinstick-1p dpad analog-fast analog-slow keyboard-on keyboard-off") do set "MODE=%%M"
goto send

:m86
choice /c NF /n /m "  8to6: [N] on  [F] off  "
if errorlevel 2 (set "MODE=8to6-off") else (set "MODE=8to6-on")

:send
echo.
curl -s --max-time 5 %PACTO%/mode/%MODE%
if errorlevel 1 echo   Could not reach the Pacto Tech Utility - is it running?
timeout /t 2 >nul
goto menu
