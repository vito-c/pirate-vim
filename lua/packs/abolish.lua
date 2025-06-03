------------------------------------------------------------
-- Neovim API aliases
------------------------------------------------------------
-- local map = vim.api.nvim_set_keymap  -- set global keymap
local cmd = vim.cmd     	    -- execute Vim commands
local exec = vim.api.nvim_exec 	-- execute Vimscript
-- local fn = vim.fn       		-- call Vim functions
-- local g = vim.g         	    -- global variables
local opt = vim.opt         	-- global/buffer/windows-scoped options

------------------------------------------------------------
-- Abolish aliases
------------------------------------------------------------
cmd('Abolish teh the')
cmd('Abolish chomd chmod')
cmd('Abolish ehco echo')
cmd('Abolish pritnln println')
cmd('Abolish pritn print')
