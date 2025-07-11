{ config, pkgs, ... }:

{
  services.skhd = {
    enable = true;
    package = pkgs.skhd;
    skhdConfig = ''
      # focus windows
      alt - h : yabai -m window --focus west
      alt - l : yabai -m window --focus east
      alt - k : yabai -m window --focus north
      alt - j : yabai -m window --focus south

      # swap windows
      shift + alt - h : yabai -m window --swap west
      shift + alt - l : yabai -m window --swap east
      shift + alt - k : yabai -m window --swap north
      shift + alt - j : yabai -m window --swap south

      # rotate
      alt - r : yabai -m space --rotate 90
    '';
  };
}
