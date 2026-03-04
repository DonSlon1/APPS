-- Autocommands configuration

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Disable default LSP mappings to avoid conflicts
autocmd('LspAttach', {
  callback = function(args)
    -- Remove default gr mappings
    pcall(vim.keymap.del, 'n', 'grn')
    pcall(vim.keymap.del, 'n', 'gra')
    pcall(vim.keymap.del, 'n', 'grr')
    pcall(vim.keymap.del, 'n', 'gri')
    pcall(vim.keymap.del, 'n', 'grt')
    
    -- Ensure only one intelephense instance
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == "intelephense" then
      -- If this client doesn't have proper settings, stop it immediately
      if not client.config.settings or not client.config.settings.intelephense or not client.config.settings.intelephense.environment then
        vim.lsp.stop_client(client.id)
        -- Set up the correct one
        vim.defer_fn(function()
          require("lsp.php").setup(require("cmp_nvim_lsp").default_capabilities())
        end, 100)
      else
        -- This is the good client, stop all others
        local clients = vim.lsp.get_active_clients({ name = "intelephense" })
        for _, c in ipairs(clients) do
          if c.id ~= client.id then
            vim.lsp.stop_client(c.id)
          end
        end
      end
    end
  end,
})

-- File type specific settings
autocmd("FileType", {
  pattern = { "javascript", "typescript", "html", "css", "json", "yaml" },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
  end,
})

autocmd("FileType", {
  pattern = { "php", "python" },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
  end,
})

-- Elixir specific settings and keymaps
autocmd("FileType", {
  pattern = { "elixir", "eex", "heex" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    -- Add Elixir specific keymaps
    vim.keymap.set("n", "<leader>mf", ":!mix format %<CR>", { buffer = true, desc = "Format with mix" })
    vim.keymap.set("n", "<leader>mt", ":!mix test %<CR>", { buffer = true, desc = "Run tests" })
    vim.keymap.set("n", "<leader>mc", ":!mix compile<CR>", { buffer = true, desc = "Compile" })
  end,
})

-- Auto-format Elixir files on save (optional - comment out if you prefer manual formatting)
-- autocmd("BufWritePre", {
--   pattern = { "*.ex", "*.exs", "*.eex", "*.heex" },
--   callback = function()
--     local save_cursor = vim.fn.getpos(".")
--     vim.cmd("silent %!mix format -")
--     vim.fn.setpos(".", save_cursor)
--   end,
-- })

-- Highlight on yank
autocmd("TextYankPost", {
  group = augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
  group = augroup("remove_trailing_whitespace", { clear = true }),
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

-- Auto-create directories when saving a file
autocmd("BufWritePre", {
  group = augroup("auto_create_dir", { clear = true }),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Show cursor line only in active window
autocmd({ "InsertLeave", "WinEnter" }, {
  group = augroup("cursor_line", { clear = true }),
  callback = function()
    vim.opt_local.cursorline = true
  end,
})

autocmd({ "InsertEnter", "WinLeave" }, {
  group = augroup("cursor_line", { clear = false }),
  callback = function()
    vim.opt_local.cursorline = false
  end,
})

-- Close certain filetypes with q
autocmd("FileType", {
  group = augroup("close_with_q", { clear = true }),
  pattern = {
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "startuptime",
    "checkhealth",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Show help hint on startup
autocmd("VimEnter", {
  callback = function()
    vim.defer_fn(function()
      if vim.fn.argc() == 0 then
        -- Only show if no files were opened
        vim.notify("Press <leader>lh to see LSP keybindings or <leader>? for all keybindings", vim.log.levels.INFO, { title = "Neovim Help" })
      end
    end, 500)
  end,
})