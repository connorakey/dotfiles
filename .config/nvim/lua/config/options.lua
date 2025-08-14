local set = vim.opt

set.relativenumber = true
set.number = true

set.tabstop = 2
set.shiftwidth = 2
set.autoindent = true
set.expandtab = true


vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        vim.lsp.buf.format({
            bufnr = args.buf,
            async = false,
            filter = function(client)
                return client.name == "null-ls"
            end,
        })
    end,
})
