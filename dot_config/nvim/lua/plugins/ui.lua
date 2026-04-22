---@module "lazy"
---@type LazySpec
return {
  {
    -- https://github.com/thesimonho/kanagawa-paper.nvim
    "thesimonho/kanagawa-paper.nvim",
    lazy = false,
    priority = 1000,
    init = function() vim.cmd.colorscheme("kanagawa-paper-ink") end,
    ---@module 'kanagawa-paper'
    ---@type KanagawaConfig
    opts = {
      -- enable undercurls for underlined text
      undercurl = true,
      diag_background = false,
      -- dim inactive windows.
      dim_inactive = true,
    },
  },
  {
    -- https://github.com/romgrk/barbar.nvim
    "romgrk/barbar.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    keys = {
      { "<leader>bd", "<cmd>BufferClose<cr>", desc = "Delete Buffer" },
      { "<leader>bD", "<cmd>BufferCloseAllButCurrentOrPinned<cr>", desc = "Delete Other Buffers" },
      { "<leader>bp", "<cmd>BufferPin<cr>", desc = "Pin Buffer" },
      { "<S-h>", "<cmd>BufferPrevious<cr>", desc = "Previous Buffer" },
      { "<S-l>", "<cmd>BufferNext<cr>", desc = "Next Buffer" },
    },
    opts = {
      icons = {
        pinned = { button = "", filename = true },
        diagnostics = {
          [vim.diagnostic.severity.ERROR] = { enabled = true, icon = require("util.icons").diagnostics.error },
          [vim.diagnostic.severity.WARN] = { enabled = false },
          [vim.diagnostic.severity.INFO] = { enabled = false },
          [vim.diagnostic.severity.HINT] = { enabled = false },
        },
        gitsigns = {
          added = { enabled = false },
          changed = { enabled = false },
          deleted = { enabled = false },
        },
      },
    },
  },
  {
    -- https://github.com/christoomey/vim-tmux-navigator
    "christoomey/vim-tmux-navigator",
    lazy = true,
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  {
    -- https://github.com/nvim-lualine/lualine.nvim
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-mini/mini.icons" },
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      local kanagawa_paper = require("lualine.themes.kanagawa-paper-ink")
      local icons = require("util.icons")

      local opts = {
        options = {
          theme = kanagawa_paper,
          disabled_filetypes = { "snacks_dashboard" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = {
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.error,
                warn = icons.diagnostics.warn,
                info = icons.diagnostics.info,
                hint = icons.diagnostics.hint,
              },
            },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { "filename", path = 4, padding = { right = 0 } },
          },
          lualine_x = {
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
            },
          },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        extensions = { "fzf", "lazy" },
      }

      return opts
    end,
  },
  {
    -- https://github.com/folke/snacks.nvim
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    -- stylua: ignore
    keys = {
      { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
    },
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = {
        enabled = true,
        preset = {
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":FzfLua files" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = " ", key = "c", desc = "Config", action = function() require("chezmoi.pick").fzf() end },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
      explorer = { enabled = false },
      image = { enabled = false },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 10000,
      },
      picker = { enabled = false },
      quickfile = { enabled = true },
      scope = { enabled = false },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
  },
  {
    -- https://github.com/ibhagwan/fzf-lua
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-mini/mini.icons" },
    cmd = "FzfLua",
    -- stylua: ignore
    keys = {
      { "<leader><space>", "<cmd>FzfLua files<cr>", desc = "Search Files (Root Dir)" },
      { "<leader>r", "<cmd>FzfLua resume<cr>", desc = "Resume last search" },
      { "<leader>/", "<cmd>FzfLua live_grep<cr>", desc = "Grep (Root Dir)" },
      { "<leader>,", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Search Buffers" },
      -- Search
      { '<leader>sb', "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      { "<leader>sf", "<cmd>FzfLua files<cr>", desc = "Files (Root Dir)" },
      { "<leader>sF", "<cmd>FzfLua files<cr>", desc = "Files (cwd)" },
      { "<leader>sh", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
      { "<leader>ss", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Symbols" },
      { "<leader>sS", "<cmd>FzfLua lsp_live_workspace_symbols<cr>", desc = "Symbols (Workspace)" },
      { '<leader>s"', "<cmd>FzfLua registers<cr>", desc = "Registers" },
      { "<leader>s:", "<cmd>FzfLua command_history<cr>", desc = "Commands" },
      { "<leader>sz", function() require("chezmoi.pick").fzf() end, desc = "dotfiles" },
    },
    ---@module "fzf-lua"
    ---@type fzf-lua.Config
    opts = {
      winopts = {
        height = 0.40,
        width = 1.0,
        row = 1.0,
      },
    },
  },
  {
    -- https://github.com/folke/which-key.nvim
    "folke/which-key.nvim",
    event = "VeryLazy",
    -- stylua: ignore
    keys = {
      { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer Local Keymaps", },
    },
    opts = {
      spec = {
        { "<leader>b", group = "buffers" },
        { "<leader>g", group = "git" },
        { "<leader>h", group = "git hunks" },
        { "<leader>s", group = "search" },
        { "<leader>t", group = "toggle" },
        { "<leader>w", proxy = "<c-w>", group = "windows" },
      },
    },
  },
  {
    -- https://github.com/nvim-mini/mini.icons
    "nvim-mini/mini.icons",
    lazy = true,
    opts = {},
    init = function()
      -- mock nvim-tree/nvim-web-devicons
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
  {
    -- https://github.com/folke/noice.nvim
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    ---@module 'noice.config'
    ---@type NoiceConfig
    opts = {
      ---@type NoicePresets
      presets = {
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
      },
    },
  },
  {
    -- https://github.com/mikavilpas/yazi.nvim
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>e", "<cmd>Yazi cwd<cr>", desc = "File explorer (cwd)" },
      { "<leader>E", "<cmd>Yazi<cr>", desc = "File explorer (buffer)" },
    },
    ---@module "yazi"
    ---@type YaziConfig
    opts = {
      integrations = {
        grep_in_selected_files = "fzf-lua",
        grep_in_directory = "fzf-lua",
      },
    },
  },
}
