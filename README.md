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
`PactoTech-<BOARD>-STLink-Full.bin` per board model:

1. Connect an ST-Link V2 to the board's SWD header (SWDIO / SWCLK / GND / 3V3).
2. Flash the file for **your board model** at address `0x08000000` (with
   [STM32CubeProgrammer](https://www.st.com/en/development-tools/stm32cubeprog.html)
   or `st-flash write PactoTech-4000T-STLink-Full.bin 0x8000000`).
3. Done — every future update happens inside the Utility app.

The `firmware/` folder and `manifests/` are the machine-readable index the
app uses; you don't need them directly.

## Release notes

**[📋 What's new — full changelog](https://leecyrille.github.io/PactoTech_Public_Releases/changelog.html)**

---
All artifacts here are cryptographically signed (minisign). The app only
installs updates whose signatures verify against its built-in public key.
