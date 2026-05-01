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

      -- Tinymist (The Best Typst LSP)
      -- It handles completions, hover, and live preview support
      vim.lsp.config("tinymist", {
        settings = {
          exportPdf = "onType", -- Automatically compile to PDF on save/type
          outputPath = "$root/$name.pdf",
        },
      })
      vim.lsp.enable("tinymist")

      -- Harper (The Spellchecker)
      -- This will provide grammar and spelling underlines
      vim.lsp.config("harper_ls", {
        settings = {
          ["harper-ls"] = {
            userDictPath = vim.fn.expand("~/.config/nvim/spell/en.utf-8.add"),
            fileDictPath = vim.fn.expand("~/.config/nvim/spell/en.utf-8.add"),
            linters = {
              spell_check = true,
              spelled_numbers = false,
            },
          },
        },
      })
      vim.lsp.enable("harper_ls")
    end,
  },
}
