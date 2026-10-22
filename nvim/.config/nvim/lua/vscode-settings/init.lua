-- leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
--my keymaps and commands
vim.keymap.set('n', '<leader>pv', '<cmd>Ex<CR>')
vim.keymap.set('n', '<leader>s', '<cmd>:w<CR>')
vim.keymap.set('x', 'p', [["_dP]])
vim.opt.clipboard = 'unnamedplus'

--harpoon keymaps
vim.keymap.set({ 'n', 'v' }, '<leader>ha', "<cmd>lua require('vscode').action('vscode-harpoon.addEditor')<CR>")
vim.keymap.set({ 'n', 'v' }, '<leader>ho', "<cmd>lua require('vscode').action('vscode-harpoon.editorQuickPick')<CR>")
vim.keymap.set({ 'n', 'v' }, '<leader>he', "<cmd>lua require('vscode').action('vscode-harpoon.editEditors')<CR>")
vim.keymap.set({ 'n', 'v' }, '<leader>h1', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor1')<CR>")
vim.keymap.set({ 'n', 'v' }, '<leader>h2', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor2')<CR>")
vim.keymap.set({ 'n', 'v' }, '<leader>h3', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor3')<CR>")
vim.keymap.set({ 'n', 'v' }, '<leader>h4', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor4')<CR>")
vim.keymap.set({ 'n', 'v' }, '<leader>h5', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor5')<CR>")
vim.keymap.set({ 'n', 'v' }, '<leader>h6', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor6')<CR>")
vim.keymap.set({ 'n', 'v' }, '<leader>h7', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor7')<CR>")
vim.keymap.set({ 'n', 'v' }, '<leader>h8', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor8')<CR>")
vim.keymap.set({ 'n', 'v' }, '<leader>h9', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor9')<CR>")

--vscode
-- Chat: open/focus
vim.keymap.set({ 'n', 'v' }, '<leader>c', "<cmd>lua require('vscode').action('workbench.action.chat.open')<CR>")

-- Hide/show secondary sidebar
vim.keymap.set({ 'n', 'v' }, '<leader>cc', "<cmd>lua require('vscode').action('workbench.action.toggleAuxiliaryBar')<CR>")

-- Focus main editor
vim.keymap.set({ 'n', 'v' }, '<leader>i', "<cmd>lua require('vscode').action('inlineChat.start')<CR>")
--terminal
vim.keymap.set({ 'n', 'v' }, '<leader>tr', "<cmd>lua require('vscode').action('python.execInTerminal')<CR>")
vim.keymap.set({ 'n', 'v' }, '<leader>tt', "<cmd>lua require('vscode').action('workbench.action.terminal.toggleTerminal')<CR>")
-- configs
vim.opt.scrolloff = 10
vim.opt.timeoutlen = 300

--undo highlight
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
-- install lazy.nivm plugin manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  'tpope/vim-surround',
}
