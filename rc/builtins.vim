" Header {{{
"--------------------------------------------------------------------------------
" vim: set sw=4 ts=4 sts=4 et tw=90 foldmethod=marker :
"  
" By: Vito C.
" }}}

let s:defaultpath='~/code/**'
" let s:defaultwig='*.class,*/target/*'
let &path=s:defaultpath
" let &wildignore=s:defaultwig
let s:orphan_msg = 'fatal: not a git repository (or any of the parent directories): .git'
function! rc#builtins#path() " {{{
    let l:glist = systemlist('git -C ' . expand('%:p:h') . ' rev-parse --show-toplevel')
    let l:groot = len(l:glist) == 0? 'fatal: nothing returned' : l:glist[0]
    " let l:dpath = match(bufname('%'), "term://") > -1 ? 
    " most_popular takes too long right now
    " \ rc#git#most_popular_groot() :
    let l:dpath = match(l:groot, 'fatal:.*') > -1 ?
                \ getcwd() :
                \ s:defaultpath
    return match(l:groot, 'fatal:.*') > -1 ? {'dir':  l:dpath . '/**' } : {'dir': l:groot . '/**' }
endfunction " }}}

function! rc#builtins#filebuffers() " {{{
    return filter(copy(getbufinfo()), 
                \ {idx, val -> val.listed && match(val.name, "term://") == -1})
endfunction " }}}

function! rc#builtins#termbuffers() " {{{
    return filter(copy(getbufinfo()), 
                \ {idx, val -> val.listed && match(val.name, "term://") > -1})
endfunction " }}}

" set includeexpr=substitute(v:fname,'\\.','/','g')
" echo substitute('com.foo.bar.SomeClass#someFunction:156','\v\C[a-z\.]*([A-Z][a-zA-Z]*)#.*(:\d+)','\=submatch(1) . submatch(2)', '')
" set includeexpr=substitute(v:fname,'\v\C[a-z\.]*([A-Z][a-zA-Z]*)#.*(:\d+)','\=submatch(1) . submatch(2)', '')
"
" [ifo]   at com.rallyhealth.authn.adapters.delegate.RegistrationAdapter.maybeCreateSession(RegistrationAdapter.scala:676)
" com.rallyhealth.authn.adapters.delegate.RegistrationAdapter#updateCompleteAccountAndLogin:156 tokens: LegacyAndArachneSessionResponse(
" set includeexpr=substitute(v:fname,'\v\C[a-z\.]*([A-Z][a-zA-Z]*)#.*(:\d+)','\=submatch(1) . " " . submatch(2)', '')
" noremap <leader>gf rc#builtins#gotofile()
" function! rc#builtins#gotofile() " {{{
"     let l:text = getbufline(bufnr('%'),line('.'), line('.'))
"     let l:word = expand('<cword>')
"     if match(a:filename, l:output) == 0
"         " let l:output = substitute(l:text,'
"     endif
" endfunction " }}}

" used for appending scala to file types when searching
" if you hit this from inside a terminal it means the file you were searching for doesn't
" exist as well as "/file/you/were/searching/for/exm.scala
" vito/easy/LinkedListCycleEasyTest/test1.scala
function! rc#builtins#includeexpr(filename) " {{{
    let l:bt = getbufvar(bufnr('%'), '&buftype', 'ERROR')
    let l:output = "" . a:filename . ""
    if l:bt == "terminal" && (filereadable(a:filename) == 0 || isdirectory(a:filename) == 0)
        let l:output = substitute(a:filename,'\v\.','/','g')
        let l:output = substitute(l:output,'\v\C([^#]*)#.*', '\=submatch(1).".scala"', '')
        " if stridx("src/test", l:output) != -1
        " add stuff here if you want to do a conditional file name
        " endif
        let l:ext = fnamemodify(l:output,':e')
        let l:fname = fnamemodify(l:output, ':t')
        if l:ext == ""
            let l:output = l:output . ".scala"
        endif
    endif
    return l:output
endfunction " }}}
set includeexpr=rc#builtins#includeexpr(v:fname)
