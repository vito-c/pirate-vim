"  ==============================================================================
"  = Header																		=
"  ==============================================================================

" map <F1> :TagbarToggle<CR>
" nore <buffer> <F1> :TagbarToggle<CR>
" nnoremap <script> <silent> <buffer> <F1> :TagbarToggle<CR>
"au BufRead,BufNewFile * noremap <F1> :TagbarToggle<CR>
highlight TermCursorNC ctermfg=15 guifg=#FFFFFF ctermbg=14 guibg=#56b6c2 cterm=NONE gui=NONE
highlight CursorLine ctermfg=NONE guifg=NONE guibg=#2c323c ctermbg=235 cterm=NONE gui=NONE
highlight CursorLineNr ctermbg=69 guifg=#000000 guibg=#8fc964
"let tagbarwinnr = bufwinnr('__Tagbar__')
"55c9ef
"2c323c


"  ------------------------------------------------------------------------------
"  - SubHeading																	-
"  ------------------------------------------------------------------------------
" set guifont=monospace:h30
" function! OnUIEnter(event)
" 	let l:ui = nvim_get_chan_info(a:event.chan)
" 	if has_key(l:ui, 'client') && has_key(l:ui.client, 'name')
" 		if l:ui.client.name ==# 'Firenvim'
" 			set guifont=monospace:h30
" 		endif
" 	endif
" endfunction
"
" augroup fireui
"     autocmd!
    " au UIEnter * call OnUIEnter(deepcopy(v:event))
" augroup END
"
