-- NvimTree configuration

return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup({
      view = { width = 30, side = "left" },
      renderer = {
        group_empty = true,
        icons = {
          show = { file = true, folder = true, folder_arrow = true, git = true },
        },
      },
      filters = { dotfiles = false },
      git = { enable = true, ignore = false },
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- Default mappings
        api.config.mappings.default_on_attach(bufnr)
        
        -- Remove conflicting mappings
        vim.keymap.del("n", "y", { buffer = bufnr })
        vim.keymap.del("n", "d", { buffer = bufnr })
        vim.keymap.del("n", "c", { buffer = bufnr })
        
        -- Add alternative mappings
        vim.keymap.set("n", "Y", api.fs.copy.node, opts("Copy"))
        vim.keymap.set("n", "D", api.fs.remove, opts("Delete"))
        vim.keymap.set("n", "C", api.fs.copy.filename, opts("Copy Name"))
      end,
    })
  end,
}