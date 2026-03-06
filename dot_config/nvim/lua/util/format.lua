local M = {}

function M.format_on_save()
  vim.b.disable_autoformat = not vim.b.disable_autoformat
  vim.notify("Format on save " .. (vim.b.disable_autoformat and "disabled" or "enabled"))
end

return M
