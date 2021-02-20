"Information {{{
"--------------------------------------------------------------------------------
" vim: set tw=90 foldmethod=marker :
"
" By: Vito C.
" }}}

"GUI {{{
highlight TermCursorNC ctermfg=15 guifg=#FFFFFF ctermbg=14 guibg=#56b6c2 cterm=NONE gui=NONE
set termguicolors
colorscheme one
set background=dark " Assume a dark background
"}}}

if has('nvim')
  let $GIT_EDITOR = 'nvr -cc split --remote-wait'
endif

set diffopt=internal,filler,iwhiteall,hiddenoff,vertical,algorithm:patience
set expandtab
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮

" configs {{{
filetype plugin indent on " Automatically detect file types.
set expandtab
syntax on                 " Syntax highlighting
set shortmess=aTI
set lazyredraw
set mouse=
scriptencoding utf-8
set history=8000
set hidden                      " Allow buffer switching without saving
set autoread
set autowrite
set noswapfile
set tabpagemax=15               " Only show 15 tabs
set showmode                    " Display the current mode
set cursorline                  " Highlight current line
set smarttab
set autoindent                  " Indent at the same level of the previous line
set shiftwidth=4                " Use indents of 4 spaces
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set relativenumber              " Line numbers on
set number
set noshowmatch                 " Show matching brackets/parenthesis
set matchtime=1                 " tenths of a second
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildignore=*.class,*/target/*
set wildmode=list:longest,full  " list matches, then longest common part, then all.
set whichwrap+=h,l,<,>,[,],b,s,~
set scrolloff=999                 " Minimum lines to keep above and below cursor
set foldenable                  " Auto fold code
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set nowrap
"set virtualedit=onemore             " Allow for cursor beyond last character
" }}}
let s:uname = system("echo -n \"$(uname)\"")
if !v:shell_error && s:uname == "Linux"
    let &shell='/usr/bin/bash'
    command! -nargs=0 SetupCoc call SetupCoc() 
    function! SetupCoc()
        CocInstall -sync coc-metals
    endfunction

endif
" Legacy undo fieles {{{
set nobackup
" }}}

" netrw {{{
let g:netrw_preview = 1
let g:netrw_winsize = 30
let g:netrw_altfile = 1
let g:netrw_list_hide= '.*\.swp$,.*\.meta$'
" }}}

" Abbrevs {{{
" TODO: Abloish plugin move to own file
iabbrev teh the
iabbrev chomd chmod
iabbrev ehco echo
iabbrev pritnln println
cabbrev ehco echo
iabbrev <expr> dtl strftime("%c")
iabbrev <expr> dts strftime("%m/%d/%Y")
iabbrev <expr> cdf expand('%')
iabbrev <expr> cdp expand('%:p')
iabbrev <expr> jpac 'package ' . substitute( join(split(expand('%:h'),'/'),'.'),'\v^\.+','','g') . ";\r"
" }}}

" Delete Empty Buffers {{{
command! -nargs=0 DeleteEmptyBuffers call DeleteEmptyBuffers() 
function! DeleteEmptyBuffers()
  let buffers = filter(range(0, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val)<0')
  if !empty(buffers)
    exe 'bw '.join(buffers, ' ')
  endif
endfunction
" }}}
