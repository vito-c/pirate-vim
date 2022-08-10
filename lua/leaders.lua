-------------------------------------------------------------------------------
-- Neovim API aliases
-------------------------------------------------------------------------------
local kmap = vim.api.nvim_set_keymap  -- set global keymap
local cmd = vim.cmd     	    -- execute Vim commands
local exec = vim.api.nvim_exec 	-- execute Vimscript
local fn = vim.fn       		-- call Vim functions
local g = vim.g         	    -- global variables
local opt = vim.opt         	-- global/buffer/windows-scoped options local function nmap(keys, command)
local function nmap(keys, command)
    vim.api.nvim_set_keymap('n', keys, command, {noremap = true})
end
local function vmap(keys, command)
    vim.api.nvim_set_keymap('v', keys, command, {noremap = true})
end
function tmap(keys, command)
    vim.api.nvim_set_keymap('t', keys, command, {noremap = true})
end

g.mapleader = ' '

-------------------------------------------------------------------------------
-- File 📁 actions
-------------------------------------------------------------------------------
nmap('<leader>w', ':<C-u>wa<CR>')
nmap(
    '<leader><leader>jt',
    ':<C-u>%!python -m json.tool<CR><Esc>:set filetype=json<CR>'
)
nmap('<leader>ev', ':<C-u>execute "tabedit " . $MYVIMRC<CR>')
nmap('<leader>eb', ':<C-U>tabedit $CODE_CONFIGS/pirate-setup/bashrc<CR>')
nmap('<leader>eg', ':<C-U>tabedit $CODE_CONFIGS/pirate-setup/gitconfig<CR>')
-- to previous file
nmap('<leader>o', '<C-^>')

-------------------------------------------------------------------------------
-- Copy ✂️  Paste 📋 Actions
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
nmap('<leader>00', ':<C-u>echom "use leader 0p"<CR>')
vmap('<leader>00', ':<C-u>echom "use leader 0p"<CR>')
nmap('<leader>0p', '"0p')
nmap('<leader>0P', '"0P')
vmap('<leader>0p', '"0p')
vmap('<leader>0P', '"0P')

-------------------------------------------------------------------------------
-- 🌶️  TerminalLoading Mapping
-------------------------------------------------------------------------------
nmap(
    '<leader>to',
    ":lua require('builtins').test_only_file(); <CR>"
)
nmap(
    '<leader>tf',
    ":lua require('builtins').test_function(); <CR>"
)

-- "$:call chansend(&channel, ['testOnly '. expand('<cfile>'), ''])<CR>"
nmap('<leader>ta', "$:call chansend(&channel, ['pytest tests/unit', ''])<CR>")
--  \x1b\x5b\x41
-- nmap('<leader>tl', "$:call chansend(&channel, ['!!', ''])<CR>G")
nmap('<leader>tt', ":lua require('builtins').opentestterm()<CR>")
nmap(
    '<leader>ts',
    ":lua require('builtins').opentestterm(); vim.fn.chansend(vim.o.channel, {'pytest tests/unit', ''})<CR>"
)
nmap(
    '<leader>tl',
    ":lua require('builtins').opentestterm(); vim.fn.chansend(vim.o.channel, {'!!', ''})<CR>"
)
nmap(
    '<leader>tg',
    ":lua require('builtins').opentestterm(); vim.fn.chansend(vim.o.channel, {'make lint', ''})<CR>"
)
nmap(
    '<leader>tm',
    ":lua require('builtins').opentestterm(); vim.fn.chansend(vim.o.channel, {'make format mypy', ''})<CR>"
)
-- ":<C-U>call rc#leaders#opensbt()<Bar>call chansend(&channel, ['!!' , ''])<CR>G"
-- nmap(
--     '<leader>tsq',
--     ":<C-U>call rc#leaders#opensbt()<Bar>call chansend(&channel, ['testQuick' , ''])<CR>G"
-- )

nmap('<leader>ct', ':tabclose <CR>')

