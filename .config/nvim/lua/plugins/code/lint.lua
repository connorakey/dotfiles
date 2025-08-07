-- Nvim-lint a linting tool for Neovim.

return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile" }, -- translation: load when the file opens
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            lua = { "luacheck" },
            javascript = { "eslint" },
            typescript = { "eslint" },
        }

        -- Lint on save
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
