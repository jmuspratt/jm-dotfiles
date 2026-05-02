#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
PLIST="/Library/Managed Preferences/net.imput.helium.plist"
EXTENSIONS_FILE="$DOTFILES_DIR/helium-extensions.txt"
UPDATE_URL="https://clients2.google.com/service/update2/crx"

FORCELIST=()
while IFS= read -r line; do
  id=$(echo "$line" | sed 's/#.*//' | tr -d '[:space:]')
  [ -n "$id" ] && FORCELIST+=("${id};${UPDATE_URL}")
done < "$EXTENSIONS_FILE"

echo "Installing Helium extensions (requires sudo)..."
if sudo defaults write "$PLIST" ExtensionInstallForcelist -array "${FORCELIST[@]}"; then
  echo "Done. Relaunch Helium to install extensions."
else
  echo "⚠️  Could not write Helium policy."
  exit 1
fi
