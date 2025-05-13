{ config, pkgs, ... }:

{
  home.username = "lhh";
  home.homeDirectory = "/Users/lhh";

  home.packages = with pkgs; [
		#    neovim
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
    shellAliases = {
      ll = "ls -alh";
      gs = "git status";
    };
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

  home.stateVersion = "23.11";
}
