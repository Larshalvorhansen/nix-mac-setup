{
  config,
  pkgs,
  lib,
  ...
}:
{
  system.stateVersion = 6;
  system.primaryUser = "lhh";

  imports = [ ../modules/tmux.nix ];

  users.users.lhh = {
    home = "/Users/lhh";
    description = "Main user account";
    shell = pkgs.zsh;
  };

  nix.package = pkgs.nix;
  nix.enable = false;
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
    (python3.withPackages (
      ps: with ps; [
        pandas
        matplotlib
        numpy
        yfinance
      ]
    ))

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
    fastfetch
    rbw
    pinentry_mac
    skim
    tmux
    when
    wikit
    wiki-tui
    zoxide
    newsboat

    # Media
    audacity
    #davinci-resolve
    ffmpeg
    imagemagick
    inkscape
    sox

    # Documents
    pandoc
    librsvg
    mermaid-cli
    pdfarranger
    stirling-pdf
    typst
    typst-live

    # Desktop apps
    element-desktop
    firefox
    google-chrome
    kitty
    obsidian
    signal-desktop
    spotify
    teams
    vscode
    wireshark

    # Window management
    aerospace
    sketchybar

    # Other
    asciiquarium-transparent
    mas
    radicale
    todoist
  ];

  homebrew = {
    enable = true;
    casks = [
      "xquartz"
    ];
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    interactiveShellInit = ''
      eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"
    '';
  };

  fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];

  system.activationScripts.masApps.text = ''
    echo "Installing App Store apps with mas..."
    mas install 937984704   # Amphetamine
    mas install 1289583905  # Pixelmator Pro
    mas install 1192318775  # GeoExpert
  '';

  # Write AeroSpace config declaratively
  system.activationScripts.aerospaceConfig.text = ''
    mkdir -p /Users/lhh/.config/aerospace
    cat > /Users/lhh/.config/aerospace/aerospace.toml << 'EOF'
    accordion-padding = 120
    after-login-command = []
    after-startup-command = ["exec-and-forget sketchybar"]
    automatically-unhide-macos-hidden-apps = false
    default-root-container-layout = "tiles"
    default-root-container-orientation = "auto"
    enable-normalization-flatten-containers = true
    enable-normalization-opposite-orientation-for-nested-containers = true
    exec-on-workspace-change = ["exec-and-forget sketchybar --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE", "exec-and-forget borders active_color=0xffe1e3e4 inactive_color=0xff494d64 width=0"]
    on-focused-monitor-changed = ["move-mouse monitor-lazy-center"]
    start-at-login = false

    [gaps.inner]
    horizontal = [{ monitor = { main = 16 } }, 6]

    [gaps.outer]
    bottom = [{ monitor = { main = 40 } }, 6]
    left = [{ monitor = { main = 140 } }, 10]
    right = [{ monitor = { main = 140 } }, 10]
    top = [{ monitor = { main = 40 } }, 6]

    [key-mapping]
    preset = "qwerty"

    [mode.apps.binding]
    alt-w = ["exec-and-forget open -a /Applications/WezTerm.app", "mode main"]

    [mode.main.binding]
    alt-1 = "workspace 1"
    alt-2 = "workspace 2"
    alt-3 = "workspace 3"
    alt-4 = "workspace 4"
    alt-h = "focus left"
    alt-j = "focus down"
    alt-k = "focus up"
    alt-l = "focus right"
    alt-shift-1 = "move-node-to-workspace 1 --focus-follows-window"
    alt-shift-2 = "move-node-to-workspace 2 --focus-follows-window"
    alt-shift-3 = "move-node-to-workspace 3 --focus-follows-window"
    alt-shift-4 = "move-node-to-workspace 4 --focus-follows-window"
    alt-shift-down = "join-with down"
    alt-shift-down-shift-j = "move down"
    alt-shift-h = "move left"
    alt-shift-j = "move down"
    alt-shift-k = "move up"
    alt-shift-l = "move right"
    alt-shift-left = "join-with left"
    alt-shift-right = "join-with right"
    alt-shift-up = "join-with up"

    [mode.service.binding]
    backspace = ["close-all-windows-but-current", "mode main"]
    esc = ["reload-config", "mode main"]
    f = ["layout floating tiling", "mode main"]
    r = ["flatten-workspace-tree", "mode main"]

    [workspace-to-monitor-force-assignment]
    1 = "^Built-in.*$"
    2 = "^DELL U.*$"
    3 = "^DELL S.*$"
    EOF
  '';

  launchd.user.agents.desktopSetup = {
    serviceConfig = {
      Label = "org.nixos.desktop-setup";
      ProgramArguments = [
        "/usr/bin/osascript"
        "-e"
        ''
          tell application "Finder"
            set desktop picture to POSIX file "/Users/lhh/nix-mac-setup/wallpaper.jpg"
            do shell script "defaults write com.apple.finder CreateDesktop -bool false"
            do shell script "killall Finder"
          end tell
        ''
      ];
      RunAtLoad = true;
    };
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
