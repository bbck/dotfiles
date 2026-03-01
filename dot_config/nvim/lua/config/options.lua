vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Disable language providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.g.root_spec = { "lsp", ".git", "cwd" }

local set = vim.opt

set.completeopt = "fuzzy,menu,menuone,noinsert,popup"
set.conceallevel = 2
set.confirm = true
set.cursorline = true
set.expandtab = true
set.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
set.foldlevel = 99
set.foldmethod = "indent"
set.foldtext = ""
set.formatexpr = "v:lua.vim.lsp.foldexpr()"
set.formatoptions = "jcroqlnt"
set.grepformat = "%f:%l:%c:%m"
set.grepprg = "rg --vimgrep"
set.ignorecase = true -- Ignore case
set.inccommand = "nosplit" -- preview incremental substitute
set.jumpoptions = "view"
set.laststatus = 3 -- global statusline
set.linebreak = true -- Wrap lines at convenient points
set.list = true -- Show some invisible characters (tabs...
set.mouse = "a" -- Enable mouse mode
set.number = true -- Print line number
set.relativenumber = true -- Relative line numbers
set.ruler = false -- Disable the default ruler
set.shiftround = true -- Round indent
set.shiftwidth = 2 -- Size of an indent
set.showmode = false
set.signcolumn = "yes"
set.smartcase = true
set.smartindent = true
set.smoothscroll = true
set.spelllang = { "en" }
set.splitbelow = true -- Put new windows below current
set.splitkeep = "screen"
set.splitright = true -- Put new windows right of current
-- set.statuscolumn = TODO
set.tabstop = 2 -- Number of spaces tabs count for
set.termguicolors = true -- True color support
set.undofile = true
set.wrap = false -- Disable line wrap
