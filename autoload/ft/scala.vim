function! ft#scala#search() abort " {{{
    
  " if !filereadable($HOME.'/.eclim/.eclimd_instances') || 
  "   \ !eclim#project#util#IsCurrentFileInProject(1) 
  "     exe 'tjump ' . expand('<cword>')
  " else
  "     call eclim#scala#search#Search('')
  " endif 
  :EnDeclaration
endfunction " }}}
