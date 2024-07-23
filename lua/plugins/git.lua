return {
  'tpope/vim-fugitive', -- bring Git commands to vim :Git
  'tpope/vim-rhubarb',  -- fugitive extension to enhance github experience.
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = 'x' },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        SetGitKeymap(bufnr, gs)
      end,
    },
  },
}
