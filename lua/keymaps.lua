-- [[ Basic Keymaps ]]
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- send x-ed chars to the void
vim.keymap.set('n', 'x', '_x', { silent = true })

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
