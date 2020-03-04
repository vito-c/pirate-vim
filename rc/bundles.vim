 " Information {{{
"--------------------------------------------------------------------------------
" vim: set sw=4 ts=4 sts=4 et tw=90 foldmethod=marker :
"
" By: Vito C.
" }}}

call plug#begin('~/.vim/bundle')

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


Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
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
 Plug 'sunaku/vim-hicterm'
 Plug 'tomtom/tcomment_vim'
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

 Plug 'tpope/vim-obsession'

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
 Plug 'flazz/vim-colorschemes'

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

 " Plug 'neomake/neomake'
 " source ~/.vim/rc/plugins/neomake.vim

 Plug 'godlygeek/tabular'
 source ~/.vim/rc/plugins/tabular.vim

 " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
 " Plug 'zchee/deoplete-go', { 'do': 'make'}

 " Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }

 " Plug 'Valloric/YouCompleteMe', { 'do': './install.py --all' }
 " source ~/.vim/rc/plugins/ycm.vim

 " Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }

 " Plug 'Shougo/unite.vim'
 " source ~/.vim/rc/plugins/unite.vim

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

"Plug 'scrooloose/syntastic'
"source ~/.vim/rc/plugins/syntastic.vim
"Plug 'vito-c/vim-pirate-scope'
" Plug 'xieyu/pyclewn'

" Deleted
" /Users/vitocutten/.vim/bundle/Flex-4/
" /Users/vitocutten/.vim/bundle/gist-vim/
" /Users/vitocutten/.vim/bundle/gundo.vim/
" /Users/vitocutten/.vim/bundle/node_modules/
" /Users/vitocutten/.vim/bundle/syntastic/
" /Users/vitocutten/.vim/bundle/tern_for_vim/
" /Users/vitocutten/.vim/bundle/unite-gist/
" /Users/vitocutten/.vim/bundle/vim-abolish/
" /Users/vitocutten/.vim/bundle/vim-classpath/
" /Users/vitocutten/.vim/bundle/vim-commentary/
" /Users/vitocutten/.vim/bundle/vim-fireplace/
" /Users/vitocutten/.vim/bundle/vim-jdaddy/
" /Users/vitocutten/.vim/bundle/vim-leiningen/
" /Users/vitocutten/.vim/bundle/vim-pirate-scope/
" /Users/vitocutten/.vim/bundle/vim-sbt/
" /Users/vitocutten/.vim/bundle/vim-table-mode/
" /Users/vitocutten/.vim/bundle/webapi-vim/
"
"
" - /Users/vito.cutten/.vim/bundle/LanguageClient-neovim/
" - /Users/vito.cutten/.vim/bundle/angular-vim-snippets/
" - /Users/vito.cutten/.vim/bundle/deoplete-go/
" - /Users/vito.cutten/.vim/bundle/deoplete.nvim/
" - /Users/vito.cutten/.vim/bundle/html5.vim/
" - /Users/vito.cutten/.vim/bundle/jq.vim/
" - /Users/vito.cutten/.vim/bundle/kotlin-vim/
" - /Users/vito.cutten/.vim/bundle/mango.vim/
" - /Users/vito.cutten/.vim/bundle/neovim-java-client/
" - /Users/vito.cutten/.vim/bundle/open-browser.vim/
" - /Users/vito.cutten/.vim/bundle/tern_for_vim/
" - /Users/vito.cutten/.vim/bundle/ultisnips/
" - /Users/vito.cutten/.vim/bundle/vim-angular/
" - /Users/vito.cutten/.vim/bundle/vim-dirvish/
" - /Users/vito.cutten/.vim/bundle/vim-geeknote/
" - /Users/vito.cutten/.vim/bundle/vim-gista/
" - /Users/vito.cutten/.vim/bundle/vim-gnupg/
" - /Users/vito.cutten/.vim/bundle/vim-go/
" - /Users/vito.cutten/.vim/bundle/vim-gradle/
" - /Users/vito.cutten/.vim/bundle/vim-multiple-cursors/
" - /Users/vito.cutten/.vim/bundle/vim-orgmode/
" - /Users/vito.cutten/.vim/bundle/vim-racer/
" - /Users/vito.cutten/.vim/bundle/vimproc.vim/
" - /Users/vito.cutten/.vim/bundle/vimwiki/
" Disabled {
" Plug 'vim-scripts/Flex-4'
"Plug 'mattn/webapi-vim'
"Plug 'mattn/gist-vim'
"Plug 'mattn/unite-gist'
"source ~/.vim/rc/plugins/gist.vim
"Plug 'Lokaltog/vim-powerline'
"Plug 'matchit.zip' "umm what's this do
" let b:match_ignorecase = 1
"wtf does this one do
"Plug 'mattn/webapi-vim'
""Plug 'scrooloose/nerdcommenter' "TODO: need a better commenter
"Plug 'vim-scripts/gtags.vim'
"Plug 'hewes/unite-gtags'
" powerline
" set " laststatus=2
" if filereadable( expand("~/.vim/Plug/powerline") )
"     python from powerline.vim import setup as powerline_setup
"     python powerline_setup()
"     python del powerline_setup
" endif
" }
