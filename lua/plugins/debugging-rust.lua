return {
	{
		"mfussenegger/nvim-dap",
		dependencies = { "rcarriga/nvim-dap-ui" },
		config = function()
			local dap = require("dap")

			-- Path to codelldb installed by Mason
			local codelldb_path = vim.fn.stdpath("data") .. "/mason/bin/codelldb"

			-- Debug adapter definition
			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = codelldb_path,
					args = { "--port", "${port}" },
				},
			}

			-- Rust launch configuration
			dap.configurations.rust = {
				{
					name = "Launch Rust executable",
					type = "codelldb",
					request = "launch",
					program = function()
						-- By default, point to Cargo's debug output
						return vim.fn.input(
							"Path to executable: ",
							vim.fn.getcwd() .. "/target/debug/",
							"file"
						)
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},
				},
				{
					name = "Attach to process",
					type = "codelldb",
					request = "attach",
					pid = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
			}
		end,
	},
}

