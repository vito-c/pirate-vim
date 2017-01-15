" Header {{{
"--------------------------------------------------------------------------------
" vim: set sw=4 ts=4 sts=4 et tw=90 foldmethod=marker :
"  
" By: Vito C.
" }}}

if g:debug_startup
    echo 'git'
endif
let s:root_cmd = 'git rev-parse --show-toplevel;'
function! rc#git#get_root(filepath) " {{{
    let groot = expand('%:h')
    if a:filepath !=# ''
        let groot = fnamemodify(a:filepath , ':h')
    endif
    return system('cd ' . groot  . '; ' . s:root_cmd)[:-2]
endfunction " }}}

function! rc#git#groot() " {{{
    let groot = systemlist('git -C ' . expand('%:p:h') . ' rev-parse --show-toplevel')[0]
    let pwd = expand('%:p:h')
    return v:shell_error ? {'dir': pwd } : {'dir': groot}
endfunction " }}}

function! rc#git#get_buffer_roots() " {{{
    for buf in range(1, bufnr('$'))
endfunction " }}}

function! rc#git#fugitive_diff() " {{{
    let groot = systemlist('git -C ' . expand('%:p:h') . ' rev-parse --show-toplevel')[0]
    " let oghead = system('cat ' . groot . '/.git/rebase-apply/orig-head')
    let oghead = join(readfile( groot . '/.git/rebase-apply/orig-head'), "\n")
    bufdo diffoff
    if bufnr('$') > 2
        1,3bd
    endif
    execute ':Gdiff ' . oghead
endfunction " }}}
