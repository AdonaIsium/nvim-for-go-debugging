-- Tab Behavior
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true

-- Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Case
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Search
vim.opt.hlsearch = false

-- Scrolling
vim.opt.sidescrolloff = 8
vim.opt.scrolloff = 8

-- Responsiveness
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Split Behavior
vim.opt.splitright = true
vim.opt.splitbelow = true

-- White Space
vim.opt.list = true
vim.opt.listchars = { tab = " ", trail = "" }

-- Incremental Editing Preview
vim.opt.inccommand = "split"

-- Highlight Line
vim.opt.cursorline = true

-- Color Column
vim.opt.colorcolumn = "80"

-- Color Column for git commits
vim.cmd("autocmd FileType gitcommit set colorcolumn=50,72")
vim.cmd("autocmd BufRead,BufNewFile COMMIT set colorcolumn=50,72")
vim.cmd("autocmd BufRead,BufNewFile COMMIT set textwidth=72")
