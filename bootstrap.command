#!/bin/bash

set -euo pipefail

if ! command -v nix >/dev/null 2>&1; then
  curl -L https://nixos.org/nix/install | sh -s -- --daemon
fi

if [ -f "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" ]; then
  . "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
fi

mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf

if [ -f /etc/bashrc ] && [ ! -f /etc/bashrc.before-nix-darwin ]; then
  sudo mv /etc/bashrc /etc/bashrc.before-nix-darwin
fi

if ! command -v brew >/dev/null 2>&1; then
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if ! command -v git >/dev/null 2>&1; then
  brew install git
fi

if [ ! -d "$HOME/nix-mac-setup" ]; then
  git clone https://github.com/Larshalvorhansen/nix-mac-setup.git "$HOME/nix-mac-setup"
fi

nix --extra-experimental-features "nix-command flakes" \
  run github:lnl7/nix-darwin -- switch \
  --flake "$HOME/nix-mac-setup#lhh-macbook" \
  --show-trace -vvvv