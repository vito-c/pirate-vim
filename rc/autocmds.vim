" Information {{{
"--------------------------------------------------------------------------------
" vim: set tw=90 foldmethod=marker :
"
" By: Vito C.
" }}}

if has("autocmd")
   let s:groot = rc#git#get_root("~/.vim/rc/vimrc")
    " Source the vimrc file after saving it
if g:debug_startup
    echom "autocmds"
endif
    autocmd!
    augroup shell " {{{
        au FileType sh let g:sh_fold_enabled=3
        au FileType sh let g:is_bash=1
        au FileType sh set foldmethod=syntax
    augroup END " }}}
    augroup vimsource " {{{
        autocmd!
        autocmd BufWritePost .vimrc source $MYVIMRC
        autocmd BufWritePost vimrc source $MYVIMRC
        autocmd BufWritePost s:groot . '/rc/**' source $MYVIMRC
        autocmd BufWritePost */rc/** source $MYVIMRC
        if has('nvim')
            autocmd Bufwritepost .nvimrc source $MYVIMRC
            autocmd BufWritePost ~/.nvim/rc/** source $MYVIMRC
            autocmd bufwritepost nvimrc source $MYVIMRC
        endif
    augroup END " }}}
    augroup autosave " {{{
        autocmd!
        autocmd FocusLost * :call SafeSave("all")
        autocmd BufWritePost * :call RestoreMarker()
        autocmd TextChanged * :call SafeSave("crrent")
        autocmd TextChangedI * :call SafeSave("crrent")
    augroup END

    let g:ltickmark = getpos("'[")
    let g:rtickmark = getpos("']")
    function! BackupMarker()
        let g:ltickmark = getpos("'[")
        let g:rtickmark = getpos("']")
    endfunction

    function! RestoreMarker()
        call setpos("'[", g:ltickmark)
        call setpos("']", g:rtickmark)
    endfunction

    function! SafeSave(target)
        if expand('%') != ''
            call BackupMarker()
            if a:target == "all"
                silent! wall
            else
                silent! update
            endif
            call RestoreMarker()
        endif
    endfunction
    " }}}
    "au BufReadPost quickfix setlocal modifiable
    "autocmd bufwritepost .vimrc source $MYVIMRC
    "autocmd bufwritepost vimrc sourc $MYVIMRC
    " Map ☠ (U+???) to <Esc> as <S-CR> is mapped to ☠ in iTerm2.
    "if has ('gui')          " On mac and Windows, use * register for copy-paste
    "au BufReadPost quickfix :noremap <buffer> <S-CR> :execute 'cc '.line(".") <Bar> cclose <Bar> copen <Bar> wincmd J<CR>
    "au BufReadPost quickfix :noremap <buffer> <leader>j :execute 'cc '.line(".") <Bar> cclose <Bar> copen <Bar> wincmd J <Bar> normal j <CR>
    "au BufReadPost quickfix :noremap <buffer> <leader>k :execute 'cc '.line(".") <Bar> cclose <Bar> copen <Bar> wincmd J <Bar> normal k <CR>
    "autocmd CmdwinEnter * map <buffer> ☠ <CR>q:
    "au BufReadPost quickfix :noremap <buffer> ☠ :execute 'cc '.line(".") <Bar> cclose <Bar> copen <Bar> wincmd J<CR>j
endif
