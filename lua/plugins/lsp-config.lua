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
				automatic_installation = true, -- this enables "install on use"
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			local on_attach = function(client, bufnr)
				if client.name == "null-ls" then
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = vim.api.nvim_create_augroup("LspFormatOnSave", { clear = true }),
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({
								async = false,
								filter = function(client)
									return client.name == "null-ls"
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
						filter = function(client)
							return client.name == "null-ls"
						end,
					})
					vim.cmd("w")
				end, { buffer = bufnr, desc = "Format and Save (stylua)" })

				vim.keymap.set("i", "<C-s>", "<Esc><C-s>", { buffer = bufnr })

				vim.keymap.set("n", "<C-f>", function()
					vim.lsp.buf.format({
						async = true,
						filter = function(client)
							return client.name == "null-ls"
						end,
					})
				end, { buffer = bufnr, desc = "Format File (stylua)" })
			end

			require("mason-lspconfig").setup_handlers({
				function(server_name)
					lspconfig[server_name].setup({
						on_attach = on_attach,
						capabilities = capabilities,
					})
				end,
			})
		end,
	},

	-- Add none-ls for stylua formatting
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
