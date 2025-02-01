-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local root_dir = vim.fs.dirname(vim.fs.find(".git", { upward = true })[1])
		if root_dir then
			print(root_dir)
			vim.fn.system(string.format("tmux rename-window '%s'", vim.fs.basename(root_dir)))
		end
	end,
})

vim.api.nvim_create_autocmd("VimLeave", {
	callback = function()
		vim.fn.system("tmux set-window-option automatic-rename on")
	end,
})
