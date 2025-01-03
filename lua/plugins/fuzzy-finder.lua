-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == '' then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ':h')
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')
      [1]
  if vim.v.shell_error ~= 0 then
    print 'Not a git repository. Searching on current working directory'
    return cwd
  end
  return git_root
end

return {
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
    lazy = true
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    lazy = true
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
  },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    config = function()
      local telescope = require('telescope')

      telescope.setup {
        -- defaults = {
        --   mappings = {
        --     i = {
        --       ['<C-u>'] = false,
        --       ['<C-d>'] = false,
        --       -- ['<c-enter>'] = 'to_fuzzy_refine',
        --     },
        --   },
        -- },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      telescope.load_extension("file_browser")

      -- Enable telescope extensions, if installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtins = require('telescope.builtin')
      -- See `:help telescope.builtin`
      SetTelescopeKeymap(builtins)

      -- Custom live_grep function to search in git root
      local function live_grep_git_root()
        local git_root = find_git_root()
        if git_root then
          builtins.live_grep {
            search_dirs = { git_root },
          }
        end
      end

      vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})
    end
  }
}
