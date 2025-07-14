{ config, lib, pkgs, ... }:

{
  config = {
    services.skhd = {
      enable = true;

      skhdConfig = ''
        # Focus space 1–4 with cmd + [1–4]
        cmd - 1 : yabai -m space --focus 1
        cmd - 2 : yabai -m space --focus 2
        cmd - 3 : yabai -m space --focus 3
        cmd - 4 : yabai -m space --focus 4
      '';
    };
  };
}
