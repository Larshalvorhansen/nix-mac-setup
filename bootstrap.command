#!/bin/bash

set -euo pipefail

# Install Nix if missing
if ! command -v nix >/dev/null 2>&1; then
  curl -L https://nixos.org/nix/install | sh -s -- --daemon
fi

# Source Nix profile
if [ -f "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" ]; then
  . "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
fi

# Enable flakes and nix-command
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >~/.config/nix/nix.conf

# Backup /etc/bashrc if needed
if [ -f /etc/bashrc ] && [ ! -f /etc/bashrc.before-nix-darwin ]; then
  sudo mv /etc/bashrc /etc/bashrc.before-nix-darwin
fi

# Install Homebrew if missing (still useful for other things)
if ! command -v brew >/dev/null 2>&1; then
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Clone repo using temporary git via nix if needed
if ! command -v git >/dev/null 2>&1; then
  nix-shell -p git --run "git clone https://github.com/Larshalvorhansen/nix-mac-setup.git \"$HOME/nix-mac-setup\""
else
  if [ ! -d "$HOME/nix-mac-setup" ]; then
    git clone https://github.com/Larshalvorhansen/nix-mac-setup.git "$HOME/nix-mac-setup"
  fi
fi

# Run nix-darwin switch
nix --extra-experimental-features "nix-command flakes" \
  run github:lnl7/nix-darwin -- switch \
  --flake "$HOME/nix-mac-setup#lhh-macbook" \
  --show-trace -vvvv

# Set global git identity
git config --global user.name "larshalvorhansen"
git config --global user.email "larshalvorhansen1@gmail.com"

# Configure dock
defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock tilesize -int 18
defaults write com.apple.dock orientation -string "right"
killall Dock

osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/Users/lhh/nix-mac-setup/wallpaper.png"'

sudo scutil --set HostName lhh

echo "Setup complete"
