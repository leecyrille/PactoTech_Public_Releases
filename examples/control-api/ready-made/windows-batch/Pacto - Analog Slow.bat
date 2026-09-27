@echo off
rem Pacto Tech - switch the controller to: Analog Slow
rem (joysticks act as a ramped (slow start) analog stick)
rem Needs the Pacto Tech Utility running. A console window may flash for a moment;
rem use the .vbs version if it must be completely silent.
rem Docs: https://leecyrille.github.io/PactoTech_Public_Releases/control-api.html
curl.exe -s -f -m 5 "http://127.117.73.87:47391/mode/analog-slow" >nul 2>&1
