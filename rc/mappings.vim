" Information {
"--------------------------------------------------------------------------------
" vim: set sw=4 ts=4 sts=4 et tw=90 foldmethod=marker :
"
" By: Vito C.
" }
if g:debug_startup
    echo "mappings"
endif
noremap ZA :wqa<CR>
noremap ZQ :qa!<CR>

" Wrapped lines goes down/up to next row, rather than next line in file.
nnoremap j gj
nnoremap k gk
" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$
" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv
vnoremap > >gv

" insert mode
inoremap jj <ESC>
inoremap kk <ESC>
"inoremap jk <ESC>
"inoremap kj <ESC>
" inoremap <C-j> <C-r>"

noremap gf gF
noremap gF gf
" noremap <leader>gf :call EditFileUnder()<CR>
"='test'<C-M>p
"noremap <leader>tt "=strftime('%c')<C-M>p
func TestFileUnder()
    "TODO: make this better
    let df = expand('<cfile>')
    startinsert test:Only " . df
endfun

func EditFileUnder()
    "TODO: make this better
    let df = substitute(expand('<cfile>'),  '\.', '/',  'g')
    echom df
endfun

if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    tnoremap jj <C-\><C-n>
    tnoremap kk <C-\><C-n>
    " tnoremap [k <C-\><C-n><Esc>[k
    " tnoremap ]k <C-\><C-n><Esc>]k
    tnoremap <A-h> <C-\><C-n><C-w>h
    tnoremap <A-j> <C-\><C-n><C-w>j
    tnoremap <A-k> <C-\><C-n><C-w>k
    tnoremap <A-l> <C-\><C-n><C-w>l
    tnoremap <A-w> <C-\><C-n><C-w>w
    tnoremap <A-c> <C-\><C-n><C-w>c
    tnoremap <expr> <A-r> '<C-\><C-N>"'.nr2char(getchar()).'pi'
endif

nnoremap tg gT

inoremap <A-h> <ESC><C-w>h
inoremap <A-j> <ESC><C-w>j
inoremap <A-k> <ESC><C-w>k
inoremap <A-l> <ESC><C-w>l
inoremap <A-w> <ESC><C-w>w

nnoremap <leader>ct :tabclose <CR>
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
nnoremap <A-w> <C-w>w
nnoremap ]d gt
nnoremap [d gT
nnoremap gy gT

" Better */# Search {{{
vnoremap <silent> * :<C-U>
            \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
            \gvy/<C-R><C-R>=substitute(
            \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
            \gV:call setreg('"', old_reg, old_regtype)<CR>

vnoremap <silent> # :<C-U>
            \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
            \gvy?<C-R><C-R>=substitute(
            \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
            \gV:call setreg('"', old_reg, old_regtype)<CR>

" vnoremap <leader>ff :<C-U>
"             \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
"             \gvy:vimgrep "<C-R><C-R>=substitute(
"             \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR>" %<CR>
"             \gV:call setreg('"', old_reg, old_regtype)<CR>
"             \:copen<CR>

" }}}

"select the last changed or pasted text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
" alternate select pasted text only nmap gp `[v`]
" Command Shift Keys {{{
command! -bang -nargs=* -complete=file E e<bang> <args>
command! -bang -nargs=* -complete=file W w<bang> <args>
command! -bang -nargs=* -complete=file Wq wq<bang> <args>
command! -bang -nargs=* -complete=file WQ wq<bang> <args>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Q q<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>

map <silent> <C-]> <Plug>(coc-definition)
" }}}
