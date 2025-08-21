return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = { "nvim-lua/plenary.nvim" },
  init = function()
    -- Only affect markdown buffers
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function() vim.opt_local.conceallevel = 2 end,
    })
  end,
  opts = {
    workspaces = {
      { name = "work", path = "~/Documents/sb" },
    },
  },
}
