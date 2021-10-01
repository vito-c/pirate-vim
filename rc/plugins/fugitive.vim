" TODO: Fix this all up
function! PirateDiffRight()
    if ( match( bufname("%"), '//2' ) != -1 )
        " On TARGET Buffer
        echo "Pending"
    elseif ( match( bufname("%"), '//3' ) != -1 )
        " On REMOTE Buffer
        echo "No Where to Put"
    else
        " On LOCAL Buffer
        :diffget //3 | diffupdate
    endif
endfunc
function! PirateDiffLeft()
    if ( match( bufname("%"), '//2' ) != -1 )
        " On TARGET Buffer
        echo "Pending"
    elseif ( match( bufname("%"), '//3' ) != -1 )
        " On REMOTE Buffer
        echo "No Where to Put"
    else
        " On LOCAL Buffer
        :diffget //2  | diffupdate
    endif
endfunc
" Quick commands to run diff put/obtain
" Obtain diff from left side
nnoremap <leader>dh call :PirateDiffLeft()<CR>
" Obtain diff from right side
nnoremap <leader>dl call :PirateDiffRight()<CR>

function! s:StageNext(count) abort
  for i in range(a:count)
    call search('^.\=\t.*','W')
  endfor
  return '.'
endfunction

" Open GitStatus and add buffer commands
function! OpenGStatusTab()
    tab split|Gstatus
    execute s:StageNext(v:count1)
    " nnoremap <buffer> <silent> q :<C-U>if bufnr('$') == 1<Bar>quit<Bar>else<Bar>bdelete<Bar>endif<CR>
endfunction

" need to have c-n/p take me to next file and update diff
"
" ~/code/configs/pirate-vim/bundle/vim-fugitive/.git/index
nnoremap <silent> <leader>gs :call OpenGStatusTab()<CR>
nnoremap <silent> <leader>gdh :Gvdiff HEAD<CR>
nnoremap <silent> <leader>gdm :Gvdiff origin/master<CR>
nnoremap <silent> <leader>gdu :Gvdiff upstream/master<CR>
nnoremap <silent> <leader>gdd :Gvdiff upstream/develop<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
