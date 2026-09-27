@echo off
rem ============================================================================
rem  Pacto Tech - run a game in a given controller mode, then switch back
rem
rem  Use it as the launch command in a front end (LaunchBox "Running script",
rem  RetroFE / CoinOps / Attract-Mode launcher, or a plain desktop shortcut):
rem
rem    launch-with-mode.bat 4p "C:\Emulators\MAME\mame.exe" gauntlet
rem    launch-with-mode.bat twinstick "C:\Games\Robotron\robotron.exe"
rem
rem  Argument 1 = the mode for this game (see pacto-mode.bat for the names)
rem  The rest   = the program and its arguments, exactly as you would type them
rem  After the game exits the controller returns to AFTER_MODE below.
rem
rem  Needs: the Pacto Tech Utility running. No token, no setup.
rem  Docs: https://leecyrille.github.io/PactoTech_Public_Releases/control-api.html
rem ============================================================================
setlocal
set "PACTO=http://127.117.73.87:47391"
set "AFTER_MODE=2p"

if "%~2"=="" (
  echo usage: launch-with-mode.bat ^<mode^> ^<program^> [arguments...]
  exit /b 1
)

set "MODE=%~1"
shift

rem collect the program + its arguments (shift does not change %*)
set "CMDLINE="
:collect
if "%~1"=="" goto run
set CMDLINE=%CMDLINE% "%~1"
shift
goto collect

:run
curl -s --max-time 5 %PACTO%/mode/%MODE% >nul
start "" /wait %CMDLINE%
curl -s --max-time 5 %PACTO%/mode/%AFTER_MODE% >nul
exit /b 0
