{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    # Correct way to set theme (new option name)
    themeFile = "Dracula";

    font = {
      name = "JetBrainsMono Nerd Font Mono";
      size = 13;
    };

    settings = {
      # Pure black background
      background = "#000000";
      background_opacity = "1.0";
      background_blur = 0;

      # Smaller margins
      window_padding_width = 1;
      window_margin_width = 0;

      # Cursor (no trail)
      cursor_shape = "beam";
      cursor_beam_thickness = 1.8;
      cursor_blink_interval = 0.7;
      cursor_trail = 0;

      # Tab bar
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "round";
      tab_bar_min_tabs = 2;

      # General
      confirm_os_window_close = 0;
      scrollback_lines = 10000;
      enable_audio_bell = false;
      url_style = "curly";
      detect_urls = true;

      # Allow Neovim to change font for .typ files
      allow_remote_control = "socket-only";
    };

    extraConfig = ''
      # Keybindings
      map ctrl+shift+t   new_tab
      map ctrl+shift+q   close_tab
      map ctrl+shift+w   close_os_window
      map ctrl+shift+enter new_window

      map ctrl+shift+equal   change_font_size all +2.0
      map ctrl+shift+minus   change_font_size all -2.0
      map ctrl+shift+0       change_font_size all 0

      map ctrl+l             clear_terminal to_cursor_scroll active
      map ctrl+shift+k       clear_terminal scrollback active
    '';
  };
}
