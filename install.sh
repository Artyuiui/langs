#!/bin/bash
# Installs the `langs` command. Usage: curl -fsSL https://raw.githubusercontent.com/Artyuiui/langs/main/install.sh | bash
set -euo pipefail

URL="https://raw.githubusercontent.com/Artyuiui/langs/main/langs"
DIR="${PREFIX:-/usr/local/bin}"   # /usr/local/bin is on macOS's default PATH

tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT
curl -fsSL "$URL" -o "$tmp"
chmod 755 "$tmp"

if [ -w "$DIR" ]; then SUDO=""; else SUDO="sudo"; echo "Installing to $DIR (needs your password)..."; fi
$SUDO mkdir -p "$DIR"
$SUDO mv "$tmp" "$DIR/langs"

echo "Installed: $DIR/langs"
echo "Run 'langs' inside any project folder."
