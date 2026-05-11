# jm-dotfiles

## Install

```bash
git clone <repo-url> ~/Sites/jm-dotfiles
cd ~/Sites/jm-dotfiles
sh install.sh
```

The script:

1. Installs Homebrew if missing
2. Runs `brew bundle` (CLI tools, casks, MAS apps)
3. Installs oh-my-zsh with the Spaceship theme
4. Applies dotfiles via chezmoi (`dot_zshrc` → `~/.zshrc`, `dot_gitconfig` → `~/.gitconfig`)

## Brewfile

### CLI tools

| Package                                          | Purpose                           |
| ------------------------------------------------ | --------------------------------- |
| `git`, `git-lfs`, `gh`                           | Git and GitHub CLI                |
| `exiftool`, `ffmpeg`, `imagemagick`, `yt-dlp`    | Media processing                  |
| `zoxide`                                         | Smarter `cd`                      |
| `zsh-autosuggestions`, `zsh-syntax-highlighting` | zsh plugins (sourced in `.zshrc`) |
| `mas`                                            | Mac App Store CLI                 |

### Casks

| Category      | Apps                                                                               |
| ------------- | ---------------------------------------------------------------------------------- |
| Browsers      | Brave, Firefox, Google Chrome                                                      |
| Dev           | Docker, Sequel Ace, VS Code                                                        |
| Design        | Acorn, Blender, Figma, Kaleidoscope, PDFpen, RightFont                             |
| Productivity  | 1Password, Granola, Notion Calendar, Obsidian, Raycast, Soulver, Todoist, Transmit |
| Communication | Discord, Slack, Zoom                                                               |
| Media         | Plex, Plexamp, VLC                                                                 |
| Utilities     | Adobe DNG Converter, Claude, NordVPN, QGIS, Sonos, Tailscope, Vienna               |

### Mac App Store

Bear, Shapr3D, Trello

> **Note:** MAS installs require signing into the App Store before running `brew bundle`.

### Manual installs

These can't be automated — install by hand after running `brew bundle`:

- **Adobe apps** — install inside Creative Cloud after the cask installs it
- **Helium browser** — no cask; download from imput.net
- **Screens 5** — MAS (cask deprecated)
- **Readwise Reader** — no cask; download from readwise.io
- Others: Cavalry, Eduard, Fastmail, Table Tool

To install packages without running the full setup script:

```bash
brew bundle
```

## Shell (`dot_zshrc`)

- Default editor: VS Code (`$EDITOR=code`)
- oh-my-zsh with Spaceship theme (battery indicator hidden)
- Plugins: `git`, `zsh-autosuggestions`, `zsh-syntax-highlighting`
- nvm for Node version management
- zoxide for smarter `cd`
- `mediaName()` — renames files in cwd by EXIF timestamp (DateTimeOriginal > MediaCreateDate > CreateDate)
- `exifstamp()` — writes DateTimeOriginal from filename (expects `YYYY-MM-DD` prefix)
- Sources `~/.zshrc.local` if present (gitignored; use for machine-specific config, aliases, tokens)

## Git (`dot_gitconfig`)

- Default branch: `main`
- Diff and merge tool: Kaleidoscope
- git-lfs configured

## After install

- Generate SSH key and add to GitHub: `ssh-keygen -t ed25519 -C 'your@email.com'`
- Sign in to VS Code Settings Sync (GitHub account)
- Create `~/.zshrc.local` for machine-specific config

## Updating dotfiles

Edit `dot_zshrc` or `dot_gitconfig`, then run:

```bash
chezmoi apply
```
