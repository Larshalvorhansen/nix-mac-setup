{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    # Theme
    theme =
      "Dracula"; # Options: Dracula, Tokyo Night, Catppuccin-Mocha, OneDark, Nord, GruvboxDark, etc.

    # Font
    font = {
      name = "JetBrainsMono Nerd Font Mono";
      size = 13;
    };

    # Main settings
    settings = {
      # Window
      window_padding_width = 12;
      window_margin_width = 8;
      confirm_os_window_close = 0;
      background_opacity = "0.96";
      background_blur = 20;

      # Cursor
      cursor_shape = "beam";
      cursor_beam_thickness = 1.8;
      cursor_blink_interval = 0.7;
      cursor_trail = 80;
      cursor_trail_decay = "0.08 0.25";

      # Tab bar
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "round";
      tab_bar_min_tabs = 2;

      # Scrollback
      scrollback_lines = 10000;
      scrollback_pager_history_size = 50;

      # Misc
      enable_audio_bell = false;
      visual_bell_duration = 0.0;
      url_style = "curly";
      detect_urls = true;
      copy_on_select = false;

      # Performance
      repaint_delay = 8;
      input_delay = 2;
    };

    # Extra raw config (for things not exposed nicely in Nix)
    extraConfig = ''
      # Custom keybindings
      map ctrl+shift+t   new_tab
      map ctrl+shift+q   close_tab
      map ctrl+shift+w   close_os_window
      map ctrl+shift+enter new_window

      # Font size control
      map ctrl+shift+equal  change_font_size all +2.0
      map ctrl+shift+minus  change_font_size all -2.0
      map ctrl+shift+0      change_font_size all 0

      # Clear shortcuts
      map ctrl+l clear_terminal to_cursor_scroll active
      map ctrl+shift+k clear_terminal scrollback active
    '';
  };
}
