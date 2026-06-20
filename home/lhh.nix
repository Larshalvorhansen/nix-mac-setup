{ config, pkgs, ... }: {
  imports = [ ../modules/kitty.nix ];

  home.username = "lhh";
  home.homeDirectory = "/Users/lhh";

  home.packages = with pkgs; [
    alacritty black cmatrix cowsay csvlens discord eza fd ffmpeg fzf gh glow
    go gopls harper iamb jless karabiner-elements kjv librsvg lynx mas
    netlify-cli nixfmt prettier python3 ripgrep rust-analyzer rustfmt shfmt
    skimpdf stylua tldr tinymist tmux tree typescript-language-server typst
    typstyle visidata websocat w3m wget yt-dlp zotero
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      g = "git"; k = "kubectl"; ls = "eza --icons"; tree = "eza --tree --icons";
      ll = "ls -alh"; gs = "git status"; conf = "nvim $HOME/nix-mac-setup/.config";
      nixing = "nvim $HOME/nix-mac-setup/home/lhh.nix"; n = "nvim"; t = "tmux";
      ta = ''tmux attach -t "$(tmux ls -F '#{session_name}' | head -n 0)"'';
      ts = "tmux choose-tree -s"; todo = "cd $HOME/Documents/dailyTodo && nvim todo.md";
      won = "networksetup -setairportpower en0 on"; woff = "networksetup -setairportpower en0 off";
      batt = "pmset -g batt";
    };

    initContent = ''
      source ${
        pkgs.fetchFromGitHub {
          owner = "zdharma-continuum"; repo = "zinit"; rev = "v3.8.0";
          sha256 = "sha256-yGUcwrwLXpsB3nzGITbi/0ycZej09GvozDoscEf7qp4=";
        }
      }/zinit.zsh

      zinit light zsh-users/zsh-autosuggestions
      zinit light zsh-users/zsh-completions
      zinit light zsh-users/zsh-syntax-highlighting
      zinit light romkatv/powerlevel10k
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
  };

  programs.git.enable = true;

  programs.neovim = {
    enable = true;
    withRuby = false;
    withPython3 = false;
    plugins = with pkgs.vimPlugins; [ harpoon2 ];
  };

  # Correct way (this fixes the "outside $HOME" error)
    config.lib.file.mkOutOfStoreSymlink

  xdg.configFile."configstore/update-notifier-netlify-cli.json".source =
    ../.config/configstore/update-notifier-netlify-cli.json;
  xdg.configFile."gh/config.yml".source = ../.config/gh/config.yml;
  xdg.configFile."gh/hosts.yml".source = ../.config/gh/hosts.yml;
  xdg.configFile."neofetch/config.conf".source = ../.config/neofetch/config.conf;

  home.stateVersion = "26.05";
}

  # Neovim config (correct method)
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/nix-mac-setup/.config/nvim";

  # Neovim config (correct & clean)
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/nix-mac-setup/.config/nvim";

  # Neovim config (single clean definition)
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/nix-mac-setup/.config/nvim";
