-------------------------------------------------------------------------------
-- Neovim API aliases
-------------------------------------------------------------------------------
local kmap = vim.api.nvim_set_keymap  -- set global keymap
local cmd = vim.cmd     	    -- execute Vim commands
local exec = vim.api.nvim_exec 	-- execute Vimscript
local fn = vim.fn       		-- call Vim functions
local g = vim.g         	    -- global variables
local opt = vim.opt         	-- global/buffer/windows-scoped options
function nmap(keys, command)
    vim.api.nvim_set_keymap('n', keys, command, {noremap = true})
end
function vmap(keys, command)
    vim.api.nvim_set_keymap('v', keys, command, {noremap = true})
end

g.mapleader = ' '
g.VITORC = fn.fnamemodify('$MYVIMRC', ':p:h') .. "/init.lua"

-------------------------------------------------------------------------------
-- File actions
-------------------------------------------------------------------------------
nmap('<leader>w', ':<C-u>wa<CR>')
nmap(
    '<leader><leader>jt',
    ':<C-u>%!python -m json.tool<CR><Esc>:set filetype=json<CR>'
)
nmap('<leader>ev', ':<C-u>execute "tabedit " . g:VITORC<CR>')
nmap('<leader>eb', ':<C-U>tabedit $CODE_CONFIGS/pirate-setup/bashrc<CR>')
nmap('<leader>eg', ':<C-U>tabedit $CODE_CONFIGS/pirate-setup/gitconfig<CR>')
-- to previous file
nmap('<leader>o', '<C-^>')

-------------------------------------------------------------------------------
-- Copy Paste Actions
-------------------------------------------------------------------------------
-- To Clipboard
nmap('<leader>y', '"*y')
nmap('<leader>Y', '"*y$')
vmap('<leader>y', '"*y')
vmap('<leader>Y', '"*y$')
-- From Clipboard
nmap('<leader>p', '"*p')
nmap('<leader>P', '"*P')
vmap('<leader>p', '"*p')
vmap('<leader>P', '"*P')
-- last yanked
nmap('<leader>0', ':echom "use leader p0"<CR>')
vmap('<leader>0', ':echom "use leader p0"<CR>')
nmap('<leader>p0', '"0p')
nmap('<leader>P0', '"0P')
vmap('<leader>p0', '"0p')
vmap('<leader>P0', '"0P')

