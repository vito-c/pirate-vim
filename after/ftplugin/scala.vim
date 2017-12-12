" autocmd <buffer> *.cs 
" let EclimScalaSingleSearchResult='edit'
" noremap <buffer> <C-]> :ScalaSearch<CR>
noremap <buffer> <C-]> :call ft#scala#search()<CR>

