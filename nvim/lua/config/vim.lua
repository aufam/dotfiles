vim.g.mapleader = " "

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 10
vim.opt.cursorline = false

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.autoindent = true
vim.opt.backspace = "indent,eol,start"
vim.opt.list = true
vim.opt.listchars = "tab:  ,trail:-"

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.smartcase = true
vim.opt.ignorecase = true

vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.titleold = "Terminal"
vim.opt.titlestring = "%F"

vim.cmd([[
  syntax match TodoComment /\v<(TODO|FIXME|NOTE):?/
  highlight TodoComment ctermfg=Yellow guifg=Yellow cterm=bold gui=bold
]])
