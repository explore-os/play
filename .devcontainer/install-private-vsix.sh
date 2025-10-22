#!/usr/bin/env bash
set -euo pipefail

VSIX_PATH="/ext/teleprompt-eos.vsix}"

SERVER_DIR="${VSCODE_AGENT_FOLDER:-$HOME/.vscode-server}"
[ -d "$HOME/.vscode-server-insiders" ] && SERVER_DIR="$HOME/.vscode-server-insiders"
[ -d "$HOME/.vscode-oss" ] && SERVER_DIR="$HOME/.vscode-oss"

EXT_DIR="$SERVER_DIR/extensions"
mkdir -p "$EXT_DIR"

TMP_DIR="$(mktemp -d)"
unzip -q "$VSIX_PATH" -d "$TMP_DIR"

PKG="$TMP_DIR/extension/package.json"
publisher=$(grep -oP '"publisher"\s*:\s*"\K[^"]+' "$PKG")
name=$(grep -oP '"name"\s*:\s*"\K[^"]+' "$PKG")
version=$(grep -oP '"version"\s*:\s*"\K[^"]+' "$PKG")

TARGET="$EXT_DIR/${publisher}.${name}-${version}"
rm -rf "$TARGET"
mkdir -p "$TARGET"

rsync -a "$TMP_DIR/extension/" "$TARGET/"

echo "installed from vsix on $(date -u)" > "$TARGET/.installdate"

rm -rf "$TMP_DIR"

echo "Installed ${publisher}.${name} ${version} into $TARGET"