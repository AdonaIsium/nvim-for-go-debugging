return {
  "nvim-lua/plenary.nvim", -- dummy base plugin

  name = "keybinding-help",
  lazy = false,
  priority = 1000,

  config = function()
    function _G.show_keybindings()
      local lines = vim.fn.readfile(vim.fn.stdpath("config") .. "/floating_help.txt")
      local buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

      local width = 70
      local height = #lines
      local opts = {
        style = "minimal",
        relative = "editor",
        width = width,
        height = height,
        row = (vim.o.lines - height) / 2,
        col = (vim.o.columns - width) / 2,
        border = "rounded",
      }

      vim.api.nvim_open_win(buf, true, opts)
    end

    vim.keymap.set("n", "<leader>?", "<cmd>lua show_keybindings()<CR>", { desc = "Show keybinding help" })
  end,
}

