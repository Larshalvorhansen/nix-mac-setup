{ config, lib, pkgs, ... }:

{
  config = {
    services.skhd = {
      enable = true;

      skhdConfig = ''
                # Focus space 1–8 with cmd + alt + [1–8]
        #        alt - 1 : yabai -m space --focus 1
         #       alt - 2 : yabai -m space --focus 2
          #      alt - 3 : yabai -m space --focus 3
           #     alt - 4 : yabai -m space --focus 4
            #    alt - 5 : yabai -m space --focus 5
             #   alt - 6 : yabai -m space --focus 6
              #  alt - 7 : yabai -m space --focus 7
               # alt - 8 : yabai -m space --focus 8
      '';
    };
  };
}
