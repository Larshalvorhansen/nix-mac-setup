# macOS Development Environment Setup

This repository provides an automated setup script for configuring a complete macOS development environment using Nix and nix-darwin.

## Installation

- Install git and clone this repo if you havent already.

- Run the following command in your terminal:
```bash
cd nix-mac-setup && ./bootstrap.command
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

To modify the installation, edit the darwin configuration files in this repository and run:

```bash
darwin-rebuild switch --flake .
```

## Repository Structure

```
.
├── .config/                    # Application configurations
│   ├── aerospace/              # Window management
│   ├── alacritty/             # Terminal emulator
│   ├── gh/                    # GitHub CLI
│   ├── neofetch/              # System info display
│   ├── nvim/                  # Neovim editor
│   ├── sketchybar/            # macOS menu bar
│   ├── skhd/                  # Hotkey daemon
│   ├── tmux/                  # Terminal multiplexer
│   └── yabai/                 # Tiling window manager
├── darwin/
│   └── configuration.nix      # nix-darwin system configuration
├── home/
│   └── lhh.nix               # Home Manager configuration
├── bootstrap.command          # Initial setup script
├── flake.nix                 # Main flake configuration
├── flake.lock                # Flake dependency lockfile
├── wallpaper.png             # Default wallpaper
└── README.md                 # This file
```

## Support

Feel free to email me if you have any problems, questions, or suggestions! I'm happy to help improve this setup.

**Contact**: [larshalvorhansen1@gmail.com](mailto:larshalvorhansen1@gmail.com)
