return {
  {
    -- required by nvim-dap
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',
    lazy = true
  },
  {
    -- required by nvim-dap
    -- library
    'nvim-neotest/nvim-nio',
    lazy = true
  },
  {
    -- required by nvim-dap
    -- LSP, debug adapters, linters, formatters package manager
    'williamboman/mason.nvim',
    config = true,
    lazy = true
  },
  {
    -- required by nvim-dap
    -- Installs the debug adapters for you
    'jay-babu/mason-nvim-dap.nvim',
    lazy = true
  },
  {
    -- required by telescope, todo-comments
    -- library
    'nvim-lua/plenary.nvim',
    lazy = true
  },
  {
    -- required by telescope, trouble, oil, alpha-nvim
    -- Useful for getting pretty icons, but requires a Nerd Font.
    'nvim-tree/nvim-web-devicons',
    enabled = vim.g.have_nerd_font
  },
  {
    -- required by nvim-lspconfig
    -- Display notifications
    'j-hui/fidget.nvim',
    opts = {},
    lazy = true
  },
  {
    -- required by bluloco
    -- colorscheme creation aid
    'rktjmp/lush.nvim',
    lazy = true
  },
}
