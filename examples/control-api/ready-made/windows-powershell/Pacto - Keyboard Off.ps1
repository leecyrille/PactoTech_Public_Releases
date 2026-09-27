# Pacto Tech - switch the controller to: Keyboard Off
# (leave keyboard mode: back to the arcade controls as gamepads (takes ~12 s so Windows can forget the old controller))
# Needs the Pacto Tech Utility running. For the least visible run use:
#   powershell -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File "Pacto - Keyboard Off.ps1"
# Docs: https://leecyrille.github.io/PactoTech_Public_Releases/control-api.html
try { Invoke-RestMethod -Uri "http://127.117.73.87:47391/mode/keyboard-off" -TimeoutSec 5 | Out-Null; exit 0 } catch { exit 1 }
