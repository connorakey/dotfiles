local set = vim.opt

set.relativenumber = true
set.number = true

set.tabstop = 2
set.shiftwidth = 2
set.autoindent = true
set.expandtab = true

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*",  -- Apply to all file types
  callback = function()
    require("conform").format()
  end,
})

local lint = require("lint")
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = function()
    lint.try_lint()
  end,
})
