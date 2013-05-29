"--------------------------------------------------------------------------------
" Information {
"--------------------------------------------------------------------------------
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldmethod=marker :
" 
" By: Vito C.
"                       .ed'''' '''$$$$be.                     
"                     -'           ^''**$$$e.                  
"                   .'                   '$$$c                 
"                  /                      '4$$b                
"                 d  3                     $$$$                
"                 $  *                   .$$$$$$               
"                .$  ^c           $$$$$e$$$$$$$$.              
"                d$L  4.         4$$$$$$$$$$$$$$b              
"                $$$$b ^ceeeee.  4$$ECL.F*$$$$$$$              
"    e$''=.      $$$$P d$$$$F $ $$$$$$$$$- $$$$$$              
"   z$$b. ^c     3$$$F '$$$$b   $'$$$$$$$  $$$$*'      .=''$c  
"  4$$$$L   \     $$P'  '$$b   .$ $$$$$...e$$        .=  e$$$. 
"  ^*$$$$$c  %..   *c    ..    $$ 3$$$$$$$$$$eF     zP  d$$$$$ 
"    '**$$$ec   '\   %ce''    $$$  $$$$$$$$$$*    .r' =$$$$P'' 
"          '*$b.  'c  *$e.    *** d$$$$$'L$$    .d'  e$$***'   
"            ^*$$c ^$c $$$      4J$$$$$% $$$ .e*'.eeP'         
"               '$$$$$$''$=e....$*$$**$cz$$' '..d$*'           
"                 '*$$$  *=%4.$ L L$ P3$$$F $$$P'              
"                    '$   '%*ebJLzb$e$$$$$b $P'                
"                      %..      4$$$$$$$$$$ '                  
"                       $$$e   z$$$$$$$$$$%                    
"                        '*$c  '$$$$$$$P'                      
"                         .'''*$$$$$$$$bc                      
"                      .-'    .$***$$$'''*e.                   
"                   .-'    .e$'     '*$c  ^*b.                 
"            .=*''''    .e$*'          '*bc  '*$e..            
"          .$'        .z*'               ^*$e.   '*****e.      
"          $$ee$c   .d'                     '*$.        3.     
"          ^*$E')$..$'                         *   .ee==d%     
"             $.d$$$*                           *  J$$$e*      
"              '''''                             '$$$'   
" }
"--------------------------------------------------------------------------------
" Environment {
"--------------------------------------------------------------------------------
    " Basics {
        set nocompatible        " Must be first line
    " }
    " Windows Compatible {
        " On Windows, also use '.vim' instead of 'vimfiles'; this makes 
	" synchronization across (heterogeneous) systems easier.
        if has('win32') || has('win64')
          set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }
    " Setup Bundle Support {
        " The next three lines ensure that the ~/.vim/bundle/ system works
        filetype on
        filetype off
        set rtp+=~/.vim/bundle/vundle
        call vundle#rc()
    " }
	" Bundles {
	    " Use bundles config {
		if filereadable(expand("~/.vimrc.bundles"))
		    source ~/.vimrc.bundles
		endif
	    " }
	" }
" }
"--------------------------------------------------------------------------------
"Experimential {
"--------------------------------------------------------------------------------
	" Fix indenting of html files
	autocmd FileType html setlocal indentkeys-=*<Return>
	autocmd FileType cs setlocal efm=%*\\s%f\(%l\\,%c\):\ error\ CS%n:\ %m
