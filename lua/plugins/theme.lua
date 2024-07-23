local themes_plugins = {
  {
    plugin = { "EdenEast/nightfox.nvim" }, -- this theme has support for fish, zellij and wezterm
    themery_config = {
      name = "Nightfox",
      variations = {
        {
          name = "Nightfox",
          colorscheme = "nightfox",
        },
        {
          name = "Dayfox (light)",
          colorscheme = "dayfox",
        },
        {
          name = "Dawnfox (light)",
          colorscheme = "dawnfox",
        },
        {
          name = "Duskfox",
          colorscheme = "duskfox",
        },
        {
          name = "Nordfox",
          colorscheme = "nordfox",
        },
        {
          name = "Terafox",
          colorscheme = "terafox",
        },
        {
          name = "Carbonfox",
          colorscheme = "carbonfox",
        },
      }
    }
  },
  {
    plugin = { "navarasu/onedark.nvim" },
    themery_config = {
      name = "Onedark",
      colorscheme = "onedark",
      variations = {
        {
          name = "Dark",
          before = [[
          local onedark = require("onedark")
          onedark.setup {
            style = 'dark' -- dark, darker, cool, deep, warm, warmer, light
          }
        ]]
        },
        {
          name = "Darker",
          before = [[
          local onedark = require("onedark")
          onedark.setup {
            style = 'darker'
          }
        ]]
        },
        {
          name = "Cool",
          before = [[
          local onedark = require("onedark")
          onedark.setup {
            style = 'cool'
          }
        ]]
        },
        {
          name = "Deep",
          before = [[
          local onedark = require("onedark")
          onedark.setup {
            style = 'deep'
          }
        ]]
        },
        {
          name = "Warm",
          before = [[
          local onedark = require("onedark")
          onedark.setup {
            style = 'warm'
          }
        ]]
        },
        {
          name = "Warmer",
          before = [[
          local onedark = require("onedark")
          onedark.setup {
            style = 'warmer'
          }
        ]]
        },
        {
          name = "Light",
          before = [[
          local onedark = require("onedark")
          onedark.setup {
            style = 'light'
          }
        ]]
        },
      }
    },
  },
  {
    plugin = { "nyoom-engineering/oxocarbon.nvim" },
    themery_config = {
      name = "Oxocarbon",
      colorscheme = "oxocarbon",
      variations = {
        {
          name = "Dark",
          before = [[
          vim.opt.background = "dark"
          -- transparent background
          -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
          -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        ]]
        },
        {
          name = "Light",
          before = [[
          vim.opt.background = "light"
          -- transparent background
          -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
          -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        ]]
        },
      }
    },
  },
  {
    plugin = { "bluz71/vim-moonfly-colors" },
    themery_config = {
      name = "Moonfly",
      colorscheme = "moonfly",
    },
  },
  {
    plugin = { 'uloco/bluloco.nvim' },
    themery_config = {
      name = "Bluloco",
      variations = {
        {
          name = "Light",
          colorscheme = "bluloco-light",
        },
        {
          name = "Dark",
          colorscheme = "bluloco-dark",
        },
      },
    }
  },
  {
    plugin = { "sainnhe/sonokai" },
    themery_config = {
      name = "Sonokai",
      colorscheme = "sonokai",
      variations = {
        {
          name = "Default",
          before = [[
          vim.g.sonokai_style = "default"
          vim.g.sonokai_enable_italic = true
        ]]
        },
        {
          name = "Atlantis",
          before = [[
          vim.g.sonokai_style = "atlantis"
          vim.g.sonokai_enable_italic = true
        ]]
        },
        {
          name = "Andromeda",
          before = [[
          vim.g.sonokai_style = "andromeda"
          vim.g.sonokai_enable_italic = true
        ]]
        },
        {
          name = "Shusia",
          before = [[
          vim.g.sonokai_style = "shusia"
          vim.g.sonokai_enable_italic = true
        ]]
        },
        {
          name = "Maia",
          before = [[
          vim.g.sonokai_style = "maia"
          vim.g.sonokai_enable_italic = true
        ]]
        },
        {
          name = "Espresso",
          before = [[
          vim.g.sonokai_style = "espresso"
          vim.g.sonokai_enable_italic = true
        ]]
        },
      },
    },
  },
  {
    plugin = { "kepano/flexoki-neovim" },
    themery_config = {
      name = "Flexoki",
      variations = {
        {
          name = "Light",
          colorscheme = "flexoki-light",
        },
        {
          name = "Dark",
          colorscheme = "flexoki-dark",
        },
      },
    },
  },
  {
    plugin = { "jacoborus/tender.vim" },
    themery_config = {
      name = "Tender",
      colorscheme = "tender",
    },
  },
}

local function get_plugin_list()
  return vim.iter(themes_plugins):map(function(value)
    return value.plugin
  end):totable()
end

local function get_themes_list()
  local raw_themes = vim.iter(themes_plugins):map(function(value)
    return value.themery_config
  end)

  local themery_converted_themes = {}

  raw_themes:each(function(value)
    local template = {}
    if value.name ~= nil then
      template.name = value.name
    end
    if value.colorscheme ~= nil then
      template.colorscheme = value.colorscheme
    end
    if value.variations == nil then
      vim.list_extend(themery_converted_themes, { template })
      return
    end
    vim.iter(value.variations):each(function(variation)
      local variation_theme = {}
      variation_theme.name = template.name .. " - " .. variation.name
      if variation.colorscheme ~= nil then
        variation_theme.colorscheme = variation.colorscheme
      else
        variation_theme.colorscheme = template.colorscheme
      end
      variation_theme.before = variation.before
      vim.list_extend(themery_converted_themes, { variation_theme })
    end)
  end)

  return themery_converted_themes
end

local themery_themes = get_themes_list()

local theme_manager = {
  'zaldih/themery.nvim',
  config = function()
    require("themery").setup({
      themes = themery_themes,
      themeConfigFile = vim.fn.stdpath('config') .. "/lua/generated/theme.lua", -- location of the file that will be modified for persistence purposes
      livePreview = true,                                                       -- Apply theme while browsing. Default to true.
    })
    SetThemesKeymap()
  end
}

local plugins = { theme_manager }
vim.list_extend(plugins, get_plugin_list())

return plugins
