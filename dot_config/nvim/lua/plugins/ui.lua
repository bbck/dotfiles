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
    -- https://github.com/akinsho/bufferline.nvim
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    },
    ---@module 'bufferline'
    opts = {
      ---@type bufferline.Options
      options = {
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        offsets = {
          {
            filetype = "snacks_layout_box",
          },
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

      local opts = {
        options = {
          theme = kanagawa_paper,
        },
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
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
      { "<leader>bD", function() Snacks.bufdelete.all() end, desc = "Delete All Buffers" },
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
      { "<leader>/", "<cmd>FzfLua live_grep<cr>", desc = "Grep (Root Dir)" },
      { "<leader>,", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Search Buffers" },
      -- Search
      { '<leader>sb', "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      { "<leader>sf", "<cmd>FzfLua files<cr>", desc = "Files (Root Dir)" },
      { "<leader>sF", "<cmd>FzfLua files<cr>", desc = "Files (cwd)" },
      { "<leader>sh", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
      { '<leader>s"', "<cmd>FzfLua registers<cr>", desc = "Registers" },
      { "<leader>s:", "<cmd>FzfLua command_history<cr>", desc = "Commands" },
      { "<leader>sz", function() require("chezmoi.pick").fzf() end, desc = "dotfiles" },
    },
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
        {
          "<leader>b",
          group = "buffers",
          expand = function() return require("which-key.extras").expand.buf() end,
        },
        { "<leader>g", group = "git" },
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
    ---@type YaziConfig | {}
    opts = {
      integrations = {
        grep_in_selected_files = "fzf-lua",
        grep_in_directory = "fzf-lua",
      },
    },
  },
}
