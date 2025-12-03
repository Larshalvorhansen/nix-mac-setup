{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    mouse = true;

    extraConfig = ''
      set -g status-position top
      set -g status-bg colour52
      set -g status-fg white
      set -g status-interval 10
      set -g status-right '#(date +"%a %b %d, %H:%M:%S")'
    '';
  };
}
