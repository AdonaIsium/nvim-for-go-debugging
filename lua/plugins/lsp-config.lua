return {
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "gopls", "pyright" },
				automatic_installation = true,
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local util = require("lspconfig.util")
			local lsp = require("config.lsp")

			-- gopls
			lspconfig.gopls.setup({
				on_attach = lsp.on_attach,
				capabilities = lsp.capabilities,
				root_dir = util.root_pattern("go.work", "go.mod", ".git"),
				settings = {
					gopls = {
						analyses = { unusedparams = true, unusedwrite = true },
						staticcheck = true,
					},
				},
			})

			-- pyright
			lspconfig.pyright.setup({
				on_attach = lsp.on_attach,
				capabilities = lsp.capabilities,
				before_init = function(_, config)
					local root = util.find_git_ancestor(vim.fn.getcwd()) or vim.fn.getcwd()
					local pybin = root .. "/.venv/bin/python"
					if vim.fn.executable(pybin) == 1 then
						config.settings = config.settings or {}
						config.settings.python = config.settings.python or {}
						config.settings.python.pythonPath = pybin
					end
				end,
			})
		end,
	},
}
