return {
  "mfussenegger/nvim-lint",
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      rust = { "clippy" },
      lua = { "luacheck" },
      go = { "golangcilint" },
      python = { "flake8" },
    }
  end,
}
