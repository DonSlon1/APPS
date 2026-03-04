-- Plugins configuration

return {
  -- Theme
  require("plugins.colorscheme"),
  
  -- File explorer
  require("plugins.nvim-tree"),
  
  -- Fuzzy finder
  require("plugins.telescope"),
  
  -- Syntax highlighting
  require("plugins.treesitter"),
  
  -- LSP
  require("plugins.lsp"),
  
  -- Completion
  require("plugins.completion"),
  
  -- Git
  require("plugins.git"),
  
  -- Status line
  require("plugins.lualine"),
  
  -- Buffer line
  require("plugins.bufferline"),
  
  -- Indent guides
  require("plugins.indent-blankline"),
  
  -- Auto pairs
  require("plugins.autopairs"),
  
  -- Comment
  require("plugins.comment"),
  
  -- Surround
  require("plugins.surround"),
  
  -- Terminal
  require("plugins.toggleterm"),
  
  -- Which key
  require("plugins.which-key"),
  
  -- Trouble
  require("plugins.trouble"),
  
  -- Smooth scrolling
  require("plugins.neoscroll"),
  
  -- Copilot
  require("plugins.copilot"),
  
  -- Additional plugins
  { "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-web-devicons" },
  { "echasnovski/mini.icons", version = false, config = function() require("mini.icons").setup() end },
  { "windwp/nvim-ts-autotag", config = function() require("nvim-ts-autotag").setup() end },
  { "brenoprata10/nvim-highlight-colors", config = function() require("nvim-highlight-colors").setup({ render = "background" }) end },
}