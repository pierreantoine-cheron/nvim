-- [[ Basic Keymaps ]]
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- send x-ed chars to the void
vim.keymap.set('n', 'x', '"_x', { silent = true })

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- disable noob keys
local arrow_opts = { noremap = true, silent = true }
vim.keymap.set({ 'n', 'v' }, '<Up>', '<Nop>', arrow_opts)
vim.keymap.set({ 'n', 'v' }, '<Down>', '<Nop>', arrow_opts)
vim.keymap.set({ 'n', 'v' }, '<Left>', '<Nop>', arrow_opts)
vim.keymap.set({ 'n', 'v' }, '<Right>', '<Nop>', arrow_opts)

-- keep the cursor in the middle of the screen when scrolling
-- from https://www.github.com/ThePrimeagen/init.lua
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
-- and for searching
vim.keymap.set('n', 'n', 'nzzv')
vim.keymap.set('n', 'N', 'Nzzv')

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

function SetThemesKeymap()
  vim.keymap.set('n', '<leader>st', ':Themery<cr>', { desc = '[S]earch [T]hemes' })
end

function SetLspKeymap(event)
  -- Jump to the definition of the word under your cursor.
  --  This is where a variable was first declared, or where a function is defined, etc.
  --  To jump back, press <C-t>.
  vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions,
    { buffer = event.buf, desc = 'Lsp: [G]oto [D]efinition' })

  -- Find references for the word under your cursor.
  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references,
    { buffer = event.buf, desc = 'Lsp: [G]oto [R]eferences' })

  -- Jump to the implementation of the word under your cursor.
  --  Useful when your language has ways of declaring types without an actual implementation.
  vim.keymap.set('n', 'gI', require('telescope.builtin').lsp_implementations,
    { buffer = event.buf, desc = 'Lsp: [G]oto [I]mplementation' })

  -- Jump to the type of the word under your cursor.
  --  Useful when you're not sure what type a variable is and you want to see
  --  the definition of its *type*, not where it was *defined*.
  vim.keymap.set('n', '<leader>D', require('telescope.builtin').lsp_type_definitions,
    { buffer = event.buf, desc = 'Lsp: Type [D]efinition' })

  -- Fuzzy find all the symbols in your current document.
  --  Symbols are things like variables, functions, types, etc.
  vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols,
    { buffer = event.buf, desc = 'Lsp: [D]ocument [S]ymbols' })

  -- Fuzzy find all the symbols in your current workspace.
  --  Similar to document symbols, except searches over your entire project.
  vim.keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
    { buffer = event.buf, desc = 'Lsp: [W]orkspace [S]ymbols' })

  -- Rename the variable under your cursor.
  --  Most Language Servers support renaming across files, etc.
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = event.buf, desc = 'Lsp: [R]e[n]ame' })

  -- Execute a code action, usually your cursor needs to be on top of an error
  -- or a suggestion from your LSP for this to activate.
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = event.buf, desc = 'Lsp: [C]ode [A]ction' })
  -- vim.keymap.set('n', '<leader>ca', function()
  --   vim.lsp.buf.code_action { context = { only = { 'quickfix', 'refactor', 'source' } } }
  -- end, '[C]ode [A]ction')

  -- Opens a popup that displays documentation about the word under your cursor
  -- See `:help K` for why this keymap
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = event.buf, desc = 'Lsp: Hover Documentation' })

  -- Opens a popup with the signature (return type & args) of the function under the cursor
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = event.buf, desc = 'Lsp: Signature Documentation' })

  -- WARN: This is not Goto Definition, this is Goto Declaration.
  --  For example, in C this would take you to the header.
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = event.buf, desc = 'Lsp: [G]oto [D]eclaration' })

  -- folders management
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder,
    { buffer = event.buf, desc = 'Lsp: [W]orkspace [A]dd Folder' })
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
    { buffer = event.buf, desc = 'Lsp: [W]orkspace [R]emove Folder' })
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { buffer = event.buf, desc = 'Lsp: [W]orkspace [L]ist Folders' })

  -- Format the current buffer
  vim.keymap.set('n', '<leader>f', vim.lsp.buf.format,
    { buffer = event.buf, desc = 'Lsp: [F]ormat current buffer with LSP' })
end

function SetOilKeymap()
  vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
end

