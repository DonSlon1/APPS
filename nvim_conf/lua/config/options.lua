-- Basic Neovim settings

local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs and indentation
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true

-- Line wrapping
opt.wrap = true
opt.linebreak = true
opt.breakindent = true
opt.showbreak = "↪ "

-- File handling
opt.swapfile = false
opt.backup = false
opt.undodir = vim.fn.stdpath("data") .. "/undodir"
opt.undofile = true

-- Search
opt.hlsearch = false
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Appearance
opt.termguicolors = true
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.colorcolumn = "80"
opt.cursorline = true

-- Performance
opt.updatetime = 50

-- Splits
opt.splitbelow = true
opt.splitright = true

-- System
opt.mouse = "a"
opt.clipboard = "unnamedplus"

-- Leaders
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Spell checking
opt.spell = true
opt.spelllang = "en_us"
opt.spelloptions = "camel"