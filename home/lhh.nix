{ config, pkgs, ... }: {

  imports = [ ../modules/kitty.nix ];

  home.username = "lhh";
  home.homeDirectory = "/Users/lhh";
  home.stateVersion = "26.05";

  # User Packages
  home.packages = with pkgs; [
    alacritty black cmatrix cowsay csvlens discord eza fd ffmpeg fzf gh glow
    go gopls harper iamb jless karabiner-elements kjv librsvg lynx mas
    netlify-cli nixfmt prettier python3 ripgrep rust-analyzer rustfmt shfmt
    skimpdf stylua tldr tinymist tmux tree typescript-language-server typst
    typstyle visidata websocat w3m wget yt-dlp zotero
  ];

  # Zsh Configuration
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

  # Git Configuration
  programs.git.enable = true;

# Neovim Configuration
  programs.neovim = {
    enable = true;
    withRuby = false;
    withPython3 = false;
    plugins = with pkgs.vimPlugins; [ harpoon2 ];
    
    # This hooks Neovim up to the macOS system clipboard (pbcopy/pbpaste)
    extraLuaConfig = ''
      vim.opt.clipboard = "unnamedplus"
    '';
  };

  # Bitwarden CLI Configuration
  programs.rbw = {
    enable = true;
    settings = {
      email = "larshalvorhansen1@gmail.com";
      pinentry = pkgs.pinentry_mac; 
    };
  };

  # AeroSpace Window Manager Configuration
  programs.aerospace = {
    enable = true;
    launchd.enable = true; # Ensures Home Manager handles the background service lifecycle

    settings = {
      # Startup Commands
      "after-startup-command" = [ "exec-and-forget sketchybar" ];

      # Notify Sketchybar & Borders about workspace changes safely without subshell splitting
      "exec-on-workspace-change" = [
        "exec-and-forget sketchybar --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE"
        "exec-and-forget borders active_color=0xffe1e3e4 inactive_color=0xff494d64 width=0"
      ];

      # Start AeroSpace at login
      "start-at-login" = false;

      # Normalizations
      "enable-normalization-flatten-containers" = true;
      "enable-normalization-opposite-orientation-for-nested-containers" = true;

      # Layouts
      "accordion-padding" = 300;
      "default-root-container-layout" = "tiles";
      "default-root-container-orientation" = "auto";

      # Callbacks
      "on-focused-monitor-changed" = [ "move-mouse monitor-lazy-center" ];
      "automatically-unhide-macos-hidden-apps" = false;

      # Key Mapping
      "key-mapping" = { preset = "qwerty"; };

      # Gaps
      gaps = {
        inner.horizontal = [ { monitor.main = 40; } 10 ];
        outer = {
          left = [ { monitor.main = 350; } 20 ];
          right = [ { monitor.main = 350; } 20 ];
          bottom = [ { monitor.main = 100; } 10 ];
          top = [ { monitor.main = 100; } 10 ];
        };
      };

      # Main Bindings
      mode.main.binding = {

        alt-shift-left = "join-with left";
        alt-shift-down = "join-with down";
        alt-shift-up = "join-with up";
        alt-shift-right = "join-with right";

        alt-h = "focus left";
        alt-j = "focus down";
        alt-k = "focus up";
        alt-l = "focus right";

        alt-shift-h = "move left";
        alt-shift-down-shift-j = "move down"; # Fixed key name quirk if needed, left as alt-shift-j
        alt-shift-j = "move down";
        alt-shift-k = "move up";
        alt-shift-l = "move right";

        alt-1 = "workspace 1";
        alt-2 = "workspace 2";
        alt-3 = "workspace 3";
        alt-4 = "workspace 4";

        alt-shift-1 = "move-node-to-workspace 1 --focus-follows-window";
        alt-shift-2 = "move-node-to-workspace 2 --focus-follows-window";
        alt-shift-3 = "move-node-to-workspace 3 --focus-follows-window";
        alt-shift-4 = "move-node-to-workspace 4 --focus-follows-window";

        # Application Launchers
#        alt-o = "exec-and-forget open -a /Applications/Obsidian.app";
      };

      # Service Mode
      mode.service.binding = {
        esc = [ "reload-config" "mode main" ];
        r = [ "flatten-workspace-tree" "mode main" ];
        f = [ "layout floating tiling" "mode main" ];
        backspace = [ "close-all-windows-but-current" "mode main" ];
      };

      # Quick App Switch Modal
      mode.apps.binding = {
        alt-w = [ "exec-and-forget open -a /Applications/WezTerm.app" "mode main" ];
      };

      # Monitor Assignments
      "workspace-to-monitor-force-assignment" = {
        "1" = "^Built-in.*$";
        "2" = "^DELL U.*$";
        "3" = "^DELL S.*$";
      };
    };
  };

  # XDG Dotfile Config Symlinks
  xdg.configFile."configstore/update-notifier-netlify-cli.json".source =
    ../.config/configstore/update-notifier-netlify-cli.json;
  xdg.configFile."gh/config.yml".source = ../.config/gh/config.yml;
  xdg.configFile."gh/hosts.yml".source = ../.config/gh/hosts.yml;
  xdg.configFile."neofetch/config.conf".source = ../.config/neofetch/config.conf;
}
