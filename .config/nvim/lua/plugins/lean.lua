return {
  "Julian/lean.nvim",
  ft = { "lean" },
  dependencies = { "neovim/nvim-lspconfig" },
  config = function()
    require("lean").setup({
      lsp = {
        on_attach = function(_, bufnr)
          local map = function(mode, lhs, rhs) vim.keymap.set(mode, lhs, rhs, { buffer = bufnr }) end
          map("n", "K", vim.lsp.buf.hover)
          map("n", "gd", vim.lsp.buf.definition)
        end,
      },
    })
  end,
}
