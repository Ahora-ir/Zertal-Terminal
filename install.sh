#!/data/data/com.termux/files/usr/bin/bash

# ==========================================
# Zertal Terminal
# Copyright (c) Ahora-ir
# ==========================================

set -eu

REPO="https://raw.githubusercontent.com/Ahora-ir/Zertal-Terminal/main"
CONFIG_DIR="$HOME/.config/fish"
CONFIG_FILE="$CONFIG_DIR/zertal_terminal.fish"
BACKUP_DIR="$HOME/.config/zertal-backups/$(date +%Y%m%d-%H%M%S)"

if [ -z "${PREFIX:-}" ] || [ ! -d "$PREFIX" ]; then
    echo "Error: This installer is designed for Termux."
    exit 1
fi

echo "================================"
echo "       ZERTAL INSTALLER"
echo "================================"

pkg update -y
pkg install -y fish curl

mkdir -p "$CONFIG_DIR" "$BACKUP_DIR"

if [ -f "$CONFIG_FILE" ]; then
    cp "$CONFIG_FILE" "$BACKUP_DIR/"
    echo "Previous Zertal configuration backed up."
fi

TMP_FILE="$(mktemp)"
trap 'rm -f "$TMP_FILE"' EXIT

curl -fLsS "$REPO/zertal_terminal.fish" -o "$TMP_FILE"

if [ ! -s "$TMP_FILE" ]; then
    echo "Error: Could not download Zertal configuration."
    exit 1
fi

cp "$TMP_FILE" "$CONFIG_FILE"

touch "$HOME/.hushlogin"

if ! grep -Fq 'exec fish' "$HOME/.bashrc" 2>/dev/null; then
    printf '\n# Start Zertal Terminal\nif [ -t 0 ] && [ -z "${ZERTAL_STARTED:-}" ]; then\n  export ZERTAL_STARTED=1\n  exec fish\nfi\n' >> "$HOME/.bashrc"
fi

echo
echo "Zertal Terminal installed successfully!"
echo "Close and reopen Termux to start."
echo
