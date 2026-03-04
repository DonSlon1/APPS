-- LSP Configuration

local M = {}

-- Diagnostic configuration
vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    source = "always",
    spacing = 4,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

-- Diagnostic signs
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Workaround for "Invalid 'col': out of range" in inlay hints (neovim#28261)
-- Neovim 0.11 bypasses vim.lsp.handlers for inlay hints, so we catch the
-- error at the nvim_buf_set_extmark call site for the inlay hint namespace.
local inlay_ns = vim.api.nvim_create_namespace("nvim.lsp.inlayhint")
local orig_buf_set_extmark = vim.api.nvim_buf_set_extmark
vim.api.nvim_buf_set_extmark = function(buffer, ns_id, line, col, opts)
  if ns_id == inlay_ns then
    local ok, result = pcall(orig_buf_set_extmark, buffer, ns_id, line, col, opts)
    if ok then return result end
    return 0
  end
  return orig_buf_set_extmark(buffer, ns_id, line, col, opts)
end

-- Setup function for all LSP servers
M.setup = function()
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  -- PHP (Intelephense) - loaded from separate file FIRST to prevent conflicts
  require("lsp.php").setup(capabilities)

  -- C/C++ (clangd) - enhanced configuration
  require("lsp.c").setup(capabilities)

  -- Other servers are handled by mason-lspconfig handlers
end

return M