------------------------------------------------------------
-- Neovim API aliases
------------------------------------------------------------
local map = vim.api.nvim_set_keymap  -- set global keymap
local cmd = vim.cmd     	    -- execute Vim commands
local exec = vim.api.nvim_exec 	-- execute Vimscript
local fn = vim.fn       		-- call Vim functions
local g = vim.g         	    -- global variables
local opt = vim.opt         	-- global/buffer/windows-scoped options
List = require 'pl.List'
pretty = require 'pl.pretty'

local defaultpath='~/code/**'
vim.o.path = defaultpath
function builtins_path()
    local cpath = vim.fn.expand('%:p:h')
    local pcmd = 'git -C ' .. cpath .. ' rev-parse --show-toplevel 2>&1'
    local handle = io.popen(pcmd)
    local groot = handle:read("*all"):gsub('\n', '')
    handle:close()
    if groot:match('fatal.*') then
        vim.o.path = defaultpath
        return defaultpath
    end
    vim.o.path = groot
    return groot .. '/**'
end

function builtins_file_buffers()
    return List(vim.fn.getbufinfo({buflisted = 1})):filter(
        function(x)
            return 
                vim.fn.getbufvar(x.bufnr, '&buftype', 'terminal') == ""
        end
    )
end    

function builtins_term_buffers()
    return List(vim.fn.getbufinfo({buflisted = 1})):filter(
        function(x)
            return 
                vim.fn.getbufvar(x.bufnr, '&buftype', 'terminal') == "terminal"
        end
    )
end    

function builtins_include_expr(fname)
    
end

function dumpbt()
    pretty.dump(builtins_term_buffers())
end
function dumpbf()
    pretty.dump(builtins_file_buffers())
end

vim.cmd [[
    augroup builtins
        autocmd!
        autocmd BufWinEnter,WinEnter,TabEnter * call v:lua.builtins_path()
    augroup END
]]