" }
"--------------------------------------------------------------------------------
" General { 
"--------------------------------------------------------------------------------
    " Status Line {
    "   if has('statusline')
    "       set laststatus=2
    "       " Broken down into easily includeable segments
    "       set statusline=%<%f\                     " Filename
    "       set statusline+=%w%h%m%r                 " Options
    "       set statusline+=%{fugitive#statusline()} " Git Hotness
    "       "set statusline+=\ [%{&ff}/%Y]            " Filetype
    "       "set statusline+=\ [%{getcwd()}]          " Current dir
    "       set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    "   endif
    " }
    " Status Line {
        let g:last_mode = ''
        function! ModePrefix()
          let l:mode = mode()
          if l:mode !=# g:last_mode
            let g:last_mode = l:mode

            " default
            hi User1 guifg=#ffffff guibg=#1c1c1c ctermfg=255 ctermbg=233
            " mode
            hi User2 guifg=#005f00 guibg=#dfff00 gui=bold ctermfg=22 ctermbg=190 term=bold
            " mode seperator
            hi User3 guifg=#dfff00 guibg=#444444 ctermfg=190 ctermbg=238
            " info
            hi User4 guifg=#ffffff guibg=#444444 ctermfg=255 ctermbg=238
            " info seperator
            hi User5 guifg=#444444 guibg=#1c1c1c ctermfg=238 ctermbg=233
            " file info
            hi User9 guifg=#ff0000 guibg=#1c1c1c ctermfg=160 ctermbg=233

            if l:mode ==# "i"
              hi User1 guifg=#00ffff ctermfg=14
              hi User2 guibg=#00dfff guifg=#00005f ctermbg=45 ctermfg=17
              hi User3 guibg=#005fff guifg=#00dfff ctermbg=27 ctermfg=45
              hi User4 guibg=#005fff ctermbg=27
              hi User5 guifg=#005fff ctermfg=27
            elseif l:mode ==? "v" || l:mode ==# ""
              hi User2 guibg=#ffaf00 guifg=#000000 ctermbg=214 ctermfg=0
              hi User3 guifg=#ffaf00 guibg=#ff5f00 ctermfg=214 ctermbg=202
              hi User4 guibg=#ff5f00 guifg=#000000 ctermbg=202 ctermfg=0
              hi User5 guifg=#ff5f00 ctermfg=202
            endif
          endif

          if l:mode ==# "n"
            return "  NORMAL "
          elseif l:mode ==# "i"
            return "  INSERT "
          elseif l:mode ==# "R"
            return "  RPLACE "
          elseif l:mode ==# "c"
            return "  COMAND "
          elseif l:mode ==# "v"
            return "  VISUAL "
          elseif l:mode ==# "V"
            return "  V·LINE "
          elseif l:mode ==# ""
            return "  V·BLCK "
          else
            return l:mode
          endif
        endfunction
        set laststatus=2
        
        set statusline=%2*%{ModePrefix()}%3*▶%4*
        set statusline+=%{exists('g:loaded_fugitive')&&strlen(fugitive#statusline())>0?'\ ':''}
        set statusline+=%{exists('g:loaded_fugitive')?matchstr(fugitive#statusline(),'(\\zs.*\\ze)'):''}
        set statusline+=%{exists('g:loaded_fugitive')&&strlen(fugitive#statusline())>0?'\ \ ':'\ '}
        set statusline+=%5*▶\ %1*%f\ %<
        set statusline+=%9*%{&ro?'RO':''}%{&mod?'+':''}
        set statusline+=%#warningmsg#
        set statusline+=%{exists('g:loaded_syntastic_plugin')?SyntasticStatuslineFlag():''}
        set statusline+=%1*%=%{strlen(&filetype)>0?&filetype.'\ ':''}%5*◀%4*\ 
        set statusline+=%{strlen(&fileencoding)>0?&fileencoding:''}
        set statusline+=%{strlen(&fileformat)>0?'['.&fileformat.']':''}
        set statusline+=\ %3*◀
        set statusline+=%2*\ %3p%%\ ◇\ %3l:%3c\ 
    " }
    " Abbrevs {
        iabbrev teh the
        iabbrev ehco echo
        cabbrev ehco echo
    " }
    "Setup Shell {
	" seems to break vimdiff sometimes
        " custom shell options
        "set shell=/usr/local/bin/bash\ --rcfile\ ~/.pirate-vim/vim-bashrc\ -i
    " }
    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " Syntax highlighting
    "set mouse=a                 " Automatically enable mouse usage
    "set mousehide               " Hide the mouse cursor while typing
    scriptencoding utf-8
    " Auto Commands {
		if has("autocmd")
			" Source the vimrc file after saving it
			autocmd bufwritepost .vimrc source $MYVIMRC
			autocmd bufwritepost vimrc sourc $MYVIMRC
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
    " Setup Paths{
        set path=~/workrepos/vito-funtime/**/src/**
        "set path+=~/workrepos/farmville2-main/Client/**/src/**
        "set path+=~/workrepos/farmville2-main/shared/**
        set path+=~/workrepos/farm-mobile/**
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
        if(&nu == 1)
            set relativenumber
        else
            set number
        endif
    endfunc

    function! NumberOff()
        if(&nu == 1)
            set nonu
        elseif(&rnu)
            set nornu
        endif
    endfunc
"}
"--------------------------------------------------------------------------------
" Vim UI {
"--------------------------------------------------------------------------------
    "set background=dark         " Assume a dark background
    "color molokai                    " Load a colorscheme
    color default
    set background=light
    "color default "Load a colorscheme
    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode
    set cursorline                  " Highlight current line
    " Setup Clipboard {
        if has ('x') && has ('gui') " On Linux use + register for copy-paste
            set clipboard=unnamedplus
        elseif has ('gui')          " On mac and Windows, use * register for copy-paste
            set clipboard=unnamed
        elseif has('x11')
            set clipboard=unnamedplus
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
        set showmatch                   " Show matching brackets/parenthesis
        set incsearch                   " Find as you type search
        set hlsearch                    " Highlight search terms
        set winminheight=0              " Windows can be 0 line high
        set ignorecase                  " Case insensitive search
        set smartcase                   " Case sensitive when uc present
        set wildmenu                    " Show list instead of just completing
        set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
        set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
        "set scrolljump=5                " Lines to scroll when cursor leaves screen
        set scrolloff=999                 " Minimum lines to keep above and below cursor
        set foldenable                  " Auto fold code
        "set listchars=tab:,.,trail:.,extends:#,nbsp:. " Highlight problematic whitespace
        set listchars=tab:▸\ ,eol:¬
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
    autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
" }
"--------------------------------------------------------------------------------
" Key (re)Mappings {
"--------------------------------------------------------------------------------
    let mapleader = ' '
	
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
        "nmap <silent> <leader>o :call ToggleList("Location List", 'l')<CR>
        nmap <silent> <leader>o :call ToggleList("Quickfix List", 'c')<CR>
    " }
    " Number toggles {
        nnoremap <leader>no :call NumberOff()<CR>
        nnoremap <leader>nn :call NumberToggle()<CR>
        nnoremap <leader>nr :set relativenumber<CR>
        nnoremap <leader>nu :set number<CR>
    " }
    " Marks {
        " Set marks correctly
        noremap ' `
        noremap ` '
        noremap g' g`
        noremap g` g'
    " }
    " Instert mode maps {
        inoremap <C-E> <ESC>A
        inoremap <C-B> <ESC>I
        "inoremap <C-;> <ESC>mcA;<ESC>`ca
    " }
    " Command mode maps {
        " Change Working Directory to that of the current file
        cmap cwd lcd %:p:h
        " For when you forget to sudo.. Really Write the file.
        cmap w!! w !sudo tee % >/dev/null
    " }
    " Windows/Tabs {
        " Easier moving in tabs and windows
        " The lines conflict with the default digraph mapping of <C-K>
        " If you prefer that functionality, add let g:spf13_no_easyWindows = 1
        " in your .vimrc.bundles.local file
        map <C-J> <C-W>j
        map <C-K> <C-W>k
        map <C-L> <C-W>l
        map <C-H> <C-W>h
        map <leader>w= <C-W>=
        map <leader>w+ <C-W>+
        map <leader>w_ <C-W>_
        map <leader>w- <C-W>-
        map <leader>wc <C-W>c
        map <leader>wo <C-W>o
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
        "nmap gV `[v`]
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
    " Path Editing {
        map <leader>nw :<C-U>e %%<CR>
        map <leader>ns :<C-U>sp %%<CR>
        map <leader>nv :<C-U>vsp %%<CR>
    " }
    " File Editing {
        " Some helpers to edit mode
        " http://vimcasts.org/e/14
        cnoremap %% <C-R>=expand('%:h').'/'<cr>
        map <leader>ef :<C-U>find
        map <leader>ew :<C-U>e %%
        map <leader>es :<C-U>sp %%
        map <leader>ev :<C-U>vsp %%
        map <leader>et :<C-U>tabe %%
        map <leader>v :<C-U>tabedit $MYVIMRC<CR>
    " }
    " Better */# Search {
        vnoremap <silent> * :<C-U>
                    \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
                    \gvy/<C-R><C-R>=substitute(
                    \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
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
				cs add /Users/$USER/workrepos/farm-mobile/.git/cscope.out
			endif
            " show msg when any other cscope db added
            set cscopeverbose  
            set cscopequickfix=s-,c-,d-,i-,t-,e-,g-
            " search tag files first
            set csto=1
            nmap <leader>fs :execute 'cs find s <C-R>=expand("<cword>")<CR>' <Bar> copen <Bar> wincmd J <CR>
        endif
    " }
    " Buffalo {
        let buffalo_autoaccept=1
    " }
    " PIV {
        let g:DisableAutoPHPFolding = 0
        let g:PIVAutoClose = 0
    " }
    " Misc {
        let b:match_ignorecase = 1
    " }
	" Gist {
		let g:gist_detect_filetype = 1
		let g:gist_open_browser_after_post = 1
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
    " ctrlp {
        let g:ctrlp_working_path_mode = 2
        nnoremap <silent> <D-t> :CtrlP<CR>
        nnoremap <silent> <D-r> :CtrlPMRU<CR>
		set wildignore+=*/tmp/*,*.anim,*.mat,*.unity,*.mdpolicy,*.userprefs,*.so,*.swp,*.exe,*.pidb,*.csproj,*.zip,*.fbx,*.meta,*.prefab,*.png,*.jpg,*~
		let g:ctrlp_custom_ignore = {
		  \ 'dir':  '\v[\/]\.(git|hg|nouveau|Library|Temp|svn|neocon|vimswap|vimundo|vimgolf)$',
		  \ 'file': '\v\.(exe|csproj|anim|mat|unity|pidb|so|dll|meta|mdpolicy|userprefs|swp|fbx|zip|prefab|sln|jpg|png)$'
		  \ }
    "}
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
        nnoremap <silent> <leader>gd :Gdiff<CR>
        nnoremap <silent> <leader>gc :Gcommit<CR>
        nnoremap <silent> <leader>gb :Gblame<CR>
        nnoremap <silent> <leader>gl :Glog<CR>
        nnoremap <silent> <leader>gp :Git push<CR>
    "}
    " Gundo {
		nnoremap <Leader>u :GundoToggle<CR>
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
" }
