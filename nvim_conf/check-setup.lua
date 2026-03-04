-- Diagnostic script to check Neovim setup
print("=== Checking Neovim Setup ===\n")

-- Check if plugins are loaded
print("1. Checking plugins:")
print("   - Which-key loaded:", pcall(require, "which-key") and "✓" or "✗")
print("   - Treesitter loaded:", pcall(require, "nvim-treesitter") and "✓" or "✗")
print("   - LSP config loaded:", pcall(require, "lspconfig") and "✓" or "✗")

-- Check treesitter parsers
print("\n2. Checking Treesitter parsers:")
local ok, parsers = pcall(require, "nvim-treesitter.parsers")
if ok then
  local ts_parsers = parsers.available_parsers()
  print("   - TypeScript parser:", vim.tbl_contains(ts_parsers, "typescript") and "✓" or "✗")
  print("   - TSX parser:", vim.tbl_contains(ts_parsers, "tsx") and "✓" or "✗")
  print("   - JavaScript parser:", vim.tbl_contains(ts_parsers, "javascript") and "✓" or "✗")
end

-- Check LSP servers
print("\n3. Checking LSP servers:")
local clients = vim.lsp.get_clients()
print("   - Active LSP clients:", #clients)
for _, client in ipairs(clients) do
  print("     -", client.name)
end

-- Check keymaps
print("\n4. Checking leader key:")
print("   - Leader key set to:", vim.g.mapleader or "not set")

-- Check which-key mappings
print("\n5. Checking which-key mappings:")
local ok_wk, wk = pcall(require, "which-key")
if ok_wk then
  print("   - Which-key is loaded")
  -- Try to trigger which-key to see if it's working
  vim.cmd("WhichKey '<Space>'")
end