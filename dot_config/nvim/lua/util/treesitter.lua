local M = {}

---@param bufnr integer
---@return string|nil
function M.detect_language(bufnr)
  local lang = vim.b[bufnr].guest_language
  if lang == nil then
    local fname = vim.fs.basename(vim.api.nvim_buf_get_name(bufnr))
    -- Strip the template extension or this matches the template's own filetype
    local stripped = vim.fn.fnamemodify(fname, ":r")
    lang = vim.filetype.match({ filename = stripped, buf = bufnr }) or false
    vim.b[bufnr].guest_language = lang
  end
  return lang or nil
end

return M
