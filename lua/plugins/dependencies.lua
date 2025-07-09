return {
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
    -- required by bluloco
    -- colorscheme creation aid
    'rktjmp/lush.nvim',
    lazy = true
  },
  {
    -- required by which-key
    -- icons
    'echasnovski/mini.icons',
    version = '*'
  },
}
