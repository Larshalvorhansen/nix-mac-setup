-- Animated "smear" cursor: the cursor stretches and leaps to its new position
-- https://github.com/sphamba/smear-cursor.nvim
-- Note: kitty's own cursor_trail is set to 0 in modules/kitty.nix; keep it that
-- way or you'll get two trails on top of each other.
return {
  "sphamba/smear-cursor.nvim",
  event = "VeryLazy",
  opts = {
    smear_between_buffers = true, -- animate when jumping between windows/buffers
    smear_between_neighbor_lines = true, -- animate j/k moves too
    scroll_buffer_space = true, -- smear follows scrolling (<C-d>/<C-u>)
    smear_insert_mode = true, -- also smear the beam cursor in insert mode
    legacy_computing_symbols_support = false,

    -- Feel: lower stiffness = slower, longer trail; higher = snappier
    -- stiffness = 0.8,
    -- trailing_stiffness = 0.5,
    -- distance_stop_animating = 0.5,
  },
}
