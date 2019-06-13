" Header {{{
"--------------------------------------------------------------------------------
" vim: set sw=4 ts=4 sts=4 et tw=90 foldmethod=marker :
"  
" By: Vito C.
" }}}

let s:defaultpath='~/code/**'
let s:defaultwig='*.class,*/target/*'
let &path=s:defaultpath
let &wildignore=s:defaultwig
let s:orphan_msg = 'fatal: not a git repository (or any of the parent directories): .git'
function! rc#builtins#path() " {{{
    let l:groot = systemlist('git -C ' . expand('%:p:h') . ' rev-parse --show-toplevel')[0]
    " let l:dpath = match(bufname('%'), "term://") > -1 ? 
    " most_popular takes too long right now
    " \ rc#git#most_popular_groot() :
    let l:dpath = match(l:groot, 'fatal:.*') > -1 ?
                \ execute('pwd') :
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
function! rc#builtins#includeexpr(filename)
    " set includeexpr=substitute(v:fname,'\\.','/','g')
    let l:blah = substitute(a:filename,'\v\C[a-z\.]*([A-Z][a-zA-Z]*)#.*', '\=submatch(1).".scala"', '')
    echom l:blah
    return l:blah
endfunction
set includeexpr=rc#builtins#includeexpr(v:fname)
