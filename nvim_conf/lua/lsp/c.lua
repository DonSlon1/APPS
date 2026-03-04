-- C/C++ LSP Configuration with enhanced features

local M = {}

M.setup = function(capabilities)
  local lspconfig = require("lspconfig")

  -- Enhanced clangd configuration
  lspconfig.clangd.setup({
    capabilities = capabilities,
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
      "--function-arg-placeholders",
      "--fallback-style=llvm",
      "--enable-config",
      "--offset-encoding=utf-16",
      "--ranking-model=heuristics",
      "--header-insertion-decorators",
      "--all-scopes-completion",
      "--completion-parse=auto",
      "--log=error",
      "--pch-storage=memory",
      "--malloc-trim",
      "--j=4",
    },
    init_options = {
      usePlaceholders = true,
      completeUnimported = true,
      clangdFileStatus = true,
    },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    root_dir = lspconfig.util.root_pattern(
      ".clangd",
      ".clang-tidy",
      ".clang-format",
      "compile_commands.json",
      "compile_flags.txt",
      "configure.ac",
      ".git"
    ),
    single_file_support = true,
    on_attach = function(client, bufnr)
      -- Enable inlay hints if available
      if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end

      -- Set up buffer-local keymaps (only clangd-specific ones;
      -- generic LSP/diagnostic keymaps are in config/keymaps.lua)
      local opts = { noremap = true, silent = true, buffer = bufnr }

      -- Clangd specific
      vim.keymap.set("n", "<leader>cs", "<cmd>ClangdSwitchSourceHeader<cr>", vim.tbl_extend("force", opts, { desc = "Switch source/header (LSP)" }))
      vim.keymap.set("n", "<leader>ct", "<cmd>ClangdTypeHierarchy<cr>", vim.tbl_extend("force", opts, { desc = "Type hierarchy" }))
      vim.keymap.set("n", "<leader>cm", "<cmd>ClangdMemoryUsage<cr>", vim.tbl_extend("force", opts, { desc = "Memory usage" }))
      vim.keymap.set("n", "<leader>ci", "<cmd>ClangdSymbolInfo<cr>", vim.tbl_extend("force", opts, { desc = "Symbol info" }))

      -- Inlay hints toggle
      vim.keymap.set("n", "<leader>ih", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
      end, vim.tbl_extend("force", opts, { desc = "Toggle inlay hints" }))
    end,
  })
end

return M