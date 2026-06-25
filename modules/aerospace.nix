settings = {
      # Startup Hooks (Keeping your top bar & window border integrations active)
      "after-startup-command" = [ "exec-and-forget sketchybar" ];
      "exec-on-workspace-change" = [
        "exec-and-forget sketchybar --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE"
        "exec-and-forget borders active_color=0xffe1e3e4 inactive_color=0xff494d64 width=0"
      ];

      "start-at-login" = false;

      # Simple, clean gaps so 1 or 2 windows look sharp
      gaps = {
        inner.horizontal = 10;
        inner.vertical = 10;
        outer = {
          left = 12;
          right = 12;
          bottom = 12;
          top = 12;
        };
      };

      # Only the essential keybindings
      mode.main.binding = {
        # Vim-style Window Selection
        alt-h = "focus left";
        alt-j = "focus down";
        alt-k = "focus up";
        alt-l = "focus right";

        # Vim-style Window Arrangement
        alt-shift-h = "move left";
        alt-shift-j = "move down";
        alt-shift-k = "move up";
        alt-shift-l = "move right";

        # Smart/Fast Workspace Switching
        alt-tab = "workspace-back-and-forth";

        # The 4 Core Workspaces
        alt-1 = "workspace 1";
        alt-2 = "workspace 2";
        alt-3 = "workspace 3";
        alt-4 = "workspace 4";

        # Moving windows across your 4 workspaces
        alt-shift-1 = "move-node-to-workspace 1";
        alt-shift-2 = "move-node-to-workspace 2";
        alt-shift-3 = "move-node-to-workspace 3";
        alt-shift-4 = "move-node-to-workspace 4";
      };
    };
