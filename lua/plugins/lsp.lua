return {
  -- LSP Configuration & Plugins
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
    },
    opts = {
      -- add here the tools I want to install (linters, formatters, etc.)
    }
  },
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
      {
        'neovim/nvim-lspconfig',
        dependencies = {
          {
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
              library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                "nvim-dap-ui",
              },
            },
          },
          'mason-org/mason-lspconfig.nvim',

          -- Useful status updates for LSP.
          { 'j-hui/fidget.nvim', opts = {} },
        },
      },
      {
        'mason-org/mason.nvim',
        opts = {
          ui = {
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗",
            },
          },
        }
      },
    },
    opts = {
      ensure_installed = {
        "clangd",
        "rust_analyzer",
        "html",
        "lua_ls",
        "omnisharp",
        "vtsls",
      }
    }
  }
}

