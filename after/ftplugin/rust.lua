-- after/ftplugin/rust.lua
-- Buffer-local Rust keymaps (only loaded for Rust files)

local opts = { buffer = true }

-- Toggle inlay hints
vim.keymap.set("n", "<leader>th", function()
	local buf = vim.api.nvim_get_current_buf()
	local enabled = vim.lsp.inlay_hint.is_enabled(buf)
	vim.lsp.inlay_hint.enable(buf, not enabled)
end, vim.tbl_extend("force", opts, { desc = "Rust: Toggle Inlay Hints" }))

-- Hover actions
vim.keymap.set("n", "K", function()
	vim.cmd.RustLsp({ "hover", "actions" })
end, vim.tbl_extend("force", opts, { desc = "Rust: Hover Actions" }))

-- Code actions
vim.keymap.set("n", "<leader>ca", function()
	vim.cmd.RustLsp({ "codeAction" })
end, vim.tbl_extend("force", opts, { desc = "Rust: Code Actions" }))

-- Expand macro
vim.keymap.set("n", "<leader>rm", function()
	vim.cmd.RustLsp({ "expandMacro" })
end, vim.tbl_extend("force", opts, { desc = "Rust: Expand Macro" }))

-- Parent module
vim.keymap.set("n", "<leader>rp", function()
	vim.cmd.RustLsp({ "parentModule" })
end, vim.tbl_extend("force", opts, { desc = "Rust: Go to Parent Module" }))

-- Runnables
vim.keymap.set("n", "<leader>rr", function()
	vim.cmd.RustLsp({ "runnables" })
end, vim.tbl_extend("force", opts, { desc = "Rust: Run Runnables" }))

-- Debuggables
vim.keymap.set("n", "<leader>rd", function()
	vim.cmd.RustLsp({ "debuggables" })
end, vim.tbl_extend("force", opts, { desc = "Rust: Debuggables" }))

-- Reload workspace
vim.keymap.set("n", "<leader>rw", function()
	vim.cmd.RustLsp({ "reloadWorkspace" })
end, vim.tbl_extend("force", opts, { desc = "Rust: Reload Workspace" }))
