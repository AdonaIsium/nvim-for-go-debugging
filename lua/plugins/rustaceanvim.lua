return {
	"mrcjkb/rustaceanvim",
	version = "^5", -- keep stable, matches your neovim release
	lazy = false, -- load at startup (recommended)
	config = function()
		local lsp = require("config.lsp")

		vim.g.rustaceanvim = {
			server = {
				on_attach = lsp.on_attach,
				capabilities = lsp.capabilities,
				settings = {
					["rust-analyzer"] = {
						cargo = { allFeatures = true },
						checkOnSave = { command = "clippy" },
						inlayHints = { enable = true },
					},
				},
			},
			tools = {
				hover_actions = {
					border = "rounded",
				},
			},
		}
	end,
}
