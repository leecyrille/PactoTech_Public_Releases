# Pacto Tech - switch the controller to: Analog Slow
# (joysticks act as a ramped (slow start) analog stick)
# .pyw files run without a window. Needs Python 3 and the Pacto Tech Utility running.
# Docs: https://leecyrille.github.io/PactoTech_Public_Releases/control-api.html
import sys
import urllib.request

try:
    urllib.request.urlopen("http://127.117.73.87:47391/mode/analog-slow", timeout=5).read()
except Exception:
    sys.exit(1)
