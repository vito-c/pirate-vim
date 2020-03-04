function! ft#kotlin#search() abort " {{{
    call LanguageClient#textDocument_definition()
endfunction " }}}

" vim interprets the above errorformat as: try to match the first entry. if it doesn't match, check
" the next one... for the other compiler lines only the third one matches (which maches everything),
" with the %-G you ignore them. for the other errors, one of the previous errorformats will match
" if you have another error format, you will have to add it before the $-G%.%# otherwise vim won't
" catch it
