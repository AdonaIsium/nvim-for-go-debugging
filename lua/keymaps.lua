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

vim.keymap.set({ "n", "i" }, "<C-s>", function()
	-- Exit insert mode if needed
	if vim.fn.mode() == "i" then
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
	end

	-- Try to format if LSP with null-ls is available
	local clients = vim.lsp.get_active_clients({ bufnr = 0 })
	local has_null_ls = false
	for _, client in ipairs(clients) do
		if client.name == "null-ls" then
			has_null_ls = true
			break
		end
	end

	if has_null_ls then
		vim.lsp.buf.format({
			async = false,
			filter = function(c)
				return c.name == "null-ls"
			end,
		})
	end

	vim.cmd("w")
end, { desc = "Save + maybe format" })
