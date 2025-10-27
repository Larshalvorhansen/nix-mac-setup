return {
  "tpope/vim-dadbod",
  "kristijanhusak/vim-dadbod-completion",
  {
    "kristijanhusak/vim-dadbod-ui",
    config = function()
      -- Set initial DBUI save location to current working directory
      vim.g.db_ui_save_location = vim.fn.getcwd() .. "/.dbui"

      -- Update save location whenever directory changes
      vim.api.nvim_create_autocmd("DirChanged", {
        pattern = "*",
        callback = function() vim.g.db_ui_save_location = vim.fn.getcwd() .. "/.dbui" end,
      })
    end,
  },
}
