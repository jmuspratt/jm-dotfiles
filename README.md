# jm-dotfiles

## Install

```bash
git clone <repo-url> ~/Sites/jm-dotfiles
cd ~/Sites/jm-dotfiles
sh install.sh
```

The script installs Homebrew, packages from the Brewfile, oh-my-zsh with the Spaceship theme, then applies dotfiles via chezmoi.

## Brewfile

[Brewfile](Brewfile) covers CLI tools, casks (browsers, dev tools, design, productivity, communication, media, utilities), and Mac App Store apps via `mas`.

To install packages without running the full setup script:

```bash
brew bundle
```

> **Note:** MAS installs require you to be signed into the App Store first. A small number of apps can't be automated — see the comments at the bottom of the Brewfile for manual install instructions.

## After install

- Generate SSH key and add to GitHub: `ssh-keygen -t ed25519 -C 'your@email.com'`
- Sign in to VS Code Settings Sync (GitHub account)
- Create `~/.zshrc.local` for anything machine-specific (server aliases, private tokens, etc.) — this file is gitignored

## Updating dotfiles

Edit `dot_zshrc` or `dot_gitconfig`, then run:

```bash
chezmoi apply
```
