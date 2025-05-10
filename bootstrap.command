#!/bin/bash

set -e

echo "Installing Nix..."
curl -L https://nixos.org/nix/install | sh

# Load nix command
. ~/.nix-profile/etc/profile.d/nix.sh

echo "Cloning flake repo..."
cd ~
git clone https://github.com/yourusername/nix-mac-setup.git
cd nix-mac-setup

echo "Running darwin-rebuild..."
darwin-rebuild switch --flake .#lhh-macbook

echo "Done. Welcome back Lars Halvor!(or anoyone else willing to try out my flake! <3)"
