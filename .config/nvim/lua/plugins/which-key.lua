return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.add({
      { "<leader>e",  desc = "Open File Explorer at Project Root", mode = "n" },

      { "<leader>f",  group = "file" },
      { "<leader>fb", desc = "Find Buffers",                       mode = "n" },
      { "<leader>fc", desc = "Fuzzy Find in Current Buffer",       mode = "n" },
      { "<leader>ff", desc = "Find File",                          mode = "n" },
      { "<leader>fr", desc = "Find Recent Files",                  mode = "n" },

      { "<leader>c",  group = "Code" },
      { "<leader>ca", desc = "Code Actions" },
      { "<leader>cd", desc = "Code Definition" },
      { "<leader>cf", desc = "Format Code" },
      { "<leader>ch", desc = "Hover Code Documentation" },
      { "<leader>cr", desc = "Rename Symbol" },

      { "<leader>h",  group = "Harpoon" },
      { "<leader>ha", desc = "Add File to Harpoon" },
      { "<leader>hh", desc = "Harpoon Menu" },
      { "<leader>hn", desc = "Next Harpoon File" },
      { "<leader>hp", desc = "Previous Harpoon File" },
    })
  end,
}
