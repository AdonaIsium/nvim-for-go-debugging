return {
	{
		"akinsho/toggleterm.nvim",
		opts = {
			size = 10,
			open_mapping = [[<C-t>]],
			shade_terminals = true,
			shading_factor = 2,
			direction = "horizontal",
			float_opts = {
				border = "curved",
				winblend = 0,
				highlights = {
					border = "Normal",
					background = "Normal",
				},
			},
			insert_mappings = true,
			terminal_mappings = true,
			persist_size = true,
			autochdir = false,
		},
		keys = {
			{ "<C-t>", "<cmd>ToggleTerm<CR>", desc = "Toggle terminal" },
		},
	},
}
