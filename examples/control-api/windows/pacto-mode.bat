@echo off
rem ============================================================================
rem  Pacto Tech - switch the controller mode (Windows)
rem
rem  Needs: the Pacto Tech Utility running (tray icon). No token, no setup.
rem
rem    pacto-mode.bat 4p
rem    pacto-mode.bat keyboard-on
rem    pacto-mode.bat              (lists every mode)
rem
rem  Modes: 2p 4p twinstick twinstick-1p twinstick-2p
rem         dpad analog-fast analog-slow
rem         keyboard-on keyboard-off 8to6-on 8to6-off interlock-on interlock-off
rem
rem  Docs: https://leecyrille.github.io/PactoTech_Public_Releases/control-api.html
rem ============================================================================
setlocal
set "PACTO=http://127.117.73.87:47391"

if "%~1"=="" (
  curl -s --max-time 5 %PACTO%/modes
  exit /b 1
)

curl -s --fail-with-body --max-time 5 %PACTO%/mode/%~1
if errorlevel 1 (
  echo.
  echo Could not switch to "%~1" - is the Pacto Tech Utility running and the controller connected?
  exit /b 1
)
exit /b 0
