return {
	-- No actual plugin, just a floating help loader
	"nvim-lua/plenary.nvim", -- dummy base to anchor config
	name = "floating-help-windows",
	lazy = false,
	priority = 1000,

	config = function()
		local function toggle_popup(buf_name, filepath)
			local winid = nil
			local bufnr = nil

			-- Check if buffer already exists
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				if vim.api.nvim_buf_get_name(buf):find(buf_name) then
					bufnr = buf
					break
				end
			end

			-- Check if it's already open in a window
			for _, win in ipairs(vim.api.nvim_list_wins()) do
				local wbuf = vim.api.nvim_win_get_buf(win)
				if bufnr and wbuf == bufnr then
					vim.api.nvim_win_close(win, true)
					return
				end
			end

			-- Create new buffer if needed
			if not bufnr then
				bufnr = vim.api.nvim_create_buf(false, true)
				vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.fn.readfile(filepath))
				vim.api.nvim_buf_set_name(bufnr, buf_name)
			end

			-- Create floating window
			local width = 80
			local lines = vim.api.nvim_buf_line_count(bufnr)
			local height = math.min(lines, 30)
			local opts = {
				style = "minimal",
				relative = "editor",
				width = width,
				height = height,
				row = (vim.o.lines - height) / 2,
				col = (vim.o.columns - width) / 2,
				border = "rounded",
			}

			vim.api.nvim_open_win(bufnr, true, opts)
		end

		vim.keymap.set("n", "<leader>?", function()
			toggle_popup("floating_help.txt", vim.fn.stdpath("config") .. "/floating_help.txt")
		end, { desc = "Toggle Plugin Keybindings Help" })

		vim.keymap.set("n", "<leader>m", function()
			toggle_popup("neovim_core_keys.txt", vim.fn.stdpath("config") .. "/neovim_core_keys.txt")
		end, { desc = "Toggle Motion/Core Keys Help" })
	end,
}
