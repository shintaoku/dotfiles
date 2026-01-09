# dotfiles

My dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Setup

```bash
# Initialize chezmoi with this repo
chezmoi init --source ~/git/github.com/gx14ac/dotfiles

# Apply dotfiles
chezmoi apply

# Or do both at once
chezmoi init --apply --source ~/git/github.com/gx14ac/dotfiles
```

## Usage

```bash
# Edit a file
chezmoi edit ~/.config/fish/config.fish

# See what would change
chezmoi diff

# Apply changes
chezmoi apply

# Add a new file
chezmoi add ~/.config/some/new/file

# Update from remote
chezmoi update
```

## Structure

```
dotfiles/
├── .chezmoi.toml.tmpl    # Chezmoi config template
├── dot_gdbinit           # ~/.gdbinit
├── dot_inputrc           # ~/.inputrc
├── dot_Xresources        # ~/.Xresources
└── private_dot_config/
    ├── fish/
    │   └── config.fish   # ~/.config/fish/config.fish
    ├── ghostty/
    │   └── config        # ~/.config/ghostty/config
    ├── i3/
    │   └── config        # ~/.config/i3/config
    ├── jj/
    │   └── config.toml   # ~/.config/jj/config.toml
    ├── kitty/
    │   └── kitty.conf    # ~/.config/kitty/kitty.conf
    ├── nvim/
    │   └── init.lua      # ~/.config/nvim/init.lua
    └── rofi/
        └── config.rasi   # ~/.config/rofi/config.rasi
```
