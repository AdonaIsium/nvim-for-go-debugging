return {
	{
		"saecki/crates.nvim",
		ft = { "toml" },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup({
				null_ls = {
					enabled = true,
					name = "crates.nvim",
				},
			})

			local crates = require("crates")

			-- Keymaps for Cargo.toml
			vim.keymap.set("n", "<leader>ct", crates.toggle, { desc = "Crates: Toggle UI" })
			vim.keymap.set("n", "<leader>cr", crates.reload, { desc = "Crates: Reload" })
			vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, { desc = "Crates: Show versions" })
			vim.keymap.set("n", "<leader>cf", crates.show_features_popup, { desc = "Crates: Show features" })
			vim.keymap.set("n", "<leader>cu", crates.update_crate, { desc = "Crates: Update crate" })
			vim.keymap.set("v", "<leader>cu", crates.update_crates, { desc = "Crates: Update selected crates" })
			vim.keymap.set("n", "<leader>ca", crates.update_all_crates, { desc = "Crates: Update all crates" })
		end,
	},
}
