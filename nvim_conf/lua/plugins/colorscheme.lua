-- Colorscheme configuration

return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "macchiato", -- Options: latte, frappe, macchiato, mocha
      integrations = {
        treesitter = true,
        nvimtree = true,
        telescope = true,
        gitsigns = true,
        cmp = true,
        mason = true,
        which_key = true,
        indent_blankline = { enabled = true },
      },
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}