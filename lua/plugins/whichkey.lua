return {
	{ "echasnovski/mini.icons", version = false },
	{
		"folke/which-key.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			local wk = require("which-key")
			wk.setup()

			wk.register({
				{ "<leader>r", group = "resize" },
				{ "<leader>d", group = "debug" },
				{ "<leader>sh", desc = "LSP: Signature Help" },
				{ "<leader>rn", desc = "LSP: Rename" },
				{ "<leader>ca", desc = "LSP: Code Action" },
				{ "<leader>D",  desc = "LSP: Type Definition" },
				{ "<leader>e",  desc = "LSP: Line Diagnostics" },
				{ "<leader>q",  desc = "LSP: Diagnostic List" },
			})
		end,
	},
}

