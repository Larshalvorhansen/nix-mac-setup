{ config, pkgs, lib, ... }:

{

  system.defaults = {
    mouse.scaling = 3.0;
    trackpad.TrackingSpeed = 3.0;
  };

  system.stateVersion = 6;
  system.primaryUser = "lhh";

  nixpkgs.config.allowUnfree = true;

  imports = [ ../modules/aerospace.nix ];

  users.users.lhh = {
    home = "/Users/lhh";
    description = "Main user account";
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    #bitwarden-cli  #broken
    #signal-desktop
    #vcv-rack
    aerospace
    bitwarden
    cmatrix
    element-desktop
    eza
    ffmpeg
    firefox
    git
    glow
    google-chrome
    lean4
    mas
    neofetch
    neovim
    nixfmt-classic
    nodejs
    python3
    skim
    spotify
    tmux
    tree-sitter
    typst
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
    "propresenter"
    "raspberry-pi-imager"
    "signal"
    "vcv-rack"
  ];

  system.activationScripts.masApps.text = ''
    echo "Installing App Store apps with mas..."
    mas install 937984704   # Amphetamine
    mas install 1289583905  # Pixelmator Pro
    mas install 1192318775  # GeoExpert – World Geography
  '';

  launchd.user.agents.desktopSetup = {
    serviceConfig = {
      Label = "org.nixos.desktop-setup";
      ProgramArguments = [
        "/usr/bin/osascript"
        "-e"
        ''
          tell application "Finder"
            set desktop picture to POSIX file "/Users/lhh/nix-mac-setup/wallpaper.png"
            do shell script "defaults write com.apple.finder CreateDesktop -bool false"
            do shell script "killall Finder"
          end tell
        ''
      ];
      RunAtLoad = true;
    };
  };

  fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];

  system.defaults = {
    dock = {
      autohide = true;
      orientation = "right";
      magnification = false;
      tilesize = 18;
      show-recents = false;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.0;
      persistent-apps = [ ];
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
    };
  };

  # Required for scripting addition
  security.accessibilityPrograms = [ ];
}
