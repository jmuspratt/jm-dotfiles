#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# ——— Homebrew ——————————————————————————————————————
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ $(uname -m) == 'arm64' ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

brew bundle --file="$DOTFILES_DIR/Brewfile"

# ——— oh-my-zsh ————————————————————————————————————
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# ——— Spaceship theme ——————————————————————————————
SPACESHIP_DIR="$HOME/.oh-my-zsh/custom/themes/spaceship-prompt"
if [ ! -d "$SPACESHIP_DIR" ]; then
  git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$SPACESHIP_DIR" --depth=1
  ln -sf "$SPACESHIP_DIR/spaceship.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/spaceship.zsh-theme"
fi

# ——— Dotfiles ——————————————————————————————————————
if ! command -v chezmoi &>/dev/null; then
  brew install chezmoi
fi

mkdir -p "$HOME/.config/chezmoi"
cat > "$HOME/.config/chezmoi/chezmoi.toml" << EOF
sourceDir = "$DOTFILES_DIR"
EOF

chezmoi init --source "$DOTFILES_DIR" --apply

echo ""
echo "Done! Restart your terminal."
echo ""
echo "Next steps:"
echo "  - Add SSH key to GitHub: ssh-keygen -t ed25519 -C 'your@email.com'"
echo "  - Sign in to VS Code Settings Sync"
echo "  - Create ~/.zshrc.local for machine-specific config"
