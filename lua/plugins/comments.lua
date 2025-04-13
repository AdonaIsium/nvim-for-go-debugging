return {
  "numToStr/Comment.nvim",
  event = "VeryLazy",
  config = function()
    require("Comment").setup()

    vim.keymap.set("n", "<C-_>", function()
      require("Comment.api").toggle.linewise.current()
    end, { noremap = true, silent = true, desc = "Toggle comment (normal mode)" })
  end,
}
