return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- TypeScript/JavaScript
      vim.lsp.config("ts_ls", {
        settings = {
          typescript = { format = { enable = false } },
          javascript = { format = { enable = false } },
        },
      })
      vim.lsp.enable("ts_ls")

      -- Python
      vim.lsp.config("pyright", {})
      vim.lsp.enable("pyright")

      -- Rust
      vim.lsp.config("rust_analyzer", {
        settings = {
          ["rust-analyzer"] = {
            check = { command = "clippy" },
          },
        },
      })
      vim.lsp.enable("rust_analyzer")

      -- Go
      vim.lsp.config("gopls", {})
      vim.lsp.enable("gopls")

      -- C/C++
      vim.lsp.config("clangd", {})
      vim.lsp.enable("clangd")

      -- R
      vim.lsp.config("r_language_server", {})
      vim.lsp.enable("r_language_server")
    end,
  },
}