function SetGitKeymap(bufnr, gs)
  -- Navigation
  vim.keymap.set({ 'n', 'v' }, ']c', function()
    if vim.wo.diff then
      return ']c'
    end
    vim.schedule(function()
      gs.next_hunk()
    end)
    return '<Ignore>'
  end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })

  vim.keymap.set({ 'n', 'v' }, '[c', function()
    if vim.wo.diff then
      return '[c'
    end
    vim.schedule(function()
      gs.prev_hunk()
    end)
    return '<Ignore>'
  end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })

  -- Actions
  -- visual mode
  vim.keymap.set('v', '<leader>hs', function()
    gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
  end, { buffer = bufnr, desc = 'stage git hunk' })
  vim.keymap.set('v', '<leader>hr', function()
    gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
  end, { buffer = bufnr, desc = 'reset git hunk' })
  -- normal mode
  vim.keymap.set('n', '<leader>hs', gs.stage_hunk, { buffer = bufnr, desc = 'git stage hunk' })
  vim.keymap.set('n', '<leader>hr', gs.reset_hunk, { buffer = bufnr, desc = 'git reset hunk' })
  vim.keymap.set('n', '<leader>hS', gs.stage_buffer, { buffer = bufnr, desc = 'git Stage buffer' })
  vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk, { buffer = bufnr, desc = 'undo stage hunk' })
  vim.keymap.set('n', '<leader>hR', gs.reset_buffer, { buffer = bufnr, desc = 'git Reset buffer' })
  vim.keymap.set('n', '<leader>hp', gs.preview_hunk, { buffer = bufnr, desc = 'preview git hunk' })
  vim.keymap.set('n', '<leader>hb', function()
    gs.blame_line { full = false }
  end, { buffer = bufnr, desc = 'git blame line' })
  vim.keymap.set('n', '<leader>hd', gs.diffthis, { buffer = bufnr, desc = 'git diff against index' })
  vim.keymap.set('n', '<leader>hD', function()
    gs.diffthis '~'
  end, { buffer = bufnr, desc = 'git diff against last commit' })

  -- Toggles
  vim.keymap.set('n', '<leader>tb', gs.toggle_current_line_blame, { buffer = bufnr, desc = 'toggle git blame line' })
  vim.keymap.set('n', '<leader>td', gs.toggle_deleted, { buffer = bufnr, desc = 'toggle git show deleted' })

  -- Text object
  vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { buffer = bufnr, desc = 'select git hunk' })
end

function SetTelescopeKeymap(builtins)
  vim.keymap.set('n', '<leader>?', builtins.oldfiles, { desc = '[?] Find recently opened files' })
  vim.keymap.set('n', '<leader><leader>', builtins.buffers, { desc = '[ ] Find existing buffers' })
  vim.keymap.set('n', '<leader>ss', builtins.builtin, { desc = '[S]earch [S]elect Telescope' })
  vim.keymap.set('n', '<leader>sk', builtins.keymaps, { desc = '[S]earch [K]eymaps' })
  vim.keymap.set('n', '<leader>gf', builtins.git_files, { desc = 'Search [G]it [F]iles' })
  vim.keymap.set('n', '<leader>sf', builtins.find_files, { desc = '[S]earch [F]iles' })
  vim.keymap.set('n', '<leader>sh', builtins.help_tags, { desc = '[S]earch [H]elp' })
  vim.keymap.set('n', '<leader>sw', builtins.grep_string, { desc = '[S]earch current [W]ord' })
  vim.keymap.set('n', '<leader>sg', builtins.live_grep, { desc = '[S]earch by [G]rep' })
  vim.keymap.set('n', '<leader>sd', builtins.diagnostics, { desc = '[S]earch [D]iagnostics' })
  vim.keymap.set('n', '<leader>sr', builtins.resume, { desc = '[S]earch [R]esume' })

  vim.keymap.set('n', '<leader>s/', function()
    builtins.live_grep {
      grep_open_files = true,
      prompt_title = 'Live Grep in Open Files',
    }
  end, { desc = '[S]earch [/] in Open Files' })

  vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })

  vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    builtins.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, { desc = '[/] Fuzzily search in current buffer' })

  -- Shortcut for searching your Neovim configuration files
  vim.keymap.set('n', '<leader>sn', function()
    builtins.find_files { cwd = vim.fn.stdpath 'config' }
  end, { desc = '[S]earch [N]eovim files' })

  vim.keymap.set('n', '<leader>sq', function()
    builtins.live_grep({
      glob_pattern = { "!node_modules/*", "!build/*"},
      grep_open_files = true,
      prompt_title = 'Live Grep ignoring build folders',
    })
  end, { desc = '[S]earch [Q] by Grep ignoring build folders' })
end

function SetDapKeymap(dap)
  vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
  vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
  vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
  vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
  vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
  vim.keymap.set('n', '<leader>B', function()
    dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
  end, { desc = 'Debug: Set Breakpoint' })
end

function SetDapUiKeymap(dapui)
  -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
  vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })
end
