-- Resize splits with <leader>r{direction}
vim.keymap.set("n", "<Leader>rh", "<cmd>vertical resize -4<CR>", { desc = "Resize split left" })
vim.keymap.set("n", "<Leader>rl", "<cmd>vertical resize +4<CR>", { desc = "Resize split right" })
vim.keymap.set("n", "<Leader>rj", "<cmd>resize -4<CR>", { desc = "Resize split down" })
vim.keymap.set("n", "<Leader>rk", "<cmd>resize +4<CR>", { desc = "Resize split up" })
vim.keymap.set("n", "<Leader>r=", "<C-w>=", { desc = "Reset all split sizes" })

-- Go helper snippet
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

-- Save + optional format via null-ls
vim.keymap.set({ "n", "i" }, "<C-s>", function()
	-- Exit insert mode if needed
	if vim.fn.mode() == "i" then
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
	end

	-- Try to format with null-ls if available
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

-- ╭─────────────────────────────╮
-- │ Rustaceanvim keymaps        │
-- ╰─────────────────────────────╯

-- Toggle inlay hints
vim.keymap.set("n", "<leader>th", function()
	local buf = vim.api.nvim_get_current_buf()
	local enabled = vim.lsp.inlay_hint.is_enabled(buf)
	vim.lsp.inlay_hint.enable(buf, not enabled)
end, { desc = "Rust: Toggle Inlay Hints" })

-- Hover actions (extended hover with actionable commands)
vim.keymap.set("n", "K", function()
	vim.cmd("RustLsp hover actions")
end, { desc = "Rust: Hover Actions" })

-- Code action groups (grouped actions like "Add derive" etc.)
vim.keymap.set("n", "<leader>ca", function()
	vim.cmd("RustLsp codeAction")
end, { desc = "Rust: Code Actions" })

-- Expand macro at cursor (see what a macro expands to)
vim.keymap.set("n", "<leader>rm", function()
	vim.cmd("RustLsp expandMacro")
end, { desc = "Rust: Expand Macro" })

-- Parent module navigation
vim.keymap.set("n", "<leader>rp", function()
	vim.cmd("RustLsp parentModule")
end, { desc = "Rust: Go to Parent Module" })

-- Run (cargo run or test) under DAP
vim.keymap.set("n", "<leader>rr", function()
	vim.cmd("RustLsp runnables")
end, { desc = "Rust: Run Runnables" })

-- Debug a test or main function
vim.keymap.set("n", "<leader>rd", function()
	vim.cmd("RustLsp debuggables")
end, { desc = "Rust: Debuggables" })

-- Reload workspace (sometimes needed after big Cargo.toml changes)
vim.keymap.set("n", "<leader>rw", function()
	vim.cmd("RustLsp reloadWorkspace")
end, { desc = "Rust: Reload Workspace" })
