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

## Release notes

**[📋 What's new — full changelog](https://leecyrille.github.io/PactoTech_Public_Releases/changelog.html)**

---
All artifacts here are cryptographically signed (minisign). The app only
installs updates whose signatures verify against its built-in public key.
