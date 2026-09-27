# Pacto Tech - switch the controller to: 8to6 Off
# (8-to-6 button shift off)
# Needs the Pacto Tech Utility running. For the least visible run use:
#   powershell -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File "Pacto - 8to6 Off.ps1"
# Docs: https://leecyrille.github.io/PactoTech_Public_Releases/control-api.html
try { Invoke-RestMethod -Uri "http://127.117.73.87:47391/mode/8to6-off" -TimeoutSec 5 | Out-Null; exit 0 } catch { exit 1 }
