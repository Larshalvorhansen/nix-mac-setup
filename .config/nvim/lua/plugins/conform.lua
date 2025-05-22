return {
	"stevearc/conform.nvim",
	opts = {
		-- Format on save with fallback to LSP formatter
		format_on_save = {
			lsp_fallback = true,
			timeout_ms = 1000, -- bumped up to 1s for slower formatters
		},

		-- Define formatters per filetype
		formatters_by_ft = {
			c = { "clang_format" },
			cpp = { "clang_format" },
			css = { "prettier" },
			go = { "gofmt" },
			html = { "prettier" },
			javascript = { "prettier" },
			json = { "prettier" },
			lua = { "stylua" },
			markdown = { "prettier" },
			nix = { "nixfmt-classic" },
			python = { "black" },
			rust = { "rustfmt" },
			sh = { "shfmt" },
			typescript = { "prettier" },
			typst = { "typstfmt" },
			yaml = { "prettier" },
		},

		-- Optional: define custom formatter behavior
		formatters = {
			shfmt = {
				prepend_args = { "-i", "2", "-ci" }, -- customize shell formatting
			},
			prettier = {
				condition = function(ctx)
					-- Only use prettier if a config file is present
					return vim.fs.find(
						{ ".prettierrc", ".prettierrc.json", "prettier.config.js" },
						{ upward = true, path = ctx.dirname }
					)[1]
				end,
			},
		},
	},
}
