------------------------------------------------------------
-- Neovim API aliases
------------------------------------------------------------
-- local map = vim.api.nvim_set_keymap  -- set global keymap
-- local cmd = vim.cmd     	    -- execute Vim commands
-- local exec = vim.api.nvim_exec 	-- execute Vimscript
-- local fn = vim.fn       		-- call Vim functions
-- local g = vim.g         	    -- global variables
-- local opt = vim.opt         	-- global/buffer/windows-scoped options
local M = {}
List = require 'pl.List'

local pretty = require 'pl.pretty'
local defaultpath='~/code/**'
-- when nvim is first opened we set the path to be the top levle code dir
vim.o.path = defaultpath
-- I am groot (git + root)
function M.groot_path()
    local cpath = vim.fn.expand('%:p:h')
    local pcmd = 'git -C ' .. cpath .. ' rev-parse --show-toplevel 2>&1'
    local handle = io.popen(pcmd)
    local groot = handle:read("*all"):gsub('\n', '')
    handle:close()
    if groot:match('fatal.*') then
        vim.o.path = defaultpath
        return defaultpath
    end
    return groot .. '/**'
end

function M.file_buffers()
    return List(vim.fn.getbufinfo({buflisted = 1})):filter(
        function(x)
            return vim.fn.getbufvar(x.bufnr, '&buftype', 'terminal') == ""
        end
    )
end

function M.term_buffers()
    return List(vim.fn.getbufinfo({buflisted = 1})):filter(
        function(x)
            return vim.fn.getbufvar(x.bufnr, '&buftype', 'terminal') == "terminal"
        end
    )
end

-- function M.include_expr(fname)
-- end

function M.dumpbt()
    pretty.dump(M.term_buffers())
end
function M.dumpbf()
    pretty.dump(M.builtins_file_buffers())
end

-- Tip: to call a something on the global table use v:lua
-- call v:lua.builtins_path()
-- to set something on the global table use _G
vim.cmd [[
    augroup builtins
        autocmd!
        autocmd BufWinEnter,WinEnter,TabEnter * lua vim.o.path=groot
    augroup END
]]
_G.groot=M.groot_path()
return M
