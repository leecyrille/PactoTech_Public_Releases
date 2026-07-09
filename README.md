# Pacto Tech — Public Releases

Official downloads for the **Pacto Tech Utility** app and **Pacto arcade
encoder firmware**. This repository hosts release binaries, signatures,
version manifests, and the customer changelog — nothing else.

## Downloads (permalinks)

These links never change — each one always serves the latest build of its
channel. **Stable** is what we recommend for everyday use; **Beta** gets
nearly-finished features; **Early Testing** is the newest work and may have
rough edges.

| Channel | App installer (Windows) | All files |
|---|---|---|
| **Stable** | [PactoTech-Utility-Setup.exe](https://github.com/leecyrille/PactoTech_Public_Releases/releases/download/stable/PactoTech-Utility-Setup.exe) | [release page](https://github.com/leecyrille/PactoTech_Public_Releases/releases/tag/stable) |
| **Beta** | [PactoTech-Utility-Setup.exe](https://github.com/leecyrille/PactoTech_Public_Releases/releases/download/beta/PactoTech-Utility-Setup.exe) | [release page](https://github.com/leecyrille/PactoTech_Public_Releases/releases/tag/beta) |
| **Early Testing** | [PactoTech-Utility-Setup.exe](https://github.com/leecyrille/PactoTech_Public_Releases/releases/download/earlytesting/PactoTech-Utility-Setup.exe) | [release page](https://github.com/leecyrille/PactoTech_Public_Releases/releases/tag/earlytesting) |

*(A link is live once its channel has had a release — see the
[changelog](https://leecyrille.github.io/PactoTech_Public_Releases/changelog.html)
for what has shipped where.)*

The app updates itself, and the channel is a setting inside the app
(App Options → Update channel) — install once from any link above and switch
channels without reinstalling.

## Firmware

Normally you never download firmware by hand: the **Utility app updates your
board over USB** (it checks your exact board model and verifies every
download's signature before a single byte is flashed, and an interrupted
update can't brick the board — it simply resumes on the next power-up).

**One exception — the one-time upgrade to the updatable firmware.** Boards
shipped before in-app updates existed need a single flash with an ST-Link
programmer to install the new bootloader. Each channel's release page hosts a
`PactoTech-<BOARD>-<MCU>-STLink-Full.bin` per board **and chip**:

| Your board | Chip marking on the big square IC | File to flash |
|---|---|---|
| 1000T / 2000T / 3000T / 4000T / SNAP2 / SNAP4 | STM32F103**VC**T6 | `PactoTech-<BOARD>-F103VC-STLink-Full.bin` |
| 2000H / 4000H | STM32F103**VC**T6 | `PactoTech-<BOARD>-F103VC-STLink-Full.bin` |
| 2000H / 4000H | STM32F103**VB**T6 | `PactoTech-<BOARD>-F103VB-STLink-Full.bin` |
| 4000H2 | STM32F103**ZE**T6 | `PactoTech-4000H2-F103ZE-STLink-Full.bin` |

Most boards use the F103**VC** chip — check the marking on the main square
chip if your 2000H/4000H is from a batch that used the F103**VB**. Every
image is target-locked: the firmware and the Utility both refuse a file
built for a different board or chip, so a mix-up can't damage anything —
it just won't apply.

**The easy way — the Utility does it for you.** Install the Pacto Tech
Utility, open its firmware section, and use **"Flash with ST-Link"**:

1. Connect an ST-Link V2 to the board's SWD header (SWDIO / SWCLK / GND / 3V3)
   and plug the ST-Link into the PC.
2. Pick your board model and press **Detect chip** — the Utility reads the
   chip itself, so it always downloads the right image for your exact
   hardware.
3. Press **Flash firmware**. Done — every future update happens inside the
   app (F103VC / F103ZE boards).

You never need to download firmware files by hand. If you prefer manual
tools, the same images can be flashed at address `0x08000000` with
[STM32CubeProgrammer](https://www.st.com/en/development-tools/stm32cubeprog.html)
or `st-flash write PactoTech-4000T-F103VC-STLink-Full.bin 0x8000000`.

*Note for F103VB boards (some 2000H/4000H): that chip has a smaller memory
with no room for the update system, so those boards always update via
ST-Link — the Utility will tell you when a new version is available for
them.*

The `firmware/` folder and `manifests/` are the machine-readable index the
app uses; you don't need them directly.

## Batocera, RetroPie & Lakka (they're all Linux)

PactoLink brings Pacto boards to Linux-based emulation systems: **on-screen
mode overlays** on the cabinet screen (PC/x86 Batocera; RetroArch messages
in-game elsewhere), the **full configurator served to any browser on your
network** at `http://<machine-ip>:46810`, and **keyboard/Disconnect mode**
for MAME-style play with zero setup.

> **Good to know:** Batocera, RetroPie, Lakka, Knulli, ROCKNIX, MiSTer and
> the Steam Deck are all **Linux** systems, even when they don't look like
> it. Native gamepad (XInput) play on them arrives with the upcoming
> **"Linux mode"** firmware update — when your board has it, set the
> board's USB identity to **LINUX** for these machines (Modes page in the
> configurator). Keyboard mode is the supported way to play until then.

### One-line install

```
curl -L https://raw.githubusercontent.com/leecyrille/PactoTech_Public_Releases/main/install.sh | sh
```

The script detects your system (Batocera / Lakka / generic Linux), downloads
the matching signed package from Early Testing, and installs it. On
RetroPie/desktop Linux run it with `sudo` (`... | sudo sh`). Everything lands
in user storage and survives OS updates; each package's README has the
uninstall steps.

**Where do I type that?**

- **Batocera — on the cabinet:** plug in a keyboard, press **F1** to open
  the file manager, then **Tools → Open Terminal**, and paste the line.
- **Batocera — from another PC (remote):** SSH is on by default. Find the
  cabinet's IP under **MAIN MENU → NETWORK SETTINGS**, then from any PC
  (Windows 10/11: PowerShell — `ssh` is built in):
  `ssh root@<cabinet-ip>` (password `linux`), then paste the line.
- **Lakka — from another PC:** enable SSH under **Settings → Services**,
  find the IP under **Main Menu → Information → Network Information**, then
  `ssh root@<ip>` (password `root`) and paste the line.
- **RetroPie — on the machine:** press **F4** to quit EmulationStation to
  the terminal, type the line with `sudo`.
- **RetroPie — from another PC (remote):** enable SSH (RetroPie menu →
  raspi-config → Interface Options, or place a file named `ssh` on the boot
  partition), then `ssh pi@<ip>` (default password `raspberry`) and run the
  line with `sudo`.

### No terminal? (Batocera)

Download `PactoLink-Batocera-x86_64.zip` from
[Early Testing](https://github.com/leecyrille/PactoTech_Public_Releases/releases/tag/earlytesting),
extract its `roms` folder onto the cabinet's network share
(`\\BATOCERA\share`, user `root` / password `linux`), refresh gamelists
(MAIN MENU → GAME SETTINGS → UPDATE GAMELISTS), and launch
**Install PactoLink** from the Ports menu.

All PactoLink packages (x86_64 + Raspberry Pi `aarch64`, the latter
experimental) are on the Early Testing release with signatures and
`PactoLink-SHA256SUMS.txt`.

## Release notes

**[📋 What's new — full changelog](https://leecyrille.github.io/PactoTech_Public_Releases/changelog.html)**

---
All artifacts here are cryptographically signed (minisign). The app only
installs updates whose signatures verify against its built-in public key.
