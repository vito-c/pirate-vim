" Note: Skip initialization for vim-tiny or vim-small.
"

let ensime_server_v2=1
if 1
    " ./rc/vimrc
    execute 'source' fnamemodify(expand('<sfile>'), ':h') . '/rc/vimrc'
endif
