" " Taken from metals website
" " https://scalameta.org/metals/docs/editors/vim.html
"
" " Smaller updatetime for CursorHold & CursorHoldI
" set updatetime=300
"
" " don't give |ins-completion-menu| messages.  For example,
" "-- XXX completion (YYY)", "match 1 of 2", "The only match",
" "Pattern not found", "Back at original", etc.
" set shortmess+=c
"
" " always show signcolumns
" " set signcolumn=auto
"
" " Some server have issues with backup files, see #649
" " set nobackup
" " set nowritebackup
"
" " Better display for messages
" " TODO: figure out why he set this to two
" set cmdheight=1
"
" " Use <c-space> for trigger completion.
" " refreshes completion
" inoremap <silent><expr> <c-space> coc#refresh()

" " Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" " Coc only does snippet and additional edit on confirm.
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"
" " Use `[c` and `]c` for navigate diagnostics
" " TODO: Fix this it overwrites jump to diff
" nmap <silent> [q <Plug>(coc-diagnostic-prev)
" nmap <silent> ]q <Plug>(coc-diagnostic-next)
"
" " Remap keys for gotos
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" " changed gi to gm since (gi go to last insert might be useful)
" nmap <silent> gm <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)
"
" " Remap for do codeAction of current line
" nmap <leader>ac <Plug>(coc-codeaction)
"
" " Remap for do action format
" nnoremap <silent> F :call CocAction('format')<CR>
"
" " Use K for show documentation in preview window
" nnoremap <silent> K :call <SID>show_documentation()<CR>
"
" function! s:show_documentation()
"   if &filetype == 'vim'
"     execute 'h '.expand('<cword>')
"   else
"     call CocAction('doHover')
"   endif
" endfunction
"
" " Highlight symbol under cursor on CursorHold
" " dunno if I want this
" " autocmd CursorHold * silent call CocActionAsync('highlight')
"
" " Remap for ename current word
" nmap <leader>rn <Plug>(coc-rename)
"
" " Show all diagnostics
" nnoremap <silent> <leader>ca  :<C-u>CocList diagnostics<cr>
" " Find symbol of current document
" nnoremap <silent> <leader>co  :<C-u>CocList outline<cr>
" " Search workspace symbols
" nnoremap <silent> <leader>cs  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <leader>cj  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <leader>ck  :<C-u>CocPrev<CR>
" " Resume latest coc list
" nnoremap <silent> <leader>cp  :<C-u>CocListResume<CR>



" These default mappings should either go in your .vimrc or in a file
" that you're going to source from your .vimrc. For example, you can
" copy this file into your ~ directory and then put the following
" in your .vimrc to source it
"
" coc.nvim lsp mappings
"if filereadable(expand("~/coc-mappings.vim"))
"  source ~/coc-mappings.vim"
"endif
"
"
" If you're curious how to share this or your .vimrc with both vim and nvim,
" you can find a great instructions about this here https://neovim.io/doc/user/nvim.html#nvim-from-vim
"
" Finally, keep in mind that these are "suggested" settings. Play around with them
" and change them to your liking.

" If hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files
set nobackup
set nowritebackup

" Better display for messages
" TODO: why two??
set cmdheight=1

" You will have a bad experience with diagnostic messages with the default of 4000.
set updatetime=300

" Don't give |ins-completion-menu| messages.
set shortmess+=c

" Always show signcolumns
set signcolumn=yes

let g:airline#extensions#coc#enabled = 1

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Used in the tab autocompletion for coc
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
" inoremap <silent><expr> <c-space> coc#refresh()


" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [q <Plug>(coc-diagnostic-prev)
nmap <silent> ]q <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gw <Plug>(coc-type-definition)
nmap <silent> gm <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Used to expand decorations in worksheets
nmap <Leader>ws <Plug>(coc-metals-expand-decoration)
nmap <Leader><cr> <Plug>(coc-metals-expand-decoration)

" Use K to either doHover or show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType scala setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')
" Remap for do action format
nnoremap <silent> F :call CocAction('format')<CR>

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add status line support, for integration with other plugins, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Show all diagnostics
nnoremap <silent> <leader>ca  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <leader>ce  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <leader>cc  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <leader>co  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <leader>cs  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <leader>cj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <leader>ck  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <leader>cp  :<C-u>CocListResume<CR>

" Notify coc.nvim that <enter> has been pressed.
" Currently used for the formatOnType feature.
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Toggle panel with Tree Views
nnoremap <silent> <leader>ct :<C-u>CocCommand metals.tvp<CR>
" Toggle Tree View 'metalsBuild'
nnoremap <silent> <leader>ctb :<C-u>CocCommand metals.tvp metalsBuild<CR>
" Toggle Tree View 'metalsCompile'
nnoremap <silent> <leader>ctc :<C-u>CocCommand metals.tvp metalsCompile<CR>
" Reveal current current class (trait or object) in Tree View 'metalsBuild'
nnoremap <silent> <leader>ctf :<C-u>CocCommand metals.revealInTreeView metalsBuild<CR>
