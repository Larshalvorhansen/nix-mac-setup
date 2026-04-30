return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        -- Change 'normal' to 'insert' so you can type immediately
        initial_mode = "insert",
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
        },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
    })

    telescope.load_extension("fzf")

    -- Keymaps: The "Prime" style uses <leader>p for project/find
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find Files" })
    vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Git Files" })
    vim.keymap.set(
      "n",
      "<leader>ps",
      function() builtin.grep_string({ search = vim.fn.input("Grep > ") }) end,
      { desc = "Grep String" }
    )
    vim.keymap.set("n", "<leader>vh", builtin.help_tags, { desc = "Help Tags" })
  end,
}
