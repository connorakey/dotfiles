--Keymap to open neotree at root directory.
vim.keymap.set("n", "<leader>e", function()
  local project_root = require("project_nvim.project").get_project_root()
  if project_root and project_root ~= "" then
    vim.cmd("Neotree toggle dir=" .. project_root)
  else
    vim.cmd("Neotree toggle")
  end
end, { noremap = true, silent = true })

local telescope = require("telescope.builtin")

vim.keymap.set("n", "<leader>fb", telescope.buffers)
vim.keymap.set("n", "<leader>fc", telescope.current_buffer_fuzzy_find)
vim.keymap.set("n", "<leader>ff", telescope.find_files)
vim.keymap.set("n", "<leader>fr", telescope.oldfiles)
vim.keymap.set("n", "<leader>fp", function()
  require("telescope").extensions.project.project({ display_type = "full" })
end, { desc = "Find Projects" })

local conform = require("conform")

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition)
vim.keymap.set("n", "<leader>cf", function()
  require('conform').format({ lsp_format = "fallback" })
end, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename)

local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<leader>ha", function()
  harpoon:list():add()
end)
vim.keymap.set("n", "<leader>hh", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)
vim.keymap.set("n", "<leader>hn", function()
  harpoon:list():next()
end)
vim.keymap.set("n", "<leader>hp", function()
  harpoon:list():prev()
end)
