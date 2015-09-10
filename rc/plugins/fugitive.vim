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

nnoremap <silent> <leader>gs :call ToggleBuffer('.git/index\\|.git/COMMIT_EDITMSG', 'g')<CR>
nnoremap <silent> <leader>gdh :Gdiff HEAD<CR>
nnoremap <silent> <leader>gdm :Gdiff master<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>

