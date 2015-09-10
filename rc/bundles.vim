" Information {
"--------------------------------------------------------------------------------
" vim: set sw=4 ts=4 sts=4 et tw=90 foldmarker={,} foldmethod=marker :
"  
" By: Vito C.
" }

"Bundle 'bling/vim-airline'

"Bundle 'tpope/vim-fireplace'
"Bundle 'tpope/vim-leiningen'
"Bundle 'tpope/vim-classpath'

Bundle 'Shougo/vimproc.vim'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-vinegar'
Bundle 'tomtom/tcomment_vim'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-abolish.git'
Bundle 'vito-c/vim-snippets'
Bundle 'xieyu/pyclewn'
Bundle 'AndrewRadev/splitjoin.vim'
Bundle 'SirVer/ultisnips'
source ~/.vim/rc/plugins/ultisnips.vim
Bundle 'spf13/vim-colors'
Bundle 'ctrlpvim/ctrlp.vim'
Bundle 'godlygeek/csapprox'
Bundle 'flazz/vim-colorschemes'
Bundle 'sjl/gundo.vim'
source ~/.vim/rc/plugins/gundo.vim
Bundle 'marijnh/tern_for_vim'
Bundle 'pangloss/vim-javascript'
Bundle 'othree/javascript-libraries-syntax.vim'
Bundle 'matthewsimo/angular-vim-snippets'
Bundle 'burnettk/vim-angular'
Bundle 'othree/html5.vim'
Bundle 'derekwyatt/vim-scala'
Bundle 'vim-scripts/Flex-4'
Bundle 'dhruvasagar/vim-table-mode'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'scrooloose/syntastic'
source ~/.vim/rc/plugins/syntastic.vim
Bundle 'vito-c/vim-pirate-scope'
Bundle 'mattn/gist-vim'
Bundle 'godlygeek/tabular'
source ~/.vim/rc/plugins/tabular.vim
Bundle 'Valloric/YouCompleteMe'
source ~/.vim/rc/plugins/ycm.vim
Bundle 'nosami/Omnisharp'
Bundle 'Shougo/unite.vim'
source ~/.vim/rc/plugins/unite.vim
Bundle 'gmarik/vundle'
Bundle 'tommcdo/vim-exchange'
if executable('ctags')
    Bundle 'majutsushi/tagbar'
endif
Bundle 'tpope/vim-fugitive'
source ~/.vim/rc/plugins/fugitive.vim


" Disabled {
"Bundle 'Lokaltog/vim-powerline'
"Bundle 'matchit.zip' "umm what's this do
" let b:match_ignorecase = 1
"wtf does this one do
"Bundle 'mattn/webapi-vim'
""Bundle 'scrooloose/nerdcommenter' "TODO: need a better commenter
"Bundle 'vim-scripts/gtags.vim'
"Bundle 'hewes/unite-gtags'
" powerline
" set " laststatus=2
" if filereadable( expand("~/.vim/bundle/powerline") )
"     python from powerline.vim import setup as powerline_setup
"     python powerline_setup()
"     python del powerline_setup
" endif
" }
