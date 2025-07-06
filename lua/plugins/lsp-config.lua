return {
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "gopls", "pyright" },
				automatic_installation = true,
				automatic_enable = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			local util = require("lspconfig.util")

			local on_attach = function(client, bufnr)
				-- Go: organize imports and format
				if vim.bo[bufnr].filetype == "go" then
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							local params = vim.lsp.util.make_range_params()
							params.context = { only = { "source.organizeImports" } }
							local result = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 1000)
							for _, res in pairs(result or {}) do
								for _, action in pairs(res.result or {}) do
									if action.edit then
										vim.lsp.util.apply_workspace_edit(action.edit, "utf-8")
									elseif type(action.command) == "table" then
										vim.lsp.buf.execute_command(action.command)
									end
								end
							end
							vim.lsp.buf.format({ async = false })
						end,
					})
				elseif client.name == "null-ls" then
					-- Null-ls formatting (e.g., stylua)
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

				-- LSP keymaps
				local nmap = function(keys, func, desc)
					if desc then
						desc = "LSP: " .. desc
					end
					vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
				end

				nmap("K", vim.lsp.buf.hover, "Hover Documentation")
				nmap("<leader>sh", vim.lsp.buf.signature_help, "Signature Help")
				nmap("gd", vim.lsp.buf.definition, "Go to Definition")
				nmap("gD", vim.lsp.buf.declaration, "Go to Declaration")
				nmap("gi", vim.lsp.buf.implementation, "Go to Implementation")
				nmap("gr", vim.lsp.buf.references, "Go to References")
				nmap("<leader>rn", vim.lsp.buf.rename, "Rename")
				nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
				nmap("<leader>D", vim.lsp.buf.type_definition, "Type Definition")
				nmap("[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
				nmap("]d", vim.diagnostic.goto_next, "Next Diagnostic")
				nmap("<leader>e", vim.diagnostic.open_float, "Line Diagnostics")
				nmap("<leader>q", vim.diagnostic.setloclist, "Diagnostic List")

				-- Format and Save
				vim.keymap.set("n", "<C-s>", function()
					vim.lsp.buf.format({
						async = false,
						filter = function(c)
							return c.name == "null-ls"
						end,
					})
					vim.cmd("w")
				end, { buffer = bufnr, desc = "Format and Save (stylua)" })

				vim.keymap.set("i", "<C-s>", "<Esc><C-s>", { buffer = bufnr })

				-- Format without save
				vim.keymap.set("n", "<C-f>", function()
					vim.lsp.buf.format({
						async = true,
						filter = function(c)
							return c.name == "null-ls"
						end,
					})
				end, { buffer = bufnr, desc = "Format File (stylua)" })
			end

			-- gopls config
			lspconfig.gopls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
							unusedwrite = true,
						},
						staticcheck = true,
					},
				},
			})

			-- pyright config with virtualenv detection
			lspconfig.pyright.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				before_init = function(_, config)
					local root_dir = util.find_git_ancestor(vim.fn.getcwd()) or vim.fn.getcwd()
					local python_path = root_dir .. "/.venv/bin/python"
					if vim.fn.executable(python_path) == 1 then
						config.settings = config.settings or {}
						config.settings.python = config.settings.python or {}
						config.settings.python.pythonPath = python_path
					end
				end,
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
				},
			})
		end,
	},
}
