# Pacto Tech - switch the controller to: 8to6 On
# (8-to-6 button shift on)
# .pyw files run without a window. Needs Python 3 and the Pacto Tech Utility running.
# Docs: https://leecyrille.github.io/PactoTech_Public_Releases/control-api.html
import sys
import urllib.request

try:
    urllib.request.urlopen("http://127.117.73.87:47391/mode/8to6-on", timeout=5).read()
except Exception:
    sys.exit(1)
