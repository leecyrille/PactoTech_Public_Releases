#!/usr/bin/env python3
"""Pacto Tech - react to controller mode changes live through PactoLink (Linux).

PactoLink pushes every mode change the moment it happens as a Server-Sent-Events
stream, so nothing has to poll. Standard library only; works on the cabinet or
from any machine on the network:

    python3 pactolink_watch.py                  # the cabinet itself
    python3 pactolink_watch.py 192.168.1.50     # from another machine

Replace on_change() with whatever should happen (LEDs, a front-end theme, OBS...).
Docs: https://leecyrille.github.io/PactoTech_Public_Releases/control-api.html
"""
import json
import sys
import time
import urllib.request

HOST = sys.argv[1] if len(sys.argv) > 1 else "127.0.0.1"
EVENTS = f"http://{HOST}:46810/api/v1/events"

# mode_flags bits (same on Windows and Linux)
FLAGS = [(0x0001, "2P"), (0x0002, "4P"), (0x0004, "TWINSTICK"), (0x0400, "TWINSTICK_1P"),
         (0x0800, "TWINSTICK_2P"), (0x0008, "DPAD"), (0x0010, "ANALOG_FAST"),
         (0x0020, "ANALOG_SLOW"), (0x1000, "TURBO"), (0x0100, "8TO6_LEFT"),
         (0x0200, "8TO6_RIGHT"), (0x0040, "INTERLOCK"), (0x0080, "KEYBOARD")]


def names(flags):
    return [n for bit, n in FLAGS if flags & bit]


def on_change(modes):
    print(time.strftime("%H:%M:%S"), " ".join(modes), flush=True)


def main():
    last = None
    while True:                                   # reconnect forever
        try:
            with urllib.request.urlopen(EVENTS, timeout=60) as stream:
                for raw in stream:
                    line = raw.decode("utf-8", "replace").strip()
                    if not line.startswith("data:"):
                        continue                  # keep-alives and blank lines
                    msg = json.loads(line[5:])
                    if msg.get("event") != "pacto://status" or not msg.get("payload"):
                        continue
                    flags = msg["payload"]["mode_flags"]
                    if flags != last:
                        last = flags
                        on_change(names(flags))
        except KeyboardInterrupt:
            return
        except Exception as e:                    # daemon restarting, Wi-Fi drop, ...
            print("PactoLink not reachable, retrying:", e, file=sys.stderr)
            time.sleep(3)


if __name__ == "__main__":
    main()
