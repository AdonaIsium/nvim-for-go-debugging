return {
	{
		"rust-lang/rust.vim",
		ft = { "rust" },
		init = function()
			-- Enable Rust-specific text objects & motion
			vim.g.rustfmt_autosave = 0 -- we already format via LSP
		end,
	},
}
