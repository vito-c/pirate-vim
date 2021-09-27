-------------------------------------------------------------------------------
-- Neovim API aliases
-------------------------------------------------------------------------------
local kmap = vim.api.nvim_set_keymap  -- set global keymap
local cmd  = vim.cmd     	          -- execute Vim commands
local exec = vim.api.nvim_exec 	      -- execute Vimscript
local fn   = vim.fn       		      -- call Vim functions
local g    = vim.g         	          -- global variables
local opt  = vim.opt         	      -- global/buffer/windows-scoped options

function nmap(keys, command)
    vim.api.nvim_set_keymap('n', keys, command, {noremap = true})
end
function vmap(keys, command)
    vim.api.nvim_set_keymap('v', keys, command, {noremap = true})
end
function imap(keys, command)
    vim.api.nvim_set_keymap('i', keys, command, {noremap = true})
end
function tmap(keys, command)
    vim.api.nvim_set_keymap('t', keys, command, {noremap = true})
end

nmap('ZA', ':wqa<CR>')
nmap('ZQ', ':qa!<CR>')

-- Wrapped lines goes down/up to next row, rather than next line in file.
nmap('j', 'gj')
nmap('k', 'gk')
-- Yank from the cursor to the end of the line, to be consistent with C and D.
nmap('Y', 'y$')
-- Visual shifting (does not exit Visual mode)
vmap('<', '<gv')
vmap('>', '>gv')
vmap('>', '>gv')

-- insert mode
-- imap('jj', '<ESC>')
-- imap('kk', '<ESC>')
-- inoremap jk <ESC>
-- inoremap kj <ESC>
-- inoremap <C-j> <C-r>"

nmap('gf', 'gF')
nmap('gF', 'gf')
-- noremap <leader>gf :call EditFileUnder()<CR>
-- "='test'<C-M>p
-- "noremap <leader>tt "=strftime('%c')<C-M>p

-- func TestFileUnder()
--     "TODO: make this better
--     let df = expand('<cfile>')
--     startinsert test:Only " . df
-- endfun
--
-- func EditFileUnder()
--     "TODO: make this better
--     let df = substitute(expand('<cfile>'),  '\.', '/',  'g')
--     echom df
-- endfun

tmap('<Esc>', '<C-\\><C-n>')
tmap('jj', '<C-\\><C-n>')
tmap('kk', '<C-\\><C-n>')
-- tnoremap [k <C-\><C-n><Esc>[k
-- tnoremap ]k <C-\><C-n><Esc>]k
tmap('<A-h>', '<C-\\><C-n><C-w>h')
tmap('<A-j>', '<C-\\><C-n><C-w>j')
tmap('<A-k>', '<C-\\><C-n><C-w>k')
tmap('<A-l>', '<C-\\><C-n><C-w>l')
tmap('<A-w>', '<C-\\><C-n><C-w>w')
tmap('<A-c>', '<C-\\><C-n><C-w>c')
-- tnoremap <expr> <A-r> '<C-\><C-N>"'.nr2char(getchar()).'pi'

nmap('tg', 'gT')

-- Alt bindings
-- inoremap <A-h> <ESC><C-w>h
-- inoremap <A-j> <ESC><C-w>j
-- inoremap <A-k> <ESC><C-w>k
-- inoremap <A-l> <ESC><C-w>l
-- inoremap <A-w> <ESC><C-w>w

nmap('<A-h>', '<C-w>h')
nmap('<A-j>', '<C-w>j')
nmap('<A-k>', '<C-w>k')
nmap('<A-l>', '<C-w>l')
nmap('<A-w>', '<C-w>w')
nmap(']d', 'gt')
nmap('[d', 'gT')
nmap('gy', 'gT')
kmap(
    'n',
    '*',
    '"zyiw*',
    {silent = true, noremap = true}
)
kmap(
    'n',
    '#',
    '"zyiw*',
    {silent = true, noremap = true}
)

kmap(
    'v',
    '*',
    string.gsub([[
        "zy
        :<C-u>let oreg=getreg('z')<CR>
        /<C-R><C-R>=substitute(escape(@z, '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
        :call setreg('z', oreg)<CR>
        gV
    ]], '  +', ''):gsub('\r?\n+', ' '),
    {silent = true, noremap = true}
)

kmap(
    'v',
    '#',
    string.gsub([[
        "zy
        :<C-u>let oreg=getreg('z')<CR>
        ?<C-R><C-R>=substitute(escape(@z, '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
        :call setreg('z', oreg)<CR>
        gV
    ]], '  +', ''):gsub('\r?\n+', ' '),
    {silent = true, noremap = true}
)

-- select the last changed or pasted text
kmap(
    'n',
    'gp',
    "'`[' . strpart(getregtype(), 0, 1) . '`]'",
    {expr = true, noremap = true}
)
-- alternate select pasted text only nmap gp `[v`]
-- command shift keys?
-- command! -bang -nargs=* -complete=file E e<bang> <args>
-- command! -bang -nargs=* -complete=file W w<bang> <args>
-- command! -bang -nargs=* -complete=file Wq wq<bang> <args>
-- command! -bang -nargs=* -complete=file WQ wq<bang> <args>
-- command! -bang Wa wa<bang>
-- command! -bang WA wa<bang>
-- command! -bang Q q<bang>
-- command! -bang QA qa<bang>
-- command! -bang Qa qa<bang>

-- nmap('<silent> <C-]>', '<Plug>(coc-definition)')

--
--actions.move_selection_next
