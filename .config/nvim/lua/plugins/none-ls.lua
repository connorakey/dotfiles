return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				-- C
				null_ls.builtins.formatting.clang_format, -- Formatter
				null_ls.builtins.diagnostics.clang_check, -- Linter

				-- Rust
				null_ls.builtins.formatting.rustfmt, -- Formatter
        null_ls.builtins.diagnostics.clippy, -- Linter

				-- Python
				null_ls.builtins.formatting.black, -- Formatter
				null_ls.builtins.formatting.isort, -- Import sorter
				null_ls.builtins.diagnostics.ruff, -- Linter

				-- JavaScript / TypeScript
				null_ls.builtins.formatting.prettier, -- Formatter
				null_ls.builtins.diagnostics.eslint_d, -- Linter

        -- Lua
        null_ls.builtins.formatting.stylua, -- Formatter
			},
		})

		-- Format only with none-ls
		vim.keymap.set("n", "<leader>cf", function()
			vim.lsp.buf.format({
				async = true,
				filter = function(client)
					return client.name == "null-ls"
				end,
			})
		end, { desc = "Format with none-ls" })
	end,
}
