---@module "lazy"
---@type LazySpec
return {
  {
    -- https://github.com/xvzc/chezmoi.nvim
    "xvzc/chezmoi.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "ChezmoiEdit" },
    init = function()
      -- run chezmoi edit on file enter
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = { os.getenv("HOME") .. "/.local/share/chezmoi/*" },
        callback = function(ev)
          local bufnr = ev.buf
          local edit_watch = function() require("chezmoi.commands.__edit").watch(bufnr) end
          vim.schedule(edit_watch)
        end,
      })
    end,
  },
  {
    -- https://github.com/folke/persistence.nvim
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      options = { "buffers", "curdir", "globals", "tabpages", "winsize" },
      pre_save = function() vim.api.nvim_exec_autocmds("User", { pattern = "SessionSavePre" }) end,
    },
  },
  {
    -- ghostty config
    -- https://github.com/ghostty-org/ghostty/discussions/8438
    "ghostty-org/ghostty",
    lazy = false,
    dir = (vim.env.GHOSTTY_RESOURCES_DIR or "") .. "/../nvim/site",
    cond = vim.env.GHOSTTY_RESOURCES_DIR ~= nil,
  },
}
