vim.filetype.add({
  pattern = {
    [".*%.sh%.tmpl"] = "gotmpl",
    [".*%.ya?ml%.tmpl"] = "gotmpl",
    [".*%.ya?ml%.j2"] = "jinja",
  },
})

vim.treesitter.query.add_directive("inject-guest-language!", function(_, _, bufnr, _, metadata)
  if type(bufnr) == "number" then -- queries can also run against a string
    metadata["injection.language"] = require("util.treesitter").detect_language(bufnr)
  end
end, { force = true })
