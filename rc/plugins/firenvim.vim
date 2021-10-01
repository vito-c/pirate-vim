" " set guifont=monospace:h30
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
"     au UIEnter * call OnUIEnter(deepcopy(v:event))
" augroup END

function! s:IsFirenvimActive(event) abort
  if !exists('*nvim_get_chan_info')
    return 0
  endif
  let l:ui = nvim_get_chan_info(a:event.chan)
  return has_key(l:ui, 'client') && has_key(l:ui.client, 'name') &&
      \ l:ui.client.name =~? 'Firenvim'
endfunction

function! OnUIEnter(event) abort
  if s:IsFirenvimActive(a:event)
    set laststatus=0
    set guifont=CaskaydiaCove\ Nerd\ Font\ Mono:h18
    set showtabline=0
  endif
endfunction
autocmd UIEnter * call OnUIEnter(deepcopy(v:event))
au BufEnter github.com_*.txt set filetype=markdown
au BufEnter leetcode.com_*.txt set filetype=scala

let g:firenvim_config = {
    \ 'globalSettings': {
        \ 'alt': 'all',
    \  },
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'neovim',
            \ 'content': 'text',
            \ 'priority': 0,
            \ 'selector': 'textarea',
            \ 'takeover': 'always',
        \ },
    \ }
\ }
let fc = g:firenvim_config['localSettings']
let fc['https?://twitter.com/'] = { 'takeover': 'never', 'priority': 1 }
