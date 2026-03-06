local map = vim.keymap.set

map("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit" })

map("n", "<leader>tf", function() require("util.format").format_on_save() end, { desc = "Toggle Format on Save" })

map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below" })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right" })
