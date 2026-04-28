{ config, pkgs, ... }: {
  # Module imports
  imports = [ ../modules/kitty.nix ];

  home.username = "lhh";
  home.homeDirectory = "/Users/lhh";
  home.packages = with pkgs; [
    alacritty # GPU-accelerated terminal emulator
    aoc-cli # Advent of Code helper tool
    black # Python code formatter
    clang-tools_16 # C/C++ development utilities
    cmatrix # "Matrix" style terminal screensaver
    cowsay # Generates ASCII art of a talking cow
    csvlens # Command-line CSV viewer
    discord # Chat and communication platform
    eza # Modern replacement for 'ls'
    ffmpeg # Audio/video processing tool
    gh # GitHub CLI tool
    glow # Terminal markdown renderer
    go # Go programming language
    jless # Interactive JSON viewer
    karabiner-elements # macOS keyboard customizer
    kjv # CLI King James Bible
    iamb # Matrix chat client (Vim-like)
    lynx # Text-based web browser
    librsvg # SVG rendering library
    nodejs_20 # Node.js runtime (v20)
    mas # Mac App Store CLI
    netlify-cli # Netlify deployment tools
    nixfmt-classic # Nix code formatter
    nodePackages.prettier # Multi-language code formatter
    python3 # Python programming language
    ripgrep # Fast text search tool
    rustfmt # Rust code formatter
    shfmt # Shell script formatter
    skimpdf # PDF reader and annotator
    stylua # Lua code formatter
    tealdeer # Fast 'tldr' (simple man pages)
    tmux # Terminal multiplexer
    texliveTeTeX # TeX typesetting distribution
    tree # Directory hierarchy visualizer
    typst # Modern typesetting system
    visidata # Terminal spreadsheet/data explorer
    w3m # Text-based web browser
    wget # Command-line file downloader
    yt-dlp # Video/audio downloader
    zotero # Research/citation manager
  ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      g = "git";
      k = "kubectl";
      ls = "eza --icons";
      tree = "eza --tree --icons";
      ll = "ls -alh";
      gs = "git status";
      conf = "nvim $HOME/nix-mac-setup/.config";
      nixing = "nvim $HOME/nix-mac-setup/home/lhh.nix";
      n = "nvim";
      t = "tmux";
      ta = ''tmux attach -t "$(tmux ls -F '#{session_name}' | head -n 0)"'';
      ts = "tmux choose-tree -s";
      todo = "cd $HOME/Documents/dailyTodo && nvim todo.md";
      won = "networksetup -setairportpower en0 on";
      woff = "networksetup -setairportpower en0 off";
      batt = "pmset -g batt";
    };
    initContent = ''
      # Load zinit from GitHub
      source ${
        pkgs.fetchFromGitHub {
          owner = "zdharma-continuum";
          repo = "zinit";
          rev = "v3.8.0";
          sha256 = "sha256-yGUcwrwLXpsB3nzGITbi/0ycZej09GvozDoscEf7qp4=";
        }
      }/zinit.zsh
      # Plugins
      zinit light zsh-users/zsh-autosuggestions
      zinit light zsh-users/zsh-completions
      zinit light zsh-users/zsh-syntax-highlighting
      # Theme
      zinit light romkatv/powerlevel10k
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
  };
  # REMOVED: programs.tmux.enable = true;  (now handled by module)
  programs.git.enable = true;
  programs.neovim.enable = true;
  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink /Users/lhh/nix-mac-setup/.config/nvim;
  xdg.configFile."configstore/update-notifier-netlify-cli.json".source =
    ../.config/configstore/update-notifier-netlify-cli.json;
  xdg.configFile."gh/config.yml".source = ../.config/gh/config.yml;
  xdg.configFile."gh/hosts.yml".source = ../.config/gh/hosts.yml;
  xdg.configFile."neofetch/config.conf".source =
    ../.config/neofetch/config.conf;
  xdg.configFile."sketchybar/sketchybarrc".source =
    ../.config/sketchybar/sketchybarrc;
  # REMOVED: xdg.configFile."tmux/tmux.conf".source = ../.config/tmux/tmux.conf;  (now managed by module)
  home.stateVersion = "24.05";
}
