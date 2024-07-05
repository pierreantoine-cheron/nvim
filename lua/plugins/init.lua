-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth', -- detect format conventions in the current file: tabs/spaces, etc.

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'auto',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  -- NOTE: `opts = {}` is the same as calling `require('plugin').setup({})`
  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
  },

  -- "gc" to comment visual regions/lines
  {
    'numToStr/Comment.nvim',
    opts = {}
  },

  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    opts = { signs = false }
  },

  -- sticky classes/functions definitions
  {
    'nvim-treesitter/nvim-treesitter-context',
    opts = {}
  },

  -- list diagnostics
  {
    "folke/trouble.nvim",
    opts = {},
  },

  -- better ui
  {
    'stevearc/dressing.nvim',
    opts = {}
  },

  -- file management as text file
  {
    'stevearc/oil.nvim',
    config = function()
      require("oil").setup()
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end
  },
}
