{ config, pkgs, ... }:

{
  home.username = "lhh";
  home.homeDirectory = "/Users/lhh";

  home.packages = with pkgs; [
    alacritty
    aoc-cli
    black
    clang-tools_16
    cmatrix
    cowsay
    discord
    eza
    ffmpeg
    gh
    glow
    go
    karabiner-elements
    kjv
    iamb
    lynx
    mas
    netlify-cli
    nixfmt-classic
    nodePackages.prettier
    python3
    ripgrep
    rustfmt
    shfmt
    skimpdf
    stylua
    tealdeer
    tmux
    texliveTeTeX
    tree
    typst
    w3m
    wget
    yt-dlp
    zotero
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

  programs.tmux.enable = true;
  programs.git.enable = true;
  programs.neovim.enable = true;
  #  programs.aerospace = {
  # enable = true;
  # settings = {
  #   config = "${config.xdg.configHome}/aerospace/aerospace.toml";
  # };
  #};

  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink /Users/lhh/nix-mac-setup/.config/nvim;

  #  xdg.configFile."aerospace.toml".source = ../.config/aerospace.toml;
  #  xdg.configFile."alacritty/alacritty.toml".source =
  #  ../.config/alacritty/alacritty.toml;
  xdg.configFile."configstore/update-notifier-netlify-cli.json".source =
    ../.config/configstore/update-notifier-netlify-cli.json;
  xdg.configFile."gh/config.yml".source = ../.config/gh/config.yml;
  xdg.configFile."gh/hosts.yml".source = ../.config/gh/hosts.yml;
  xdg.configFile."neofetch/config.conf".source =
    ../.config/neofetch/config.conf;
  xdg.configFile."sketchybar/sketchybarrc".source =
    ../.config/sketchybar/sketchybarrc;
  xdg.configFile."tmux/tmux.conf".source = ../.config/tmux/tmux.conf;

  home.stateVersion = "24.05";
}
