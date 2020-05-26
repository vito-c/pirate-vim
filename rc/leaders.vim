" Information {{{
"--------------------------------------------------------------------------------
" vim: set sw=4 ts=4 sts=4 et tw=90 foldmethod=marker :
"
" By: Vito C.
" }}}

if g:debug_startup
    echo "leaders"
endif
let g:mapleader = ' '

" noremap <leader>vb :<C-U>vsp<Bar>bn<CR>
" nmap <leader><CR> :call CustomCompileFile()<CR>

" TODO: move this to experimental;
noremap <leader>; :<C-F>i
noremap <leader>s /<C-F>i
noremap <leader><leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
inoremap <C-k> <C-o>gk
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-j> <C-o>gj

" Quick Edits {{{
let g:VITORC=fnamemodify($MYVIMRC,':h')."/rc/vimrc"
" CODE_CONFIGS/pirate-vim/rc/vimrc
noremap <leader>ev :<C-U>execute "tabedit " . g:VITORC<CR>
noremap <leader>eb :<C-U>tabedit $CODE_CONFIGS/pirate-setup/bashrc<CR>
noremap <leader>eg :<C-U>tabedit $CODE_CONFIGS/pirate-setup/gitconfig<CR>
" Some helpers to edit mode
" http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>
noremap <leader>ew :<C-U>e <C-R>=expand('%:h').'/'<cr>
noremap <leader>es :<C-U>sp %%
" }}}
" Copy Pasting Clipboard {{{
noremap <leader>y "+y
noremap <leader>Y "+y$
noremap <leader>o <C-^>

vnoremap <leader>y "+y
vnoremap <leader>Y "+y$

" vnoremap <leader>d "+d
" noremap <leader>d "+d

noremap <leader>p "+p
noremap <leader>P "+P
noremap <leader>0 "0p
noremap <leader>0 "0P

vnoremap <leader>p "+p
vnoremap <leader>P "+P
" }}}
" Windows Actions {{{
nnoremap <leader>wv :vsp<Bar>bn<Bar>wincmd L<CR>
nnoremap <leader>ws :sp<Bar>bn <CR>
nnoremap <leader>ww :wincmd w<Bar>wincmd _<CR>
" }}}
" Fold Levels {{{
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
" }}}

" Some terminal mappings
noremap <leader>to :call chansend(&channel, ['testOnly '. expand('<cfile>'), ''])<CR>
noremap <leader>ta :call chansend(&channel, ['test', ''])<CR>
" \x1b\x5b\x41
noremap <leader>tl :call chansend(&channel, ["!!", ''])<CR>

tnoremap <C-o> <C-l><C-\><C-n>:call rc#leaders#clearterm()<CR>i
noremap <leader>tc :call chansend(&channel, ['compile', ''])<CR>
" noremap <C-k> :exe '!printf "\e[2J\e[H" >' nvim_get_chan_info(&channel).pty<CR>
noremap <leader>tn :exe '!printf "\e[2J" >' nvim_get_chan_info(&channel).pty<CR>

" need to config better tabbing
nnoremap <leader>ct :tabclose<CR>
" nnoremap <leader>qq :cw<CR>
" nnoremap <leader>ll :lw<CR>

nnoremap [k :tabprevious<CR>
nnoremap ]k :tabnext<CR>
func TermSetScrollback(timer)
  set scrollback=0
  set scrolloff=0
endfunc

function! rc#leaders#clearterm() " {{{
    set scrollback=1
    set scrolloff=0
    exe '!printf "\e[2J" >' nvim_get_chan_info(&channel).pty
    let timer = timer_start(200, 'TermSetScrollback',
        \ {'repeat': 1})
endfunction " }}}
