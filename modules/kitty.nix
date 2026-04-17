{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    theme = "Dracula";

    font = {
      name = "JetBrainsMono Nerd Font Mono";
      size = 13;
    };

    settings = {
      # Background - Pure Black
      background = "#000000";
      background_opacity = "1.0";
      background_blur = 0;

      # Smaller margins/padding
      window_padding_width = 6;
      window_margin_width = 4;

      # Cursor - No flying ninja
      cursor_shape = "beam";
      cursor_beam_thickness = 1.8;
      cursor_blink_interval = 0.7;
      cursor_trail = 0;

      # Tab bar
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "round";
      tab_bar_min_tabs = 2;

      # Other settings
      confirm_os_window_close = 0;
      scrollback_lines = 10000;
      enable_audio_bell = false;
      url_style = "curly";
      detect_urls = true;
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
