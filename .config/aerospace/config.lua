-- ~/.config/aerospace/init.lua
-- AeroSpace configuration in Lua format

return {
  -- Reduced from 300 to utilize more space
  ["accordion-padding"] = 120,

  ["after-login-command"] = {},
  ["after-startup-command"] = { "exec-and-forget sketchybar" },
  ["automatically-unhide-macos-hidden-apps"] = false,
  ["default-root-container-layout"] = "tiles",
  ["default-root-container-orientation"] = "auto",
  ["enable-normalization-flatten-containers"] = true,
  ["enable-normalization-opposite-orientation-for-nested-containers"] = true,

  ["exec-on-workspace-change"] = {
    "exec-and-forget sketchybar --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE",
    "exec-and-forget borders active_color=0xffe1e3e4 inactive_color=0xff494d64 width=0",
  },

  ["on-focused-monitor-changed"] = { "move-mouse monitor-lazy-center" },
  ["start-at-login"] = false,

  -- Reduced inner gaps
  ["gaps.inner"] = {
    horizontal = { { monitor = { main = 16 } }, 6 },
  },

  -- Reduced outer gaps (main monitor values significantly lowered from 350/100)
  ["gaps.outer"] = {
    bottom = { { monitor = { main = 40 } }, 6 },
    left = { { monitor = { main = 140 } }, 10 },
    right = { { monitor = { main = 140 } }, 10 },
    top = { { monitor = { main = 40 } }, 6 },
  },

  ["key-mapping"] = {
    preset = "qwerty",
  },

  ["mode.apps.binding"] = {
    ["alt-w"] = { "exec-and-forget open -a /Applications/WezTerm.app", "mode main" },
  },

  ["mode.main.binding"] = {
    ["alt-1"] = "workspace 1",
    ["alt-2"] = "workspace 2",
    ["alt-3"] = "workspace 3",
    ["alt-4"] = "workspace 4",
    ["alt-h"] = "focus left",
    ["alt-j"] = "focus down",
    ["alt-k"] = "focus up",
    ["alt-l"] = "focus right",
    ["alt-shift-1"] = "move-node-to-workspace 1 --focus-follows-window",
    ["alt-shift-2"] = "move-node-to-workspace 2 --focus-follows-window",
    ["alt-shift-3"] = "move-node-to-workspace 3 --focus-follows-window",
    ["alt-shift-4"] = "move-node-to-workspace 4 --focus-follows-window",
    ["alt-shift-down"] = "join-with down",
    ["alt-shift-down-shift-j"] = "move down",
    ["alt-shift-h"] = "move left",
    ["alt-shift-j"] = "move down",
    ["alt-shift-k"] = "move up",
    ["alt-shift-l"] = "move right",
    ["alt-shift-left"] = "join-with left",
    ["alt-shift-right"] = "join-with right",
    ["alt-shift-up"] = "join-with up",
  },

  ["mode.service.binding"] = {
    backspace = { "close-all-windows-but-current", "mode main" },
    esc = { "reload-config", "mode main" },
    f = { "layout floating tiling", "mode main" },
    r = { "flatten-workspace-tree", "mode main" },
  },

  ["workspace-to-monitor-force-assignment"] = {
    ["1"] = "^Built-in.*$",
    ["2"] = "^DELL U.*$",
    ["3"] = "^DELL S.*$",
  },
}
