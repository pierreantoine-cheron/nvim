require("prelude")

require("os_specifics")

-- [[ Setting options ]]
require("options")

-- [[ Basic Keymaps ]]
require("keymaps")

-- [[ Install `lazy.nvim` plugin manager ]]
require("plugin_manager")

-- [[ Configure plugins ]]
require('lazy').setup({
  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/plugins/*.lua`
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  { import = 'plugins' },
}, {})

require("autocommands")

require("ft")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
