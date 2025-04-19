-- Resize splits with <leader>r{direction}
vim.keymap.set("n", "<Leader>rh", "<cmd>vertical resize -4<CR>", { desc = "Resize split left" })
vim.keymap.set("n", "<Leader>rl", "<cmd>vertical resize +4<CR>", { desc = "Resize split right" })
vim.keymap.set("n", "<Leader>rj", "<cmd>resize -4<CR>", { desc = "Resize split down" })
vim.keymap.set("n", "<Leader>rk", "<cmd>resize +4<CR>", { desc = "Resize split up" })
vim.keymap.set("n", "<Leader>r=", "<C-w>=", { desc = "Reset all split sizes" })

vim.keymap.set("n", "<leader>ie", function()
  local ls = require("luasnip")
  local s = ls.snippet
  local t = ls.text_node
  local i = ls.insert_node

  ls.snip_expand(s("ife", {
    t("if err != nil {"),
    t({ "", "\t" }),
    i(0),
    t({ "", "}" }),
  }))
end, { desc = "Insert 'if err != nil' snippet" })

