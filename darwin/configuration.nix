{ config, pkgs, ... }:

{

  nixpkgs.config.allowUnfree = true;

  users.users.lhh = {
    home = "/Users/lhh";
    description = "Main user account";
  };

  environment.systemPackages = with pkgs; [
    aerospace
    alacritty
    cmatrix
    element-desktop
    eza
    firefox
    ffmpeg
    git
    glow
    google-chrome
    neofetch
    neovim
    nodejs
    python3
    skim
    spotify
    tree-sitter
    tmux
    typst
    zinit
    #bitwarden-cli  #broken
    #signal-desktop
    #vcv-rack
  ];

  nix.package = pkgs.nix;
  programs.zsh.enable = true;

  # other apps...
  # Optional: disable Homebrew completely
  # homebrew.enable = false;

  #Apps that arent supported yet on apple-darwin
  homebrew.enable = true;
  homebrew.casks = [
    "ableton-live-standard"
    "chatgpt"
    "messenger"
    "minecraft"
    "raspberry-pi-imager"
    "signal"
    "vcv-rack"
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
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
    };
  };

  system.stateVersion = 6;
}
