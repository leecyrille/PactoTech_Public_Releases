@echo off
rem Pacto Tech - switch the controller to: 8to6 On
rem (8-to-6 button shift on)
rem Needs the Pacto Tech Utility running. A console window may flash for a moment;
rem use the .vbs version if it must be completely silent.
rem Docs: https://leecyrille.github.io/PactoTech_Public_Releases/control-api.html
curl.exe -s -f -m 5 "http://127.117.73.87:47391/mode/8to6-on" >nul 2>&1
