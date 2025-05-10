{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    tmux
    python3
    cmatrix
    typst
    eza
    neofetch
    ffmpeg
    glow
  ];

  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  programs.zsh.enable = true;

  homebrew.enable = true;
  homebrew.casks = [
    "ableton-live-standard"
    "aerospace"
    "alacritty"
    "bitwarden"
    "chatgpt"
    "element"
    "firefox"
    "google-chrome"
    "messenger"
    "minecraft"
    "pixelmator-pro"
    "raspberry-pi-imager"
    "rectangle"
    "signal"
    "skim"
    "spotify"
    "vcv-rack"
    "balenaetcher"
  ];

  system.defaults = {
    dock.autohide = true;
    dock.orientation = "left";
    dock.magnification = false;
    finder.AppleShowAllFiles = true;
    NSGlobalDomain.AppleKeyboardUIMode = 3;
    NSGlobalDomain."com.apple.keyboard.fnState" = true;
    NSGlobalDomain."com.apple.controlcenter" = {
      "NSStatusItem Visible Brightness" = false;
    };
    notification."com.apple.ncprefs".doNotDisturb = true;
  };
}
