{ config, pkgs, lib, ... }: {
  # Core system configuration
  system.stateVersion = 6;
  system.primaryUser = "lhh";

  # Module imports
  imports = [ ../modules/yabai.nix ../modules/skhd.nix ];

  # User configuration
  users.users.lhh = {
    home = "/Users/lhh";
    description = "Main user account";
    shell = pkgs.zsh;
  };

  # Nix and package configuration
  nix.package = pkgs.nix;
  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
  };

  # System packages organized by category
  environment.systemPackages = with pkgs; [
    # Development tools
    cargo
    git
    git-lfs
    lean4
    neovim
    nixfmt-classic
    nodejs
    nodejs_20
    pyright
    rustc
    tree-sitter

    # Vim plugins for neovim
    vimPlugins.vim-dadbod
    vimPlugins.vim-dadbod-ui
    vimPlugins.vim-dadbod-completion

    # Python with data science packages
    (python3.withPackages (ps: with ps; [ pandas matplotlib numpy yfinance ]))

    # Database tools
    postgresql
    mysql80
    sqlite
    sqls
    visidata

    # Terminal utilities
    cmatrix
    eza
    fd
    glow
    neofetch
    skim
    tmux
    when
    wikit
    zoxide
    newsboat
    # handbrake

    # Media tools
    audacity
    ffmpeg
    imagemagick
    sox

    # Document tools
    librsvg
    mermaid-cli
    pdfarranger
    stirling-pdf
    texliveMedium
    texlive.combined.scheme-full
    typst

    # Desktop applications
    bitwarden
    element-desktop
    firefox
    google-chrome
    kitty
    obsidian
    spotify

    # Specialized tools
    asciiquarium-transparent
    darwin.PowerManagement
    gnuradio
    mas
    radicale
    todoist
  ];

  # Shell configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    interactiveShellInit = ''
      eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"
    '';
  };

  # Fonts
  fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];

  # Homebrew configuration
  homebrew = {
    enable = true;
    brews = [ "dark-mode" ];
    casks = [
      "ableton-live-standard"
      "chatgpt"
      "messenger"
      "propresenter"
      "raspberry-pi-imager"
      "signal"
      "vcv-rack"
    ];
  };

  # Mac App Store installations
  system.activationScripts.masApps.text = ''
    echo "Installing App Store apps with mas..."
    mas install 937984704   # Amphetamine
    mas install 1289583905  # Pixelmator Pro
    mas install 1192318775  # GeoExpert – World Geography
  '';

  # Desktop appearance configuration
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

  # Window management
  services.skhd.enable = true;
  services.yabai = {
    enable = true;
    enableScriptingAddition = true;
    package = pkgs.yabai;
  };

  # macOS system defaults
  system.defaults = {
    dock = {
      autohide = true;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.0;
      orientation = "right";
      magnification = false;
      tilesize = 18;
      show-recents = false;
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

  # Accessibility for yabai scripting addition
  security.accessibilityPrograms = [ ];
}
