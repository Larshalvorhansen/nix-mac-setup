{ pkgs, lib, inputs, config, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      env = { TERM = "xterm-256color"; };

      window = {
        padding = {
          x = 8;
          y = 2;
        };

        dynamic_padding = true;
        dynamic_title = true;

        decorations = "none"; # full/none/transparent/buttonless

        # Transparency:
        opacity = lib.mkDefault 0.95;
      };

      scrolling = {
        history = 9999;
        multiplier = 3;
      };

      # Font configuration (changes require restart)
      font = {
        normal = {
          family = "Hack Nerd Font Mono";
          style = "Regular";
        };

        bold = {
          family = "Hack Nerd Font Mono";
          style = "Bold";
        };

        italic = {
          family = "Hack Nerd Font Mono";
          style = "Italic";
        };

        size = 14;
      };

      colors = {
        draw_bold_text_with_bright_colors = true;

        # # gruvbox_material_medium_dark
        #  primary = {
        #     background = "0x282828";
        #     foreground = "0xd4be98";
        #   };
        #   normal = {
        #     black =  "0x3c3836";
        #     red =     "0xea6962";
        #     green =   "0xa9b665";
        #     yellow =  "0xd8a657";
        #     blue =    "0x7daea3";
        #     magenta = "0xd3869b";
        #     cyan =    "0x89b482";
        #     white =   "0xd4be98";
        #   };
        #   bright = {
        #     black =   "0x3c3836";
        #     red =     "0xea6962";
        #     green =   "0xa9b665";
        #     yellow =  "0xd8a657";
        #     blue =    "0x7daea3";
        #     magenta = "0xd3869b";
        #     cyan =    "0x89b482";
        #     white =   "0xd4be98";
        #   };

        # # # Tomorrow Night Bright
        # primary = {
        #   background = "0x141414";
        #   foreground = "0xeaeaea";
        # };

        # cursor = {
        #   text = "0x000000";
        #   cursor = "0xffffff";
        # };

        # normal = {
        #   black   = "0x000000";
        #   red     = "0xd54e53";
        #   green   = "0x82de37";
        #   yellow  = "0xe6c547";
        #   blue    = "0x7aa6da";
        #   magenta = "0xc397d8";
        #   cyan    = "0x70c0ba";
        #   white   = "0xffffff";
        # };

        # bright = {
        #   black   = "0x666666";
        #   red     = "0xff3334";
        #   green   = "0x8bd45d";
        #   yellow  = "0xe7c547";
        #   blue    = "0x7aa6da";
        #   magenta = "0xb77ee0";
        #   cyan    = "0x54ced6";
        #   white   = "0xffffff";
        # };

        # Nord:
        primary = {
          background = "0x2e3440";
          foreground = "0xd8dee9";
          dim_foreground = "0xa5abb6";
        };

        cursor = {
          text = "0x2e3440";
          cursor = "0xd8dee9";
        };

        vi_mode_cursor = {
          text = "0x2e3440";
          cursor = "0xd8dee9";
        };

        selection = {
          text = "CellForeground";
          background = "0x4c566a";
        };

        normal = {
          black = "0x3b4252";
          red = "0xbf616a";
          green = "0xa3be8c";
          yellow = "0xebcb8b";
          blue = "0x81a1c1";
          magenta = "0xb48ead";
          cyan = "0x88c0d0";
          white = "0xe5e9f0";
        };

        bright = {
          black = "0x4c566a";
          red = "0xbf616a";
          green = "0xa3be8c";
          yellow = "0xebcb8b";
          blue = "0x81a1c1";
          magenta = "0xb48ead";
          cyan = "0x8fbcbb";
          white = "0xeceff4";
        };

        dim = {
          black = "0x373e4d";
          red = "0x94545d";
          green = "0x809575";
          yellow = "0xb29e75";
          blue = "0x68809a";
          magenta = "0x8c738c";
          cyan = "0x6d96a5";
          white = "0xaeb3bb";
        };

        # Indexed Colors
        #
        # The indexed colors include all colors from 16 to 256.
        # When these are not set, they're filled with sensible defaults.
        #
        # Example:
        #   `- { index: 16, color: '0xff00ff' }`
        #
        # indexed_colors: []
      };

      bell = {
        animation = "Ease";
        color = "0xffffff";
        duration = 100;
      };

      # Key bindings
      #
      # Key bindings are specified as a list of objects. Each binding will specify a
      # key and modifiers required to trigger it, terminal modes where the binding is
      # applicable, and what should be done when the key binding fires. It can either
      # send a byte sequence to the running application (`chars`), execute a
      # predefined action (`action`) or fork and execute a specified command plus
      # arguments (`command`).
      #
      # Bindings are always filled by default, but will be replaced when a new binding
      # with the same triggers is defined. To unset a default binding, it can be
      # mapped to the `None` action.
      #
      # Example:
      #   `- { key: V, mods: Control|Shift, action: Paste }`
      #
      # Available fields:
      #   - key
      #   - mods (optional)
      #   - chars | action | command (exactly one required)
      #   - mode (optional)
      #
      # Values for `key`:
      #   - `A` -> `Z`
      #   - `F1` -> `F12`
      #   - `Key1` -> `Key0`
      #
      #   A full list with available key codes can be found here:
      #   https://docs.rs/glutin/*/glutin/enum.VirtualKeyCode.html#variants
      #
      #   Instead of using the name of the keys, the `key` field also supports using
      #   the scancode of the desired key. Scancodes have to be specified as a
      #   decimal number.
      #   This command will allow you to display the hex scancodes for certain keys:
      #     `showkey --scancodes`
      #
      # Values for `mods`:
      #   - Command
      #   - Control
      #   - Option
      #   - Super
      #   - Shift
      #   - Alt
      #
      #   Multiple `mods` can be combined using `|` like this: `mods: Control|Shift`.
      #   Whitespace and capitalization is relevant and must match the example.
      #
      # Values for `chars`:
      #   The `chars` field writes the specified string to the terminal. This makes
      #   it possible to pass escape sequences.
      #   To find escape codes for bindings like `PageUp` ("\x1b[5~"), you can run
      #   the command `showkey -a` outside of tmux.
      #   Note that applications use terminfo to map escape sequences back to
      #   keys. It is therefore required to update the terminfo when
      #   changing an escape sequence.
      #
      # Values for `action`:
      #   - Paste
      #   - PasteSelection
      #   - Copy
      #   - IncreaseFontSize
      #   - DecreaseFontSize
      #   - ResetFontSize
      #   - ScrollPageUp
      #   - ScrollPageDown
      #   - ScrollLineUp
      #   - ScrollLineDown
      #   - ScrollToTop
      #   - ScrollToBottom
      #   - ClearHistory
      #   - Hide
      #   - Quit
      #   - ClearLogNotice
      #   - SpawnNewInstance
      #   - ToggleFullscreen
      #   - None
      #
      # Values for `action` (macOS only):
      #   - ToggleSimpleFullscreen: Enters fullscreen without occupying another space
      #
      # Values for `command`:
      #   The `command` field must be a map containing a `program` string and
      #   an `args` array of command line parameter strings.
      #
      #   Example:
      #       `command: { program: "alacritty", args: ["-e", "vttest"] }`
      #
      # Values for `mode`:
      #   - ~AppCursor
      #   - AppCursor
      #   - ~AppKeypad
      #   - AppKeypad
      #
      # key_bindings:
      #   - { key: V,        mods: Alt,       action: Paste                        }
      #   - { key: C,        mods: Alt,       action: Copy                         }
      #   - { key: Q,        mods: Alt,       action: Quit                         }
      #   - { key: N,        mods: Alt,       action: SpawnNewInstance             }
      #   - { key: Return,   mods: Alt,       action: ToggleFullscreen             }

      #   - { key: Home,                          chars: "\x1bOH",   mode: AppCursor   }
      #   - { key: Home,                          chars: "\x1b[H",   mode: ~AppCursor  }
      #   - { key: End,                           chars: "\x1bOF",   mode: AppCursor   }
      #   - { key: End,                           chars: "\x1b[F",   mode: ~AppCursor  }
      #   - { key: Equals,   mods: Alt,       action: IncreaseFontSize             }
      #   - { key: Minus,    mods: Alt,       action: DecreaseFontSize             }
      #   - { key: Minus,    mods: Alt|Shift, action: ResetFontSize                }
      #   - { key: PageUp,   mods: Shift,         chars: "\x1b[5;2~"                   }
      #   - { key: PageUp,   mods: Control,       chars: "\x1b[5;5~"                   }
      #   - { key: PageUp,                        chars: "\x1b[5~"                     }
      #   - { key: PageDown, mods: Shift,         chars: "\x1b[6;2~"                   }
      #   - { key: PageDown, mods: Control,       chars: "\x1b[6;5~"                   }
      #   - { key: PageDown,                      chars: "\x1b[6~"                     }
      #   - { key: Left,     mods: Shift,         chars: "\x1b[1;2D"                   }
      #   - { key: Left,     mods: Control,       chars: "\x1b[1;5D"                   }
      #   - { key: Left,     mods: Alt,           chars: "\x1b[1;3D"                   }
      #   - { key: Left,                          chars: "\x1b[D",   mode: ~AppCursor  }
      #   - { key: Left,                          chars: "\x1bOD",   mode: AppCursor   }
      #   - { key: Right,    mods: Shift,         chars: "\x1b[1;2C"                   }
      #   - { key: Right,    mods: Control,       chars: "\x1b[1;5C"                   }
      #   - { key: Right,    mods: Alt,           chars: "\x1b[1;3C"                   }
      #   - { key: Right,                         chars: "\x1b[C",   mode: ~AppCursor  }
      #   - { key: Right,                         chars: "\x1bOC",   mode: AppCursor   }
      #   - { key: Up,       mods: Shift,         chars: "\x1b[1;2A"                   }
      #   - { key: Up,       mods: Control,       chars: "\x1b[1;5A"                   }
      #   - { key: Up,       mods: Alt,           chars: "\x1b[1;3A"                   }
      #   - { key: Up,                            chars: "\x1b[A",   mode: ~AppCursor  }
      #   - { key: Up,                            chars: "\x1bOA",   mode: AppCursor   }
      #   - { key: Down,     mods: Shift,         chars: "\x1b[1;2B"                   }
      #   - { key: Down,     mods: Control,       chars: "\x1b[1;5B"                   }
      #   - { key: Down,     mods: Alt,           chars: "\x1b[1;3B"                   }
      #   - { key: Down,                          chars: "\x1b[B",   mode: ~AppCursor  }
      #   - { key: Down,                          chars: "\x1bOB",   mode: AppCursor   }
      #   - { key: Tab,      mods: Shift,         chars: "\x1b[Z"                      }
      #   - { key: F1,                            chars: "\x1bOP"                      }
      #   - { key: F2,                            chars: "\x1bOQ"                      }
      #   - { key: F3,                            chars: "\x1bOR"                      }
      #   - { key: F4,                            chars: "\x1bOS"                      }
      #   - { key: F5,                            chars: "\x1b[15~"                    }
      #   - { key: F6,                            chars: "\x1b[17~"                    }
      #   - { key: F7,                            chars: "\x1b[18~"                    }
      #   - { key: F8,                            chars: "\x1b[19~"                    }
      #   - { key: F9,                            chars: "\x1b[20~"                    }
      #   - { key: F10,                           chars: "\x1b[21~"                    }
      #   - { key: F11,                           chars: "\x1b[23~"                    }
      #   - { key: F12,                           chars: "\x1b[24~"                    }
      #   - { key: Back,                          chars: "\x7f"                        }
      #   - { key: Back,     mods: Alt,           chars: "\x1b\x7f"                    }
      #   - { key: Insert,                        chars: "\x1b[2~"                     }
      #   - { key: Delete,                        chars: "\x1b[3~"                     }

      selection = {
        semantic_escape_chars = '',│`|:"' ()[]{}<>'';
        save_to_clipboard = false;
      };

      cursor = {
        style = {
          shape = "Block";
          blinking = "on";
        };
        unfocused_hollow = true;
      };

    };
  };
}
