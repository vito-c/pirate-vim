" Information {
"--------------------------------------------------------------------------------
" vim: set sw=4 ts=4 sts=4 et tw=90 foldmarker={,} foldmethod=marker :
"  
" By: Vito C.
" }

"Plugin 'bling/vim-airline'

"Plugin 'tpope/vim-fireplace'
"Plugin 'tpope/vim-leiningen'
"Plugin 'tpope/vim-classpath'

Plugin 'Shougo/vimproc.vim'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-vinegar'
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-abolish.git'
Plugin 'vito-c/vim-snippets'
Plugin 'xieyu/pyclewn'
Plugin 'AndrewRadev/splitjoin.vim'

Plugin 'SirVer/ultisnips'
source ~/.vim/rc/plugins/ultisnips.vim

Plugin 'spf13/vim-colors'
Plugin 'ctrlpvim/ctrlp.vim'
source ~/.vim/rc/plugins/ctrlp.vim
Plugin 'godlygeek/csapprox'
Plugin 'flazz/vim-colorschemes'

Plugin 'sjl/gundo.vim'
source ~/.vim/rc/plugins/gundo.vim

Plugin 'marijnh/tern_for_vim'
Plugin 'pangloss/vim-javascript'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'matthewsimo/angular-vim-snippets'
Plugin 'burnettk/vim-angular'
Plugin 'othree/html5.vim'
Plugin 'derekwyatt/vim-scala'
Plugin 'vim-scripts/Flex-4'

Plugin 'dhruvasagar/vim-table-mode'
source ~/.vim/rc/plugins/table-mode.vim

Plugin 'terryma/vim-multiple-cursors'

"Plugin 'scrooloose/syntastic'
"source ~/.vim/rc/plugins/syntastic.vim

Plugin 'vito-c/vim-pirate-scope'

"Plugin 'mattn/webapi-vim'
"Plugin 'mattn/gist-vim'
"Plugin 'mattn/unite-gist'
"source ~/.vim/rc/plugins/gist.vim
Plugin 'lambdalisue/vim-gista'
Plugin 'tyru/open-browser.vim'
source ~/.vim/rc/plugins/gista.vim

Plugin 'benekastah/neomake'
source ~/.vim/rc/plugins/neomake.vim

Plugin 'godlygeek/tabular'
source ~/.vim/rc/plugins/tabular.vim

Plugin 'Valloric/YouCompleteMe'
source ~/.vim/rc/plugins/ycm.vim

Plugin 'nosami/Omnisharp'
Plugin 'Shougo/unite.vim'
source ~/.vim/rc/plugins/unite.vim

Plugin 'gmarik/vundle'
Plugin 'tommcdo/vim-exchange'
if executable('ctags')
    Plugin 'majutsushi/tagbar'
endif

Plugin 'tpope/vim-fugitive'
source ~/.vim/rc/plugins/fugitive.vim


" Disabled {
"Plugin 'Lokaltog/vim-powerline'
"Plugin 'matchit.zip' "umm what's this do
" let b:match_ignorecase = 1
"wtf does this one do
"Plugin 'mattn/webapi-vim'
""Plugin 'scrooloose/nerdcommenter' "TODO: need a better commenter
"Plugin 'vim-scripts/gtags.vim'
"Plugin 'hewes/unite-gtags'
" powerline
" set " laststatus=2
" if filereadable( expand("~/.vim/Plugin/powerline") )
"     python from powerline.vim import setup as powerline_setup
"     python powerline_setup()
"     python del powerline_setup
" endif
" }
