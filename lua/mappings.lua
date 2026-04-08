-------------------------------------------------------------------------------
-- Neovim API aliases
-------------------------------------------------------------------------------
vim.keymap.set('n', 'ZA', ':wqa<CR>', {noremap = true})
vim.keymap.set('n', 'ZQ', ':qa!<CR>', {noremap = true})

-- Wrapped lines goes down/up to next row, rather than next line in file.
vim.keymap.set('n', 'j', 'gj', {noremap = true})
vim.keymap.set('n', 'k', 'gk', {noremap = true})
-- Yank from the cursor to the end of the line, to be consistent with C and D.
vim.keymap.set('n', 'Y', 'y$', {noremap = true})
-- Visual shifting (does not exit Visual mode)
vim.keymap.set('v', '<', '<gv', {noremap = true})
vim.keymap.set('v', '>', '>gv', {noremap = true})
vim.keymap.set('v', '>', '>gv', {noremap = true})

-- insert mode
-- imap('jj', '<ESC>')
-- imap('kk', '<ESC>')
-- inoremap jk <ESC>
-- inoremap kj <ESC>
-- inoremap <C-j> <C-r>"

vim.keymap.set('n', 'gf', 'gF', {noremap = true})
vim.keymap.set('n', 'gF', 'gf', {noremap = true})
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

-- tmap('kk', '<C-\\><C-n>')
-- tnoremap [k <C-\><C-n><Esc>[k
-- tnoremap ]k <C-\><C-n><Esc>]k
vim.keymap.set('t', '<C-o>', "<C-\\><C-n>:lua require('builtins').clearterm()<CR>", {noremap=true})
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', {noremap=true})
vim.keymap.set('t', '<C-q>', function()
  vim.fn.chansend(vim.bo.channel, '\x1b')
end, { noremap = true, silent = true })
vim.keymap.set('t', '<A-h>', '<C-\\><C-n><C-w>h', {noremap=true})
vim.keymap.set('t', '<A-j>', '<C-\\><C-n><C-w>j', {noremap=true})
vim.keymap.set('t', '<A-k>', '<C-\\><C-n><C-w>k', {noremap=true})
vim.keymap.set('t', '<A-l>', '<C-\\><C-n><C-w>l', {noremap=true})
vim.keymap.set('t', '<A-w>', '<C-\\><C-n><C-w>w', {noremap=true})
vim.keymap.set('t', '<A-c>', '<C-\\><C-n><C-w>c', {noremap=true})
-- tnoremap <expr> <A-r> '<C-\><C-N>"'.nr2char(getchar()).'pi'

vim.keymap.set('n', 'tg', 'gT', {noremap = true})

-- Alt bindings
-- inoremap <A-h> <ESC><C-w>h
-- inoremap <A-j> <ESC><C-w>j
-- inoremap <A-k> <ESC><C-w>k
-- inoremap <A-l> <ESC><C-w>l
-- inoremap <A-w> <ESC><C-w>w

vim.keymap.set('n', '<A-h>', '<C-w>h', {noremap = true})
vim.keymap.set('n', '<A-j>', '<C-w>j', {noremap = true})
vim.keymap.set('n', '<A-k>', '<C-w>k', {noremap = true})
vim.keymap.set('n', '<A-l>', '<C-w>l', {noremap = true})
vim.keymap.set('n', '<A-w>', '<C-w>w', {noremap = true})
-- vim.keymap.set('n', ']d', 'gt')
-- vim.keymap.set('n', '[d', 'gT')
vim.keymap.set('n', 'gy', 'gT')
vim.keymap.set(
    'n',
    '*',
    '"zyiw*',
    { silent = true, noremap = true }
)
vim.keymap.set(
    'n',
    '#',
    '"zyiw*',
    { silent = true, noremap = true }
)

vim.keymap.set(
    'v',
    '*',
    string.gsub([[
        "zy
        :<C-u>let oreg=getreg('z')<CR>
        /<C-R><C-R>=substitute(escape(@z, '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
        :call setreg('z', oreg)<CR>
        gV
    ]], '  +', ''):gsub('\r?\n+', ' '),
    { silent = true, noremap = true }
)

vim.keymap.set(
    'v',
    '#',
    string.gsub([[
        "zy
        :<C-u>let oreg=getreg('z')<CR>
        ?<C-R><C-R>=substitute(escape(@z, '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
        :call setreg('z', oreg)<CR>
        gV
    ]], '  +', ''):gsub('\r?\n+', ' '),
    { silent = true, noremap = true }
)

-- select the last changed or pasted text
vim.keymap.set(
    'n',
    'gp',
    "'`[' . strpart(getregtype(), 0, 1) . '`]'",
    { expr = true, noremap = true }
)

vim.keymap.set("n", "q:", "q:", { noremap = true, desc = "Native cmdwin" })

vim.keymap.set("c", "<C-f>", function()
    require("noice").cmd("dismiss")
    -- small delay to let noice close, then send <C-f>
    vim.schedule(function()
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-f>", true, true, true), "n")
    end)
end, { desc = "Open cmdline window" })


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
