return {
	{
		"mfussenegger/nvim-dap",
		dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio", "leoluz/nvim-dap-go" },
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			require("dapui").setup()
			require("dap-go").setup()

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.open()
			end

			vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {})
			vim.keymap.set("n", "<Leader>dT", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end)
			vim.keymap.set("n", "<Leader>dc", dap.continue, {})
			vim.keymap.set("n", "<Leader>do", dap.step_over)
			vim.keymap.set("n", "<Leader>di", dap.step_into)
			vim.keymap.set("n", "<Leader>dO", dap.step_out)

			vim.keymap.set("n", "<Leader>lp", function()
				dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end)
			vim.keymap.set("n", "<Leader>dr", dap.run_last)
			vim.keymap.set("n", "<Leader>dq", function()
				require("dap").terminate()
        require("dapui").close()
			end, { desc = "DAP: Terminate session & Close UI" })

			-- DAP UI
			vim.keymap.set("n", "<Leader>du", dapui.toggle)
			vim.keymap.set("n", "<Leader>de", dapui.eval)
		end,
	},
}
