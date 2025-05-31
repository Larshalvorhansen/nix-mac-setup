return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      lspconfig.tsserver = nil -- optional: just in case
      lspconfig.ts_ls.setup({
        settings = {
          typescript = { format = { enable = false } },
          javascript = { format = { enable = false } },
        },
      })

      lspconfig.pyright.setup({})
      lspconfig.rust_analyzer.setup({
        settings = {
          ["rust-analyzer"] = {
            check = { command = "clippy" },
          },
        },
      })

      lspconfig.gopls.setup({})
      lspconfig.clangd.setup({})
      lspconfig.r_language_server.setup({})
    end,
  },
}
