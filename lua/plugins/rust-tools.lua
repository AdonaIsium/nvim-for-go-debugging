return {
	{
		"simrat39/rust-tools.nvim",
		ft = { "rust" },
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			local rt = require("rust-tools")

			rt.setup({
				-- Server = rust-analyzer
				server = {
					on_attach = function(_, bufnr)
						-- Use your shared keymaps + add rust-tools extras
						local function buf_map(mode, lhs, rhs, desc)
							vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
						end

						-- Hover actions (better than plain K)
						buf_map("n", "K", rt.hover_actions.hover_actions, "Rust Hover Actions")

						-- Code action groups (cargo fix, etc.)
						buf_map("n", "<leader>ca", rt.code_action_group.code_action_group, "Rust Code Action Group")
					end,
					settings = {
						["rust-analyzer"] = {
							cargo = { allFeatures = true },
							checkOnSave = { command = "clippy" },
						},
					},
				},

				-- Tools = UI enhancements
				tools = {
					autoSetHints = true,
					inlay_hints = {
						show_parameter_hints = true,
						parameter_hints_prefix = "<- ",
						other_hints_prefix = "=> ",
					},
				},
			})
		end,
	},
}
