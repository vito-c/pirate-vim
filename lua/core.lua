------------------------------------------------------------
-- Neovim core configurations
------------------------------------------------------------

------------------------------------------------------------
-- Neovim API aliases
------------------------------------------------------------
local map = vim.api.nvim_set_keymap  -- set global keymap
local cmd = vim.cmd     	    -- execute Vim commands
local exec = vim.api.nvim_exec 	-- execute Vimscript
local fn = vim.fn       		-- call Vim functions
local g = vim.g         	    -- global variables
local opt = vim.opt         	-- global/buffer/windows-scoped options

------------------------------------------------------------
-- UI
------------------------------------------------------------
opt.termguicolors = true
opt.background = 'dark'
cmd('colorscheme one')
opt.showmode = true       -- Display the current mode
opt.cursorline = true     -- Highlight current line
opt.showmatch = false     -- Show matching brackets/parenthesis
opt.matchtime = 1         -- tenths of a second
opt.linespace = 0         -- No extra spaces between rows
opt.winminheight = 0      -- Windows can be 0 line high
opt.listchars = 'tab:▸\\ ,eol:¬,extends:❯,precedes:❮'


------------------------------------------------------------
-- Tabs, indent
------------------------------------------------------------
opt.expandtab = true      -- use spaces instead of tabs
opt.shiftwidth = 4        -- shift 4 spaces when tab
opt.tabstop = 4           -- 1 tab == 4 spaces
opt.smartindent = true    -- autoindent new lines
opt.softtabstop = 4
opt.smarttab = true
opt.autoindent = true
opt.backspace = 'indent,eol,start'  -- Backspace for dummies

------------------------------------------------------------
-- Numbering
------------------------------------------------------------
opt.number = true
opt.relativenumber = true

------------------------------------------------------------
-- Scrolling, folding
------------------------------------------------------------
opt.scrolloff = 999       -- Minimum lines to keep above and below cursor
opt.foldenable = true
opt.viewoptions = 'folds,options,cursor,unix,slash' -- Better Unix / Windows compatibility
opt.wrap = false

------------------------------------------------------------
-- Searching
------------------------------------------------------------
opt.ignorecase = true     -- Case insensitive search
opt.smartcase  = true     -- Case sensitive when uc present
opt.incsearch = true      -- Find as you type search
opt.hlsearch = true       -- Highlight search terms

------------------------------------------------------------
-- Reading and Writing
------------------------------------------------------------
opt.autoread = true
opt.autowrite = true
opt.swapfile = false
opt.backup = false
cmd('filetype plugin indent on')

------------------------------------------------------------
-- Wild Menu
------------------------------------------------------------
opt.wildmenu = true               -- Show list instead of just completing
opt.wildignore = '*.class,*/target/*'
opt.wildmode = 'list:longest,full'  -- list matches, then longest common part, then all.
opt.whichwrap = 'h,l,<,>,[,],b,s,~'

------------------------------------------------------------
-- Memory, CPU
------------------------------------------------------------
opt.hidden = true         -- enable background buffers
opt.history = 800         -- remember n lines in history
opt.lazyredraw = true     -- faster scrolling
opt.synmaxcol = 240       -- max column for syntax highlight
opt.tabpagemax=15         -- Only show 15 tabs

------------------------------------------------------------
-- Abbreviations
-- TODO move this to another file/use abolish
------------------------------------------------------------
cmd('iabbrev teh the')
cmd('iabbrev chomd chmod')
cmd('iabbrev ehco echo')
cmd('iabbrev pritnln println')
cmd('cabbrev ehco echo')
cmd("iabbrev <expr> dtl strftime('%c')")
cmd("iabbrev <expr> dts strftime('%m/%d/%Y')")
cmd("iabbrev <expr> cdf expand('%')")
cmd("iabbrev <expr> cdp expand('%:p')")
cmd("iabbrev <expr> jpac 'package ' . substitute( join(split(expand('%:h'),'/'),'.'),'\\v^\\.+','','g') . \";\\r\"")

------------------------------------------------------------
-- Docker setup stuff
------------------------------------------------------------
-- let s:uname = system("echo -n \"$(uname)\"")
-- if !v:shell_error && s:uname == "Linux"
--     let &shell='/usr/bin/bash'
--     command! -nargs=0 SetupCoc call SetupCoc()
--     function! SetupCoc()
--         CocInstall -sync coc-metals
--     endfunction
--
-- endif
-- highlight on yank
exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=300}
  augroup end
]], false)
