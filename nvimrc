" Note: Skip initialization for vim-tiny or vim-small.
"
if 1
    " ./rc/vimrc
    execute 'source' fnamemodify(expand('<sfile>'), ':h').'/rc/vimrc'
endif