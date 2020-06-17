 " Information {{{
"--------------------------------------------------------------------------------
" vim: set sw=4 ts=4 sts=4 et tw=90 foldmethod=marker :
"
" By: Vito C.
" }}}

call plug#begin('~/.vim/bundle')

" current theme
Plug 'rakr/vim-one'
Plug 'vim-airline/vim-airline-themes'
Plug 'joshdick/onedark.vim'

"Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
"Plug 'tpope/vim-leiningen', { 'for': 'clojure' }
"Plug 'tpope/vim-classpath', { 'for': 'clojure' }
"Bundle 'spf13/vim-colors'

" \ 'for': ['rust', 'python', 'kotlin', 'javascript'],
" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }
" source ~/.vim/rc/plugins/languageclient.vim




" Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" " Or build from source code by using yarn: https://yarnpkg.com
" Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
source ~/.vim/rc/plugins/coc.vim
Plug 'scalameta/coc-metals', {'do': 'yarn install --frozen-lockfile'}

" Plug 'natebosch/vim-lsc'
" source ~/.vim/rc/plugins/vim-lsc.vim
" set efm=

" Plug 'jceb/vim-orgmode'
" Plug 'vimwiki/vimwiki'

" Plug 'fatih/vim-go'

" Plug 'jamessan/vim-gnupg'

" Plug 'racer-rust/vim-racer'
" Plug 'udalov/kotlin-vim'

" Here
 Plug 'bling/vim-airline'
 source ~/.vim/rc/plugins/airline.vim

 Plug 'sunaku/vim-hicterm'
 Plug 'tomtom/tcomment_vim'
 Plug 'tpope/vim-obsession'
 Plug 'tpope/vim-abolish'
 Plug 'tpope/vim-dispatch'
 Plug 'tpope/vim-repeat'
 Plug 'tpope/vim-speeddating'
 Plug 'tpope/vim-surround'
 Plug 'tpope/vim-unimpaired'
 Plug 'tpope/vim-vinegar'
 Plug 'keith/swift.vim'
 Plug 'vito-c/applescript.vim'
 " Plug 'justinmk/vim-dirvish'

 " My plugins {{{
 let g:plug_url_format = 'git@github.com:%s.git'
 Plug 'vito-c/vim-snippets'
 unlet! g:plug_url_format
 Plug '~/code/personal/scratchy'
 Plug '~/code/personal/jq.vim'
 " }}}

 " Java Junk
 " Plug 'fdinoff/neovim-java-client'

 Plug 'AndrewRadev/splitjoin.vim'
 Plug 'jtratner/vim-flavored-markdown'

 " Plug 'critiqjo/lldb.nvim'
 Plug 'mhinz/vim-startify'


 " Plug 'SirVer/ultisnips'
 " source ~/.vim/rc/plugins/ultisnips.vim

 Plug 'ctrlpvim/ctrlp.vim'
 source ~/.vim/rc/plugins/ctrlp.vim

 " Plug 'neilagabriel/vim-geeknote'

 Plug 'junegunn/fzf.vim'

 " Plug 'junegunn/vim-peekaboo'
 " source ~/.vim/rc/plugins/peekaboo.vim
 Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
 source ~/.vim/rc/plugins/fzf.vim

 Plug 'godlygeek/csapprox'
"  Plug 'flazz/vim-colorschemes'

 Plug 'simnalamburt/vim-mundo'
 source ~/.vim/rc/plugins/gundo.vim

 " javascript
 " Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'html']  }

 " TODO: figure this out
 " Plug 'panglossr/vim-javascript', { 'for': ['javascript', 'html']  }

 " Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript', 'html']  }
 " Plug 'matthewsimo/angular-vim-snippets', { 'for': ['javascript', 'html']  }
 " Plug 'burnettk/vim-angular', { 'for': ['javascript', 'html']  }
 " Plug 'othree/html5.vim', { 'for': ['javascript', 'html']  }
 " Plug 'goatslacker/mango.vim', { 'for': 'javascript' }

 Plug 'derekwyatt/vim-scala', { 'for': 'scala' }

 " useless
 " Plug 'terryma/vim-multiple-cursors'

 " Plug 'lambdalisue/vim-gista'
 " Plug 'tyru/open-browser.vim'
 " source ~/.vim/rc/plugins/gista.vim

 Plug 'godlygeek/tabular'
 source ~/.vim/rc/plugins/tabular.vim

 Plug 'tommcdo/vim-exchange'

 if executable('ctags')
     " Plug 'majutsushi/tagbar'
 endif

 Plug 'tpope/vim-fugitive'
 source ~/.vim/rc/plugins/fugitive.vim

call plug#end()

" Want to try:
" elzr/vim-json - concealment in json
" Plug 'dhruvasagar/vim-table-mode'
" source ~/.vim/rc/plugins/table-mode.vim;

