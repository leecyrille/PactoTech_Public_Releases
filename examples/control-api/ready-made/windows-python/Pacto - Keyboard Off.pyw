# Pacto Tech - switch the controller to: Keyboard Off
# (leave keyboard mode: back to the arcade controls as gamepads (takes ~12 s so Windows can forget the old controller))
# .pyw files run without a window. Needs Python 3 and the Pacto Tech Utility running.
# Docs: https://leecyrille.github.io/PactoTech_Public_Releases/control-api.html
import sys
import urllib.request

try:
    urllib.request.urlopen("http://127.117.73.87:47391/mode/keyboard-off", timeout=5).read()
except Exception:
    sys.exit(1)
