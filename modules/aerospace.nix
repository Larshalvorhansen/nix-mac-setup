{ config, lib, pkgs, ... }:

{
  programs.aerospace = {
    enable = true;

    settings = {
      layout_mode = "bsp";
      mod_key = "mod1"; # alt

      keybindings = [
        {
          key = "return";
          modifiers = [ "mod1" ];
          action = {
            type = "exec";
            command = "alacritty";
          };
        }
        {
          key = "h";
          modifiers = [ "mod1" ];
          action = "focus-left";
        }
        {
          key = "l";
          modifiers = [ "mod1" ];
          action = "focus-right";
        }
        {
          key = "j";
          modifiers = [ "mod1" ];
          action = "focus-down";
        }
        {
          key = "k";
          modifiers = [ "mod1" ];
          action = "focus-up";
        }
      ];
    };
  };
}
