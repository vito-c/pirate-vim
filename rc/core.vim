"Information {{{
"--------------------------------------------------------------------------------
" vim: set tw=90 foldmethod=marker :
"
" By: Vito C.
" }}}

"GUI {{{
highlight TermCursorNC ctermfg=15 guifg=#FFFFFF ctermbg=14 guibg=#56b6c2 cterm=NONE gui=NONE
"}}}

if has('nvim')
  let $GIT_EDITOR = 'nvr -cc split --remote-wait'
endif

set diffopt=internal,filler,iwhiteall,hiddenoff,vertical,algorithm:patience

" configs {{{
filetype plugin indent on " Automatically detect file types.
syntax on                 " Syntax highlighting
set shortmess=aTI
set mouse=
scriptencoding utf-8
"set virtualedit=onemore             " Allow for cursor beyond last character
" }}}
let s:uname = system("echo -n \"$(uname)\"")
if !v:shell_error && s:uname == "Linux"
    let &shell='/usr/bin/bash'
    command! -nargs=0 SetupCoc call SetupCoc() 
    function! SetupCoc()
        CocInstall -sync coc-metals
    endfunction

endif
" Legacy undo fieles {{{
" }}}

" netrw {{{
let g:netrw_preview = 1
let g:netrw_altfile = 1
let g:netrw_list_hide= '.*\.swp$,.*\.meta$'
" }}}

" Abbrevs {{{
" TODO: Abloish plugin move to own file
iabbrev teh the
iabbrev chomd chmod
iabbrev ehco echo
iabbrev pritnln println
cabbrev ehco echo
iabbrev <expr> dtl strftime("%c")
iabbrev <expr> dts strftime("%m/%d/%Y")
iabbrev <expr> cdf expand('%')
iabbrev <expr> cdp expand('%:p')
iabbrev <expr> jpac 'package ' . substitute( join(split(expand('%:h'),'/'),'.'),'\v^\.+','','g') . ";\r"
" }}}

" Delete Empty Buffers {{{
command! -nargs=0 DeleteEmptyBuffers call DeleteEmptyBuffers() 
function! DeleteEmptyBuffers()
  let buffers = filter(range(0, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val)<0')
  if !empty(buffers)
    exe 'bw '.join(buffers, ' ')
  endif
endfunction
" }}}
