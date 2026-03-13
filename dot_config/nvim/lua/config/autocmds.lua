-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("my.highlight_yank", {}),
  callback = function() vim.hl.on_yank() end,
})

-- Rename tmux window
vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("my.tmux_title", {}),
  callback = function()
    local root_dir = vim.fs.dirname(vim.fs.find(".git", { upward = true })[1])
    if root_dir then
      print(root_dir)
      vim.fn.system(string.format("tmux rename-window '%s'", vim.fs.basename(root_dir)))
    end
  end,
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("my.close_with_q", {}),
  pattern = {
    "checkhealth",
    "help",
    "lspinfo",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", {
      buffer = event.buf,
      silent = true,
      desc = "Quit buffer",
    })
  end,
})
