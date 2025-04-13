return {
  "folke/which-key.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local wk = require("which-key")
    wk.setup()

    wk.register({
      ["<leader>r"] = { name = "+resize" },
      ["<leader>d"] = { name = "+debug" },
      ["<leader>sh"] = "LSP: Signature Help",
      ["<leader>rn"] = "LSP: Rename",
      ["<leader>ca"] = "LSP: Code Action",
      ["<leader>D"]  = "LSP: Type Definition",
      ["<leader>e"]  = "LSP: Line Diagnostics",
      ["<leader>q"]  = "LSP: Diagnostic List",
    })
  end,
}


