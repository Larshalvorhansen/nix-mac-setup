return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "markdown",
      "latex",
      "bash",
      "python",
      "json",
      "html",
      "css",
      "javascript",
    },
    highlight = { enable = true },
    indent = { enable = true },
    auto_install = true,
  },
}
