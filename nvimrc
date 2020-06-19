" Note: Skip initialization for vim-tiny or vim-small.

let s:suitetype = "full"

if s:suitetype == "full"
    " ./rc/vimrc
    execute 'source' fnamemodify(expand('<sfile>'), ':h') . '/rc/vimrc'
elseif s:suitetype == "minimal"
    " ./rc/vimrc-minimal
    execute 'source' fnamemodify(expand('<sfile>'), ':h') . '/rc/vimrc-minimal'
endif
