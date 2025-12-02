local opt = vim.opt

-- Editing
opt.backspace = 'indent,eol,start'
opt.nu = true
opt.relativenumber = true
opt.signcolumn = 'auto'
opt.updatetime = 50

-- Saving
opt.backup = false
opt.swapfile = false
opt.undodir = vim.fn.expand(vim.fn.stdpath('state') .. '/nvim/undo/')
opt.undofile = true

-- Search
opt.hlsearch = false
opt.ignorecase = true
opt.incsearch = true
opt.smartcase = true

-- Whitespace
opt.colorcolumn = '80'
opt.expandtab = true
opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 4
opt.smartindent = true

-- Windowing
opt.splitbelow = true
opt.splitright = true
