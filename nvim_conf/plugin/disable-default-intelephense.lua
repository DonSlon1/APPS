-- Disable default intelephense configuration
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyLoad",
  callback = function(event)
    if event.data == "nvim-lspconfig" then
      local ok, lspconfig = pcall(require, "lspconfig")
      if ok and lspconfig.intelephense then
        -- Override the default setup to do nothing
        local original_setup = lspconfig.intelephense.setup
        lspconfig.intelephense.setup = function(config)
          -- Only allow setup if it has our custom settings
          if config and config.settings and config.settings.intelephense and config.settings.intelephense.environment then
            original_setup(config)
          end
        end
      end
    end
  end
})