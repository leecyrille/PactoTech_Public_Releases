# Pacto Tech — change controller modes with scripts

**Full guide with explanations: https://leecyrille.github.io/PactoTech_Public_Releases/control-api.html**

Download everything at once:
[PactoTech-Control-Examples.zip](https://github.com/leecyrille/PactoTech_Public_Releases/releases/download/earlytesting/PactoTech-Control-Examples.zip)

The quickest possible version (Windows, with the Pacto Tech Utility running):

```bat
curl -s http://127.117.73.87:47391/mode/4p
```

## Ready-made: one script per mode, nothing to edit

Folder `ready-made/` has a file for every mode in every method. Modes: keyboard / disconnect
mode (DongleMaster pads), leave keyboard mode, 2 player, 4 player, analog fast, d-pad, analog slow,
8to6 on, 8to6 off.

| Folder | Runs silently? | Needs |
|---|---|---|
| `ready-made/windows-silent-vbs` | yes, nothing on screen (+ `launch-with-mode.vbs` for front ends) | nothing |
| `ready-made/windows-batch` | a console window may flash | nothing |
| `ready-made/windows-powershell` | a brief flash | nothing |
| `ready-made/windows-python` | yes (`.pyw`) | Python 3 |
| `ready-made/windows-autohotkey` | yes | AutoHotkey v2 |
| `ready-made/linux-batocera` | yes | PactoLink (tested in virtual machines so far) |

Turbo on/off cannot be scripted yet (use the board's turbo button/switch or a Game profile).

## Building blocks

| File | What it is |
|---|---|
| `windows/pacto-mode.bat` | switch to any mode: `pacto-mode.bat 4p` |
| `windows/launch-with-mode.bat` | run a game in a mode, switch back when it closes |
| `windows/pacto-menu.bat` | double-click menu to pick a mode |
| `windows/PactoApi.ps1` | PowerShell functions: switch, read, watch modes, remaps, settings |
| `windows/pacto_mode.py` | Python command line tool and module (switch / status / watch) |
| `windows/pacto-hotkeys.ahk` | AutoHotkey v2: every mode on Ctrl+Alt+number |
| `linux/pactolink-mode.sh` | PactoLink (Batocera, RetroPie, Lakka): switch by name |
| `linux/pactolink_watch.py` | PactoLink: react to every mode change instantly (no polling) |
| `linux/batocera-mode-per-system.sh` | Batocera game-start hook: a mode per system |

Mode names: `2p` `4p` `twinstick` `twinstick-1p` `twinstick-2p` `dpad` `analog-fast`
`analog-slow` `keyboard-on` `keyboard-off` `8to6-on` `8to6-off` `interlock-on` `interlock-off`
