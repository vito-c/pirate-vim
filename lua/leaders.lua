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
-- File 📁 actions
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
    "$:call chansend(&channel, ['testOnly '. expand('<cfile>'), ''])<CR>"
)
nmap('<leader>ta', "$:call chansend(&channel, ['test', ''])<CR>")
--  \x1b\x5b\x41
nmap('<leader>tl', "$:call chansend(&channel, ['!!', ''])<CR>G")
nmap('<leader>ts', ':<C-U>call rc#leaders#opensbt()<CR>')
nmap('<leader>tss', ':<C-U>call rc#leaders#opensbt()<CR>')
nmap(
    '<leader>tst',
    ":<C-U>call rc#leaders#opensbt()<Bar>call chansend(&channel, ['test', ''])<CR>G"
)
nmap(
    '<leader>tsl',
    ":<C-U>call rc#leaders#opensbt()<Bar>call chansend(&channel, ['!!' , ''])<CR>G"
)
nmap(
    '<leader>tsq',
    ":<C-U>call rc#leaders#opensbt()<Bar>call chansend(&channel, ['testQuick' , ''])<CR>G"
)

nmap('<leader>ct', ':tabclose <CR>')

function leaders_opensbt()

    print("implement")
end

function leaders_openterminal(name, command)
    cmd('wincmd s')
    cmd('wincmd T')
    cmd('terminal')
    cmd('file ' .. name)
    -- vim.o.channel
    -- vim.fn.chansend( 3, {'echo hi', ''})
    -- :lua vim.api.nvim_call_function('chansend', { 3, {'echo hi', ''}})
    fn.chansend(vim.o.channel, {command, ''})
end

function leaders_jump_to_buffer(name)
    print("implement")
end

function leaders_jump_tab_win(t,w)
    cmd('tabnext')
    cmd('wincmd w')
end

function leaders_find_open_window(bnr)
    print("implement")
end
