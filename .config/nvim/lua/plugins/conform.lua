return {
  "stevearc/conform.nvim",
  opts = function()
    return {
      -- Format on save for all filetypes
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 1000,
      },

      -- Formatters by filetype
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        go = { "gofmt" },
        rust = { "rustfmt" },
        sh = { "shfmt" },
        nix = { "alejandra", "nixfmt" }, -- try alejandra, then nixfmt-classic
        javascript = { "prettier" },
        typescript = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        typst = { "typstfmt" },
      },

      -- Optional: extra formatter settings
      formatters = {
        alejandra = {
          condition = function(ctx) return vim.fn.executable("alejandra") == 1 end,
        },
        nixfmt_classic = {
          condition = function(ctx) return vim.fn.executable("nixfmt-classic") == 1 end,
        },
        prettier = {
          condition = function(ctx) return vim.fn.executable("prettier") == 1 end,
        },
        shfmt = {
          prepend_args = { "-i", "2", "-ci" },
        },
        stylua = {
          prepend_args = {
            "--indent-type",
            "Spaces",
            "--indent-width",
            "2",
            "--column-width",
            "100",
            "--collapse-simple-statement",
            "Always",
            "--quote-style",
            "AutoPreferDouble",
          },
        },
      },
    }
  end,

  -- Hook format-on-save to BufWritePre
  config = function(_, opts)
    require("conform").setup(opts)
    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function(args) require("conform").format({ bufnr = args.buf }) end,
    })
  end,
}
