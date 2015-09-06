
" Information {
"--------------------------------------------------------------------------------
" vim: set sw=4 ts=4 sts=4 et tw=100 foldmarker={,} foldmethod=marker :
" 
" By: Vito C.
" }
"--------------------------------------------------------------------------------
" Environment {
"--------------------------------------------------------------------------------
        set nocompatible        " Must be first line
        set expandtab
        
        " The next three lines ensure that the ~/.vim/bundle/ system works
        filetype on
        filetype off
        set rtp+=~/.vim/bundle/vundle
        call vundle#rc()

        " powerline setup
        if filereadable( expand("~/.vim/bundle/powerline") )
            python from powerline.vim import setup as powerline_setup
            python powerline_setup()
            python del powerline_setup
        endif
		if filereadable(expand("~/.vim/vimrc.bundles"))
		    source ~/.vim/vimrc.bundles
		endif
    " Windows Compatible {
        " On Windows, also use '.vim' instead of 'vimfiles'; this makes 
        " synchronization across (heterogeneous) systems easier.
        if has('win32') || has('win64')
          set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }
" }
"--------------------------------------------------------------------------------
"Experimential {
"--------------------------------------------------------------------------------
	" Fix indenting of html files
	autocmd FileType html setlocal indentkeys-=*<Return>
	autocmd FileType cs setlocal efm=%*\\s%f\(%l\\,%c\):\ error\ CS%n:\ %m
    autocmd FileType actionscript set isk+=$ 
    " add some quick leader stuff
    " vsp|next buffer - new vertical window

