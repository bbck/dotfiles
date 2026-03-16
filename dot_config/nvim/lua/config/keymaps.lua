local map = vim.keymap.set

map("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit" })

map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

map("n", "<leader>tf", function() require("util.format").format_on_save() end, { desc = "Toggle Format on Save" })

map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below" })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right" })
map("n", "<leader>wc", "<C-W>c", { desc = "Close window" })
