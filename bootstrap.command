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
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf

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

# Clear all pinned Dock apps
defaults write com.apple.dock persistent-apps -array
killall Dock
