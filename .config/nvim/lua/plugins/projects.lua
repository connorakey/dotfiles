return {
  "ahmedkhalf/project.nvim",
  lazy = false,
  config = function()
    require("project_nvim").setup({
      silent_chdir = true,
      detection_methods = { "lsp", "pattern" },
      patterns = {
        ".git",           -- Git repository
        "package.json",   -- Node.js project
        "tsconfig.json",  -- TypeScript project
        "go.mod",         -- Go project
        "Cargo.toml",     -- Rust project
        "pyproject.toml", -- Python project
        "setup.py",       -- Python project
      },
      scope_chdir = 'global',
      datapath = vim.fn.stdpath("data"),
    })
  end,
}
