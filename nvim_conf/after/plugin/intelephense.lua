-- Force stop any default intelephense instances and ensure only one properly configured instance
local function ensure_single_intelephense()
  local clients = vim.lsp.get_active_clients({ name = "intelephense" })
  local good_client = nil
  
  -- Find the client with proper settings
  for _, client in ipairs(clients) do
    if client.config.settings and client.config.settings.intelephense and client.config.settings.intelephense.environment then
      good_client = client
      break
    end
  end
  
  -- Stop all other clients
  for _, client in ipairs(clients) do
    if good_client and client.id ~= good_client.id then
      vim.lsp.stop_client(client.id)
    elseif not good_client and (not client.config.settings or not client.config.settings.intelephense) then
      vim.lsp.stop_client(client.id)
    end
  end
  
  -- If no good client exists and we're in a PHP file, set up the correct one
  if not good_client and vim.bo.filetype == "php" then
    require("lsp.php").setup(require("cmp_nvim_lsp").default_capabilities())
  end
end

-- Run immediately and on a timer
ensure_single_intelephense()
vim.defer_fn(ensure_single_intelephense, 500)
vim.defer_fn(ensure_single_intelephense, 1000)

-- Also run when entering PHP files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "php",
  callback = function()
    vim.defer_fn(ensure_single_intelephense, 100)
  end,
})