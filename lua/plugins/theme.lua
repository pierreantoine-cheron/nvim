return {
  -- {
  --   "template/theme.nvim",
  --   lazy = false, -- should load immediatly
  --   priority = 1000, -- should be the first plugin loaded
  --   config = function()
  --     vim.cmd.colorscheme("theme")
  --   end
  -- },
  -- {
  --   "EdenEast/nightfox.nvim", -- this theme has support for fish, zellij and wezterm
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme("carbonfox")
  --   end
  -- },
  -- {
  --   "navarasu/onedark.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     local onedark = require("onedark")
  --     onedark.setup {
  --       style = 'darker' -- dark, darker, cool, deep, warm, warmer, light
  --     }
  --     onedark.load()
  --   end
  -- },
  -- {
  --   "nyoom-engineering/oxocarbon.nvim",
  --   lazy = false,    -- should load immediatly
  --   priority = 1000, -- should be the first plugin loaded
  --   config = function()
  --     vim.opt.background = "dark"
  --     vim.cmd.colorscheme("oxocarbon")
  --
  --     -- transparent background
  --     -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  --     -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  --   end
  -- },
  -- {
  --   "bluz71/vim-moonfly-colors",
  --   name = "moonfly",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme("moonfly")
  --   end
  -- },
  -- {
  --   'uloco/bluloco.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   dependencies = { 'rktjmp/lush.nvim' },
  --   config = function()
  --     vim.cmd.colorscheme("bluloco")
  --   end,
  -- },
  -- {
  --   "sainnhe/sonokai",
  --   lazy = false,    -- should load immediatly
  --   priority = 1000, -- should be the first plugin loaded
  --   config = function()
  --     vim.cmd.colorscheme("sonokai")
  --   end
  -- },
  -- {
  --   "kepano/flexoki-neovim",
  --   lazy = false,  -- should load immediatly
  --   priority = 1000, -- should be the first plugin loaded
  --   name = "flexoki",
  --   config = function()
  --     vim.cmd.colorscheme("flexoki-dark")
  --   end
  -- },
  {
    "jacoborus/tender.vim",
    lazy = false, -- should load immediatly
    priority = 1000, -- should be the first plugin loaded
    config = function()
      vim.cmd.colorscheme("tender")
    end
  },

  -- {
  --   "template/theme.nvim",
  --   lazy = false, -- should load immediatly
  --   priority = 1000, -- should be the first plugin loaded
  --   config = function()
  --     vim.cmd.colorscheme("theme")
  --   end
  -- },
}
