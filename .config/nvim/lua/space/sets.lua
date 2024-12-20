vim.opt.mouse = nil

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.expandtab = true -- false
vim.opt.shiftwidth = 2 -- 4
vim.opt.tabstop = 2 -- 4
vim.opt.softtabstop = 2 -- 4
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.breakindent = true -- Enable break indent
vim.opt.cindent = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.mouse = "a" -- Enable mouse mode, can be useful for resizing splits for example!

vim.opt.showmode = false -- It's already in the status line
vim.opt.signcolumn = "yes" -- Keep signcolumn on by default
vim.opt.cursorline = false -- Show which line your cursor is on
-- vim.opt.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor.

vim.opt.ignorecase = true -- Case-insensitive searching
vim.opt.smartcase = true -- UNLESS \C or one or more capital letters in the search term

vim.opt.updatetime = 250 -- Decrease swapfile update time
vim.opt.timeoutlen = 300 -- Decrease mapped sequence wait time

vim.opt.inccommand = "split" -- Preview substitutions live, as you type!
vim.opt.undofile = true -- Save undo history

-- How new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
