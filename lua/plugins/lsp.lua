return {
  {
    'williamboman/mason-lspconfig.nvim',
    lazy = true
  },
  -- LSP Configuration & Plugins
  {
    'neovim/nvim-lspconfig',
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          SetLspKeymap(event)

          -- Create a command `:Format` local to the LSP buffer
          vim.api.nvim_buf_create_user_command(event.buf, 'Format', function(_)
            vim.lsp.buf.format()
          end, { desc = 'Format current buffer with LSP' })

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. They will be passed to
      --  the `settings` field of the server config. You must look up that documentation yourself.
      --
      --  If you want to override the default filetypes that your language server will attach to you can
      --  define the property 'filetypes' to thenmap in question.
      local mason_managed_servers = {
        clangd = {},

        rust_analyzer = {},

        ts_ls = {},

        html = {},

        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
          },
        },

        omnisharp = {}
      }

      -- ensure the servers and tools above are installed
      -- mason is a lsp package manager ?
      -- mason-lspconfig requires that these setup functions are called in this order
      -- before setting up the servers.
      require('mason').setup()


      -- Ensure the servers above are installed
      local mason_lspconfig = require('mason-lspconfig')

      local function get_setup_for_server_list(server_list)
        return function(server_name)
          local server = server_list[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for tsserver)
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end
      end

      local mason_managed_servers_setup = get_setup_for_server_list(mason_managed_servers)
      mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(mason_managed_servers),
        -- handlers = mason_managed_servers_setup
      })

      mason_lspconfig.setup_handlers({
        mason_managed_servers_setup
      })
      -- local function language_server_setup(server_name)
      --   require('lspconfig')[server_name].setup {
      --     capabilities = capabilities,
      --     on_attach = on_attach,
      --     settings = servers[server_name],
      --     filetypes = (servers[server_name] or {}).filetypes,
      --   }
      -- end

      -- mason_lspconfig.setup_handlers {
      --   language_server_setup
      -- }

      local mason_free_servers = {
        gdscript = {},
        biome = {},
      }

      -- for key, _ in pairs(mason_free_servers) do
      --   language_server_setup(key)
      -- end

      for key, _ in pairs(mason_free_servers) do
        local mason_free_servers_setup = get_setup_for_server_list(mason_free_servers)
        mason_free_servers_setup(key)
      end
    end
  } }
