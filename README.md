# Pacto Tech — Downloads

Welcome! This is the home for the **Pacto Tech Utility** — the free app for
setting up your Pacto arcade controller — and the **firmware** that runs on the
boards. Install the app once and it keeps both itself and your controller up to
date for you.

## Get the app (Windows)

### ➡️ [Download the Pacto Tech Utility](https://github.com/leecyrille/PactoTech_Public_Releases/releases/download/earlytesting/PactoTech-Utility-Setup.exe)

Run the installer and you're ready to go — the app updates itself from then on.
You can also browse [everything on the release page](https://github.com/leecyrille/PactoTech_Public_Releases/releases/tag/earlytesting).

> 💡 This is our **Early Testing** build — you get the newest features first.
> It's what we're inviting people to try right now, so if you spot anything
> odd, we'd love to hear about it.

## Keeping your controller up to date

**Good news: you almost never have to think about this.** Plug your controller
into your PC with its USB cable, open the Utility, and it updates the firmware
for you over that same cable. It checks your exact board first, and an
interrupted update can't harm anything — it simply picks up where it left off
the next time you power on.

**One kind of board works a little differently.** Some **2000H** and **4000H**
controllers use a smaller memory chip (the **F103VB**) that doesn't have room
for the over-the-cable update system. Those boards get their firmware through a
small **ST-Link V2** programmer instead — and the nice part is the **Utility now
does this for you, right inside the app**. No separate tools, no command line:

1. Connect an ST-Link V2 to the four pins on the board labelled
   **SWDIO / SWCLK / GND / 3V3**, and plug the ST-Link into your PC. Keep the
   board's own USB cable plugged in too (it needs its own power).
2. In the Utility, go to **Update / About**, and under **Your controller** press
   **Detect chip**, then **Flash firmware**.

That's it. The app reads your exact board and chip and flashes the matching
firmware, and your settings are kept. If your controller uses one of the larger
chips, you'll never need the ST-Link at all — it just updates over USB.

**Not sure which chip you have?** The Utility tells you. On the **Update / About**
page it names your exact board and chip (for example *"4000H (F103VB)"*), so
you always know whether it updates over USB or with an ST-Link.

## Using Pacto boards on Batocera, RetroPie, Lakka & other Linux systems

PactoLink brings Pacto boards to Linux-based emulation systems, adding:
**on-screen mode overlays** on the cabinet screen (a "4 PLAYER MODE" banner pops
up when you switch), the **full configurator in any web browser on your network**
at `http://<machine-ip>:46810`, and **keyboard / Disconnect mode** for MAME-style
play — all with no extra setup.

> **Good to know:** Batocera, RetroPie, Lakka, Knulli, ROCKNIX, MiSTer and the
> Steam Deck are all **Linux** systems, even when they don't look like it.
> Native gamepad (XInput) play on them arrives with the upcoming **"Linux mode"**
> firmware — once your board has it, set the board's USB identity to **LINUX**
> for these machines (Modes page in the configurator). Keyboard mode is the
> supported way to play until then.

### One-line install

```
curl -L https://raw.githubusercontent.com/leecyrille/PactoTech_Public_Releases/main/install.sh | sh
```

The script detects your system (Batocera / Lakka / generic Linux), downloads the
matching signed package, and installs it. On RetroPie / desktop Linux, add
`sudo` (`... | sudo sh`). Everything lands in your user storage and survives OS
updates, and each package's README has the uninstall steps.

**Where do I type that?**

- **Batocera — on the cabinet:** plug in a keyboard, press **F1** for the file
  manager, then **Tools → Open Terminal**, and paste the line.
- **Batocera — from another PC:** SSH is on by default. Find the cabinet's IP
  under **Main Menu → Network Settings**, then from any PC (on Windows 10/11,
  open PowerShell — `ssh` is built in): `ssh root@<cabinet-ip>` (password
  `linux`), and paste the line.
- **Lakka — from another PC:** turn on SSH under **Settings → Services**, find
  the IP under **Main Menu → Information → Network Information**, then
  `ssh root@<ip>` (password `root`) and paste the line.
- **RetroPie — on the machine:** press **F4** to quit to the terminal, then run
  the line with `sudo`.
- **RetroPie — from another PC:** turn on SSH (RetroPie menu → raspi-config →
  Interface Options), then `ssh pi@<ip>` (default password `raspberry`) and run
  the line with `sudo`.

### Prefer not to use a terminal? (Batocera)

Download `PactoLink-Batocera-x86_64.zip` from the
[releases page](https://github.com/leecyrille/PactoTech_Public_Releases/releases/tag/earlytesting),
extract its `roms` folder onto the cabinet's network share (`\\BATOCERA\share`,
user `root` / password `linux`), refresh the gamelists (**Main Menu → Game
Settings → Update Gamelists**), and launch **Install PactoLink** from the Ports
menu.

All PactoLink packages (PC `x86_64` plus Raspberry Pi `aarch64`, the latter
experimental) are on the releases page with signatures and
`PactoLink-SHA256SUMS.txt`.

## What's new

### 📋 [See the full changelog](https://leecyrille.github.io/PactoTech_Public_Releases/changelog.html)

---

Every file here is cryptographically signed, and the app only ever installs an
update whose signature checks out — so you can trust that a download really came
from us.
