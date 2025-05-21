return {
	"stevearc/conform.nvim",
	opts = {
		format_on_save = {
			lsp_fallback = true,
			timeout_ms = 500,
		},
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
	},
}
