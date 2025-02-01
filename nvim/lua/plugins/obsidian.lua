return {
	{
		"epwalsh/obsidian.nvim",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		event = {
			"BufReadPre " .. vim.fn.expand("~/Developer/notes/*.md"),
			"BufNewFile " .. vim.fn.expand("~/Developer/notes/*.md"),
		},
		opts = {
			daily_notes = {
				folder = "daily",
				template = "daily.md",
			},
			workspaces = {
				{
					name = "notes",
					path = "~/Developer/notes",
				},
			},
			notes_subdir = "0-inbox",
			new_notes_location = "notes_subdir",

			---@param title string|?
			---@return string
			note_id_func = function(title)
				-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
				-- In this case a note with the title 'My new note' will be given an ID that looks
				-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
				local suffix = ""
				if title ~= nil then
					-- If title is given, transform it into valid file name.
					suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
				else
					-- If title is nil, just add 4 random uppercase letters to the suffix.
					for _ = 1, 4 do
						suffix = suffix .. string.char(math.random(65, 90))
					end
				end
				return tostring(os.time()) .. "-" .. suffix
			end,

			-- Disable in favor of markdown.nvim
			ui = { enable = false },
		},
		keys = {
			{ "<leader>oo", "<cmd>obsidianQuickSwitch<cr>", desc = "Open Note" },
			{ "<leader>on", "<cmd>ObsidianNew<cr>", desc = "New Note" },
			{ "<leader>o/", "<cmd>ObsidianSearch<cr>", desc = "Search Notes" },
			{ "<leader>od", "<cmd>ObsidianToday<cr>", desc = "Daily Note" },
		},
	},
	{
		"folke/which-key.nvim",
		opts = {
			spec = {
				{
					{ "<leader>o", group = "notes", icon = { icon = "󱞁", color = "purple" } },
				},
			},
		},
	},
}
