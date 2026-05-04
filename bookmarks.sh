#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
CANONICAL="$DOTFILES_DIR/bookmarks/helium.json"
HELIUM_DIR="$HOME/Library/Application Support/net.imput.helium"
PROFILES=("Default" "Profile 1" "Profile 2")

# ——— Guard ————————————————————————————————————————————
if pgrep -xq "Helium"; then
  echo "Helium is running. Quit it first." >&2
  exit 1
fi

# ——— Commands —————————————————————————————————————————
cmd="${1:-help}"

case "$cmd" in
  push)
    # Copy canonical bookmarks → all profiles
    for profile in "${PROFILES[@]}"; do
      dest="$HELIUM_DIR/$profile/Bookmarks"
      if [[ -d "$HELIUM_DIR/$profile" ]]; then
        cp "$CANONICAL" "$dest"
        echo "  → $profile"
      fi
    done
    echo "Done. Launch Helium to apply."
    ;;

  pull)
    # Capture Default profile → canonical source
    src="$HELIUM_DIR/Default/Bookmarks"
    cp "$src" "$CANONICAL"
    echo "Captured Default → bookmarks/helium.json"
    echo "Review with: git diff bookmarks/helium.json"
    ;;

  diff)
    diff <(python3 -m json.tool "$CANONICAL") \
         <(python3 -m json.tool "$HELIUM_DIR/Default/Bookmarks") \
      && echo "No differences."
    ;;

  *)
    echo "Usage: $0 <command>"
    echo ""
    echo "  push   Copy bookmarks/helium.json to all Helium profiles"
    echo "  pull   Capture Default profile back to bookmarks/helium.json"
    echo "  diff   Compare canonical source against Default profile"
    ;;
esac
