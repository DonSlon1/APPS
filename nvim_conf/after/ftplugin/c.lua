-- C-specific settings

-- Set tab/indent settings for C
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = true

-- Set comment string
vim.opt_local.commentstring = "// %s"

-- Enable line numbers and relative line numbers
vim.opt_local.number = true
vim.opt_local.relativenumber = true

-- Set colorcolumn at 80 characters
vim.opt_local.colorcolumn = "80"

-- Enable spell checking in comments
vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us"

-- Set makeprg for C files
vim.opt_local.makeprg = "gcc -O2 -g -Wno-unused-result -Wall -Wextra -Wconversion -Wdangling-pointer=1 -Werror=uninitialized -Werror=vla -Werror=return-type % -o %:r -lm"

-- Format options
vim.opt_local.formatoptions:append("ro")
vim.opt_local.formatoptions:remove("t")

-- Set path for file searching (gf command)
vim.opt_local.path:append("/usr/include")
vim.opt_local.path:append("/usr/local/include")

-- Folding settings
vim.opt_local.foldmethod = "syntax"
vim.opt_local.foldlevel = 99

-- Auto-insert header guards for .h files
local group = vim.api.nvim_create_augroup("CHeaderGuard", { clear = true })
vim.api.nvim_create_autocmd("BufNewFile", {
  group = group,
  pattern = "*.h",
  callback = function()
    local filename = vim.fn.expand("%:t:r"):upper()
    local guard = filename .. "_H_"
    local lines = {
      "#ifndef " .. guard,
      "#define " .. guard,
      "",
      "",
      "",
      "#endif /* " .. guard .. " */",
    }
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    vim.api.nvim_win_set_cursor(0, {4, 0})
  end,
})

-- Quick compile and run
vim.keymap.set("n", "<F6>", ":w<CR>:!gcc -O2 -g -Wno-unused-result -Wall -Wextra -Wconversion -Wdangling-pointer=1 -Werror=uninitialized -Werror=vla -Werror=return-type % -o %:r -lm && ./%:r<CR>",
  { buffer = true, desc = "Compile and run C file" })
vim.keymap.set("n", "<F7>", ":w<CR>:!gcc -O2 -g -Wno-unused-result -Wall -Wextra -Wconversion -Wdangling-pointer=1 -Werror=uninitialized -Werror=vla -Werror=return-type % -o %:r -lm<CR>",
  { buffer = true, desc = "Compile C file" })
vim.keymap.set("n", "<F8>", ":!./%:r<CR>",
  { buffer = true, desc = "Run compiled C file" })

-- Quick access to man pages
vim.keymap.set("n", "K", function()
  local word = vim.fn.expand("<cword>")
  vim.cmd("Man 3 " .. word .. " || Man 2 " .. word .. " || Man " .. word)
end, { buffer = true, desc = "Open man page for word under cursor" })