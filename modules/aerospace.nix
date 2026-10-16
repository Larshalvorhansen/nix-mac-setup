settings = {
  # Startup Hooks (Keeping your top bar & window border integrations active)
  "after-startup-command" = [ "exec-and-forget sketchybar" ];
  "exec-on-workspace-change" = [
    "exec-and-forget sketchybar --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE"
    "exec-and-forget borders active_color=0xffe1e3e4 inactive_color=0xff494d64 width=0"
  ];

  "start-at-login" = false;

  # --- Automatic tiling behavior ---
  # Default layout for new workspaces. "h_accordion" / "v_accordion" are
  # the "master + stacked" styles; "tiles" is the classic niri/PaperWM
  # scrolling-strip layout; "accordion" is a single-window-focus stack.
  # Omit this line to keep AeroSpace's default ("tiles").
  # default-root-container-layout = "tiles";

  # What to do when a new window opens on a workspace that already has
  # windows: "auto" (default, respect the layout), "horizontal", "vertical",
  # or "opposite". "auto" is the sane choice for automatic tiling.
  default-root-container-orientation = "auto";

  # Automatically flatten containers so 2 windows side-by-side don't get
  # nested inside an accordion. Makes alt-h/j/k/l navigation feel natural.
  "automatically-unhide-macos-hidden-apps" = false;

  # Simple, clean gaps so 1 or 2 windows look sharp
  gaps = {
    inner.horizontal = 2;
    inner.vertical = 2;
    outer = {
      left = 2;
      right = 2;
      bottom = 2;
      top = 2;
    };
  };

  # --- Automatic tiling keybindings ---
  # These let you flip between layouts on the fly, which is the main thing
  # people miss when they say "automatic tiling". Every layout is still
  # automatic; you're just choosing the shape.
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

    # --- Layout switchers (this is the "automatic tiling" toggle) ---
    alt-slash = "layout tiles horizontal vertical";  # cycle tiling orientations
    alt-comma = "layout accordion horizontal vertical";  # cycle accordion orientations

    # Force-resize the focused window's share of its container
    # (works in tiles layout — grows/shrinks the split)
    alt-shift-minus = "resize smart -50";
    alt-shift-equal = "resize smart +50";

    # Fullscreen the focused window within its workspace (macOS fullscreen
    # is a different thing and doesn't play well with tiling)
    alt-f = "fullscreen";

    # Toggle the "accordion" behavior on the current container
    alt-shift-space = "flatten-workspace-tree";
  };
};
