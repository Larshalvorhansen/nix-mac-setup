return {
  "stevearc/conform.nvim",
  opts = {
    -- Autoformat on save
    format_on_save = {
      lsp_fallback = true,
      timeout_ms = 500,
    },

    -- Per-language formatter setup
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "black" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      json = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      sh = { "shfmt" },
      go = { "gofmt" },
      rust = { "rustfmt" },
      nix = { "nixfmt" },
      c = { "clang_format" },
      cpp = { "clang_format" },
    },
  },
}
