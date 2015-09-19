" autocmd <buffer> *.cs 
let EclimScalaSingleSearchResult="edit"
"noremap <buffer> <C-]> :ScalaSearch<CR>
noremap <buffer> <C-]> :call DoScalaSearch()<CR>

function! DoScalaSearch(argline) " {{{
  if filereadable($HOME.'/.eclim/.eclimd_instances') || 
    \ !eclim#project#util#IsCurrentFileInProject(1) 
      echom "do tag search"
  else
      call eclim#scala#search#Search(a:argline) 
  endif 
endfunction " {{{


