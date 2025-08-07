local vo = vim.opt

-- Line Numbers
vo.relativenumber = true
vo.number = true

-- Indentation and Tabs
vo.tabstop = 4
vo.shiftwidth = 4
vo.autoindent = true
vo.expandtab = true

-- Search Settings
vo.ignorecase = true
vo.smartcase = true

-- Undo Dir Settings
vo.swapfile = false
vo.backup = false
vo.undodir = os.getenv("HOME") .. "/.nvim/undodir"
vo.undofile = true
