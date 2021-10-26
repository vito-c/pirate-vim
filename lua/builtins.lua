------------------------------------------------------------
-- Neovim API aliases
------------------------------------------------------------
-- local map = vim.api.nvim_set_keymap  -- set global keymap
local cmd = vim.cmd     	    -- execute Vim commands
-- local exec = vim.api.nvim_exec 	-- execute Vimscript
local fn = vim.fn       		-- call Vim functions
-- local g = vim.g         	    -- global variables
local opt = vim.opt         	-- global/buffer/windows-scoped options
local M = {}
List = require 'pl.List'

local pretty = require 'pl.pretty'
local defaultpath='~/code/**'
-- when nvim is first opened we set the path to be the top levle code dir
vim.o.path = defaultpath
-- I am groot (git + root)
function M.groot_path()
    return M.groot_stub() .. '/**'
end

function M.groot_stub()
    local cpath = fn.expand('%:p:h')
    local pcmd = 'git -C ' .. cpath .. ' rev-parse --show-toplevel 2>&1'
    local handle = io.popen(pcmd)
    local groot = handle:read("*all"):gsub('\n', '')
    handle:close()
    if groot:match('fatal.*') then
        vim.o.path = defaultpath
        return defaultpath
    end
    return groot
end

function M.file_buffers()
    return List(fn.getbufinfo({buflisted = 1})):filter(
        function(x)
            return fn.getbufvar(x.bufnr, '&buftype', 'terminal') == ""
        end
    )
end

function M.term_buffers()
    return List(fn.getbufinfo({buflisted = 1})):filter(
        function(x)
            return fn.getbufvar(x.bufnr, '&buftype', 'terminal') == "terminal"
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
function M.reload(fname)
    for k in pairs(package.loaded) do
        if k:match("^" .. fname) then
            package.loaded[k] = nil
        end
    end
    require(fname)
end

-- Tip: to call a something on the global table use v:lua
-- call v:lua.builtins_path()
-- to set something on the global table use _G
cmd [[
    augroup builtins
        autocmd!
        autocmd BufWinEnter,WinEnter,TabEnter * lua vim.o.path=require('builtins').groot_path()
    augroup END
]]

function _G.groot_path()
    return M.groot_path()
end

function _G.groot()
    return M.groot_stub()
end

function M.test(str)
    print(str)
end

function M.openterminal(name, command)
    cmd('wall')
    cmd('wincmd s')
    cmd('wincmd T')
    cmd('terminal')
    cmd('file ' .. name)
    -- vim.o.channel
    -- vim.fn.chansend( 3, {'echo hi', ''})
    -- :lua vim.api.nvim_call_function('chansend', { 3, {'echo hi', ''}})
    fn.chansend(vim.o.channel, {command, ''})
end

function M.clearterm()
    opt.scrolloff=0
    opt.scrollback=1
    local tty=vim.api.nvim_get_chan_info(vim.o.channel)["pty"]
    fn.chansend(vim.o.channel, {"printf '\\e[2J' > " .. tty, ''})
    fn.chansend(vim.o.channel, {'clear -x', ''})
    vim.api.nvim_feedkeys("i", "n", true)
    vim.api.
    opt.scrolloff=0
    opt.scrollback=0
end

function M.jump_to_buffer(name)
    if fn.len(fn.win_findbuf(fn.bufnr(name))) ~= 0 then
        local tup = M.find_open_window(fn.bufnr(name))
        local t = tup[1]
        local w = tup[2]
        if t then
          M.jump_tab_win(t, w)
          return
        end
    end
end

function M.find_open_window(bnr)
    local tcur = fn.tabpagenr() - 1
    local tcnt = fn.tabpagenr('$')
    for i = 0, tcnt - 1 do
        local ts = (tcur + i) % tcnt + 1
        local bs = fn.tabpagebuflist(ts)
        for j, b in pairs(bs) do
            if b == bnr then
                return {ts, j}
            end
        end
    end
    return {0,0}
end

function M.jump_tab_win(t,w)
    fn.execute('normal! ' .. t .. 'gt')
    cmd(w .. ' wincmd w')
end

function M.opentestterm()
    cmd(":update")
    if fn.bufexists('test.term') == 1 then
        if fn.getbufvar(fn.bufnr('test.term'), '&buftype') == 'terminal' then
            if fn.len(fn.win_findbuf(fn.bufnr('test.term'))) == 0 then
                cmd('wall')
                if fn.winnr('$') ~= 1 then
                    cmd('wincmd s')
                    cmd('wincmd T')
                end
                cmd("buffer test.term")
            else
                M.jump_to_buffer('test.term')
            end
        else
            cmd("bw! test.term")
            M.openterminal('test.term','make unit-test')
        end
    else
        M.openterminal('test.term','make unit-test')
    end
end
-- " TODO: Move these to utility
-- function! rc#leaders#openterminal(name, cmd) " {{{
--     wincmd s
--     wincmd T
--     terminal
--     file sbt.term
--     call chansend(&channel, [a:cmd, ''])
-- endfunction " }}}


cmd [[
    command! -nargs=* -range Reload  lua require('builtins').reload(unpack({<f-args>}))
]]

return M
