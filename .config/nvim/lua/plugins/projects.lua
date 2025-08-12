return {
	"ahmedkhalf/project.nvim",
	lazy = false,
	config = function()
		require("project_nvim").setup({
			autochdir = true, -- Disable project.nvim's autochdir
			detection_methods = { "pattern", "lsp" },
			patterns = {
				".git", -- Git repository
				"package.json", -- Node.js project
				"tsconfig.json", -- TypeScript project
				"go.mod", -- Go project
				"Cargo.toml", -- Rust project
				"pyproject.toml", -- Python project
				"setup.py", -- Python project
			},
		})
	end,
}
