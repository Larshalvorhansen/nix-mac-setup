-- Set leader key
vim.g.mapleader = " "

-- Set basic options
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.clipboard = 'unnamedplus'
vim.opt.number = true
vim.opt.relativenumber = true

-- Tabs
--vim.opt.tabstop = 2
--vim.opt.shiftwidth = 2
--vim.opt.expandtab = true

-- Fonts
vim.opt.guifont = "JetBrainsMono:h16"

-- Colors
vim.opt.termguicolors = true
highlight = { enable = true }

vim.opt.backupcopy = "yes"

-- Bootstrap lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
