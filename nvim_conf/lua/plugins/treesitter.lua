-- Treesitter configuration

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "lua", "vim", "vimdoc", "query",
        "javascript", "typescript", "tsx",
        "html", "css", "scss", "json", "yaml",
        "php", "python", "rust", "go", "c", "cpp",
        "bash", "dockerfile", "markdown", "markdown_inline",
        "elixir", "heex", "eex", "erlang",
      },
      highlight = { enable = true },
      indent = { enable = true },
      rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
      },
    })
  end,
}