" }
"--------------------------------------------------------------------------------
" General { 
"--------------------------------------------------------------------------------
    " Abbrevs {
    " TODO: Abloish plugin
        iabbrev teh the
        iabbrev chomd chmod
        iabbrev ehco echo
        cabbrev ehco echo
        iabbrev <expr> dtl strftime("%c")
        iabbrev <expr> dts strftime("%m/%d/%Y")
        iabbrev <expr> cdf expand('%')
        iabbrev <expr> cdp expand('%:p')
        iabbrev <expr> jpac 'package ' . substitute( join(split(expand('%:h'),'/'),'.'),'\v^\.+','','g') . ";\r"

    " }
    "Setup Shell {
	" seems to break vimdiff sometimes
        " custom shell options
        "set shell=/usr/local/bin/bash\ --rcfile\ ~/.pirate-setup/pirate-vim/vim-bashrc\ -i
    " }
    filetype plugin indent on   " Automatically detect file types.
    autocmd BufRead *.as set filetype=actionscript 
    autocmd BufRead *.mxml set filetype=mxml 
    autocmd FileType actionscript set efm=%f(%l):\ col:\ %c\ Error:\ %m,%-G%.%#

    syntax on                   " Syntax highlighting
    "set mouse=a                 " Automatically enable mouse usage
    "set mousehide               " Hide the mouse cursor while typing
    set mouse=
    scriptencoding utf-8
    " Auto Commands {
		if has("autocmd")
			" Source the vimrc file after saving it
            augroup vimsource 
                autocmd! 
                autocmd bufwritepost .vimrc source $MYVIMRC 
                autocmd bufwritepost vimrc source $MYVIMRC 
                if has('nvim')
                    autocmd bufwritepost .nvimrc source $MYVIMRC 
                    autocmd bufwritepost nvimrc source $MYVIMRC 
                endif
            augroup END
			"autocmd bufwritepost .vimrc source $MYVIMRC
			"autocmd bufwritepost vimrc sourc $MYVIMRC
			au BufReadPost quickfix setlocal modifiable
			" Map ☠ (U+???) to <Esc> as <S-CR> is mapped to ☠ in iTerm2.
			"if has ('gui')          " On mac and Windows, use * register for copy-paste
			au BufReadPost quickfix :noremap <buffer> <S-CR> :execute 'cc '.line(".") <Bar> cclose <Bar> copen <Bar> wincmd J<CR>
			au BufReadPost quickfix :noremap <buffer> <leader>j :execute 'cc '.line(".") <Bar> cclose <Bar> copen <Bar> wincmd J <Bar> normal j <CR>
			au BufReadPost quickfix :noremap <buffer> <leader>k :execute 'cc '.line(".") <Bar> cclose <Bar> copen <Bar> wincmd J <Bar> normal k <CR>
			autocmd CmdwinEnter * map <buffer> ☠ <CR>q:
			au BufReadPost quickfix :noremap <buffer> ☠ :execute 'cc '.line(".") <Bar> cclose <Bar> copen <Bar> wincmd J<CR>j
		endif
	" }
    " Most prefer to automatically switch to the current file directory when
    " a new buffer is opened; to prevent this behavior, add the following to
    " your .vimrc.bundles.local file:
    "   let g:spf13_no_autochdir = 1
    "if !exists('g:spf13_no_autochdir')
    "    autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
    "    " Always switch to the current file directory
    "endif
    "set autowrite                       " Automatically write a file when leaving a modified buffer

    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore             " Allow for cursor beyond last character
    "set virtualedit=block
    set history=1000                    " Store a ton of history (default is 20)
    "set spell                           " Spell checking on
    set hidden                          " Allow buffer switching without saving
    set autoread
    set autowrite
    set ttyfast
    set showcmd
    set backup
    set noswapfile
    set undodir=~/.vim/tmp/undo//     " undo files
    set backupdir=~/.vim/tmp/backup// " backups
    set directory=~/.vim/tmp/swap//   " swap files

    " Make those folders automatically if they don't already exist.
    if !isdirectory(expand(&undodir))
        call mkdir(expand(&undodir), "p")
    endif
    if !isdirectory(expand(&backupdir))
        call mkdir(expand(&backupdir), "p")
    endif
    if !isdirectory(expand(&directory))
        call mkdir(expand(&directory), "p")
    endif


    " Setup Paths{
        set path=~/code/**
        set path+=~/playground/**
    " }
    " Setting up the directories {
	"TODO: just set this variable via a flag
"        if has('persistent_undo')
"			set backup                  " Backups are nice ...
"            set undofile                " So is persistent undo ...
"            set undolevels=1000         " Maximum number of changes that can be undone
"            set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
"        endif
    " }
" }
"--------------------------------------------------------------------------------
" Custom Functions {
"--------------------------------------------------------------------------------
    " TODO: automatically open quickfix window cscope, make etc
    " TODO: pop errors off the quickfix window, append search, remove search
    " TODO: also shift enter in full command mode would be cool
    " TODO: get make functionality for c# unity project
    " TODO: install pyclewn and get functionality working
    " TODO: command line tab should complete and control space should list
	" TODO: get vim hearders searchable via tags
	" TODO: <F5> needs to force refresh tags and cscope
	" TODO: Fugitve doesn't do it's thing
	
	"command! -nargs=1 -complete=command -bang Cdo call ArgPopAndRestore( ListFileNames( 'quickfix' ), <f-args> )
	"command! -nargs=1 -complete=command -bang Ldo call ArgPopAndRestore( ListFileNames( 'loclist' ), <f-args> )
	command! -nargs=0 -bar RefreshTags execute RefreshTagsInGitHooks()

	" TODO: consider buffdo instead of argdo then restor the buffer list
	"function! ArgPopAndRestore( exelist, execommand )
	"	let current_arglist = argv()
	"	exe 'args ' . a:exelist . '| argdo! ' . a:execommand
	"	exe 'args ' . join(current_arglist)
	"endfunc

	"function! ListFileNames( listName )
	"  " Building a hash ensures we get each buffer only once
	"  let buffer_numbers = {}
	"  if a:listName == 'quickfix' 
	"	  for quickfix_item in getqflist()
	"		let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
	"	  endfor
	"  elseif a:listName == 'loclist'
	"	  for loclist_item in getloclist()
	"		let buffer_numbers[loclist_item['bufnr']] = bufname(loclist_item['bufnr'])
	"	  endfor
	"  endif
	"  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
	"endfunction

	function! RefreshTagsInGitHooks()
		if filereadable(".git/hooks/ctags")
			:!.git/hooks/ctags
		else 
			echo "Failed to find tag generator"
		endif
	endfunction

	"function! GetBufferList()
	"	redir =>buflist
	"	silent! ls
	"	redir END
	"	return buflist
	"endfunction

	" TODO: if in COMMIT_EDITMSG should you save quit on toggle? or ZZ?
	"function! ToggleBuffer(bufname, pfx)
	"	let buflist = GetBufferList()
	"	"let pat = '"'.a:bufname.'"' | echo filter(split('abc keep also def'), 'pat =~ v:val' )
	"	for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ a:bufname'), 'str2nr(matchstr(v:val, "\\d\\+"))')
	"		if bufwinnr(bufnum) != -1
	"			exec('bd '.bufnum)
	"			return
	"		endif
	"	endfor
	"	" Test Prefix and open your buffer here
	"	if a:pfx == 'g'
	"		:Gstatus
	"		return
	"	endif
	"endfunction

	"function! ToggleList(bufname, pfx)
	"	let buflist = GetBufferList()
	"	for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
	"		if bufwinnr(bufnum) != -1
	"			exec(a:pfx.'close')
	"			return
	"		endif
	"	endfor
	"	if a:pfx == 'l' && len(getloclist(0)) == 0
	"		echohl ErrorMsg
	"		echo "Location List is Empty."
	"		return
	"	endif
	"	let winnr = winnr()
	"	exec(a:pfx.'open')
	"	wincmd J
	"	if winnr() != winnr
	"		wincmd J
	"	endif
	"endfunction

    function! NumberToggle()
        if(&nu == 1 && &rnu == 0 || &nu == 0 )
            set relativenumber
            set number
        elseif(&nu == 1 && &ru == 1)
            set norelativenumber
            set number
        endif
    endfunc

    function! NumberOff()
        if(&nu)
            set nonu
        endif
        if(&rnu)
            set nornu
        endif
    endfunc
"}
"--------------------------------------------------------------------------------
" Vim UI {
"--------------------------------------------------------------------------------
    set background=dark         " Assume a dark background
    color molokai                    " Load a colorscheme
    "color default
    "set background=light
    "color default "Load a colorscheme
    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode
    set cursorline                  " Highlight current line
    " Setup Clipboard {
        if has ('x') && has ('gui') " On Linux use + register for copy-paste
            set clipboard=unnamedplus,autoselect
        elseif has ('gui')          " On mac and Windows, use * register for copy-paste
            set clipboard=unnamed
        elseif has('x11')
            set clipboard=unnamed
            " set clipboard=unnamedplus,autoselect
        endif
    " }
    " Status Line {
        if has('cmdline_info')
            set ruler                   " Show the ruler
            set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
            set showcmd                 " Show partial commands in status line and
                                        " Selected characters/lines in visual mode
        endif
    " }
    " Netrw Ignore {
        let g:netrw_list_hide= '.*\.swp$,.*\.meta$'
    " }
    " Setup Misc {
        set backspace=indent,eol,start  " Backspace for dummies
        set linespace=0                 " No extra spaces between rows
        set relativenumber              " Line numbers on
        set number
        set showmatch                   " Show matching brackets/parenthesis
        set incsearch                   " Find as you type search
        set hlsearch                    " Highlight search terms
        set winminheight=0              " Windows can be 0 line high
        set ignorecase                  " Case insensitive search
        "set smartcase                   " Case sensitive when uc present
        set wildmenu                    " Show list instead of just completing
        set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
        set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
        "set scrolljump=5                " Lines to scroll when cursor leaves screen
        set scrolloff=999                 " Minimum lines to keep above and below cursor
        set foldenable                  " Auto fold code
        "set listchars=tab:,.,trail:.,extends:#,nbsp:. " Highlight problematic whitespace
        set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
        " Save when losing focus
        au FocusLost * :call SafeSave("all")
        au BufWritePost * :call RestoreMarker()
        au TextChanged * :call SafeSave("crrent")
        au TextChangedI * :call SafeSave("crrent")

        let g:ltickmark = getpos("'[")
        let g:rtickmark = getpos("']")
        function! BackupMarker()
            let g:ltickmark = getpos("'[")
            let g:rtickmark = getpos("']")
        endfunction

        function! RestoreMarker()
            call setpos("'[", g:ltickmark)
            call setpos("']", g:rtickmark)
        endfunction

        function! SafeSave(target)
            if expand('%') != ''
                call BackupMarker()
                if a:target == "all"
                    silent! wall
                else
                    silent! update
                endif
                call RestoreMarker()
            endif
        endfunction
    " }

" }
"--------------------------------------------------------------------------------
" Formatting {
"--------------------------------------------------------------------------------
    set nowrap                      " Wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=4                " Use indents of 4 spaces
    "set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    "set matchpairs+=<:>             " Match, to be used with %
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
    "set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
    " Remove trailing whitespaces and ^M chars
    autocmd FileType c,cpp,java,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> call StripTrailingWhitespace()
    " autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
" }
"--------------------------------------------------------------------------------
" Key (re)Mappings {
"--------------------------------------------------------------------------------
    let mapleader = ' '
    noremap ZA :wqa<CR>
	
    " Searching {
        nnoremap <leader>ff :call FindInFile()<CR>
        noremap <leader>fg :Ack <C-R>=expand("<cword>")<CR><CR>
        noremap <leader>fc :call FindInPath()<CR>
        "nnoremap <F1> :TagbarToggle<CR>
        noremap <F4> :set hlsearch! hlsearch?<CR>
        " Toggle search highlighting
        nmap <silent> <leader>/ :set invhlsearch<CR>
    " }
    " Custom Function calls {
        noremap <F5> :call RefreshTags()<CR>
        noremap <leader><leader>t :echo "<C-R>=expand("<cword>")<CR>"<CR>
        nmap <silent> <leader>ol :call ToggleList("Location List", 'l')<CR>
        nmap <silent> <leader>oq :call ToggleList("Quickfix List", 'c')<CR>
    " }
    " Number toggles {
        nnoremap <leader>no :call NumberOff()<CR>
        nnoremap <leader>nn :call NumberToggle()<CR>
        nnoremap <leader>nr :set relativenumber<CR>
        nnoremap <leader>nu :set number<CR>
    " }
    " Marks {
        " Set marks correctly
        "noremap ' `
        "noremap ` '
        "noremap g' g`
        "noremap g` g'
    " }
    " Instert mode maps {
        inoremap <C-E> <ESC>A
        inoremap <C-B> <ESC>I
        inoremap ☠ <ESC>o
        inoremap 🍺 <ESC>O
        "inoremap <C-;> <ESC>mcA;<ESC>`ca
    " }
    " Command mode maps {
        " Change Working Directory to that of the current file
        cmap cwd lcd %:p:h
        " For when you forget to sudo.. Really Write the file.
        cmap w!! w !sudo tee % >/dev/null
    " }
    " Windows/Tabs { : use <leader>w for window commands
        " Easier moving in tabs and windows
        " The lines conflict with the default digraph mapping of <C-K>
        " If you prefer that functionality, add let g:spf13_no_easyWindows = 1
        " in your .vimrc.bundles.local file
        nnoremap <C-J> <C-W>j
        nnoremap <C-K> <C-W>k
        nnoremap <C-L> <C-W>l
        nnoremap <C-H> <C-W>h
        nnoremap <leader>wj <C-W>j
        nnoremap <leader>wk <C-W>k
        nnoremap <leader>wl <C-W>l
        nnoremap <leader>wh <C-W>h
        nnoremap <leader>w= <C-W>=
        nnoremap <leader>w+ <C-W>+
        nnoremap <leader>w_ <C-W>_
        nnoremap <leader>w- <C-W>-
        nnoremap <leader>wc <C-W>c
        nnoremap <leader>wo <C-W>o
        nnoremap <leader>wv :vsp<Bar>bn <CR>
        nnoremap <leader>ws :sp<Bar>bn <CR>
        nnoremap <leader>wt <C-W>T
        " Adjust viewports to the same size
        map <Leader>= <C-w>=
    " }
    " Mic Stuff  {
        " Wrapped lines goes down/up to next row, rather than next line in file.
        nnoremap j gj
        nnoremap k gk
        " Yank from the cursor to the end of the line, to be consistent with C and D.
        nnoremap Y y$
        " Visual shifting (does not exit Visual mode)
        vnoremap < <gv
        vnoremap > >gv
        vnoremap > >gv
        "select the last changed or pasted text
        nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
        " alternate select pasted text only nmap gp `[v`]
        " Easier horizontal scrolling
        map zl zL
        map zh zH
        " saving 
        noremap <leader>ss :w<CR>
        noremap <leader>sa :wa<CR>
        noremap <leader>sq :wqa<CR>
        noremap <leader><leader>l :set list!<CR>
        map <leader>; mcA;<ESC>'c
    " }
    " Shift Key Fixes {
        " Stupid shift key fixes
        if !exists('g:spf13_no_keyfixes')
            if has("user_commands")
                command! -bang -nargs=* -complete=file E e<bang> <args>
                command! -bang -nargs=* -complete=file W w<bang> <args>
                command! -bang -nargs=* -complete=file Wq wq<bang> <args>
                command! -bang -nargs=* -complete=file WQ wq<bang> <args>
                command! -bang Wa wa<bang>
                command! -bang WA wa<bang>
                command! -bang Q q<bang>
                command! -bang QA qa<bang>
                command! -bang Qa qa<bang>
            endif
        endif
    " }
    " Fold Levels {
        " Code folding options
        nmap <leader>f0 :set foldlevel=0<CR>
        nmap <leader>f1 :set foldlevel=1<CR>
        nmap <leader>f2 :set foldlevel=2<CR>
        nmap <leader>f3 :set foldlevel=3<CR>
        nmap <leader>f4 :set foldlevel=4<CR>
        nmap <leader>f5 :set foldlevel=5<CR>
        nmap <leader>f6 :set foldlevel=6<CR>
        nmap <leader>f7 :set foldlevel=7<CR>
        nmap <leader>f8 :set foldlevel=8<CR>
        nmap <leader>f9 :set foldlevel=9<CR>
    " }
    " Path Editing { : use leader n to open 
        " uses the current file name as the path to browse for a file to open
        "map <leader>nw :<C-U>e %%<CR>
        "map <leader>ns :<C-U>sp %%<CR>
        "map <leader>nv :<C-U>vsp %%<CR>
    " }
    " File Editing { : use <leader>e to edit files
        function! FastVFind(name)
            let list_cmd="find . -name '*.meta' -prune -o -iname " . a:name . " -type f -print" . g:pirate_unite_fsorter
            let flist=system( list_cmd . "| perl -ne 'print \"$.\\ $_\"'")
            call DisplayFindResults(flist, a:name, "vsp", "")
        endfunction
        command! -nargs=1 FastVFind :call FastVFind("<args>")
        function! FastFind(name)
            "let list_cmd="find . -name '*.meta' -prune -o -iname " . a:name . " -type f -print" . g:pirate_unite_fsorter
            let list_cmd="find . " . g:pirate_unite_ifind . " -iname " . a:name . " -type f -print " . g:pirate_unite_fsorter
            let flist=system( list_cmd . " | perl -ne 'print \"$.\\ $_\"'")
            call DisplayFindResults(flist, a:name, "e", "")
        endfunction
        command! -nargs=1 FastFind :call FastFind("<args>")

        function! FindFileInBranch( edittype )
            let current_file=expand('%:t')
            let current_dir=expand('%:h')
            let target_dir="/Users/vcutten/workrepos/farm3/dev_sswistun_rnd_merged/src"
            let dir_match = matchstr(current_dir, '/Users/vcutten/workrepos/farm3/dev_sswistun_rnd_merged')
            if !empty(dir_match)
                let target_dir="/Users/vcutten/workrepos/farm3-dev/Farm3"
            endif

            let flist=system("find " . target_dir . " -name " . current_file . " | perl -ne 'print \"$.\\ $_\"'" )
            call DisplayFindResults( flist, current_file, a:edittype, line(".") )
        endfunction
        command! -nargs=1 FindFileInBranch :call FindFileInBranch("<args>")

        function! FindGenerated( edittype )
            let current_file = expand('%:t')
            let current_ext  = expand('%:t:e')
            let current_root = expand('%:t:r')
            let current_dir  = expand('%:h')
            let target_ext="as"
            if current_dir == "/Users/vcutten/workrepos/farm3-dev/Flash"
                let target_dir = "/Users/vcutten/workrepos/farm3-dev/Farm3"
            elseif current_dir == "/Users/vcutten/workrepos/farm3-dev/Farm3"
                let target_dir = "/Users/vcutten/workrepos/farm3-dev/Flash"
            else
                let target_dir = GitRootOrHome()
            endif

            if current_ext == "as"
                let target_ext="cs"
            endif

            let name = current_root . "." . target_ext 
            let flist=system("find " . target_dir . " -name " . name . " | perl -ne 'print \"$.\\ $_\"'" )
            echom target_dir
            call DisplayFindResults( flist, name, a:edittype, line("."))
        endfunction
        command! -nargs=1 FindGenerated :call FindGenerated("<args>")

        function! GitRootOrHome()
            let current_dir = expand('%:p:h')
            let scmd = "if [[ -e " . current_dir .  "/.git || "
                            \ . current_dir . " == " . $HOME .  " || "
                            \ . current_dir . " == / ]]; then printf 1; else printf 0; fi"
            while system(scmd) != "1"
                let current_dir = fnamemodify( current_dir, ":p:h:h")
                let scmd = "if [[ -e " . current_dir .  "/.git || "
                                \ . current_dir . " == " . $HOME .  " || "
                                \ . current_dir . " == / ]]; then printf 1; else printf 0; fi"
            endwhile
            return current_dir
        endfunc

        function! DisplayFindResults(flist, name, edittype, gotoline)
            if a:gotoline == "" 
                let cline = 0
            else
                let cline = a:gotoline
            endif

            if a:edittype == "" 
                let editor = ":e"
            else
                let editor = ":" . a:edittype
            endif

            let l:num=strlen(substitute(a:flist, "[^\n]", "", "g"))
            if l:num < 1
                echo "'".a:name."' not found"
                return
            endif

            if l:num != 1
                echo a:flist
                let l:input=input("Select One: (CR=nothing)\n")
            if strlen(l:input)==0
                return
            endif

            if strlen(substitute(l:input, "[0-9]", "", "g"))>0
                echo "Not a number"
                return
            endif

            if l:input<1 || l:input>l:num
                echo "Out of range"
                return
            endif
                let l:line=matchstr("\n".a:flist, "\n".l:input." [^\n]*")
            else
                let l:line=a:flist
            endif

            let l:line=substitute(l:line, "^[^ ]* ", "", "")
            if a:edittype == "diff" 
                execute "tabedit +" . cline . " %"
                execute "vsp +" . cline . " " . l:line 
                windo diffthis
                wincmd h 
            else
                execute editor . " +" . cline . " " . l:line 
            endif
        endfunction

        noremap <leader>eg :<C-U>FindGenerated e<CR>
        noremap <leader>eo :<C-U>FindFileInBranch e<CR>
        noremap <leader>do :<C-U>FindFileInBranch diff<CR>
        noremap <leader>ef :<C-U>FastFind 

        " Some helpers to edit mode
        " http://vimcasts.org/e/14
        cnoremap %% <C-R>=expand('%:h').'/'<cr>
        noremap <leader>ew :<C-U>e <C-R>=expand('%:h').'/'<cr>
        noremap <leader>es :<C-U>sp %%
        "noremap <leader>ev :<C-U>vsp %%
        noremap <leader>et :<C-U>tabe %%
        noremap <leader>ev :<C-U>tabedit $MYVIMRC<CR>
        noremap <leader>eb :<C-U>tabedit /Users/$USER/.pirate-setup/bashrc<CR>
        noremap <leader>vb :<C-U>vsp<Bar>bn<CR>
        noremap <leader>vg :<C-U>FindGenerated vsp<CR>
        noremap <leader>vf :<C-U>FastVFind 

        " tab operantions
        "noremap <leader>tc :<C-U>tabclose<CR>
    " }
    " Better */# Search {
        vnoremap <silent> * :<C-U>
                    \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
                    \gvy/<C-R><C-R>=substitute(
                    \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
                    \gV:call setreg('"', old_reg, old_regtype)<CR>

        vnoremap <silent> # :<C-U>
                    \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
                    \gvy?<C-R><C-R>=substitute(
                    \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
                    \gV:call setreg('"', old_reg, old_regtype)<CR>

        vnoremap <leader>ff :<C-U>
                    \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
                    \gvy:vimgrep "<C-R><C-R>=substitute(
                    \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR>" %<CR>
                    \gV:call setreg('"', old_reg, old_regtype)<CR>
                    \:copen<CR>
    " }
" }
"--------------------------------------------------------------------------------
" Plugins {
"--------------------------------------------------------------------------------
    " Airline {
        let g:airline_powerline_fonts = 1 
    " }
    " CScope {
        if has("cscope")
            " add any cscope database in current directory
"            if filereadable("cscope.out")
"                cs add cscope.out  
"            " else add the database pointed to by environment variable 
"            elseif $CSCOPE_DB != ""
"                cs add $CSCOPE_DB
"            else
"                cs add ~/workrepos/farm-mobile/cscope.out
"            endif
			if !exists("cscope_test_loaded")
				let cscope_test_loaded = 1
				cs add $HOME.'/workrepos/mobile/cscope.out'
			endif
            " show msg when any other cscope db added
            set cscopeverbose  
            set cscopequickfix=s-,c-,d-,i-,t-,e-,g-
            " search tag files first
            set csto=1
            noremap <leader>fs :execute 'cs find s <C-R>=expand("<cword>")<CR>' <Bar> copen <Bar> wincmd J <CR>
        endif
    " }
    " Buffalo {
        let buffalo_autoaccept=1
    " }
    " PIV {
        let g:DisableAutoPHPFolding = 0
        let g:PIVAutoClose = 0
    " }
    " Powerline {
         set laststatus=2
        "let g:Powerline_symbols = 'fancy'
    " }
    " Misc {
        let b:match_ignorecase = 1
    " }
	" Gist {
		let g:gist_detect_filetype = 1
		let g:gist_open_browser_after_post = 1
	" }
    " OmniSharp {
        "let g:OmniSharp_sln_list_name = $HOME.'/workrepos/mobile/FarmMobile/FarmMobile.sln'
        "let g:OmniSharp_sln_list_name = $HOME.'/workrepos/farm3/branches/dev/src/FarmMobile/FarmMobile.sln'
        "let g:OmniSharp_sln_list_name = $HOME.'/workrepos/farm3/dev/src/FarmMobile/FarmMobile.sln'
        let g:OmniSharp_sln_list_index = 1
        let g:OmniSharp_BufWritePreSyntaxCheck = 0
        let g:OmniSharp_timeout = 300
    " }
    " OmniComplete {

    "    if has("autocmd") && exists("+omnifunc")
    "        autocmd Filetype *
    "            \if &omnifunc == "" |
    "            \setlocal omnifunc=syntaxcomplete#Complete |
    "            \endif
    "    endif

        hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
        hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
        hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

    "    " Some convenient mappings
    "    inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
    "    inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
    "    inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
    "    inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
    "    inoremap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
    "    inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

    "    " Automatically open and close the popup menu / preview window
    "    au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
    "    set completeopt=menu,preview,longest
    " }
    " Ctags {
    "   set tags=./tags;/,~/.vimtags
    " }
    " Tabularize {
        nmap <Leader>a& :Tabularize /&<CR>
        vmap <Leader>a& :Tabularize /&<CR>
        nmap <Leader>a+ :Tabularize /+<CR>
        vmap <Leader>a+ :Tabularize /+<CR>
        nmap <Leader>a= :Tabularize /=<CR>
        vmap <Leader>a= :Tabularize /=<CR>
        nmap <Leader>a: :Tabularize /:<CR>
        vmap <Leader>a: :Tabularize /:<CR>
        nmap <Leader>a:: :Tabularize /:\zs<CR>
        vmap <Leader>a:: :Tabularize /:\zs<CR>
        nmap <Leader>a{ :Tabularize /{<CR>
        vmap <Leader>a} :Tabularize /}<CR>
        nmap <Leader>a, :Tabularize /,<CR>
        vmap <Leader>a, :Tabularize /,<CR>
        nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
        vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
    " }
    " JSON {
        nmap <leader><leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
    " }
    " PyMode {
        let g:pymode_lint_checker = "pyflakes"
        let g:pymode_utils_whitespaces = 0
        let g:pymode_options = 0
    " }
    " TagBar {
        "nnoremap <F1> :TagbarToggle<CR>
		" This is set in ~/.pirate-vim/vim/after/plugin/my_mappings.vim
        "nnoremap <silent> <leader>tt :TagbarToggle<CR>
        let g:tagbar_type_actionscript = {
                    \ 'ctagstype' : 'flex',
                    \ 'kinds' : [
                    \ 'f:functions',
                    \ 'c:classes',
                    \ 'm:methods',
                    \ 'p:properties',
                    \ 'v:global variables',
                    \ 'x:mxtags'
                    \ ]
                    \ }
        let g:tagbar_type_mxml = {
                    \ 'ctagstype' : 'flex',
                    \ 'kinds' : [
                    \ 'f:functions',
                    \ 'c:classes',
                    \ 'm:methods',
                    \ 'p:properties',
                    \ 'v:global variables',
                    \ 'x:mxtags'
                    \ ]
                    \ }
    "}
    " PythonMode {
		" Disable if python support not present
        if !has('python')
            let g:pymode = 1
        endif
    " }
    " Fugitive {
		function! PirateDiffRight()
			if ( match( bufname("%"), '//2' ) != -1 )
				" On TARGET Buffer
				echo "Pending"
			elseif ( match( bufname("%"), '//3' ) != -1 )
				" On REMOTE Buffer
				echo "No Where to Put"
			else
				" On LOCAL Buffer
				:diffget //3 | diffupdate
			endif
		endfunc
		function! PirateDiffLeft()
			if ( match( bufname("%"), '//2' ) != -1 )
				" On TARGET Buffer
				echo "Pending"
			elseif ( match( bufname("%"), '//3' ) != -1 )
				" On REMOTE Buffer
				echo "No Where to Put"
			else
				" On LOCAL Buffer
				:diffget //2  | diffupdate
			endif
		endfunc
		" Quick commands to run diff put/obtain
		" Obtain diff from left side
		nnoremap <leader>dh call :PirateDiffLeft()<CR>
		" Obtain diff from right side
		nnoremap <leader>dl call :PirateDiffRight()<CR>

		nnoremap <silent> <leader>gs :call ToggleBuffer('.git/index\\|.git/COMMIT_EDITMSG', 'g')<CR>
        nnoremap <silent> <leader>gdh :Gdiff HEAD<CR>
        nnoremap <silent> <leader>gdm :Gdiff master<CR>
        nnoremap <silent> <leader>gc :Gcommit<CR>
        nnoremap <silent> <leader>gb :Gblame<CR>
        nnoremap <silent> <leader>gl :Glog<CR>
        "nnoremap <silent> <leader>gp :Git push<CR>
    "}
    " Gundo {
		nnoremap <Leader>u :GundoToggle<CR>
    " }
    " Syntastic {
        let g:syntastic_always_populate_loc_list=1
        let g:syntastic_auto_jump=0
        let g:syntastic_check_on_open=1
    " }
    " YCM {
        let g:ycm_autoclose_preview_window_after_completion = 1
    " }
    " UltiSnips {
        let g:UltiSnipsExpandTrigger="<c-j>"
        let g:UltiSnipsJumpForwardTrigger="<c-j>"
        let g:UltiSnipsJumpBackwardTrigger="<c-k>"
    " }
    " unite {
        "test
    
        let g:pirate_unite_fsorter="| gawk -vFS=/ -vOFS=/ '{ print $NF,$0 }' | sort -f -t / |  cut -f2- -d/"
        "TODO: make this work cat ~/.vim/unite-exclusive.json 
        let g:pirate_unite_exclusive="-iname '*.js' -o -iname '*.scala' -o -iname '*.html'"
    "cat ~/.vim/unite-ignores.json | jq -c '.commands = ["-iname '\''*." + .filetypes[] + "'\'' -prune -o"] + ["-type d -iname " + .directories[] + " -prune -o"] | .commands[] '
        let g:pirate_unite_ignores="cat ~/.vim/unite-ignores.json | " .
                        \"jq -c '.commands = [\"-iname '\\''*.\" + .filetypes[] + \"'\\'' -prune -o\"] + " .
                        \"[\"-type d -iname \" + .directories[] + \" -prune -o\"] " .
                        \"| .commands[]' " .
                        \"| tr -d '\"' | tr '\n' ' '"
        let g:pirate_unite_ifind=system(g:pirate_unite_ignores)

        let g:pirate_unite_rsync_icommand="find . " . g:pirate_unite_ifind . " -type f -print " . g:pirate_unite_fsorter
        let g:pirate_unite_rsync_ecommand="find . " . g:pirate_unite_exclusive . g:pirate_unite_fsorter
        let g:pirate_static_filetype=""
        let g:pirate_unite_rsync_ccommand="find . -iname '*." . g:pirate_static_filetype . "'"

        "let g:unite_source_rec_find_args=['-path', '*/.idea/*', '-prune', '-o','-path', '*/.git/*', '-prune', '-o', '-type', 'l', '-print']
        "let g:unite_source_rec_async_command="find . " . g:pirate_unite_ifind . " -type f -print"
		let g:unite_source_file_rec_max_cache_files = 250
        "call unite#filters#matcher_default#use(['matcher_fuzzy'])

        "call unite#custom#source('file_rec,file_rec/async', 'max_candidates', 0)
        "call unite#custom#source('file_rec,file_rec/async', 'ignore_pattern', '\(\.anim$\|\.mat$\|\.unity$\|\.mdpolicy$\|\.userprefs$\|\.so$\|\.swp$\|\.exe$\|\.pidb$\|\.csproj$\|\.zip$\|\.fbx$\|\.meta$\|\.prefab$\|\.png$\|\.jpg$\|\~$\|\.PNG$\|\.asset$\|\.nib$\|\.svn$\|nouveau\|Library\|Temp\|svn\|neocon\|vimswap\|vimundo\|vimgolf\|AssetsSrc\)')
        "call unite#custom#source('file_rec,file_rec/async', 'ignore_pattern', '\(\.anim$\|\.mat$\|\.unity$\|\.mdpolicy$\|\.userprefs$\|\.so$\|\.swp$\|\.exe$\|\.pidb$\|\.csproj$\|\.zip$\|\.fbx$\|\.meta$\|\.prefab$\|\.png$\|\.jpg$\|\~$\|\.PNG$\|\.asset$\|\.nib$\|\.svn$\|nouveau\|Library\|Temp\|svn\|neocon\|vimswap\|vimundo\|vimgolf\|AssetsSrc\)')

        "call unite#custom#source('file_rec,file_rec/async', 'ignore_pattern', '\.meta$')

        let g:unite_source_history_yank_enable = 1
        "let g:unite_split_rule = 'botright'

        nnoremap <leader>eg :<C-u>Unite -start-insert -toggle -no-split file_rec/git:!<CR>
        nnoremap <leader>er :<C-u>Unite -start-insert -toggle -no-split file_rec/async:!<CR>
        "nnoremap <leader>l :<C-u>Unite -start-insert -toggle -auto-preview -no-split -winheight=15 -immediately buffer<CR>
        nnoremap <leader>l :<C-u>Unite -start-insert -toggle -no-split buffer:-<CR>
        nnoremap <leader>t :<C-u>Unite -start-insert -toggle -no-split buffer:t<CR>
        "nnoremap <leader>er :<C-u>let g:unite_source_rec_async_command=g:pirate_unite_rsync_icommand <Bar> Unite -start-insert -toggle -auto-preview -winheight=60 -no-split file_rec/async:!<CR>
        "nnoremap <leader>ee :<C-u>let g:unite_source_rec_async_command=g:pirate_unite_rsync_ecommanj <Bar> Unite -start-insert -toggle -auto-preview -winheight=60 -no-split file_rec/async:!<CR>
        "nnoremap <leader>ec :<C-u>let g:unite_source_rec_async_command="find . -iname '\*." . &ft . "'" <Bar> Unite -start-insert -toggle -auto-preview -winheight=60 -no-split file_rec/async:!<CR>
        "nnoremap <leader>l :<C-u>let g:unite_split_rule = 'botright' <Bar> Unite -start-insert -here -winheight=60 buffer<CR>
        "TODO: buffer map dd to exit (trust me this makes sense)
        "nnoremap <leader>t :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<cr>
        "nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
        "nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
        "nnoremap <leader>o :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
        "nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
        "nnoremap <leader>e :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>

        " Custom mappings for the unite buffer
        "autocmd FileType unite call s:unite_settings()
        "function! s:unite_settings()
        "  " Play nice with supertab
        "  let b:SuperTabDisabled=1
        "  " Enable navigation with control-j and control-k in insert mode
        "  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
        "  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
        "endfunction

        let g:unite_source_buffer_time_format=""
        call unite#custom#source('file,file/new,buffer,file_rec,file_rec/git',
          \ 'matchers', ['converter_abbr_word','matcher_fuzzy'])
        call unite#filters#sorter_default#use(['sorter_rank'])

        "ctrl-p
        let g:ctrlp_max_files = 2500000
        let g:ctrlp_custom_ignore = {
          \ 'dir':  '\v[\/](\.(git|hg|svn|metadata|idea|settings)|target|vendor|vendors|node_modules)$',
          \ 'file': '\v\.(min.js|cache|class|exe|so|dll|php|exe|gitignore|jar|meta|dll|png|anim|unity|jpg|wav|prefab|fbx|asset|mp3|tga|psd|mat|atf|csproj|sln|svg|unity3d|mdb|dll|tiff|gif)$',
          \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
          \ }
    " }
" }
"--------------------------------------------------------------------------------
" GUI Settings {
"--------------------------------------------------------------------------------
    " Setup GUI {
        " GVIM- (here instead of .gvimrc)
        if has('gui_running')
            set guioptions-=T           " Remove the toolbar
            set lines=40                " 40 lines of text instead of 24
            if has("gui_gtk2")
                set guifont=Andale\ Mono\ Regular\ 16,Menlo\ Regular\ 15,Consolas\ Regular\ 16,Courier\ New\ Regular\ 18
            else
                set guifont=Andale\ Mono\ Regular:h16,Menlo\ Regular:h15,Consolas\ Regular:h16,Courier\ New\ Regular:h18
            endif
        else
            if &term == 'xterm' || &term == 'screen'
                set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
            endif
            "set term=builtin_ansi       " Make arrow and other keys work
        endif
    " }
" }
"--------------------------------------------------------------------------------
" Functions {
"--------------------------------------------------------------------------------
    " Strip whitespace {
    function! StripTrailingWhitespace()
        " To disable the stripping of whitespace, add the following to your
        " .vimrc.local file:
        "   let g:spf13_keep_trailing_whitespace = 1
        if !exists('g:spf13_keep_trailing_whitespace')
            " Preparation: save last search, and cursor position.
            let _s=@/
            let l = line(".")
            let c = col(".")
            " do the business:
            %s/\s\+$//e
            " clean up: restore previous search history, and cursor position
            let @/=_s
            call cursor(l, c)
        endif
    endfunction
    " }
    " Custom Compile {
    nmap <leader><CR> :call CustomCompileFile()<CR>
    "TODO: move these to file types
    function! CustomCompileFile()
        echom "file type ".&ft
      if( &ft == "php" )
        set makeprg=php\ \%
        mak
        ":!php %:p
      elseif( &ft == "xml" )
        set makeprg=xmllint\ \--noout\ \%
        mak
      elseif( &ft == "applescript" )
        set makeprg=osascript\ \%
        update %  
        make
      else
        set makeprg=bash\ %
        update %  
        make
        "set makeprg=exec\ \.expand('%:p')
        "make
        ":make
        " elseif( &ft == "sh" )
        "set makeprg=exec\ \%
        "make
        "execute '!'.expand('%:p')
      endif
    endfunc
    " }
" }

let EclimScalaSingleSearchResult="edit"

if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    let g:rally_start_dir     = "/code/RoboCopUnicorn"
    let g:pirate_bash_profile = "~/.bash_profile"
    let g:rally_startup_cmds  = "cd " . g:rally_start_dir . "; bash --rcfile " . g:pirate_bash_profile . ";"

    function! Pirate_rally_start()
        tabnew | call termopen('cd /code/RoboCopUnicorn && sbt apiContainer:start; bash',{"name":"rally/api"})
        vnew | call termopen('cd /code/RoboCopUnicorn && sbt surveyWeb/run;bash',{"name":"rally/surveyWeb"})
        new | call termopen("cd /code/RoboCopUnicorn && sbt 'project sortingHatWeb' 'start';bash",{"name":"rally/sortingHatWeb"})
        new | call termopen("cd /code/calvinball && sbt 'project calvinballWeb' 'start 6425';bash")
        wincmd l
        new | call termopen('cd /code/RoboCopUnicorn && sbt zenAdminWeb/run;bash',{"name":"rally/zenAdminWeb"})
        new | call termopen('cd /code/RoboCopUnicorn && sbt zenplay/run;bash',{"name":"rally/zenplay"})
        new | call termopen('cd /code/RoboCopUnicorn && sbt meatLockerWeb/run;bash',{"name":"rally/meatLockerWeb"})
        new | call termopen('cd /code/rewards && sbt plinko/run;bash',{"name":"rally/plinko"})
        silent !mkdir( $HOME . "/.cache/rally", "p")
        set sessionoptions-=tabpages
        mksession! ~/.cache/rally/launch.vim
        set sessionoptions+=tabpages
    endfunc

    function! Filter_buffname(bufnr)
        let bufname = bufname(a:bufnr)
        let buftype = getbufvar(a:bufnr, '&buftype')
        let is_term = buftype == 'terminal' 
        let is_rall = bufname =~# '.*rally\/.*$'
        "echo bufname . " is term: " .  is_term . " is rall: " . is_rall

        return buflisted(a:bufnr) 
                \ && buftype == 'terminal'
                \ && bufname =~# '.*rally\/.*$'
    endfunction
    function! Pirate_rally_split_test()
       let rallytermbuffs=filter(range(1, bufnr('$')), 'Filter_buffname(v:val)')
       execute ":buffer " . get(rallytermbuffs, 0)
       if len(rallytermbuffs) > 1
           execute ":vnew | buffer " . bufname( get(rallytermbuffs, 1) )
       endif
       if len(rallytermbuffs) > 2
           for bufnr in range( 2, len(rallytermbuffs) - 1 )
               echo bufname(bufnr)
           endfor
        endif
    endfunc
    function! Pirate_rally_start_test()
        tabnew | call termopen(g:rally_startup_cmds,{"name":"rally/api"})
        " right side
        vnew | call termopen(g:rally_startup_cmds,{"name":"rally/zenAdminWeb"})
        new | call termopen(g:rally_startup_cmds,{"name":"rally/zenplay"})
        "new | call termopen(g:rally_startup_cmds,{"name":"rally/meatLockerWeb"})
        wincmd h
        " left side
        new | call termopen(g:rally_startup_cmds,{"name":"rally/surveyWeb"})
        "new | call termopen(g:rally_startup_cmds,{"name":"rally/sortingHatWeb"})
    endfunc
endif
let g:table_mode_map_prefix = "<Leader><Leader>t"
"let g:unite_source_gtags_ref_option= 'r'
"let g:unite_source_gtags_def_option= ''
"let g:unite_source_gtags_result_option= 'ctags-x'
let g:syntastic_html_tidy_exec = "tidy5"
let g:syntastic_quiet_messages = { "level":"warnings" }
let g:syntastic_ignore_files = ['\m\c\.h$', '\m\.sbt$']
let g:EclimCompletionMethod = 'omnifunc'

if executable('ag')
    " Use ag in unite grep source.
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts =
                \ '-i --vimgrep --hidden --ignore ' .
                \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
    let g:unite_source_grep_recursive_opt = ''
endif


function! QfMakeConv()
    let qflist = getqflist()
    for item in qflist
        let item.bufnr = bufnr( item.bufnr,pathshorten(bufname(item.bufnr)))
    endfor
    call setqflist(qflist)
endfunction

highlight CursorLine  guibg=#3E3D32 ctermbg=235

   "hi CursorLine                    guibg=#293739
   "hi CursorLine                    guibg=#3E3D32
au QuickfixCmdPost make call QfMakeConv()

