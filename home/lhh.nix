{ config, pkgs, ... }:

{
  home.username = "lhh";
  home.homeDirectory = "/Users/lhh";

  home.packages = with pkgs; [
    alacritty
    tmux
    cmatrix
    python3
    eza
    ffmpeg
    typst
    glow
    yt-dlp
    cowsay
    tree
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      g = "git";
      k = "kubectl";
      ls = "eza --icons";
      ll = "ls -alh";
      gs = "git status";
      conf = "cd ~/nix-mac-setup/.config $$ nvim ."
    };

    initExtra = ''
      # Load zinit from GitHub
      source ${pkgs.fetchFromGitHub {
        owner = "zdharma-continuum";
        repo = "zinit";
        rev = "v3.8.0";
sha256 = "sha256-yGUcwrwLXpsB3nzGITbi/0ycZej09GvozDoscEf7qp4=";
      }}/zinit.zsh

      # Plugins
      zinit light zsh-users/zsh-autosuggestions
      zinit light zsh-users/zsh-completions
      zinit light zsh-users/zsh-syntax-highlighting

      # Theme (optional)
      zinit light romkatv/powerlevel10k
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
  };

  programs.tmux.enable = true;
  programs.git.enable = true;
  programs.neovim.enable = true;

  xdg.configFile."alacritty/alacritty.toml".source = ../.config/alacritty/alacritty.toml;
  xdg.configFile."gh/config.yml".source = ../.config/gh/config.yml;
  xdg.configFile."gh/hosts.yml".source = ../.config/gh/hosts.yml;
  xdg.configFile."configstore/update-notifier-netlify-cli.json".source = ../.config/configstore/update-notifier-netlify-cli.json;
  xdg.configFile."nvim".source = ../.config/nvim;
  xdg.configFile."neofetch/config.conf".source = ../.config/neofetch/config.conf;
  xdg.configFile."tmux/tmux.conf".source = ../.config/tmux/tmux.conf;
  xdg.configFile."tmux/cheatsheet.txt".source = ../.config/tmux/cheatsheet.txt;
  xdg.configFile."aerospace/aerospace.toml".source = ../.config/aerospace/aerospace.toml;
xdg.configFile."yabai/yabairc".source = ../.config/yabai/yabairc;
xdg.configFile."skhd/skhdrc".source = ../.config/skhd/skhdrc;


  home.stateVersion = "23.11";
}
