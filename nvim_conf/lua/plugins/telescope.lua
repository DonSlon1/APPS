-- Telescope configuration

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-fzf-native.nvim",
  },
  config = function()
    require("telescope").setup({
      defaults = {
        file_ignore_patterns = { "node_modules", ".git/", "dist/", "build/" },
        layout_strategy = "horizontal",
        layout_config = { preview_width = 0.6 },
      },
    })
  end,
}