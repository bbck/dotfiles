return {
	{
		"numToStr/Navigator.nvim",
		cmd = "Navigator",
		keys = {
			{ "<C-h>", "<CMD>NavigatorLeft<CR>" },
			{ "<C-j>", "<CMD>NavigatorDown<CR>" },
			{ "<C-k>", "<CMD>NavigatorUp<CR>" },
			{ "<C-l>", "<CMD>NavigatorRight<CR>" },
		},
		opts = {
			auto_save = "current",
			disable_on_zoom = true,
		},
	},
}
