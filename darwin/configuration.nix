{ config, pkgs, lib, ... }: {
  system.stateVersion = 6;
  system.primaryUser = "lhh";

  imports = [ ../modules/tmux.nix ];

  users.users.lhh = {
    home = "/Users/lhh";
    description = "Main user account";
    shell = pkgs.zsh;
  };

  nix.package = pkgs.nix;

  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
    permittedInsecurePackages = [
      "electron-39.8.10"
    ];
  };

  environment.systemPackages = with pkgs; [
    # Development
    cargo
    git
    git-lfs
    lean4
    neovim
    nixfmt
    nodejs
    pyright
    rustc
    tree-sitter

    # Vim plugins
    vimPlugins.vim-dadbod
    vimPlugins.vim-dadbod-ui
    vimPlugins.vim-dadbod-completion

    # Python
    (python3.withPackages (ps: with ps; [ pandas matplotlib numpy yfinance ]))

    # Databases
    postgresql
    sqlite
    sqls
    visidata

    # Terminal
    cmatrix
    eza
    fd
    glow
    # neofetch
# neowofetch 
    skim
    tmux
    when
    wikit
    wiki-tui
    zoxide
    newsboat

    # Media
    audacity
    ffmpeg
    imagemagick
    inkscape
    sox

    # Documents
    librsvg
    mermaid-cli
    pdfarranger
    stirling-pdf
    typst

    # Desktop apps
    bitwarden
    element-desktop
    firefox
    google-chrome
    kitty
    obsidian
    spotify
    vscode

    # Other
    asciiquarium-transparent
    darwin.PowerManagement
    gnuradio
    mas
    radicale
    todoist
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    interactiveShellInit = ''
      eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"
    '';
  };

  fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];

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

  system.activationScripts.masApps.text = ''
    echo "Installing App Store apps with mas..."
    mas install 937984704   # Amphetamine
    mas install 1289583905  # Pixelmator Pro
    mas install 1192318775  # GeoExpert
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

  services.skhd.enable = true;
  services.yabai = {
    enable = true;
    enableScriptingAddition = true;
    package = pkgs.yabai;
  };

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

  security.accessibilityPrograms = [ ];
}
