" Information {
"--------------------------------------------------------------------------------
" vim: set sw=4 ts=4 sts=4 et tw=90 foldmarker={,} foldmethod=marker :
"  
" By: Vito C.
" }

echo "leaders"
let mapleader = ' '

" noremap <leader>vb :<C-U>vsp<Bar>bn<CR>
" nmap <leader><CR> :call CustomCompileFile()<CR>

" TODO: fix this to jump back to pos
noremap <leader>; mcA;<ESC>'c
noremap <leader><leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>

" Quick Edits {
noremap <leader>ev :<C-U>tabedit $MYVIMRC<CR>
noremap <leader>eb :<C-U>tabedit /Users/$USER/.bash_profile<CR>
" Some helpers to edit mode
" http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>
noremap <leader>ew :<C-U>e <C-R>=expand('%:h').'/'<cr>
noremap <leader>es :<C-U>sp %%
" }
" Copy Pasting {
noremap <leader>y "+y
noremap <leader>Y "+y$

vnoremap <leader>y "+y
vnoremap <leader>Y "+y$

vnoremap <leader>d "+d
noremap <leader>d "+d

noremap <leader>p "+p
noremap <leader>P "+P

vnoremap <leader>p "+p
vnoremap <leader>P "+P
" }
" Windows Actions {
nnoremap <leader>wv :vsp<Bar>bn<Bar>wincmd L<CR>
nnoremap <leader>ws :sp<Bar>bn <CR>
" }
" Fold Levels {
nmap <leader>f0 :set foldlevel=0<CR>
nmap <leader>f1 :set foldlevel=1<CR>
nmap <leader>f2 :set foldlevel=2<CR>
nmap <leader>f3 :set foldlevel=3<CR>
nmap <leader>f4 :set foldlevel=4<CR>
nmap <leader>f5 :set foldlevel=5<CR>
nmap <leader>f6 :set foldlevel=6<CR>
nmap <leader>f7 :set foldlevel=7<CR>
nmap <leader>f8 :set foldlevel=8<CR>
nmap <leader>f9 :set foldlevel=9<CR>
" }
" Saving {
noremap <leader>ss :w<CR>
noremap <leader>sa :wa<CR>
noremap <leader>sq :wqa<CR>
" }
