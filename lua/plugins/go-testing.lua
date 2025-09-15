return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-go",
		},
		config = function()
			local neotest = require("neotest")

			neotest.setup({
				adapters = {
					require("neotest-go")({
						experimental = {
							test_table = true, -- better test discovery
						},
						args = { "-count=1", "-timeout=60s" }, -- prevent caching, set test timeout
					}),
				},
			})

			-- ╭─────────────────────────────╮
			-- │ Go test/run keymaps         │
			-- ╰─────────────────────────────╯

			-- Run nearest test
			vim.keymap.set("n", "<leader>gt", function()
				neotest.run.run()
			end, { desc = "Go: Run nearest test" })

			-- Run all tests in current file
			vim.keymap.set("n", "<leader>gT", function()
				neotest.run.run(vim.fn.expand("%"))
			end, { desc = "Go: Run all tests in file" })

			-- Run entire project/package tests
			vim.keymap.set("n", "<leader>gp", function()
				neotest.run.run("./...")
			end, { desc = "Go: Run all tests in project" })

			-- Debug nearest test (uses dap-go)
			vim.keymap.set("n", "<leader>gd", function()
				neotest.run.run({ strategy = "dap" })
			end, { desc = "Go: Debug nearest test" })

			-- Open test output (floating window)
			vim.keymap.set("n", "<leader>go", function()
				neotest.output.open({ enter = true })
			end, { desc = "Go: Open test output" })

			-- Toggle summary panel
			vim.keymap.set("n", "<leader>gs", function()
				neotest.summary.toggle()
			end, { desc = "Go: Toggle test summary" })
		end,
	},
}
