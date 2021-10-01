" \ 'scala': ['node', expand('~/code/configs/pirate-setup/bin/metals-vim')],
"

" let g:LanguageClient_serverCommands = {
"             \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
"             \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
"             \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
"             \ 'python': ['/usr/local/bin/pyls'],
"             \ 'kotlin': ['server'],
"             \ 'scala': ['metals-vim'],
"             \ }
" let g:LanguageClient_autoStart = 1
"
" " \ 'scala': ['node', expand('~/code/configs/pirate-setup/bin/sbt-server-stdio.js')],
" nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
"
" let $LANGUAGECLIENT_DEBUG=1
" let g:LanguageClient_devel = 1 " Use rust debug build
" let g:LanguageClient_loggingLevel='DEBUG'
" let g:LanguageClient_autoStart=0
" let g:LanguageClient_loggingFile =  expand('~/.local/share/nvim/LanguageClient.log')
