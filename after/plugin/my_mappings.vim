"  ==============================================================================
"  = Header																		=
"  ==============================================================================

" map <F1> :TagbarToggle<CR>
" nore <buffer> <F1> :TagbarToggle<CR>
" nnoremap <script> <silent> <buffer> <F1> :TagbarToggle<CR>
"au BufRead,BufNewFile * noremap <F1> :TagbarToggle<CR>
au FileType * nore <buffer> <F1> :TagbarToggle<CR>
"let tagbarwinnr = bufwinnr('__Tagbar__')


"  ------------------------------------------------------------------------------
"  - SubHeading																	-
"  ------------------------------------------------------------------------------
