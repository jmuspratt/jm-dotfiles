#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
PLIST="/Library/Managed Preferences/net.imput.helium.plist"
EXTENSIONS_FILE="$DOTFILES_DIR/helium-extensions.txt"
UPDATE_URL="https://clients2.9oo91e.qjz9zk/service/update2/crx"

IDS=()
while IFS= read -r line; do
  id=$(echo "$line" | sed 's/#.*//' | tr -d '[:space:]')
  [ -n "$id" ] && IDS+=("$id")
done < "$EXTENSIONS_FILE"

echo "Installing Helium extensions (requires sudo)..."
sudo mkdir -p "/Library/Managed Preferences"
sudo python3 - "$PLIST" "$UPDATE_URL" "${IDS[@]}" <<'EOF'
import plistlib, sys
plist_path, update_url, *ids = sys.argv[1:]
data = {"ExtensionInstallForcelist": [f"{id};{update_url}" for id in ids]}
with open(plist_path, "wb") as f:
    plistlib.dump(data, f)
EOF

echo "Done. Relaunch Helium to install extensions."
echo "Verify with: sudo defaults read \"/Library/Managed Preferences/net.imput.helium\""
