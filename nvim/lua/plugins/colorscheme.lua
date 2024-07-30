return {
	-- install kanagawa
	{
		"rebelot/kanagawa.nvim",
		opts = {
			overrides = function(colors)
				local ret = {}
				for i = 1, 6 do
					-- markdown.nvim
					ret["RenderMarkdownH" .. i .. "Bg"] = { bg = colors.theme.diff.change }
				end
				return ret
			end,
		},
	},

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
