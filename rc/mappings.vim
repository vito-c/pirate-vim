" Information {
"--------------------------------------------------------------------------------
" vim: set sw=4 ts=4 sts=4 et tw=90 foldmarker={,} foldmethod=marker :
"  
" By: Vito C.
" }
echo "mappings"
noremap ZA :wqa<CR>

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

if has('nvim')
    tnoremap <Esc> <C-\><C-n>
endif

" Better */# Search {
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

vnoremap <leader>ff :<C-U>
            \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
            \gvy:vimgrep "<C-R><C-R>=substitute(
            \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR>" %<CR>
            \gV:call setreg('"', old_reg, old_regtype)<CR>
            \:copen<CR>
" }

"select the last changed or pasted text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
" alternate select pasted text only nmap gp `[v`]
" Command Shift Keys {
command! -bang -nargs=* -complete=file E e<bang> <args>
command! -bang -nargs=* -complete=file W w<bang> <args>
command! -bang -nargs=* -complete=file Wq wq<bang> <args>
command! -bang -nargs=* -complete=file WQ wq<bang> <args>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Q q<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>
" } 
