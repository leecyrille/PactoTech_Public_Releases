#!/usr/bin/env python3
"""Pacto Tech Utility - change and watch controller modes from Python (Windows).

Standard library only. The Pacto Tech Utility must be running.

    python pacto_mode.py 4p            switch mode (no token needed)
    python pacto_mode.py --list        every mode name
    python pacto_mode.py --status      live modes          (full API, see below)
    python pacto_mode.py --watch       print every mode change until Ctrl+C (full API)

--status and --watch use the full API: switch on "Allow local AI agents" in the
Utility's App Options first (the token is read from
%LOCALAPPDATA%\\PactoConfigurator\\agent_token.txt automatically).

Docs: https://leecyrille.github.io/PactoTech_Public_Releases/control-api.html
"""
import json
import os
import sys
import time
import urllib.error
import urllib.request

BASE = "http://127.117.73.87:47391"


def _get(path, token=None, timeout=5):
    req = urllib.request.Request(BASE + path)
    if token:
        req.add_header("Authorization", "Bearer " + token)
    with urllib.request.urlopen(req, timeout=timeout) as r:
        return r.read().decode("utf-8")


def token():
    path = os.path.join(os.environ.get("LOCALAPPDATA", ""), "PactoConfigurator", "agent_token.txt")
    with open(path, encoding="utf-8") as f:
        return f.read().strip()


def set_mode(mode):
    """Switch a mode by name ('4p', 'keyboard-on', ...). Returns the Utility's answer."""
    return _get("/mode/" + mode).strip()


def status():
    """Live modes: {'mode_flags': int, 'modes': ['2P', 'ANALOG_FAST', ...], ...}"""
    return json.loads(_get("/agent/status", token()))["status"]


def watch(on_change, interval=0.25):
    """Call on_change(mode_names) whenever the live modes change."""
    last, tok = None, token()
    while True:
        try:
            st = json.loads(_get("/agent/status", tok))["status"]
            if st["mode_flags"] != last:
                last = st["mode_flags"]
                on_change(st["modes"])
        except (urllib.error.URLError, OSError, KeyError, ValueError) as e:
            if last != -1:
                last = -1
                print("Utility or controller not reachable:", e, file=sys.stderr)
        time.sleep(interval)


if __name__ == "__main__":
    arg = sys.argv[1] if len(sys.argv) > 1 else "--list"
    try:
        if arg == "--list":
            print(_get("/modes"), end="")
        elif arg == "--status":
            print(" ".join(status()["modes"]))
        elif arg == "--watch":
            watch(lambda modes: print(time.strftime("%H:%M:%S"), " ".join(modes), flush=True))
        else:
            print(set_mode(arg))
    except urllib.error.HTTPError as e:
        print(e.read().decode("utf-8", "replace").strip(), file=sys.stderr)
        sys.exit(1)
    except urllib.error.URLError as e:
        print("Pacto Tech Utility not reachable - is it running?", e.reason, file=sys.stderr)
        sys.exit(1)
    except KeyboardInterrupt:
        pass
