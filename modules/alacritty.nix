{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 1.0;
        decorations = "none"; # remove titlebar
      };

      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Italic";
        };
        bold_italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold Italic";
        };
        size = 18.0;
      };

      colors = {
        primary = {
          background = "0x000000";
          foreground = "0xffffff";
        };

        normal = {
          black = "0x2c2525";
          red = "0xfd6883";
          green = "0xadda78";
          yellow = "0xf9cc6c";
          blue = "0xf38d70";
          magenta = "0xa8a9eb";
          cyan = "0x85dacc";
          white = "0xfff1f3";
        };

        bright = {
          black = "0x72696a";
          red = "0xfd6883";
          green = "0xadda78";
          yellow = "0xf9cc6c";
          blue = "0xf38d70";
          magenta = "0xa8a9eb";
          cyan = "0x85dacc";
          white = "0xfff1f3";
        };
      };
    };
  };
}
