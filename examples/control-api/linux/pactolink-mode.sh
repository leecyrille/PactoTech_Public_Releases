#!/bin/sh
# Pacto Tech - switch the controller mode through PactoLink (Batocera, RetroPie,
# Lakka, any Linux with the PactoLink daemon installed).
#
#   ./pactolink-mode.sh 4p
#   ./pactolink-mode.sh keyboard-on
#   PACTO_HOST=192.168.1.50 ./pactolink-mode.sh dpad     # from another machine
#
# On the cabinet itself no PIN is ever needed. From another machine, a PIN is
# only needed if one was set: PACTO_PIN=1234 ./pactolink-mode.sh 2p
# Docs: https://leecyrille.github.io/PactoTech_Public_Releases/control-api.html
HOST="${PACTO_HOST:-127.0.0.1}"
URL="http://$HOST:46810/api/v1/invoke/set_mode"

case "$1" in
  2p)            ID=0;  ON=true ;;
  4p)            ID=1;  ON=true ;;
  twinstick)     ID=2;  ON=true ;;
  twinstick-1p)  ID=9;  ON=true ;;
  twinstick-2p)  ID=10; ON=true ;;
  dpad)          ID=3;  ON=true ;;
  analog-fast)   ID=4;  ON=true ;;
  analog-slow)   ID=5;  ON=true ;;
  keyboard-on)   ID=6;  ON=true ;;
  keyboard-off)  ID=6;  ON=false ;;
  8to6-on)       ID=7;  ON=true ;;
  8to6-off)      ID=7;  ON=false ;;
  interlock-on)  ID=8;  ON=true ;;
  interlock-off) ID=8;  ON=false ;;
  *)
    echo "usage: $0 <mode>"
    echo "modes: 2p 4p twinstick twinstick-1p twinstick-2p dpad analog-fast analog-slow"
    echo "       keyboard-on keyboard-off 8to6-on 8to6-off interlock-on interlock-off"
    exit 1 ;;
esac

if [ -n "$PACTO_PIN" ]; then
  ANSWER=$(curl -s --max-time 5 -X POST -H "Content-Type: application/json" \
    -H "X-Pacto-Pin: $PACTO_PIN" -d "{\"id\":$ID,\"on\":$ON}" "$URL")
else
  ANSWER=$(curl -s --max-time 5 -X POST -H "Content-Type: application/json" \
    -d "{\"id\":$ID,\"on\":$ON}" "$URL")
fi
if [ "$ANSWER" = "true" ]; then
  echo "ok: $1"
else
  case "$ANSWER" in
    false) WHY="the controller is not connected or refused it" ;;
    "")    WHY="PactoLink is not reachable" ;;
    *)     WHY="$ANSWER" ;;
  esac
  echo "could not switch to $1: $WHY" >&2
  exit 1
fi
