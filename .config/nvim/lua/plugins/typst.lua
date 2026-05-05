return {
  "chomosuke/typst-preview.nvim",
  ft = "typst",
  version = "1.*",

  -- NO build function! This was the main problem
  -- (calling .update() forces the plugin to ignore your Nix binaries)
  config = function()
    require("typst-preview").setup({
      -- Tell it to use the binaries Nix already gave you
      dependencies_bin = {
        tinymist = vim.fn.exepath("tinymist") or "tinymist",
        websocat = vim.fn.exepath("websocat") or "websocat",
      },

      -- These three lines fix the URL problem you had
      debug = true, -- creates a log file (super useful right now)
      port = 8383, -- fixed port → URL never changes again
      host = "127.0.0.1",

      -- Auto-open the browser reliably (uncomment the one you need)
      -- open_cmd = "xdg-open %s",      -- most NixOS / Linux desktops
      -- open_cmd = "open %s",          -- macOS
      -- open_cmd = "explorer.exe %s",  -- WSL / Windows

      -- Nice extras (optional but recommended)
      -- invert_colors = "auto",
      -- follow_cursor = true,
    })
  end,
}
