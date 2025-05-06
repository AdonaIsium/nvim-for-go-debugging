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
				automatic_installation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			local mason_lspconfig = require("mason-lspconfig")

			local on_attach = function(client, bufnr)
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

				vim.keymap.set("n", "<C-f>", function()
					vim.lsp.buf.format({
						async = true,
						filter = function(c)
							return c.name == "null-ls"
						end,
					})
				end, { buffer = bufnr, desc = "Format File (stylua)" })
			end

			for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
				local opts = {
					on_attach = on_attach,
					capabilities = capabilities,
				}

				if server_name == "gopls" then
					opts.settings = {
						gopls = {
							analyses = {
								unusedparams = true,
								unusedwrite = true,
							},
							staticcheck = true,
						},
					}
					opts.on_init = function(client)
						client.server_capabilities.documentFormattingProvider = true
					end
				end

				lspconfig[server_name].setup(opts)
			end
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
