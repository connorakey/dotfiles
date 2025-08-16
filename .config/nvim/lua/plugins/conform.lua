return {
  {
    'stevearc/conform.nvim',
    lazy = false,
    config = function()
      require('conform').setup({
        formatters = {
          python = { 'black', 'autopep8' },
          go = { 'gofmt' },
          rust = { 'rustfmt' },
          javascript = { 'prettier' },
          typescript = { 'prettier' },
        }
      })
    end
  }
}
