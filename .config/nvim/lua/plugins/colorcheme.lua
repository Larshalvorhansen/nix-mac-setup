return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			highlight_overrides = {
				mocha = function(colors)
					return {
						Normal = { bg = "#000000" },
						NormalNC = { bg = "#000000" },
						NormalFloat = { bg = "#000000" },
						FloatBorder = { bg = "#000000" },
						SignColumn = { bg = "#000000" },
						VertSplit = { bg = "#000000" },
						StatusLine = { bg = "#000000" },
						LineNr = { bg = "#000000" },
						CursorLine = { bg = "#000000" },
						CursorLineNr = { bg = "#000000" },
					}
				end,
			},
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
