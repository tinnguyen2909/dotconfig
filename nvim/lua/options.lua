local opt = vim.opt
local g = vim.g

g.mapleader = " "

opt.termguicolors = true
-- vim.cmd "colorscheme nightfox"
vim.cmd "set relativenumber"

opt.list = true
opt.listchars:append "space:⋅"
opt.listchars:append "eol:↴"

opt.mouse = {}

opt.laststatus = 3 -- global statusline
opt.showmode = false

opt.title = true
opt.clipboard = "unnamedplus"
opt.cursorline = true

-- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
-- opt.mouse = "a"

-- Numbers
opt.number = true
opt.numberwidth = 2
-- opt.ruler = false

local opts = { noremap = true, silent = true }
