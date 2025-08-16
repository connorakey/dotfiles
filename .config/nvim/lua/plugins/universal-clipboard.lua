return {
  "swaits/universal-clipboard.nvim",
  config = function()
    require("universal-clipboard").setup({
      verbose = false,
    })
  end,
}
