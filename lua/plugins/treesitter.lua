return {
	-- fast, treesitter-aware replacement for matchparen
	{
		"andymass/vim-matchup",
		event = "VeryLazy",
		config = function()
			-- show matching offscreen parens in a popup instead of jumping
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	},

	-- main treesitter plugin
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
				autotag = { enable = true },

				-- 👇 enable vim-matchup integration
				matchup = {
					enable = true,
					disable_virtual_text = true,
				},
			})
		end,
	},
}
