# My personal developement setup

![nix-lambdasimLogo](logo.png "Lambda-nix")

This repository provides an automated setup script for configuring a complete macOS development environment using Nix and nix-darwin.

## Installation

- Install git and clone this repo if you havent already.

- Run the following command in your terminal:
```bash
sudo ./nix-mac-setup/bootstrap.command
```

- Install nixDarwin for using nix on macOS
```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz home-manager
nix-channel --update
```

- Build and switch to the flake
```bash
sudo nix --extra-experimental-features "nix-command flakes" run nix-darwin -- switch --flake ./nix-mac-setup
```

and use this for casual updates:
```bash
sudo darwin-rebuild switch --flake .#lhh
```

_Note: The script may also be available via curl - check the repository for the latest installation method._

## What Gets Installed

The installation script will automatically install and configure the following:

### Core Tools

- **Nix** - The Nix package manager
- **nix-darwin** - Nix-based system configuration for macOS
- **Git** - Version control system

### Configuration

- Enable experimental Nix features
- Download this repository from GitHub
- Run `nix run nix-darwin -- switch --flake .` to apply the configuration

### Software Installation

Various software packages will be installed as defined in the darwin configuration file, including:

- **Aerospace** - Window management system
- **Alacritty** - Modern terminal emulator
- **Neovim** - Advanced text editor
- **SketchyBar** - Customizable macOS menu bar
- **SKHD** - Hotkey daemon for keyboard shortcuts
- **Tmux** - Terminal multiplexer
- **Yabai** - Tiling window manager
- **GitHub CLI** - Command-line interface for GitHub

### macOS System Settings

The script will configure several macOS system preferences:

- Wallpaper
- Dock settings
- Language preferences
- Time and date settings

## Getting Started

After installation, your macOS system will be configured with a reproducible development environment managed by Nix.

## Customization

It's recomended to modify the name of the configuration to something else. Im using my initials lhh but you can change it to whatwver you would like by doing the following:
```nix
file: flake.nix
line 32:      darwinConfigurations."YOURE-NAME" = darwin.lib.darwinSystem {

```

```bash
sudo darwin-rebuild switch --flake .#YOUR-NAME
```

## Repository Structure

```
📁 .
├── 📄 bootstrap.command
├── 📁 darwin
│   ├── 📄 configuration.nix
│   ├── 📁 nix-modules
│   │   └── 📄 aerospace.nix
│   └── 📄 result
├── ❄️ flake.lock
├── ❄️ flake.nix
├── 🏠 home
│   └── 📄 lhh.nix
├── 🖼️ logo.png
├── 📘 README.md
└── 🖼️ wallpaper.png
```

## Support

Feel free to use this setup yourself. Please email me if you have any problems, questions or suggestions! 
I would be happy to improve this setup.

**Contact**: [larshalvorhansen1@gmail.com](mailto:larshalvorhansen1@gmail.com)
