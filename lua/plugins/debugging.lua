return {
	{
		"mfussenegger/nvim-dap",
		dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio", "leoluz/nvim-dap-go" },
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			require("dapui").setup()
			require("dap-go").setup()
			-- If we want ui to open when we start a debugging session, uncomment these.
			-- dap.listeners.before.attach.dapui_config = function()
			-- 	dapui.open()
			-- end
			-- dap.listeners.before.launch.dapui_config = function()
			-- 	dapui.open()
			-- end
			-- dap.listeners.before.event_terminated.dapui_config = function()
			-- 	dapui.open()
			-- end
			-- dap.listeners.before.event_exited.dapui_config = function()
			-- 	dapui.open()
			-- end

			vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {})
			vim.keymap.set("n", "<Leader>dT", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end)
			vim.keymap.set("n", "<Leader>dc", dap.continue, {})
			vim.keymap.set("n", "F3", dap.continue, {})
			vim.keymap.set("n", "<Leader>do", dap.step_over)
			vim.keymap.set("n", "F4", dap.step_over)
			vim.keymap.set("n", "<Leader>di", dap.step_into)
			vim.keymap.set("n", "F5", dap.step_into)
			vim.keymap.set("n", "<Leader>dO", dap.step_out)
			vim.keymap.set("n", "F6", dap.step_out)

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
				require("dap").terminate()
				require("dapui").close()
			end, { desc = "DAP: Terminate session & Close UI" })

			-- DAP UI
			local sidebar = nil

			vim.keymap.set("n", "<leader>dus", function()
				local widgets = require("dap.ui.widgets")
				if not sidebar then
					sidebar = widgets.sidebar(widgets.scopes)
				end
				-- Toggle based on whether it's currently open
				if sidebar._opened then
					sidebar.close()
				else
					sidebar.open()
				end
			end, { desc = "DAP: Toggle scopes sidebar" })
			vim.keymap.set("n", "<Leader>du", dapui.toggle)
			vim.keymap.set("n", "<Leader>de", dapui.eval)
		end,
	},
}
