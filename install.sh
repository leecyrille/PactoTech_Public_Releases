#!/bin/sh
# PactoLink one-line installer for Linux emulation systems (Early Testing).
#
#   curl -L https://raw.githubusercontent.com/leecyrille/PactoTech_Public_Releases/main/install.sh | sh
#
# Detects Batocera / Lakka / generic Linux (RetroPie, Debian, Ubuntu,
# Raspberry Pi OS), downloads the matching signed package from the
# Early Testing release, and runs its installer. Everything lands in user
# storage (Batocera /userdata, Lakka /storage, generic /usr/local) - see the
# per-platform READMEs in the packages. Uninstall notes are printed at the
# end and live in the README of each package.
#
# This file is maintained in the PactoTech firmware repo and published to
# the releases repo root; the packages it downloads are minisign-signed
# (PactoLink-SHA256SUMS.txt[.sig] on the release page).
set -e

BASE="https://github.com/leecyrille/PactoTech_Public_Releases/releases/download/earlytesting"

say() { printf '%s\n' "== $*"; }
die() { printf '%s\n' "!! $*" >&2; exit 1; }

ARCH=$(uname -m)
case "$ARCH" in
    x86_64)          A=x86_64 ;;
    aarch64|arm64)   A=aarch64 ;;   # Pi-class builds are EXPERIMENTAL
    *) die "unsupported architecture: $ARCH (x86_64 and aarch64 only)" ;;
esac

dl() { # url dest
    if command -v curl >/dev/null 2>&1; then
        curl -L -f -s -S -o "$2" "$1"
    else
        wget -q -O "$2" "$1"
    fi
}

OS=$(grep -is '^NAME=' /etc/os-release 2>/dev/null | head -1)

case "$OS" in
    *[Bb]atocera*)
        say "Batocera detected ($A)"
        T=/userdata/pactolink-setup
        mkdir -p "$T"
        say "downloading PactoLink-Batocera-$A.zip"
        dl "$BASE/PactoLink-Batocera-$A.zip" "$T/pactolink.zip"
        # lands the installer in the Ports menu too (handy for re-installs)
        unzip -o -q "$T/pactolink.zip" -d /userdata "roms/*"
        rm -f "$T/pactolink.zip"
        say "running the installer"
        bash "/userdata/roms/ports/Install PactoLink.sh"
        say "done - PACTOLINK INSTALLED should pop on the cabinet screen."
        IP=$(ip -4 addr show scope global 2>/dev/null | sed -n 's/.*inet \([0-9.]*\).*/\1/p' | head -1)
        say "Configurator: http://${IP:-<cabinet-ip>}:46810"
        say "(An 'Install PactoLink' entry now also lives in the Ports menu"
        say " after MAIN MENU -> GAME SETTINGS -> UPDATE GAMELISTS.)"
        ;;
    *[Ll]akka*)
        say "Lakka detected ($A)"
        T=/storage/pactolink-setup
        mkdir -p "$T"
        say "downloading PactoLink-Lakka-$A.zip"
        dl "$BASE/PactoLink-Lakka-$A.zip" "$T/pactolink.zip"
        unzip -o -q "$T/pactolink.zip" -d "$T"
        rm -f "$T/pactolink.zip"
        say "running the installer"
        sh "$T/install.sh"
        ;;
    *)
        say "generic Linux detected ($A) - RetroPie / Debian / Ubuntu path"
        [ "$(id -u)" = "0" ] || die "please run as root:  curl -L .../install.sh | sudo sh"
        T=$(mktemp -d)
        say "downloading PactoLink-Linux-$A.tar.gz"
        dl "$BASE/PactoLink-Linux-$A.tar.gz" "$T/pactolink.tar.gz"
        tar xzf "$T/pactolink.tar.gz" -C "$T"
        say "running the installer"
        (cd "$T/pactolink" && ./install.sh)
        rm -rf "$T"
        ;;
esac
