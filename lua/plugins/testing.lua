return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-go",
			"rouge8/neotest-rust",
		},
		config = function()
			local neotest = require("neotest")

			neotest.setup({
				adapters = {
					require("neotest-go")({
						experimental = { test_table = true },
						args = { "-count=1", "-timeout=60s" },
					}),
					require("neotest-rust")({
						args = { "--nocapture" },
					}),
				},
				icons = {
					running = "⏱",
					passed = "✅",
					failed = "❌",
					skipped = "⚠️",
					unknown = "❓",
				},
				highlights = {
					passed = "NeotestPassed",
					failed = "NeotestFailed",
					running = "NeotestRunning",
					skipped = "NeotestSkipped",
					unknown = "NeotestUnknown",
				},
				output = {
					enabled = true,
					open_on_run = "short", -- opens quick output for failing tests
				},
				summary = {
					enabled = true,
					follow = true, -- keep summary focused on running test
				},
				quickfix = {
					enabled = true,
					open = false, -- don’t auto-open quickfix unless you want it
				},
			})

			-- ╭─────────────────────────────╮
			-- │ Shared test keymaps         │
			-- ╰─────────────────────────────╯

			-- Run nearest test
			vim.keymap.set("n", "<leader>gt", function()
				neotest.run.run()
			end, { desc = "Test: Run nearest" })

			-- Run all tests in current file
			vim.keymap.set("n", "<leader>gT", function()
				neotest.run.run(vim.fn.expand("%"))
			end, { desc = "Test: Run file" })

			-- Run all tests in project/package
			vim.keymap.set("n", "<leader>gp", function()
				neotest.run.run("./...")
			end, { desc = "Test: Run project" })

			-- Debug nearest test
			vim.keymap.set("n", "<leader>gd", function()
				neotest.run.run({ strategy = "dap" })
			end, { desc = "Test: Debug nearest" })

			-- Open output (floating window)
			vim.keymap.set("n", "<leader>go", function()
				neotest.output.open({ enter = true })
			end, { desc = "Test: Open output" })

			-- Toggle summary panel
			vim.keymap.set("n", "<leader>gs", function()
				neotest.summary.toggle()
			end, { desc = "Test: Toggle summary" })

			-- Jump between test results
			vim.keymap.set("n", "[t", function()
				neotest.jump.prev({ status = "failed" })
			end, { desc = "Test: Jump to previous failed" })

			vim.keymap.set("n", "]t", function()
				neotest.jump.next({ status = "failed" })
			end, { desc = "Test: Jump to next failed" })
		end,
	},
}
