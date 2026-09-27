# Pacto Tech - switch the controller to: Analog Fast
# (joysticks act as a full-speed analog stick)
# .pyw files run without a window. Needs Python 3 and the Pacto Tech Utility running.
# Docs: https://leecyrille.github.io/PactoTech_Public_Releases/control-api.html
import sys
import urllib.request

try:
    urllib.request.urlopen("http://127.117.73.87:47391/mode/analog-fast", timeout=5).read()
except Exception:
    sys.exit(1)
