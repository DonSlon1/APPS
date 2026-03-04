-- Keymaps configuration

local keymap = vim.keymap.set

-- File explorer
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
keymap("n", "<leader>E", ":NvimTreeFindFile<CR>", { desc = "Find current file in explorer" })
keymap("n", "<leader>o", ":NvimTreeFocus<CR>", { desc = "Focus file explorer" })

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files" })
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live grep" })
keymap("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Find buffers" })
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Help tags" })
keymap("n", "<leader>fr", ":Telescope oldfiles<CR>", { desc = "Recent files" })
keymap("n", "<leader>fc", ":Telescope colorscheme<CR>", { desc = "Colorschemes" })

-- Force trigger completion
keymap("i", "<C-Space>", function() require('cmp').complete() end, { desc = "Trigger completion" })

-- LSP (will be active when LSP attaches)
keymap("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
keymap("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
keymap("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
keymap("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
keymap("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
keymap("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename symbol" })
keymap("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
keymap("n", "<leader>cf", function()
  -- Use LSP format if available, otherwise use language-specific formatter
  if vim.bo.filetype == "elixir" then
    vim.cmd("!mix format %")
  else
    vim.lsp.buf.format()
  end
end, { desc = "Format file" })

-- Git with lazygit in toggleterm
function _lazygit_toggle()
  local Terminal = require('toggleterm.terminal').Terminal
  local lazygit = Terminal:new({
    cmd = "lazygit",
    direction = "float",
    float_opts = {
      border = "curved",
      width = function()
        return math.floor(vim.o.columns * 0.9)
      end,
      height = function()
        return math.floor(vim.o.lines * 0.9)
      end,
    },
    on_open = function(term)
      vim.cmd("startinsert!")
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
    end,
    on_close = function(term)
      vim.cmd("startinsert!")
    end,
  })
  lazygit:toggle()
end

keymap("n", "<leader>gg", "<cmd>lua _lazygit_toggle()<CR>", { desc = "LazyGit" })
keymap("n", "<leader>gj", ":Gitsigns next_hunk<CR>", { desc = "Next hunk" })
keymap("n", "<leader>gk", ":Gitsigns prev_hunk<CR>", { desc = "Previous hunk" })
keymap("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "Preview hunk" })
keymap("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
keymap("n", "<leader>gb", ":Gitsigns blame_line<CR>", { desc = "Blame line" })

-- Diffview keymaps
keymap("n", "<leader>gdo", ":DiffviewOpen<CR>", { desc = "Open Diffview" })
keymap("n", "<leader>gdc", ":DiffviewClose<CR>", { desc = "Close Diffview" })
keymap("n", "<leader>gdh", ":DiffviewFileHistory %<CR>", { desc = "File History" })
keymap("n", "<leader>gdf", ":DiffviewFocusFiles<CR>", { desc = "Focus Files" })
keymap("n", "<leader>gdt", ":DiffviewToggleFiles<CR>", { desc = "Toggle Files" })

-- Diagnostics
keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
keymap("n", "<leader>de", vim.diagnostic.open_float, { desc = "Show diagnostic error" })
keymap("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Add diagnostics to location list" })

-- Toggle diagnostics
keymap("n", "<leader>td", function()
  if vim.diagnostic.is_enabled({ bufnr = 0 }) then
    vim.diagnostic.enable(false, { bufnr = 0 })
    print("Diagnostics disabled")
  else
    vim.diagnostic.enable(true, { bufnr = 0 })
    print("Diagnostics enabled")
  end
end, { desc = "Toggle diagnostics" })

-- Buffers
keymap("n", "<Tab>", ":BufferLineCycleNext<CR>", { desc = "Next buffer" })
keymap("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
keymap("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

-- Save and quit
keymap("n", "<leader>w", ":w<CR>", { desc = "Save file" })
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit" })
keymap("n", "<leader>Q", ":q!<CR>", { desc = "Quit without saving" })
keymap("n", "<leader>W", ":wq<CR>", { desc = "Save and quit" })

-- Trouble
keymap("n", "<leader>xx", ":TroubleToggle<CR>", { desc = "Toggle trouble" })
keymap("n", "<leader>xw", ":TroubleToggle workspace_diagnostics<CR>", { desc = "Workspace diagnostics" })
keymap("n", "<leader>xd", ":TroubleToggle document_diagnostics<CR>", { desc = "Document diagnostics" })

-- Terminal
keymap("n", "<leader>tt", ":ToggleTerm<CR>", { desc = "Toggle terminal" })
keymap("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize windows
keymap("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
keymap("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Move text up and down
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move text down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text up" })

-- Stay in indent mode
keymap("v", "<", "<gv", { desc = "Indent left" })
keymap("v", ">", ">gv", { desc = "Indent right" })

-- Maintain cursor position
keymap("n", "J", "mzJ`z", { desc = "Join lines" })
keymap("n", "<C-d>", "<C-d>zz", { desc = "Page down" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Page up" })
keymap("n", "n", "nzzzv", { desc = "Next search result" })
keymap("n", "N", "Nzzzv", { desc = "Previous search result" })

-- Replace word under cursor
keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word under cursor" })

-- Copilot
keymap("i", "<C-J>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false, desc = "Accept Copilot suggestion" })
keymap("i", "<M-]>", 'copilot#Next()', { expr = true, desc = "Next Copilot suggestion" })
keymap("i", "<M-[>", 'copilot#Previous()', { expr = true, desc = "Previous Copilot suggestion" })
keymap("i", "<M-\\>", 'copilot#Dismiss()', { expr = true, desc = "Dismiss Copilot suggestion" })

-- PHP specific keymaps
keymap("n", "<leader>pi", function()
  vim.lsp.buf.code_action({ 
    filter = function(action) 
      return action.title:match("Import") 
    end,
    apply = true
  })
end, { desc = "PHP Import class" })
keymap("n", "<leader>pf", ":!vendor/bin/php-cs-fixer fix %<CR>", { desc = "PHP CS Fixer" })
keymap("n", "<leader>ps", ":!vendor/bin/phpstan analyse %<CR>", { desc = "PHPStan analyze" })
keymap("n", "<leader>pu", ":!vendor/bin/phpunit %<CR>", { desc = "PHPUnit test" })

-- Toggle line wrapping
keymap("n", "<leader>tw", function()
  vim.opt.wrap = not vim.opt.wrap:get()
  if vim.opt.wrap:get() then
    vim.notify("Line wrapping enabled", vim.log.levels.INFO)
  else
    vim.notify("Line wrapping disabled", vim.log.levels.INFO)
  end
end, { desc = "Toggle line wrapping" })

-- Spell checking keymaps
keymap("n", "<leader>ts", function()
  vim.opt.spell = not vim.opt.spell:get()
  if vim.opt.spell:get() then
    vim.notify("Spell checking enabled", vim.log.levels.INFO)
  else
    vim.notify("Spell checking disabled", vim.log.levels.INFO)
  end
end, { desc = "Toggle spell checking" })
keymap("n", "]s", "]s", { desc = "Next misspelled word" })
keymap("n", "[s", "[s", { desc = "Previous misspelled word" })
keymap("n", "z=", "z=", { desc = "Suggest spelling corrections" })
keymap("n", "zg", "zg", { desc = "Add word to dictionary" })
keymap("n", "zw", "zw", { desc = "Mark word as incorrect" })

-- LSP keybindings help
keymap("n", "<leader>lh", ":LspKeybindings<CR>", { desc = "Show LSP keybindings help" })
keymap("n", "<leader>lr", ":LspRestart<CR>", { desc = "Restart LSP" })
keymap("n", "<leader>li", ":LspInfo<CR>", { desc = "LSP Info" })
keymap("n", "<leader>lp", function()
  -- Force restart PHP LSP with correct config
  vim.lsp.stop_client(vim.lsp.get_active_clients({ name = "intelephense" }))
  vim.defer_fn(function()
    require("lsp.php").setup(require("cmp_nvim_lsp").default_capabilities())
    vim.cmd("edit")
  end, 100)
end, { desc = "Restart PHP LSP" })
keymap("n", "<leader>?", ":WhichKey<CR>", { desc = "Show all keybindings" })