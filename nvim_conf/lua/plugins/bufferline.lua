-- Bufferline configuration

return {
  "akinsho/bufferline.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    require("bufferline").setup({
      options = {
        diagnostics = "nvim_lsp",
        show_buffer_close_icons = true,
        show_close_icon = true,
        separator_style = "slant",
      },
    })
  end,
}

