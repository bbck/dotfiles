return {
  {
    -- colorscheme
    -- https://github.com/thesimonho/kanagawa-paper.nvim
    "thesimonho/kanagawa-paper.nvim",
    lazy = false,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme("kanagawa-paper-ink")
    end,
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
    -- buffer tab bar
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
    -- Ctrl+hjkl between neovim and tmux splits
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
    --
    -- https://github.com/folke/snacks.nvim
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    -- stylua: ignore
    keys = {
      { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
      { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
      -- { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
      { "<leader>e", function() Snacks.explorer({ cwd = Snacks.git.get_root() }) end, desc = "File Explorer" },
      { "<leader>E", function() Snacks.explorer({ cwd = vim.uv.cwd() }) end, desc = "File Explorer (cwd)" },
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
      { "<leader>bD", function() Snacks.bufdelete.all() end, desc = "Delete All Buffers" },
    },
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      explorer = { enabled = false },
      image = { enabled = false },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      picker = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
  },
  {
    -- keybinding hints
    -- https://github.com/folke/which-key.nvim
    "folke/which-key.nvim",
    event = "VeryLazy",
    -- stylua: ignore
    keys = {
      { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer Local Keymaps (which-key)", },
    },
  },
  {
    -- icon library for other plugins
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
    -- bottom statusline
    -- https://github.com/nvim-mini/mini.statusline
    "nvim-mini/mini.statusline",
    event = "VeryLazy",
    opts = {},
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
}
