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

local trees = require("nvim-treesitter")
local pretty = require 'pl.pretty'
local defaultpath='~/code/**'
-- when nvim is first opened we set the path to be the top levle code dir
vim.o.path = defaultpath
local prev_groot = defaultpath
-- I am groot (git + root)
function M.groot_path()
    if fn.getbufvar(fn.bufnr('%'), '&buftype') == 'terminal' then
        return prev_groot
    else
        return M.groot_stub() .. '/**'
    end
end

function M.groot_stub()
    prev_groot = vim.o.path
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

function M.get_file()
    -- bufnr() gives you the current buffer number
    if fn.getbufvar(fn.bufnr(), '&buftype') == 'terminal' then
        return vim.fn.expand('<cfile>')
    else
        return vim.fn.expand('%')
    end
end

function M.test_only_file()
    local file = M.get_file()
    M.opentestterm(M.test(file))
end

function M.test_function()
    local funky = trees.statusline()
    local file = M.get_file()
    local fcmd = 'pytest ' .. file .. '::' .. string.gsub(funky, "def ([^(]*).*", "%1")

    M.opentestterm(fcmd)
end

function M.test(file)
    if vim.o.filetype == "python" or string.find(file, ".py") then
        return 'mypy ' ..
                    '--strict ' ..
                    '--follow-imports=silent ' ..
                    '--implicit-reexport ' .. file .. ' && ' ..
                'pytest ' .. file
    end
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
function _G.groot()
    return M.groot_stub()
end

function M.openterminal(name, command)
    cmd('wall')
    cmd('wincmd s')
    cmd('wincmd T')
    cmd('terminal')
    cmd('file ' .. name)
    if command then
        fn.chansend(vim.o.channel, {command, ''})
    end
end

function M.clearterm()
    opt.scrolloff=0
    opt.scrollback=1
    vim.opt.scrollback=1
    vim.o.scrollback=1
    -- keeping console clearing via command codes for reference:
    -- local tty=vim.api.nvim_get_chan_info(vim.o.channel)["pty"]
    -- fn.chansend(vim.o.channel, {" printf '\\e[2J' > " .. tty, ''})
    fn.chansend(vim.o.channel, {' clear -x', ''})
    vim.defer_fn(function()
        opt.scrolloff=0
        opt.scrollback=0
        vim.api.nvim_feedkeys("i", "n", true)
    end, 300)
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

function M.opentestterm(command)
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
                if command then
                    fn.chansend(vim.o.channel, {command, ''})
                end
            else
                M.jump_to_buffer('test.term')
                if command then
                    fn.chansend(vim.o.channel, {command, ''})
                end
            end
        else
            cmd("bw! test.term")
            M.openterminal('test.term', command)
        end
    else
        M.openterminal('test.term', command)
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
    -- function! CustomgF()
    --     " are we in a terminal window?
    --     if win_getid()->getwininfo()->get(0, {})->get('terminal', 0)
    --
    --         " if we are, find a suitable line number on this line
    --         let line = getline('.')->matchstr(', line \zs\d\+')
    --
    --         if line
    --             " if we have one, do regular gF, which won't jump
    --             " to the desired line anyway because Vim can't parse
    --             " tracebacks properly
    --             normal! gF
    --
    --             " but we don't care because we can jump
    --             " to the found line on our own
    --             execute line
    --         else
    --             " if we don't, do regular gF
    --             normal! gF
    --         endif
    --     else
    --         " if we aren't, do regular gF
    --         normal! gF
    --     endif
    -- endfunction
    -- nnoremap gF <Cmd>call CustomgF()<CR>

return M
