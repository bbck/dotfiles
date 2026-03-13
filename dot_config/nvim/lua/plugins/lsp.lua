---@module "lazy"
---@type LazySpec
return {
  {
    -- https://github.com/neovim/nvim-lspconfig
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    ---@class PluginLspOpts
    opts = {
      ---@type vim.diagnostic.Opts
      diagnostics = {
        virtual_text = false,
        virtual_lines = { current_line = true },
        signs = {
          enabled = true,
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = " ",
            [vim.diagnostic.severity.HINT] = " ",
          },
        },
        underline = { severity = vim.diagnostic.severity.ERROR },
        update_in_insert = false,
        severity_sort = true,
      },
      inlay_hints = {
        enabled = true,
      },
      folds = {
        enabled = true,
      },
      servers = {
        -- jsonls = {
        --   -- lazy-load schemastore when needed
        --   before_init = function(_, new_config)
        --     new_config.settings.json.schemas = vim.tbl_deep_extend(
        --       "force",
        --       new_config.settings.json.schemas or {},
        --       require("schemastore").json.schemas()
        --     )
        --   end,
        --   settings = {
        --     json = {
        --       format = { enable = true },
        --       validate = { enable = true },
        --     },
        --   },
        -- },
        gopls = {
          settings = {
            gopls = {},
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              codeLens = {
                enable = true,
              },
              completion = {
                callSnippet = "Replace",
              },
              doc = {
                privateName = { "^_" },
              },
              format = {
                enabled = true,
              },
              hint = {
                arrayIndex = "Disable",
                enable = true,
                paramName = "Disable",
                paramType = true,
                semicolon = "Disable",
                setType = false,
              },
              workspace = {
                checkThirdParty = false,
                -- NOTE: Workaround for first load
                -- https://github.com/folke/lazydev.nvim/issues/136#issuecomment-3855867406
                library = {
                  vim.env.VIMRUNTIME,
                  { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                  { path = "snacks.nvim", words = { "Snacks" } },
                },
              },
            },
          },
        },
        yamlls = {
          capabilities = {
            textDocument = {
              foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
              },
            },
          },
          -- lazy-load schemastore when needed
          before_init = function(_, new_config)
            new_config.settings.yaml.schemas = vim.tbl_deep_extend(
              "force",
              new_config.settings.yaml.schemas or {},
              require("schemastore").yaml.schemas()
            )
          end,
          settings = {
            redhat = { telemetry = { enabled = false } },
            yaml = {
              format = { enabled = true },
              validate = true,
              schemaStore = {
                -- Must disable built-in schemaStore support to use
                -- schemas from SchemaStore.nvim plugin
                enable = false,
                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = "",
              },
            },
          },
        },
      },
    },
    ---@param opts PluginLspOpts
    config = function(_, opts)
      -- Enable lsp servers
      for server, server_opts in pairs(opts.servers) do
        vim.lsp.config[server] = server_opts
        vim.lsp.enable(server)
      end

      -- Configure diagnostics
      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("my.lsp", {}),
        callback = function(args)
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
          require("util.lsp").features(client, args.buf)
          require("util.lsp").keymaps(client, args.buf)
        end,
      })
    end,
  },
  {
    -- https://github.com/folke/lazydev.nvim
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
  },
  {
    -- https://github.com/b0o/SchemaStore.nvim
    "b0o/SchemaStore.nvim",
    lazy = true,
  },
}
