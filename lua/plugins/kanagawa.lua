return {
  "rebelot/kanagawa.nvim",
  priority = 1000, -- Make sure it loads before other UI plugins
  config = function()
    vim.cmd("colorscheme kanagawa")
  end,
}

