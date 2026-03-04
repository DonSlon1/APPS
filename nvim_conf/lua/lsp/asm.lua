local M = {}

M.setup = function(capabilities)
  local lspconfig = require("lspconfig")

  -- Configuration for asm-lsp
  lspconfig.asm_lsp.setup({
    capabilities = capabilities,
    cmd = { "asm-lsp" },
    -- Covers common assembly extensions: .asm (NASM/MASM), .s/.S (GAS)
    filetypes = { "asm", "vmasm", "s", "S", "mac" },
    root_dir = lspconfig.util.root_pattern(
      ".git",
      "Makefile",
      "build.sh",
      "build.bat"
    ),
    single_file_support = true,
    on_attach = function(client, bufnr)
      -- Set up buffer-local keymaps
      local opts = { noremap = true, silent = true, buffer = bufnr }

      -- LSP Navigation
      -- Note: Assembly LSPs are lighter than clangd. 'Hover' and 'Definition' are the stars here.
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition (label/macro)" }))
      vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Show references" }))
      vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Show x86 instruction docs" }))

      -- Diagnostics (Syntax errors caught by the assembler engine)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Show diagnostic" }))
      vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, vim.tbl_extend("force", opts, { desc = "Diagnostics to loclist" }))

      -- Formatting (asm-lsp doesn't natively format; you'd typically pair this with a formatter like asmfmt via none-ls/conform.nvim)
      vim.keymap.set("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })
      end, vim.tbl_extend("force", opts, { desc = "Format buffer" }))

      -- Workspace
      vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, vim.tbl_extend("force", opts, { desc = "Add workspace folder" }))
      vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, vim.tbl_extend("force", opts, { desc = "Remove workspace folder" }))
      vim.keymap.set("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, vim.tbl_extend("force", opts, { desc = "List workspace folders" }))

      -- Removed C++ specific keys (like SwitchSourceHeader, MemoryUsage, etc.)
      -- as they do not apply to flat assembly files.
    end,
  })
end

return M
