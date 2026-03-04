-- Ultimate Neovim Configuration for Web Development
-- Modular configuration structure

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load core configuration
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Load plugins with lazy.nvim
require("lazy").setup("plugins", {
  defaults = { lazy = false },
  install = { colorscheme = { "catppuccin" } },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- Custom command to show LSP keybindings help
vim.api.nvim_create_user_command("LspKeybindings", function()
  local help_text = [[
LSP Keybindings Help:

Navigation:
  gd          - Go to definition
  gD          - Go to declaration
  gr          - Go to references
  gi          - Go to implementation
  K           - Hover documentation (show info about symbol)

Code Actions:
  <leader>ca  - Code action (show available actions)
  <leader>cr  - Rename symbol
  <leader>cf  - Format file

Diagnostics:
  [d          - Go to previous diagnostic
  ]d          - Go to next diagnostic
  <leader>de  - Show diagnostic error in floating window
  <leader>dl  - Add diagnostics to location list
  <leader>td  - Toggle diagnostics

PHP Specific:
  <leader>pi  - Import PHP class
  <leader>pf  - Run PHP CS Fixer on current file
  <leader>ps  - Run PHPStan analysis on current file
  <leader>pu  - Run PHPUnit test on current file

Tips:
  - Press <Space> to see all leader key mappings
  - Press g to see all go-to mappings
  - Use :WhichKey to explore keybindings interactively
  ]]

  -- Create a floating window to display help
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(help_text, "\n"))
  vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")

  local width = 60
  local height = 30
  local win_opts = {
    relative = "editor",
    width = width,
    height = height,
    col = (vim.o.columns - width) / 2,
    row = (vim.o.lines - height) / 2,
    border = "rounded",
    style = "minimal",
    title = " LSP Keybindings ",
    title_pos = "center",
  }

  local win = vim.api.nvim_open_win(buf, true, win_opts)
  vim.api.nvim_buf_set_option(buf, "modifiable", false)
  vim.api.nvim_buf_set_keymap(buf, "n", "q", ":close<CR>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", ":close<CR>", { noremap = true, silent = true })
end, { desc = "Show LSP keybindings help" })
