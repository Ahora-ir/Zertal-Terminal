ZERTAL TERMINAL

Custom terminal environment for Termux by Ahora-ir

A personalized Fish shell with a custom logo, colored prompt, battery status, memory and storage information.

Features

- Custom ZERTAL logo
- Colored terminal prompt
- Current time display
- Battery percentage
- Memory and storage information
- Automatic startup

Installation Guide

Follow these steps in order. Copy and run each command separately in Termux.

Step 1 — Update Termux

pkg update -y && pkg upgrade -y

Step 2 — Install required packages

pkg install -y git curl fish coreutils procps

Step 3 — Download Zertal Terminal

git clone https://github.com/Ahora-ir/Zertal-Terminal.git

Step 4 — Enter the project directory

cd Zertal-Terminal

Step 5 — Run the installer

bash install.sh

Step 6 — Restart Termux

Close Termux completely and open it again.

How It Works

Logo: Displays the ZERTAL ASCII logo when Fish starts.

Prompt: Displays the current directory and time.

Battery: Shows battery percentage when the required Android API support is available.

Memory: Displays used and total system memory.

Storage: Displays used and total storage for the home filesystem.

Automatic startup: Starts Fish automatically when a new Termux session opens.

Troubleshooting

Git clone fails: Check your internet connection and retry.

Battery percentage is missing: Check Termux:API support and whether the companion Android app is installed.

Zertal does not start automatically: Check your Bash startup configuration and verify that installation completed successfully.

Project Files

File| Description
"install.sh"| Installer
"zertal_terminal.fish"| Terminal appearance and prompt

Developer

AHORA-IR

GitHub: "Ahora-ir" (https://github.com/Ahora-ir)

Telegram: "@iD_Zertal" (https://t.me/iD_Zertal)

Rubika: "@Ahura_Zertal"


ZERTAL TERMINAL — Your terminal. Your style.
