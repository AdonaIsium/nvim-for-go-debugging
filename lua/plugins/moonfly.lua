return {
	"bluz71/vim-moonfly-colors",
	name = "moonfly",
	lazy = false,
	priority = 1000,
	config = function()
		-- Load the colorscheme first
		vim.cmd.colorscheme("moonfly")

		-- Pure black backgrounds
		vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })
		vim.api.nvim_set_hl(0, "SignColumn", { bg = "#000000" })
		vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "#000000" })

		-- Neo-tree backgrounds + borders
		vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "#000000" })
		vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "#000000" })
		vim.api.nvim_set_hl(0, "NeoTreeBorder", { fg = "#3a3a3a", bg = "#000000" })

		-- Window dividers and splits (medium gray, subtle contrast)
		vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#3a3a3a", bg = "#000000" })
		vim.api.nvim_set_hl(0, "VertSplit", { fg = "#3a3a3a", bg = "#000000" })

		-- Floating window borders (lighter gray, more pronounced)
		vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#585858", bg = "#000000" })
		vim.api.nvim_set_hl(0, "LspInfoBorder", { fg = "#585858", bg = "#000000" })
	end,
}
