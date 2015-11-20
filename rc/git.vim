" Header {{{
"--------------------------------------------------------------------------------
"  
" By: Vito C.
" vim: set sw=4 ts=4 sts=4 et tw=90 
" }}}

echo 'git'
let s:root_cmd = 'git rev-parse --show-toplevel;'
function! rc#git#get_root(filepath) " {{{
    let groot = expand('%:h')
    if a:filepath !=# ''
        let groot = fnamemodify(a:filepath , ':h')
    endif
    return system('cd ' . groot  . '; ' . s:root_cmd)[:-2]
endfunction " }}}

function! rc#git#get_buffer_roots() " {{{
    for buf in range(1, bufnr('$'))
endfunction " }}}
