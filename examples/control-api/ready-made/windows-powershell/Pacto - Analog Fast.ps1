# Pacto Tech - switch the controller to: Analog Fast
# (joysticks act as a full-speed analog stick)
# Needs the Pacto Tech Utility running. For the least visible run use:
#   powershell -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File "Pacto - Analog Fast.ps1"
# Docs: https://leecyrille.github.io/PactoTech_Public_Releases/control-api.html
try { Invoke-RestMethod -Uri "http://127.117.73.87:47391/mode/analog-fast" -TimeoutSec 5 | Out-Null; exit 0 } catch { exit 1 }
