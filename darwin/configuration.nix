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

  programs.aerospace = {
    enable = true;
    settings = {
      start-at-login = false;
      enable-normalization-flatten-containers = true;
      enable-normalization-opposite-orientation-for-nested-containers = true;
      accordion-padding = 30;
      default-root-container-layout = "tiles";
      default-root-container-orientation = "auto";
      on-focused-monitor-changed = [ "move-mouse monitor-lazy-center" ];
      automatically-unhide-macos-hidden-apps = false;

      after-login-command = [ ];
      after-startup-command = [ ];

      key-mapping.preset = "qwerty";

      gaps = {
        inner = {
          horizontal = 0;
          vertical = 0;
        };
        outer = {
          left = 0;
          right = 0;
          top = 0;
          bottom = 0;
        };
      };

      mode.main.binding = {
        "alt-enter" = "exec-and-forget open -na Alacritty";
        "alt-comma" = "layout tiles horizontal vertical";
        "alt-slash" = "layout accordion horizontal vertical";
        "alt-h" = "focus left";
        "alt-j" = "focus down";
        "alt-k" = "focus up";
        "alt-l" = "focus right";
        "alt-shift-h" = "move left";
        "alt-shift-j" = "move down";
        "alt-shift-k" = "move up";
        "alt-shift-l" = "move right";
        "alt-1" = "workspace 1";
        "alt-2" = "workspace 2";
        "alt-3" = "workspace 3";
        "alt-4" = "workspace 4";
        "alt-shift-1" = "move-node-to-workspace 1";
        "alt-shift-2" = "move-node-to-workspace 2";
        "alt-shift-3" = "move-node-to-workspace 3";
        "alt-shift-4" = "move-node-to-workspace 4";
        "alt-tab" = "workspace-back-and-forth";
        "alt-shift-semicolon" = "mode service";
      };

      mode.service.binding = {
        esc = [ "reload-config" "mode main" ];
        r = [ "flatten-workspace-tree" "mode main" ];
        f = [ "layout floating tiling" "mode main" ];
        backspace = [ "close-all-windows-but-current" "mode main" ];
        "alt-shift-h" = [ "join-with left" "mode main" ];
        "alt-shift-j" = [ "join-with down" "mode main" ];
        "alt-shift-k" = [ "join-with up" "mode main" ];
        "alt-shift-l" = [ "join-with right" "mode main" ];
      };
    };
  };
  services.sketchybar.enable = true;

  # Required for scripting addition
  #  security.accessibilityPrograms = [ ];
  /* launchd.daemons.aerospace = {
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
  */
  security.accessibilityPrograms = [ "${pkgs.aerospace}/bin/aerospace" ];

}
