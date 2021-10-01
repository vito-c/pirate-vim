function! ft#scala#search() abort " {{{

  " if !filereadable($HOME.'/.eclim/.eclimd_instances') ||
  "   \ !eclim#project#util#IsCurrentFileInProject(1)
  "     exe 'tjump ' . expand('<cword>')
  " else
  "     call eclim#scala#search#Search('')
  " endif
  " if len(taglist(expand('<cword>'))) > 0
      " execute('tag ' . expand('<cword>'))
  " else
      " LSClientGoToDefinition
    " call LanguageClient#textDocument_definition()
    call CocActionAsync('jumpDefinition')
  " endif
endfunction " }}}
