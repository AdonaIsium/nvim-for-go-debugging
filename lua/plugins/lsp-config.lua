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
				ensure_installed = { "gopls", "pyright", "rust_analyzer" },
				automatic_enable = false,
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
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- shared on_attach
			local on_attach = function(client, bufnr)
				local function buf_map(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc and ("LSP: " .. desc) or nil })
				end

				-- Go organize imports + format on save
				if vim.bo[bufnr].filetype == "go" then
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							local params = vim.lsp.util.make_range_params()
							params.context = { only = { "source.organizeImports" } }
							local results = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 1000)
							for _, res in pairs(results or {}) do
								for _, act in pairs(res.result or {}) do
									if act.edit then
										vim.lsp.util.apply_workspace_edit(act.edit, "utf-8")
									elseif type(act.command) == "table" then
										vim.lsp.buf.execute_command(act.command)
									end
								end
							end
							vim.lsp.buf.format({ async = false })
						end,
					})
				end

				-- null-ls format on save
				if client.name == "null-ls" then
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({
								async = false,
								filter = function(c)
									return c.name == "null-ls"
								end,
							})
						end,
					})
				end

				-- Keymaps
				buf_map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
				buf_map("n", "<leader>sh", vim.lsp.buf.signature_help, "Signature Help")
				buf_map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
				buf_map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
				buf_map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
				buf_map("n", "gr", vim.lsp.buf.references, "Go to References")
				buf_map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
				buf_map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
				buf_map("n", "<leader>D", vim.lsp.buf.type_definition, "Type Definition")
				buf_map("n", "[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
				buf_map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
				buf_map("n", "<leader>e", vim.diagnostic.open_float, "Line Diagnostics")
				buf_map("n", "<leader>q", vim.diagnostic.setloclist, "Diagnostic List")

				-- Format + save
				vim.keymap.set("n", "<C-s>", function()
					vim.lsp.buf.format({ async = false })
					vim.cmd("w")
				end, { buffer = bufnr, desc = "Format & Save" })
				vim.keymap.set("i", "<C-s>", "<Esc><C-s>", { buffer = bufnr })
				vim.keymap.set("n", "<C-f>", function()
					vim.lsp.buf.format({ async = true })
				end, { buffer = bufnr, desc = "Format File" })
			end

			-- gopls
			lspconfig.gopls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
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
				on_attach = on_attach,
				capabilities = capabilities,
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
