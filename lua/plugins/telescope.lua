return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
	},
	config = function()
		local telescope = require("telescope")

		telescope.setup({
			extensions = {
				["ui-select"] = require("telescope.themes").get_dropdown({
					previewer = false,
					prompt_title = false,
				}),
			},
		})
		telescope.load_extension("ui-select")
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<C-p>", builtin.find_files, {})
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
	end,
}
