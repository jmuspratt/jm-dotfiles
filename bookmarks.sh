#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
HELIUM_DIR="$HOME/Library/Application Support/net.imput.helium"

declare -A PROFILES=(
  [personal]="Default"
  [work]="Profile 1"
  [social]="Profile 2"
)

# ——— Guard ————————————————————————————————————————————
if pgrep -xq "Helium"; then
  echo "Helium is running. Quit it first." >&2
  exit 1
fi

# ——— Commands —————————————————————————————————————————
cmd="${1:-help}"

case "$cmd" in
  push)
    for name in "${!PROFILES[@]}"; do
      dir="${PROFILES[$name]}"
      src="$DOTFILES_DIR/bookmarks/helium-$name.json"
      dest="$HELIUM_DIR/$dir/Bookmarks"
      if [[ -f "$src" && -d "$HELIUM_DIR/$dir" ]]; then
        cp "$src" "$dest"
        echo "  → $name ($dir)"
      fi
    done
    echo "Done. Launch Helium to apply."
    ;;

  pull)
    for name in "${!PROFILES[@]}"; do
      dir="${PROFILES[$name]}"
      src="$HELIUM_DIR/$dir/Bookmarks"
      dest="$DOTFILES_DIR/bookmarks/helium-$name.json"
      if [[ -f "$src" ]]; then
        cp "$src" "$dest"
        echo "  ← $name ($dir)"
      fi
    done
    echo "Done. Review with: git diff bookmarks/"
    ;;

  diff)
    for name in "${!PROFILES[@]}"; do
      dir="${PROFILES[$name]}"
      canonical="$DOTFILES_DIR/bookmarks/helium-$name.json"
      live="$HELIUM_DIR/$dir/Bookmarks"
      echo "=== $name ==="
      diff <(python3 -m json.tool "$canonical") \
           <(python3 -m json.tool "$live") \
        && echo "  No differences."
    done
    ;;

  *)
    echo "Usage: $0 <command>"
    echo ""
    echo "  push   Copy all canonical bookmarks → Helium profiles"
    echo "  pull   Capture all Helium profiles → bookmarks/"
    echo "  diff   Compare canonical files against live profiles"
    ;;
esac
