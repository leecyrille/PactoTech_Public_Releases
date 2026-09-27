#!/bin/sh
# Pacto Tech (PactoLink on Batocera / RetroPie / Lakka) - switch the controller to: 2 Player
# (2 player layout)
# Silent. Exit code 0 = switched. Tested so far in virtual machines only.
# Docs: https://leecyrille.github.io/PactoTech_Public_Releases/control-api.html
curl -s -m 5 -X POST -H "Content-Type: application/json" \
  -d '{"id":0,"on":true}' http://127.0.0.1:46810/api/v1/invoke/set_mode | grep -q true
