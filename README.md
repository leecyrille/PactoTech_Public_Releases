# Pacto Tech — Public Releases

Official downloads for the **Pacto Tech Utility** app and **controller
firmware**. This repository hosts release binaries, signatures, version
manifests, and the customer changelog — nothing else.

## Download

**[⬇ Pacto Tech Utility for Windows (latest production)](https://github.com/leecyrille/PactoTech_Public_Releases/releases/download/app-production/PactoTech-Utility-Setup.exe)**

*(link becomes active with the first production release)*

## Release notes

**[📋 What's new — full changelog](https://leecyrille.github.io/PactoTech_Public_Releases/changelog.html)**

## Firmware

Firmware updates are installed from inside the Pacto Tech Utility app
(About → firmware update). The app verifies every download's signature
before flashing. Binaries under `firmware/` are indexed by
`manifests/firmware-production.json` / `firmware-beta.json`.

---
All artifacts here are cryptographically signed. The app only installs
updates whose signatures verify against its built-in public key.
