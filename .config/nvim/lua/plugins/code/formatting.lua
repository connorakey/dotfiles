# conform.nvim a formatter for Neovim
return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" }, -- translation: only load on write
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                -- fallback for everything else
                ["_"] = { "trim_whitespace" },
            },

            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true, -- use LSP formatting if no formatter is configured.
            },
        })
    end,
}
