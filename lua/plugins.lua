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
-- cmd("Plug 'vim-airline/vim-airline-themes'")
cmd("Plug 'joshdick/onedark.vim'")
cmd("Plug 'kyazdani42/nvim-web-devicons'")
-- cmd("Plug 'kdheepak/tabline.nvim'")
cmd("Plug 'hoob3rt/lualine.nvim'")
cmd("Plug 'alvarosevilla95/luatab.nvim'")

------------------------------------------------------------
-- Editing Plugins
------------------------------------------------------------
cmd("Plug 'tomtom/tcomment_vim'")

cmd('call plug#end()')

vim.o.tabline = '%!v:lua.require\'luatab\'.tabline()'
require('lualine').setup {
  options = {theme = 'onedark'},
  extensions = {'fzf', 'nvim-tree', 'fugitive'}
}
