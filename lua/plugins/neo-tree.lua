return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x", -- Use the stable v3 branch
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- optional, but recommended
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree", -- Lazy-load when Neotree is used
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Toggle NeoTree" },
    { "<C-n>", "<cmd>Neotree toggle<CR>", desc = "Toggle NeoTree" },
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      enable_git_status = true,
      enable_diagnostics = true,
      filesystem = {
        filtered_items = {
          visible = false,
          hide_dotfiles = true,
          hide_gitignored = true,
        },
      },
    })
  end,
}

