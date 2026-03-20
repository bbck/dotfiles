---@module "lazy"
---@type LazySpec
return {
  {
    -- https://github.com/nvim-mini/mini.surround
    "nvim-mini/mini.surround",
    opts = {
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
      },
    },
    keys = {
      { "gsa", desc = "Add Surrounding", mode = { "n", "v" } },
      { "gsd", desc = "Delete Surrounding" },
      { "gsf", desc = "Find Right Surrounding" },
      { "gsF", desc = "Find Left Surrounding" },
      { "gsh", desc = "Highlight Surrounding" },
      { "gsr", desc = "Replace Surrounding" },
    },
    config = function(_, opts) require("mini.surround").setup(opts) end,
  },
  {
    -- https://github.com/nvim-mini/mini.pairs
    "nvim-mini/mini.pairs",
    event = "VeryLazy",
    opts = {
      modes = {
        insert = true,
        command = true,
        terminal = false,
      },
    },
  },
  {
    -- https://github.com/nvim-mini/mini.ai
    "nvim-mini/mini.ai",
    event = "VeryLazy",
    opts = {},
  },
  {
    -- https://github.com/stevearc/conform.nvim
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      { "<leader>f", function() require("conform").format({ async = true }) end, desc = "Format Buffer" },
    },
    ---@type conform.setupOpts
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        if vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 500, lsp_format = "never" }
      end,
      formatters_by_ft = {
        go = { "gofmt" },
        lua = { "stylua" },
        yaml = { "yamlfmt" },
        ["*"] = { "trim_whitespace" },
      },
    },
  },
  {
    -- https://github.com/saghen/blink.cmp
    "saghen/blink.cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      -- "rafamadriz/friendly-snippets",
    },
    -- use a release tag to download pre-built binaries
    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      completion = {
        list = {
          selection = {
            preselect = true,
            auto_insert = false,
          },
        },
        menu = {
          draw = {
            columns = { { "kind_icon" }, { "label", gap = 1 } },
            components = {
              label = {
                text = function(ctx) return require("colorful-menu").blink_components_text(ctx) end,
                highlight = function(ctx) return require("colorful-menu").blink_components_highlight(ctx) end,
              },
            },
          },
        },
      },
      keymap = { preset = "default" },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        per_filetype = {
          lua = { inherit_defaults = true, "lazydev" },
        },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority
            score_offset = 100,
          },
        },
      },
    },
    opts_extend = { "sources.default" },
  },
  {
    -- https://github.com/xzbdmw/colorful-menu.nvim
    "xzbdmw/colorful-menu.nvim",
    opts = {},
  },
  {
    -- https://github.com/folke/todo-comments.nvim
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    -- https://github.com/lewis6991/gitsigns.nvim
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        map("n", "<leader>hs", gitsigns.stage_hunk)
        map("n", "<leader>hr", gitsigns.reset_hunk)
        map("v", "<leader>hs", function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end)
        map("v", "<leader>hr", function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end)

        map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle Git Blame" })
        map({ "o", "x" }, "ih", gitsigns.select_hunk)
      end,
    },
  },
}
