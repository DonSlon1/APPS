-- Spell checking and dictionary configuration

return {
  {
    "kamykn/spelunker.vim",
    event = "BufRead",
    config = function()
      vim.g.spelunker_check_type = 2
      vim.g.spelunker_highlight_type = 2
      vim.g.spelunker_disable_auto_group = 1
      vim.g.enable_spelunker_vim = 1
      vim.g.spelunker_max_suggest_words = 15
      vim.g.spelunker_max_hi_words_each_buf = 100
    end,
  },
  {
    "f3fora/cmp-spell",
    dependencies = "hrsh7th/nvim-cmp",
  },
}