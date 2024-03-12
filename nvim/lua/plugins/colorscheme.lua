return {
	-- install kanagawa
	{ "rebelot/kanagawa.nvim" },

	-- disable included colorschemes
	{ "catppuccin/nvim", enabled = false },
	{ "folke/tokyonight.nvim", enabled = false },

	-- set the colorscheme in lazy
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "kanagawa",
		},
	},
}
