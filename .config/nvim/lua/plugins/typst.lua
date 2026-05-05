return {
  "chomosuke/typst-preview.nvim",
  ft = "typst",
  version = "1.*",
  build = function()
    -- This tells the plugin NOT to download binaries because Nix provides them
    require("typst-preview").update()
  end,
  opts = {
    -- Explicitly tell the plugin where the Nix-installed binaries are
    dependencies_bin = {
      ["tinymist"] = "tinymist",
      ["websocat"] = "websocat",
    },
  },
}
