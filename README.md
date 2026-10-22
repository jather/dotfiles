# dotfiles

My configs for a Windows + WSL (Ubuntu) setup.

This one repo is cloned twice, once on each side. Each side links only its own configs:

| Folder          | Side    | Links to                         | Linked by     |
|-----------------|---------|----------------------------------|---------------|
| `zsh/`          | WSL     | `~/.zshrc`, `~/.p10k.zsh`        | `stow`        |
| `git/`          | WSL     | `~/.gitconfig`                   | `stow`        |
| `nvim/`         | WSL     | `~/.config/nvim`                 | `stow`        |
| `glazewm/`      | Windows | `~\.glzr\glazewm`                | `install.ps1` |
| `zebar/`        | Windows | `~\.glzr\zebar`                  | `install.ps1` |
| `tacky-borders/`| Windows | `~\.config\tacky-borders`        | `install.ps1` |
| `wezterm/`      | Windows | `~\.config\wezterm`              | `install.ps1` |

The links point into the repo, so editing a config in its usual place edits the repo.

## New machine

### Windows (PowerShell)

```powershell
# Apps (tacky-borders: download from its GitHub releases)
winget install Git.Git glzr-io.glazewm glzr-io.zebar wez.wezterm

# Clone and link. Do this BEFORE first launching the apps,
# otherwise they create default configs and install.ps1 skips them.
git clone https://github.com/jather/dotfiles $HOME\dotfiles
& $HOME\dotfiles\install.ps1
```

`install.ps1` creates junctions, which don't need admin rights. It is safe to re-run, because it skips anything that already exists.

### WSL

```bash
sudo apt install -y zsh stow git neovim
chsh -s $(which zsh)

# zsh plugins (loaded from ~/.zsh by .zshrc)
git clone --depth=1 https://github.com/romkatv/powerlevel10k ~/.zsh/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting

# nvm (optional)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

# Clone and link
git clone https://github.com/jather/dotfiles ~/dotfiles
cd ~/dotfiles
rm -f ~/.zshrc ~/.gitconfig   # remove defaults so stow doesn't conflict
stow zsh git nvim
```

`.gitconfig` uses `gh` for GitHub credentials. Install `gh` and run `gh auth login`.

WezTerm assumes the WSL distro is named `Ubuntu` and the Linux user is `jather`. Otherwise, edit `default_domain` and `ssh_domains` in `wezterm.lua`.

## Adding a config

- **WSL:** put it under `<app>/` mirroring its path from `~`, then `stow <app>`.
- **Windows:** move its folder into `<app>/` the same way, then add a line to `install.ps1`.

## Secrets and machine-local settings

This repo is public. Keep private stuff out of it:

- **Shell secrets** (API keys etc.) go in `~/.zshrc.local`, which `.zshrc` loads if it exists. It is untracked.
- **SSH hosts** go in WSL's `~/.ssh/config`, not in `wezterm.lua`.
- `~/.ssh/` is never in this repo.

## Notes

- **Ctrl+Shift+S** in WezTerm opens WSL over SSH, which avoids ConPTY rendering issues. It needs the Windows SSH key in WSL's `~/.ssh/authorized_keys`.
