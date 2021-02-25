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
    augroup kotlin " {{{
        autocmd!
        autocmd Filetype kotlin setlocal makeprg=./gradlew\ build
        autocmd Filetype kotlin setlocal efm=:compileKotline:\ %f:\ (%l\\,\ %c):\ %m,e:\ %f:\ (%l\\,\ %c):\ %m,%-G%.%#
    augroup END " }}}
    augroup git " {{{
        autocmd!
        autocmd FileType gitcommit set bufhidden=delete
        " move this to 
        " ~/.vim/ftplugin/gitcommit_mappings.vim
        " autocmd FileType gitcommit noremap <buffer> ZZ :w|bd<CR>
    augroup END " }}}
    augroup shell " {{{
        autocmd!
        au FileType sh let g:sh_fold_enabled=3
        au FileType sh let g:is_bash=1
        au FileType sh set foldmethod=syntax
    augroup END " }}}
    augroup builtins " {{{
        autocmd!
        autocmd BufWinEnter,WinEnter,TabEnter * let &path=rc#builtins#path()['dir']
    augroup END " }}}
    augroup vimsource " {{{
        autocmd!
        autocmd BufWritePost .vimrc source $MYVIMRC
        autocmd BufWritePost vimrc source $MYVIMRC
        autocmd BufWritePost s:groot . '/rc/**' source $MYVIMRC
        autocmd BufWritePost */rc/** source $MYVIMRC
        autocmd BufWritePost */rc/** echom s:groot
        autocmd BufWritePost s:groot . '/rc/**' echom s:groot
        if has('nvim')
            autocmd Bufwritepost .nvimrc source $MYVIMRC
            autocmd BufWritePost ~/.nvim/rc/** source $MYVIMRC
            autocmd BufWritePost nvimrc source $MYVIMRC
        endif
    augroup END " }}}
    " "Causing issues:
    augroup autotag " {{{
        autocmd!
        " need to cd to groot
        " autocmd BufNewFile,BufRead,BufEnter * call UpdatePath()
    augroup END " }}}
    augroup autosave " {{{
        autocmd!
        " keep it simple
        autocmd InsertLeave * :call SafeSave("crrent")
        autocmd TextChanged * :call SafeSave("crrent")
        " autocmd FocusLost * :call SafeSave("all")
    "     autocmd BufWritePost * :call RestoreMarker()
    augroup END " }}}
    augroup cleanups " {{{
        autocmd!
        " autocmd FileType netrw setlocal bufhidden=delete
    augroup END " }}}
    augroup termcmd "{{{
        autocmd!
        " autocmd BufWinEnter,WinEnter term://* call timer_start(400, 'StartInsertInTermBuffer')
        " autocmd BufWinEnter,WinEnter,TabEnter term* setlocal scrolloff=0
        " autocmd BufWinLeave,WinLeave,TabLeave term* setlocal scrolloff=999
        " autocmd BufEnter * if &buftype=="terminal" | setlocal scrolloff=0 | endif
        " autocmd BufLeave * if &buftype=="terminal" | setlocal scrolloff=999 | endif
        autocmd BufEnter *.term setlocal scrolloff=0
        autocmd BufLeave *.term setlocal scrolloff=999
    augroup END " }}}

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

    function! StartInsertInTermBuffer(timer)
        if match(bufname('%'), "term://") > -1
            execute 'normal!i'
        endif
    endfunction

    function! UpdatePath()
        let foo = match(fnameescape(expand('%')), "fugitive://,list://")
        if &buftype != 'terminal' && foo < 0
            set path&vim | let &path=rc#git#groot()['dir'] . '/**'
            execute 'cd' rc#git#groot()['dir']
        endif
    endfunction

    function! SafeSave(target)
        if expand('%') != ''
            " call BackupMarker()
            if a:target == "all"
                silent! wall
            else
                silent! update
            endif
            " call RestoreMarker()
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
