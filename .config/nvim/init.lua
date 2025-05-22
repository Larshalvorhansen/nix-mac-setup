-- Set leader key
vim.g.mapleader = " "

-- Set basic options
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = true

-- Tabs & Indentation
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 2 -- Size of an indent
vim.opt.tabstop = 22 -- Number of spaces a tab counts for
vim.opt.softtabstop = 2 -- Number of spaces inserted when pressing Tab

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
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
