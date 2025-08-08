{ config, lib, pkgs, ... }:

{
  config = {
    services.skhd = {
      enable = true;

      skhdConfig = ''
        # Focus space 1–8 with cmd + alt + [1–8]
        cmd + alt - 1 : yabai -m space --focus 1
        cmd + alt - 2 : yabai -m space --focus 2
        cmd + alt - 3 : yabai -m space --focus 3
        cmd + alt - 4 : yabai -m space --focus 4
        cmd + alt - 5 : yabai -m space --focus 5
        cmd + alt - 6 : yabai -m space --focus 6
        cmd + alt - 7 : yabai -m space --focus 7
        cmd + alt - 8 : yabai -m space --focus 8
      '';
    };
  };
}
