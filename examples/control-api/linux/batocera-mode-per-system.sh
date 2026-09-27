#!/bin/sh
# Pacto Tech - pick the controller mode per SYSTEM on Batocera.
#
# Batocera runs every script in /userdata/system/scripts/ when a game starts
# ($1 = gameStart) and stops ($1 = gameStop), with $2 = the system name.
# Install:
#   cp batocera-mode-per-system.sh /userdata/system/scripts/
#   chmod +x /userdata/system/scripts/batocera-mode-per-system.sh
#
# Tip: for per-GAME settings (and turbo, remaps, keyboard mode...) use the Game
# profiles page of the PactoLink web page instead - it needs no scripts at all.
# Docs: https://leecyrille.github.io/PactoTech_Public_Releases/control-api.html
API="http://127.0.0.1:46810/api/v1/invoke/set_mode"
mode() { curl -s --max-time 3 -X POST -H "Content-Type: application/json" -d "{\"id\":$1,\"on\":true}" "$API" >/dev/null; }

case "$1" in
  gameStart)
    case "$2" in
      mame|fbneo|neogeo)           mode 1 ;;   # arcade: 4 player
      snes|megadrive|nes|pcengine) mode 3 ;;   # consoles: d-pad
      *)                           mode 0 ;;   # everything else: 2 player
    esac ;;
  gameStop)
    mode 0 ;;                                       # back to 2 player
esac
exit 0
