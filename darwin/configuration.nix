{ config, pkgs, ... }:

{
  system.stateVersion = 6;

  system.primaryUser = "lhh";

  nixpkgs.config.allowUnfree = true;

  users.users.lhh = {
    home = "/Users/lhh";
    description = "Main user account";
    shell = pkgs.zsh;
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
    lean4
    mas
    neofetch
    neovim
    nixfmt
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

  services.aerospace.enable = true; # Enable AeroSpace window manager at login
  services.aerospace.package =
    pkgs.aerospace; # (Optional) specify package; defaults to pkgs.aerospace [oai_citation:4‡nix-darwin.github.io](https://nix-darwin.github.io/nix-darwin/manual/#:~:text=%60%20%3Cnix)

  /* #Yabai stuff:
     services.yabai = {
       enable = true;
       enableScriptingAddition = true;
       package = pkgs.yabai;
       config = {
         layout = "bsp";
         window_placement = "second_child";
         mouse_follows_focus = "on";
         focus_follows_mouse = "autoraise";
       };
     };

     services.skhd = {
       enable = true;
       package = pkgs.skhd;
     };
  */
  services.sketchybar.enable = true;

  # Required for scripting addition
  #  security.accessibilityPrograms = [ ];

  launchd.daemons.aerospace = {
    enable = true;
    serviceConfig = {
      Label = "org.nixos.aerospace";
      ProgramArguments = [ "${pkgs.aerospace}/bin/aerospace" ];
      RunAtLoad = true;
      KeepAlive = true;
      StandardOutPath = "/tmp/aerospace.out";
      StandardErrorPath = "/tmp/aerospace.err";
    };
  };

  security.accessibilityPrograms = [ "${pkgs.aerospace}/bin/aerospace" ];

}
