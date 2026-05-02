return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- === CUSTOM AUTO-FIX KEYMAP ===
      -- Jump to next error and apply the first suggestion
      vim.keymap.set("n", "<leader>ff", function()
        -- 1. Jump to the next diagnostic (error/warning)
        vim.diagnostic.goto_next({ float = false })

        -- 2. Brief delay to let the cursor settle so LSP knows where we are
        vim.defer_fn(function()
          -- 3. Apply the first code action automatically
          vim.lsp.buf.code_action({
            apply = true,
            filter = function(action)
              -- This picks the first one; works great for Harper/Typos
              return action.isPreferred or true
            end,
          })
        end, 100)
      end, { desc = "Jump to next error and auto-fix" })

      -- === LSP SERVER CONFIGS ===

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
      vim.lsp.config("tinymist", {
        settings = {
          exportPdf = "onType",
          outputPath = "$root/$name.pdf",
        },
      })
      vim.lsp.enable("tinymist")

      -- Harper (The Spellchecker)
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
