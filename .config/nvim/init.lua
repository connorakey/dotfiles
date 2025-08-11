-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Set leaders
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup({
  spec = {
    -- catppuccin colorscheme
    {
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000,
      config = function()
        require("catppuccin").setup({ flavour = "frappe" })
        vim.cmd.colorscheme("catppuccin")
      end,
    },

    -- universal-clipboard
    {
      "swaits/universal-clipboard.nvim",
      opts = { verbose = false },
    },

    -- lualine statusline
    {
      "nvim-lualine/lualine.nvim",
      event = "VeryLazy",
      init = function()
        vim.g.lualine_laststatus = vim.o.laststatus
        if vim.fn.argc(-1) > 0 then
          vim.o.statusline = " "
        else
          vim.o.laststatus = 0
        end
      end,
      opts = function()
        local icons = {
          diagnostics = { Error = " ", Warn = " ", Info = " ", Hint = " " },
          git = { added = " ", modified = " ", removed = " " },
        }

        vim.o.laststatus = vim.g.lualine_laststatus

        return {
          options = {
            theme = "auto",
            globalstatus = vim.o.laststatus == 3,
            disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter" } },
          },
          sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch" },
            lualine_c = {
              function()
                local cwd = vim.fn.getcwd()
                return " " .. vim.fn.fnamemodify(cwd, ":t")
              end,
              {
                "diagnostics",
                symbols = {
                  error = icons.diagnostics.Error,
                  warn = icons.diagnostics.Warn,
                  info = icons.diagnostics.Info,
                  hint = icons.diagnostics.Hint,
                },
              },
              { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
              { "filename", path = 1 },
            },
            lualine_x = {
              "encoding",
              "fileformat",
              "filetype",
              {
                "diff",
                symbols = {
                  added = icons.git.added,
                  modified = icons.git.modified,
                  removed = icons.git.removed,
                },
                source = function()
                  local gitsigns = vim.b.gitsigns_status_dict
                  if gitsigns then
                    return {
                      added = gitsigns.added,
                      modified = gitsigns.changed,
                      removed = gitsigns.removed,
                    }
                  end
                end,
              },
            },
            lualine_y = {
              { "progress", separator = " ",                  padding = { left = 1, right = 0 } },
              { "location", padding = { left = 0, right = 1 } },
            },
            lualine_z = {
              function() return " " .. os.date("%R") end,
            },
          },
          inactive_sections = {
            lualine_c = { "filename" },
            lualine_x = { "location" },
          },
          extensions = { "neo-tree", "lazy", "fzf" },
        }
      end,
    },

    -- which-key for keybinding hints
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      config = function()
        local wk = require("which-key")
        wk.setup({})
        wk.register({
          c = {
            name = "Code",
            a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
            d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Go to Definition" },
            f = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format Code" },
            h = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover Documentation" },
            r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename Symbol" },
          },
          f = {
            name = "Find",
            b = { "<cmd>Telescope buffers<cr>", "Find Buffers" },
            f = { "<cmd>Telescope find_files<cr>", "Find Files" },
            g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
            h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
          },
        }, { prefix = "<leader>" })
      end,
    },

    -- project.nvim
    {
      "ahmedkhalf/project.nvim",
      config = function()
        require("project_nvim").setup({
          detection_methods = { "lsp", "pattern" },
          patterns = {
            ".git", "Cargo.toml", "Makefile", "pyproject.toml", "requirements.txt",
            "setup.py", "Pipfile", "go.mod", "package.json", "node_modules",
            "tsconfig.json", "init.lua", "README.md", "Dockerfile",
            "docker-compose.yml",
            ".env", ".envrc", "Makefile.toml", "Cargo.lock",
          },
          update_focused_file = { enable = true, update_cwd = true },
          show_hidden = false,
        })
      end,
    },

    -- telescope.nvim
    {
      "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      cmd = "Telescope",
    },

    -- neo-tree.nvim
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
      },
      config = function()
        require("neo-tree").setup({
          close_if_last_window = true,
          popup_border_style = "rounded",
          enable_git_status = true,
          enable_diagnostics = true,
          filesystem = {
            follow_current_file = { enabled = true, leave_dirs_open = false },
            filtered_items = {
              visible = false,
              hide_dotfiles = false,
              hide_gitignored = true,
            },
            use_libuv_file_watcher = true,
          },
          window = {
            position = "left",
            width = 30,
            mappings = {
              ["<space>"] = "none",
              ["o"] = "open",
              ["<cr>"] = "open",
              ["S"] = "open_split",
              ["s"] = "open_vsplit",
              ["t"] = "open_tabnew",
              ["a"] = "add",
              ["d"] = "delete",
              ["r"] = "rename",
              ["R"] = "refresh",
              ["q"] = "close_window",
            },
          },
        })
      end,
    },

    -- nvim-treesitter
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
        require("nvim-treesitter.configs").setup({
          auto_install = true,
          ensure_installed = { "bash", "html", "css", "javascript", "typescript", "json", "lua", "rust", "go" },
          highlight = { enable = true },
          indent = { enable = false },
        })
      end,
    },

    -- mason.nvim for managing LSP servers
    {
      "williamboman/mason.nvim",
      cmd = "Mason",
      config = function() require("mason").setup() end,
    },

    -- mason-lspconfig.nvim
    {
      "williamboman/mason-lspconfig.nvim",
      after = "mason.nvim",
      config = function()
        require("mason-lspconfig").setup({
          ensure_installed = { "rust_analyzer", "pyright", "ts_ls", "clangd", "lua_ls" },
          automatic_installation = true,
        })
      end,
    },

    -- nvim-lspconfig with blink.cmp capabilities, minimal default config + diagnostics inline
    {
      "neovim/nvim-lspconfig",
      dependencies = { "saghen/blink.cmp" },
      config = function()
        local lspconfig = require("lspconfig")
        local blink_cmp = require("blink.cmp")
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = blink_cmp.get_lsp_capabilities(capabilities)

        local servers = { "rust_analyzer", "pyright", "ts_ls", "clangd", "lua_ls" }
        for _, server in ipairs(servers) do
          lspconfig[server].setup({
            capabilities = capabilities,
          })
        end

        -- Diagnostics config: show inline errors/warnings/info/hints with circle symbol ●
        vim.diagnostic.config({
          virtual_text = {
            prefix = "●",
            spacing = 4,
            severity = { min = vim.diagnostic.severity.HINT },
          },
          signs = true,
          underline = true,
          update_in_insert = false,
          severity_sort = true,
          float = {
            border = "rounded",
            source = "always",
          },
        })
      end,
    },

    -- blink.cmp completion with Enter accept preset, no Tab mappings
    {
      "saghen/blink.cmp",
      dependencies = { "rafamadriz/friendly-snippets" },
      version = "1.*",
      opts = {
        keymap = { preset = "enter" },
        appearance = { nerd_font_variant = "mono" },
        completion = { documentation = { auto_show = false } },
        sources = { default = { "lsp", "path", "snippets", "buffer" } },
        fuzzy = { implementation = "prefer_rust_with_warning" },
      },
      opts_extend = { "sources.default" },
    },

    -- nvim-lint for linting
    {
      "mfussenegger/nvim-lint",
      event = { "BufReadPost", "BufNewFile" },
      config = function()
        local lint = require("lint")
        lint.linters.cargo = {
          cmd = "cargo",
          args = { "check", "--message-format=json" },
          stream = "stdout",
          parser = require("lint.parser").from_pattern(
            [[{"message":{"spans":[{"file_name":"(.-)","line_start":(%d+),"line_end":(%d+),"column_start":(%d+),"column_end":(%d+)}],"level":"(%a+)","message":"(.-)"}]],
            { "file", "lnum", "end_lnum", "col", "end_col", "severity", "message" },
            {
              severity = function(severity)
                if severity == "error" then
                  return "error"
                elseif severity == "warning" then
                  return "warning"
                else
                  return "info"
                end
              end,
            }
          ),
        }
        lint.linters_by_ft = {
          python = { "flake8" },
          lua = { "luacheck" },
          javascript = { "eslint" },
          typescript = { "eslint" },
          rust = { "cargo" },
          go = { "golangci_lint" },
          sh = { "shellcheck" },
        }

        -- Run lint on save, buffer enter, focus gain, insert leave with short delay for stable inline diagnostics
        vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "FocusGained", "InsertLeave" }, {
          callback = function()
            vim.defer_fn(function()
              lint.try_lint()
            end, 300)
          end,
        })
      end,
    }, -- nvim-lint end

    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      build = ":Copilot auth",
      event = "BufReadPost",
      opts = {

        suggestion = {
          enabled = false,
          panel = false,
          auto_trigger = true,
          hide_during_completion = vim.g.ai_cmp,
          keymap = {
            accept = false, -- handled by nvim-cmp / blink.cmp
            next = "<M-]>",
            prev = "<M-[>",
          },
        },
        panel = { enabled = false },
        filetypes = {
          markdown = true,
          help = true,
        },
      },
    }, -- copilot.lua end
    { "giuxtaposition/blink-cmp-copilot" },
    {
      "saghen/blink.cmp",
      optional = true,
      dependencies = { "giuxtaposition/blink-cmp-copilot" },
      opts = {
        sources = {
          default = { "copilot" },
          providers = {
            copilot = {
              name = "copilot",
              module = "blink-cmp-copilot",
              score_offset = 100,
              async = true,
            },
          },
        },
      },
    }, -- end blink.cmp
    {
      'echasnovski/mini.pairs',
      version = '*',
      config = function()
        require("mini.pairs").setup()
      end,

    },
  },
  install = { colorscheme = { "catppuccin" } },
  checker = { enabled = true },
})

-- Keymap to open neo-tree at project root with <leader>e
vim.keymap.set("n", "<leader>e", function()
  local project_root = require("project_nvim.project").get_project_root()
  if project_root and project_root ~= "" then
    vim.cmd("Neotree toggle dir=" .. project_root)
  else
    vim.cmd("Neotree toggle")
  end
end, { noremap = true, silent = true })

local keymap_opts = { noremap = true, silent = true }

-- Telescope keymaps
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", keymap_opts)
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", keymap_opts)
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", keymap_opts)
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", keymap_opts)

-- Code action keymaps
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, keymap_opts)
vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, keymap_opts)
vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, keymap_opts)
vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, keymap_opts)
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, keymap_opts)

-- Options
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.number = true
vim.opt.relativenumber = true

-- Suppress WARN notifications mainly from which-key
vim.notify = function(msg, level, opts)
  if level == vim.log.levels.WARN then return end
  vim.api.nvim_echo({ { msg } }, true, {})
end

-- Auto Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    local clients = vim.lsp.get_active_clients({ bufnr = vim.api.nvim_get_current_buf() })
    for _, client in ipairs(clients) do
      if client.supports_method("textDocument/formatting") then
        vim.lsp.buf.format({ async = false })
        return
      end
    end
  end,
})
