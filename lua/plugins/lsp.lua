return {
  -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',

    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { 'j-hui/fidget.nvim',       opts = {} },

    -- Additional lua configuration, makes nvim stuff amazing!
    { 'folke/neodev.nvim',       opts = {} }, -- better lsp for neovim config
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = desc })
        end

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

        -- Find references for the word under your cursor.
        nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
        -- nmap('<leader>ca', function()
        --   vim.lsp.buf.code_action { context = { only = { 'quickfix', 'refactor', 'source' } } }
        -- end, '[C]ode [A]ction')

        -- Opens a popup that displays documentation about the word under your cursor
        -- See `:help K` for why this keymap
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')

        -- Opens a popup with the signature (return type & args) of the function under the cursor
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- folders management
        nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        nmap('<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, '[W]orkspace [L]ist Folders')

        -- Format the current buffer
        nmap('<leader>f', vim.lsp.buf.format, '[F]ormat current buffer with LSP')

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

      tsserver = {},

      html = {},

      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
          -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
          -- diagnostics = { disable = { 'missing-fields' } },
        },
      },
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
    }

    -- for key, _ in pairs(mason_free_servers) do
    --   language_server_setup(key)
    -- end

    for key, _ in pairs(mason_free_servers) do
      local mason_free_servers_setup = get_setup_for_server_list(mason_free_servers)
      mason_free_servers_setup(key)
    end
  end
}
