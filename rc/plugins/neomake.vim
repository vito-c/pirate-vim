" test
let g:neomake_verbose=0
let g:neomake_scala_fast=1
let s:dirty_file = 0
let g:neomake_scala_style = 0

" updatetime is 2000ms so CursorHold fires every 2secs with no input
" i will set updatetime explicityly
augroup automake " {{{
    autocmd!
    autocmd FocusLost * Neomake
    autocmd BufWritePost * Neomake
    autocmd InsertLeave * Neomake
    autocmd TextChanged * Neomake "let s:dirty_file = 1
    autocmd TextChangedI * call rc#plugins#neomake#shrink()
    autocmd CursorHold * call rc#plugins#neomake#run()
augroup END " }}}

function! rc#plugins#neomake#shrink()
    let s:dirty_file = 1
    if eval(&ut) == 0
        return
    else
        let temp = str2nr(eval(&ut))
        let ut=str2nr(temp-500)
    endif
endfunction
function! rc#plugins#neomake#run()
    if s:dirty_file
        Neomake
        let s:dirty_file = 0
        let updatetime=2000
    endif
endfunction
