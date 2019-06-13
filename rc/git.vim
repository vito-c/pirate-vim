" Header {{{
"--------------------------------------------------------------------------------
" vim: set sw=4 ts=4 sts=4 et tw=90 foldmethod=marker :
"  
" By: Vito C.
" }}}

if g:debug_startup
    echo 'git'
endif
let s:orphan_msg = 'fatal: not a git repository (or any of the parent directories): .git'
let s:root_cmd = 'git rev-parse --show-toplevel;'
function! rc#git#get_root(filepath) " {{{
    let groot = expand('%:h')
    if a:filepath !=# ''
        let groot = fnamemodify(a:filepath , ':h')
    endif
    return systemlist('git -C ' . groot . ' rev-parse --show-toplevel')[0]
endfunction " }}}

function! rc#git#groot() " {{{
    let groot = systemlist('git -C ' . expand('%:p:h') . ' rev-parse --show-toplevel')[0]
    let pwd = expand('%:p:h')
    return v:shell_error ? {'dir': pwd } : {'dir': groot}
endfunction " }}}

function! rc#git#most_popular_groot() " {{{
    let mgroot = max(rc#git#get_root_counts())
    return keys(filter(rc#git#get_root_counts(), {key, val -> val >= mgroot}))[0]
endfunction " }}}

function! rc#git#get_root_counts() " {{{

    let dircount = {}
    for buff in filter(copy(getbufinfo()), 
                \ {idx, val -> val.listed && match(val.name, "term://") == -1})
        let grr = rc#git#get_root(buff.name)
        if has_key(dircount, grr)
            let dircount[grr] += 1
        else
            let dircount[grr] = 1
        endif
    endfor

    return dircount
endfunction " }}}

function! rc#git#get_buffer_roots() " {{{
    let buffs = map(rc#builtins#filebuffers(), 
                \ { idx, val -> rc#git#get_root(val.name)} )
    return buffs
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
