# Pacto Tech - switch the controller to: Analog Slow
# (joysticks act as a ramped (slow start) analog stick)
# Needs the Pacto Tech Utility running. For the least visible run use:
#   powershell -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File "Pacto - Analog Slow.ps1"
# Docs: https://leecyrille.github.io/PactoTech_Public_Releases/control-api.html
try { Invoke-RestMethod -Uri "http://127.117.73.87:47391/mode/analog-slow" -TimeoutSec 5 | Out-Null; exit 0 } catch { exit 1 }
