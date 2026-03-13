local M = {}

function M.keymaps(client, bufnr)
  local map = function(mode, lhs, rhs, opts)
    opts.buffer = bufnr
    vim.keymap.set(mode, lhs, rhs, opts)
  end
  map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
  map("n", "gr", vim.lsp.buf.references, { desc = "References", nowait = true })
  map("n", "gI", vim.lsp.buf.implementation, { desc = "Goto Implementation" })
  map("n", "gy", vim.lsp.buf.type_definition, { desc = "Goto T[y]pe Definition" })
  map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
  map("n", "K", function() return vim.lsp.buf.hover() end, { desc = "Hover" })

  if client:supports_method("textDocument/signatureHelp", bufnr) then
    map("n", "gK", function() return vim.lsp.buf.signature_help() end, { desc = "Signature Help" })
    map("i", "<C-k>", function() return vim.lsp.buf.signature_help() end, { desc = "Signature Help" })
  end
end

function M.features(client, bufnr)
  -- Configure folds
  if client:supports_method("textDocument/foldingRange", bufnr) then
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "v:lua.vim.lsp.foldexpr()"
  end
  -- Configure completion
  if client:supports_method("textDocument/completion", bufnr) then
    vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
  end
end

return M
