{ config, pkgs, ... }:

{

  nixpkgs.config.allowUnfree = true;

  users.users.lhh = {
    home = "/Users/lhh";
    description = "Main user account";
  };

  environment.systemPackages = with pkgs; [
    aerospace
    cmatrix
    element-desktop
    eza
    firefox
    ffmpeg
    git
    glow
    google-chrome
    mas
    neofetch
    neovim
    nodejs
    python3
    skim
    spotify
    tree-sitter
    tmux
    typst
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

  system.activationScripts.masApps.text = ''
    echo "Installing App Store apps with mas..."
    mas install 937984704   # Amphetamine
    mas install 1289583905  # Pixelmator Pro
    mas install 1192318775  # GeoExpert – World Geography
  '';

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
      "com.apple.keyboard.fnState" = true;
    };
  };

  #Yabai stuff:
  launchd.user.agents = {
    yabai = {
      serviceConfig = {
        Program = "${pkgs.yabai}/bin/yabai";
        RunAtLoad = true;
        KeepAlive = true;
      };
    };

    skhd = {
      serviceConfig = {
        Program = "${pkgs.skhd}/bin/skhd";
        RunAtLoad = true;
        KeepAlive = true;
      };
    };
  };

  system.stateVersion = 6;
}
