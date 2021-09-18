------------------------------------------------------------
-- Neovim plugin configurations
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

cmd("call plug#begin('~/.vim/bundle')")
------------------------------------------------------------
-- GUI Plugins
------------------------------------------------------------
cmd("Plug 'vito-c/vim-one'")
cmd("Plug 'vim-airline/vim-airline-themes'")
cmd("Plug 'joshdick/onedark.vim'")
cmd("Plug 'bling/vim-airline'")
require('plugins/airline')

cmd('call plug#end()')
