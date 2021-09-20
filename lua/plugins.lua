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
cmd("Plug 'joshdick/onedark.vim'")
cmd("Plug 'kyazdani42/nvim-web-devicons'")
cmd("Plug 'hoob3rt/lualine.nvim'")
cmd("Plug 'alvarosevilla95/luatab.nvim'")
cmd("Plug 'mhinz/vim-startify'")

------------------------------------------------------------
-- Editing Plugins
------------------------------------------------------------
cmd("Plug 'tomtom/tcomment_vim'")
cmd("Plug 'tpope/vim-repeat'")
cmd("Plug 'tpope/vim-repeat'")
cmd("Plug 'tpope/vim-surround'")
cmd("Plug 'AndrewRadev/splitjoin.vim'")
cmd("Plug 'tommcdo/vim-exchange'")
cmd("Plug 'godlygeek/tabular'")
cmd("Plug 'tpope/vim-abolish'")

------------------------------------------------------------
-- Syntax Plugins
------------------------------------------------------------
cmd("Plug '~/code/personal/jq.vim'")
cmd("Plug 'jtratner/vim-flavored-markdown'")
cmd("Plug 'vito-c/applescript.vim'")

------------------------------------------------------------
-- Git Plugins
------------------------------------------------------------
cmd("Plug 'tpope/vim-rhubarb'")
cmd("Plug 'tpope/vim-fugitive'")

------------------------------------------------------------
-- Text Navigation Plugins
------------------------------------------------------------
cmd("Plug 'tpope/vim-unimpaired'")

------------------------------------------------------------
-- File Navigation Plugins
------------------------------------------------------------
cmd("Plug 'tpope/vim-vinegar'")
cmd("Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }")
cmd("Plug 'junegunn/fzf.vim'")
cmd("Plug 'pbogut/fzf-mru.vim'")

------------------------------------------------------------
-- Misc Plugins
------------------------------------------------------------
cmd("Plug 'tpope/vim-obsession'")

------------------------------------------------------------
-- LSP Plugins
------------------------------------------------------------
cmd("Plug 'neovim/nvim-lspconfig'")

cmd('call plug#end()')



vim.o.tabline = '%!v:lua.require\'luatab\'.tabline()'
require('lualine').setup {
  options = {theme = 'onedark'},
  extensions = { 'fzf', 'nvim-tree', 'fugitive' }
}
