-- LSP Plugins configuration

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    -- Setup Mason first
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls", "ts_ls", "eslint", "html", "cssls",
        "tailwindcss", "pyright", "rust_analyzer",
        "gopls", "dockerls", "yamlls", "jsonls",
        "elixirls", "clangd",
      },
      -- Don't auto-setup servers
      automatic_installation = false,
      handlers = {
        -- Default handler for most servers
        function(server_name)
          -- Skip servers we set up manually in lua/lsp/
          if server_name == "intelephense" or server_name == "clangd" then
            return
          end
          require("lspconfig")[server_name].setup({
            capabilities = require("cmp_nvim_lsp").default_capabilities()
          })
        end,
      }
    })
    
    -- Setup LSP servers
    require("lsp").setup()
  end,
}