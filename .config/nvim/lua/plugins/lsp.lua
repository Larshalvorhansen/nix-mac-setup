return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- TypeScript / JavaScript
        tsserver = {
          settings = {
            typescript = { format = { enable = false } },
            javascript = { format = { enable = false } },
          },
        },

        -- Python
        pyright = {},

        -- Rust
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              check = { command = "clippy" },
            },
          },
        },

        -- Go
        gopls = {},

        -- C/C++
        clangd = {},

        -- R (R language server)
        r_language_server = {},
      },
    },
  },
}
