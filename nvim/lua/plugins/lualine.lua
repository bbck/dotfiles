return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = function(_, opts)
			-- remove the clock
			table.remove(opts.sections.lualine_z)
		end,
	},
}
