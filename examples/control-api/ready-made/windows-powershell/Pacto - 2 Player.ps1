# Pacto Tech - switch the controller to: 2 Player
# (2 player layout)
# Needs the Pacto Tech Utility running. For the least visible run use:
#   powershell -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File "Pacto - 2 Player.ps1"
# Docs: https://leecyrille.github.io/PactoTech_Public_Releases/control-api.html
try { Invoke-RestMethod -Uri "http://127.117.73.87:47391/mode/2p" -TimeoutSec 5 | Out-Null; exit 0 } catch { exit 1 }
