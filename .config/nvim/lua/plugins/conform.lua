return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				rust = { "rustfmt" },
				javascript = { "prettierd", "prettier" },
				typescript = { "prettierd", "prettier" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
		})
	end,
}
