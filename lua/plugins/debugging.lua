return {
	{
		"mfussenegger/nvim-dap",
		dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio", "leoluz/nvim-dap-go" },
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup({
				layouts = {
					{
						elements = {
							{ id = "watches", size = 0.15 },
							{ id = "scopes", size = 0.40 },
							{ id = "breakpoints", size = 0.20 },
							{ id = "stacks", size = 0.20 },
						},
						size = 40,
						position = "left",
					},
					{
						elements = {
							{ id = "repl", size = 1 },
						},
						size = 11,
						position = "bottom",
					},
				},
			})

			require("dap-go").setup()

			vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint)
			vim.keymap.set("n", "<Leader>dT", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end)
			vim.keymap.set("n", "<Leader>dC", dap.continue)
			vim.keymap.set("n", "<Leader>do", dap.step_over)
			vim.keymap.set("n", "<Leader>di", dap.step_into)
			vim.keymap.set("n", "<Leader>dO", dap.step_out)

			vim.keymap.set("n", "<Leader>dgt", function()
				require("dap-go").debug_test()
			end, { desc = "DAP Go: Debug test" })

			vim.keymap.set("n", "<Leader>dgl", function()
				require("dap-go").debug_last()
			end, { desc = "DAP Go: Debug last test" })

			vim.keymap.set("n", "<Leader>lp", function()
				dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end)
			vim.keymap.set("n", "<Leader>dr", dap.run_last)
			vim.keymap.set("n", "<Leader>dq", function()
				dap.terminate()
				dapui.close()
			end, { desc = "DAP: Terminate session & close UI" })

			vim.keymap.set("n", "<Leader>du", function()
				dapui.toggle({})
			end, { desc = "DAP: Toggle Full UI (Scopes + REPL + Controls)" })

			vim.keymap.set("n", "<Leader>dc", function()
				dapui.toggle({ layout = 2, reset = true })
			end, { desc = "DAP: Open only REPL + Controls (Minimal)" })

			local sidebar = nil
			vim.keymap.set("n", "<Leader>ds", function()
				local widgets = require("dap.ui.widgets")
				if not sidebar then
					sidebar = widgets.sidebar(widgets.scopes)
				end
				if sidebar._opened then
					sidebar.close()
				else
					sidebar.open()
				end
			end, { desc = "DAP: Toggle Scopes Sidebar" })

			vim.keymap.set("n", "<Leader>de", dapui.eval)
		end,
	},
}
