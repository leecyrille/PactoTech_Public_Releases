# Pacto Tech — Downloads

> # ⚠️ EARLY TESTING RELEASE
>
> **Everything on this page is an _Early Testing_ (preview) build.** You're
> getting the newest features first — but this is **not** the final, polished
> release, so it may have rough edges or change as we go.
>
> It's perfect if you're happy to try new things and let us know how it goes.
> Thanks for helping us test! 🙌

Welcome! This is the home for the **Pacto Tech Utility** — the free Windows app
for setting up your Pacto arcade controller — the **firmware** that runs on the
boards, and the **PactoTech Control Test**, a full-screen input tester for
arcade cabinets. Install the Utility once and it keeps both itself and your
controller up to date for you.

## Which download do I need?

| You are… | Download this | Why |
|---|---|---|
| **A Pacto owner** (most people) | ➡️ **[Pacto Tech Utility installer](https://github.com/leecyrille/PactoTech_Public_Releases/releases/download/earlytesting/PactoTech-Utility-Setup.exe)** | Configures the board, updates the firmware, shows mode banners on screen, **and includes the full Control Test** on its *Test & Log* page (open it full screen from there). You do not need anything else. |
| **Building a cabinet or front end**, doing a lot of hardware work, or you **don't own a Pacto board (yet)** | ➡️ **[PactoTech Control Test (stand-alone zip)](https://github.com/leecyrille/PactoTech_Public_Releases/releases/download/earlytesting/PactoTech-ControlTest.zip)** | One portable `.exe` you can add to CoinOps / RetroFE / LaunchBox / any front end as a "game": every controller, mouse, trackball, light gun, keyboard and MIDI device on the PC, the XInput / DirectInput player order, polling rates, mouse speed graphs with 8-bit clipping detection, and (with a Pacto board) the arcade panel in its current mode. The zip also holds a front-end logo, a background image and a ready-made CoinOps entry. |

The Utility and the stand-alone tester have the **same test features**. The
stand-alone build exists for people who want the tester as a launchable item on
a cabinet, or who have no Pacto hardware at all — it is useful for checking any
arcade encoder, trackball or light gun.

### New to GitHub? Here is how downloading works

1. Click one of the **➡️ links above** — the file downloads straight away, like
   any other download. (No account, no sign-up, nothing to "clone".)
2. If your browser asks whether to keep the file, choose **Keep** — the files
   here are signed by us and the app only ever installs signed updates.
3. **Utility:** double-click `PactoTech-Utility-Setup.exe` and follow the
   installer. It lives in the system tray afterwards and updates itself.
4. **Control Test:** right-click `PactoTech-ControlTest.zip` → **Extract All…**,
   then double-click `PactoTech-ControlTest.exe`. It opens full screen; hold
   **ESC** (or **START+BACK** on a pad) to leave. `README.txt` inside explains
   the logo, the background and the CoinOps folder.
5. Want to see every file, older versions, or the firmware images? Open the
   [Early Testing release page](https://github.com/leecyrille/PactoTech_Public_Releases/releases/tag/earlytesting)
   and scroll down to **Assets** — that list is the downloads.

> 💡 Because this is an Early Testing build, if you spot anything odd we'd
> genuinely love to hear about it — that feedback is exactly what it's for.

## Keeping your controller up to date

**Most of the time you don't have to think about this.** Plug your controller
into your PC with its USB cable, open the Utility, and it updates the firmware
for you right over that cable — it checks your exact board first, and an
interrupted update can't harm anything (it just picks up again next power-on).

There are two times you'll reach for a small **ST-Link V2** programmer — and the
good news is the **Utility now does the ST-Link flash for you, right inside the
app**, with no separate tools and no command line:

**1. Boards on older firmware** (from before over-USB updates existed) need
**one** ST-Link flash to install the new *bootloader* — the piece that makes
updating over USB possible. **After that single flash, the board updates over
USB from then on**, and you won't need the ST-Link again.

**2. Some 2000H and 4000H boards** use a smaller memory chip (the **F103VB**)
that doesn't have room for the update system, so **those boards always update
with the ST-Link**. It's not a fault, and you're not missing anything — these
boards do **everything** the larger-chip versions do, exactly the same; the
only difference is that firmware updates come through the ST-Link rather than
over USB. If you like, you can simply **leave the ST-Link connected while you
play** — it does no harm and makes the occasional update a one-click affair.

**Doing the ST-Link flash (either case):**

1. Connect an ST-Link V2 to the four pins on the board labelled
   **SWDIO / SWCLK / GND / 3V3**, and plug the ST-Link into your PC. Keep the
   board's own USB cable plugged in too (it needs its own power).
2. In the Utility, open **Update / About**, and under **Your controller** press
   **Detect chip**, then **Flash firmware**. The app reads your exact board and
   chip and flashes the matching firmware — your settings are kept.

**Not sure which case you're in?** The Utility tells you on the **Update /
About** page: it names your exact board and chip (for example *"4000H
(F103VB)"*) and says right there whether it updates over USB or with an
ST-Link. It also lets you know whenever a new version is available.

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
