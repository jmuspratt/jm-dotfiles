# jm-dotfiles

## Install

```bash
git clone <repo-url> ~/Sites/jm-dotfiles
cd ~/Sites/jm-dotfiles
sh install.sh
```

The script installs Homebrew, packages from the Brewfile, oh-my-zsh with the Spaceship theme, then applies dotfiles via chezmoi.

## After install

- Generate SSH key and add to GitHub: `ssh-keygen -t ed25519 -C 'your@email.com'`
- Sign in to VS Code Settings Sync (GitHub account)
- Create `~/.zshrc.local` for anything machine-specific (server aliases, private tokens, etc.) — this file is gitignored

## Updating dotfiles

Edit `dot_zshrc` or `dot_gitconfig`, then run:

```bash
chezmoi apply
```
