 " Information {{{
"--------------------------------------------------------------------------------
" vim: set sw=4 ts=4 sts=4 et tw=90 foldmethod=marker :
"
" By: Vito C.
" }}}


call plug#begin('~/.vim/bundle')

" {{{ GUI Stuff
Plug 'rakr/vim-one'
Plug 'vim-airline/vim-airline-themes'
Plug 'joshdick/onedark.vim'
Plug 'bling/vim-airline'
source ~/.vim/rc/plugins/airline.vim
" }}}

" {{{ LSP Plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scalameta/coc-metals', {'do': 'yarn install --frozen-lockfile'}
source ~/.vim/rc/plugins/coc.vim
Plug 'puremourning/vimspector'
noremap <leader>ds :call vimspector#StepOver()<CR>
noremap <leader>db :call vimspector#ToggleBreakpoint()<CR>
noremap <leader>dc :call vimspector#Continue()<CR>
Plug 'neoclide/coc-snippets'
Plug 'antoinemadec/coc-fzf'
Plug 'vim-test/vim-test'
" }}}
        
"  Plug 'SirVer/ultisnips'
"  source ~/.vim/rc/plugins/ultisnips.vim

" Tpope {{{
 Plug 'tomtom/tcomment_vim'
 Plug 'tpope/vim-obsession'
 Plug 'tpope/vim-abolish'
 Plug 'tpope/vim-repeat'
 Plug 'tpope/vim-speeddating'
 Plug 'tpope/vim-surround'
 source ~/.vim/rc/plugins/surround.vim
 Plug 'tpope/vim-unimpaired'
 Plug 'tpope/vim-vinegar'
 Plug 'tpope/vim-fugitive'
 source ~/.vim/rc/plugins/fugitive.vim
"  Plug 'tpope/vim-dispatch'
" }}}

" My plugins {{{
 let g:plug_url_format = 'git@github.com:%s.git'
 Plug 'vito-c/vim-snippets'
 unlet! g:plug_url_format
 Plug '~/code/personal/scratchy'
 Plug '~/code/personal/jq.vim'
 " }}}


 " Debuggers {{{
 " Plug 'critiqjo/lldb.nvim'
 " }}}

 Plug 'mhinz/vim-startify'
 Plug 'AndrewRadev/splitjoin.vim'
 Plug 'jtratner/vim-flavored-markdown'

 Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
 Plug 'junegunn/fzf.vim'
 source ~/.vim/rc/plugins/fzf.vim
 Plug 'pbogut/fzf-mru.vim'


 Plug 'simnalamburt/vim-mundo'
 source ~/.vim/rc/plugins/gundo.vim


" Filetype syntax {{{
 Plug 'derekwyatt/vim-scala', { 'for': 'scala' }
 Plug 'keith/swift.vim'
 Plug 'vito-c/applescript.vim'
" }}}

 Plug 'godlygeek/tabular'
 source ~/.vim/rc/plugins/tabular.vim

 Plug 'tommcdo/vim-exchange'
"  Plug 'fatih/vim-go'


call plug#end()
 " Compiler Stuff
 "
 " Plug 'justinmk/vim-dirvish'

 " javascript
 " Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'html']  }

 " TODO: figure this out
 " Plug 'panglossr/vim-javascript', { 'for': ['javascript', 'html']  }

 " Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript', 'html']  }
 " Plug 'matthewsimo/angular-vim-snippets', { 'for': ['javascript', 'html']  }
 " Plug 'burnettk/vim-angular', { 'for': ['javascript', 'html']  }
 " Plug 'othree/html5.vim', { 'for': ['javascript', 'html']  }
 " Plug 'goatslacker/mango.vim', { 'for': 'javascript' }
" Old Stuff
 " Plug 'SirVer/ultisnips'
 " source ~/.vim/rc/plugins/ultisnips.vim
"  Plug 'ctrlpvim/ctrlp.vim'
"  source ~/.vim/rc/plugins/ctrlp.vim
 " Plug 'neilagabriel/vim-geeknote'
 " Plug 'junegunn/vim-peekaboo'
 " source ~/.vim/rc/plugins/peekaboo.vim
" Plug 'godlygeek/csapprox'
" Plug 'majutsushi/tagbar'
" Plug 'jceb/vim-orgmode'
" Plug 'vimwiki/vimwiki'
" Plug 'jamessan/vim-gnupg'
" Plug 'racer-rust/vim-racer'
" Plug 'udalov/kotlin-vim'

" Want to try:
" elzr/vim-json - concealment in json
" Plug 'dhruvasagar/vim-table-mode'
" source ~/.vim/rc/plugins/table-mode.vim;
