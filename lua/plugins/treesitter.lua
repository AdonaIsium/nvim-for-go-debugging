return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate", -- updates parsers on install
  event = { "BufReadPost", "BufNewFile" }, -- optional lazy-loading
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "lua", "vim", "vimdoc", "bash", "python", "go", "html", "javascript",
      },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    })
  end,
}
