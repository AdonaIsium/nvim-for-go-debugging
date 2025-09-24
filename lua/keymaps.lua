-- lua/keymaps.lua

-- ╭─────────────────────────────╮
-- │ General window management   │
-- ╰─────────────────────────────╯
vim.keymap.set("n", "<Leader>rh", "<cmd>vertical resize -4<CR>", { desc = "Resize split left" })
vim.keymap.set("n", "<Leader>rl", "<cmd>vertical resize +4<CR>", { desc = "Resize split right" })
vim.keymap.set("n", "<Leader>rj", "<cmd>resize -4<CR>", { desc = "Resize split down" })
vim.keymap.set("n", "<Leader>rk", "<cmd>resize +4<CR>", { desc = "Resize split up" })
vim.keymap.set("n", "<Leader>r=", "<C-w>=", { desc = "Reset all split sizes" })

-- ╭─────────────────────────────╮
-- │ Go helpers                  │
-- ╰─────────────────────────────╯
vim.keymap.set("n", "<leader>ie", function()
	-- Move to a new line below, preserving indent
	vim.cmd("normal! o")

	-- Insert the snippet text
	local lines = {
		"if err != nil {",
		"\t",
		"}",
	}
	vim.api.nvim_put(lines, "l", true, true)

	-- Move cursor inside the block (on the tabbed line)
	vim.api.nvim_feedkeys("kA", "n", true)
end, { desc = "Insert 'if err != nil' snippet below" })

-- ╭─────────────────────────────╮
-- │ Save + format               │
-- ╰─────────────────────────────╯
vim.keymap.set({ "n", "i" }, "<C-s>", function()
	if vim.fn.mode() == "i" then
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
	end

	local clients = vim.lsp.get_clients({ bufnr = 0 })
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
