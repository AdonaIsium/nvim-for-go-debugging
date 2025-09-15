return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					-- Core langs
					"lua",
					"go",
					"rust",
					"python",

					-- Infra / config
					"bash",
					"json",
					"yaml",
					"toml",

					-- Docs / text
					"markdown",
					"markdown_inline",
				},
				highlight = { enable = true },
				indent = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "gnn",
						node_incremental = "grn",
						scope_incremental = "grc",
						node_decremental = "grm",
					},
				},
				autotag = { enable = true }, -- if you’ve installed nvim-ts-autotag
			})
		end,
	},
}
