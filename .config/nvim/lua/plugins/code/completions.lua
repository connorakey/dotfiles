return {
    {
        "saghen/blink.cmp",
        version = "1.*", -- Use latest release with prebuilt binaries
        event = "InsertEnter",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        opts = {
            keymap = {
                preset = "enter", -- Disable default mappings
            },
            appearance = {
                nerd_font_variant = "mono",
            },
            completion = {
                documentation = {
                    auto_show = true,
                },
            },
            sources = {
                default = { "lsp", "snippets", "path", "buffer" },
            },
            fuzzy = {
                implementation = "prefer_rust_with_warning",
            },
        },
        opts_extend = { "sources.default" },
        config = function(_, opts)
            require("luasnip.loaders.from_vscode").lazy_load()
            require("blink-cmp").setup(opts)
        end,
    },

    {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
    },

    {
        "giuxtaposition/blink-cmp-copilot"
    },
}
