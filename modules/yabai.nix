{ config, pkgs, ... }:

{
  services.yabai = {
    enable = true;
    package = pkgs.yabai;
    enableScriptingAddition = true;
    config = {
      layout = "bsp";
      auto_balance = "on";
      mouse_follows_focus = "on";
      focus_follows_mouse = "off";
      window_placement = "second_child";
    };
    extraConfig = ''
      yabai -m rule --add app="System Settings" manage=off
      yabai -m rule --add app="Finder" manage=off
    '';
  };
}
