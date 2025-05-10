{ config, pkgs, ... }:

{
  users.users.lhh = {
    home = "/Users/lhh";
    description = "Main user account";
  };

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
    neovim
  ];

  nix.package = pkgs.nix;
  programs.zsh.enable = true;

  homebrew.enable = true;
  homebrew.casks = [
    "ableton-live-standard"
#    "aerospace"
    "alacritty"
    "bitwarden"
    "chatgpt"
    "element"
    "firefox"
    "google-chrome"
    "messenger"
    "minecraft"
 #   "pixelmator-pro"
    "raspberry-pi-imager"
    "signal"
    "skim"
    "spotify"
    "vcv-rack"
#    "balenaetcher"
  ];

  system.defaults = {
    dock = {
      autohide = true;
      orientation = "right";
      magnification = false;
      tilesize = 18;
      show-recents = false;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.0;
      persistent-apps = [];
    };

    finder.AppleShowAllFiles = true;

    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleKeyboardUIMode = 3;
      AppleShowAllExtensions = true;
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      NSAutomaticWindowAnimationsEnabled = false;
      NSDocumentSaveNewDocumentsToCloud = false;
      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;
      PMPrintingExpandedStateForPrint = true;
      PMPrintingExpandedStateForPrint2 = true;
      _HIHideMenuBar = true;
      "com.apple.keyboard.fnState" = true;
      #reduceMotion = true;
    };
  };

  system.stateVersion = 6;
}
