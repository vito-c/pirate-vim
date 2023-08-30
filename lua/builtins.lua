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

local ts = require("nvim-treesitter")
local pretty = require 'pl.pretty'
local plenary = require("plenary")
local Path = require "plenary.path"
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
        vim.o.path = cpath
        return cpath
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
    M.open_test_term(M.test(file))
end

function M.test_function()
    local funky = ts.statusline()
    local file = M.get_file()
    local fcmd = 'pytest ' .. file .. '::' .. string.gsub(funky, "def ([^(]*).*", "%1")

    M.open_test_term(fcmd)
end

function M.test(file)
    if vim.o.filetype == "python" or string.find(file, ".py") then
        return 'mypy ' ..
                    '--strict ' ..
                    '--follow-imports=silent ' ..
                    '--implicit-reexport ' .. file .. ' && ' ..
                'pytest ' .. file
    end
    if vim.o.filetype == "scala" or string.find(file, ".scala") then
        local package = M.package_name(vim.fn.bufnr('%'))
        local class_name = M.get_class_name(vim.fn.bufnr('%'))
        return 'testOnly ' .. package .. '.' .. class_name
        -- local pkg_node = vim.treesitter.get_node("(class_definition)")
        -- local package = vim.treesitter.get_node_text(pkg_node, 0)
        -- test_class = ""
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

function M.open_term(name, command)
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

function M.test_create_file()
    local file = vim.fn.expand('%:p')
    local file_path = vim.fn.expand('%:h')

    local test_path = file_path:gsub("src/main", "src/test", 1)
    local test_file = file:gsub("%.scala", "Spec.scala", 1):gsub("src/main", "src/test", 1)

    test_path = Path:new(test_path)

    if not test_path:exists() then
        test_path:mkdir { parents = true }
    end
    if not Path:new(test_file):exists() then
        -- local new_file = io.open(test_file)
        -- local parser = require('nvim-treesitter.parsers').get_parser(0, 'scala')  -- Assuming buffer number is 0
        -- local query = vim.treesitter.query.parse("scala", "((package_identifier) @package)")
        local package = M.package_name(vim.fn.bufnr('%'))
        vim.api.nvim_command("edit " .. test_file)
        vim.api.nvim_buf_set_lines(0, 0, 1, true, {package})
        -- if new_file then

            -- if package then
            --     new_file:write(package)
            -- end
            -- new_file:close()
        -- else
        --     print("Error creating file: " .. test_file)
        -- end
    else
        vim.api.nvim_command("edit " .. test_file)
    end
end

function M.find_open_window(bnr)
    local tcur = fn.tabpagenr() - 1
    local tcnt = fn.tabpagenr('$')
    for i = 0, tcnt - 1 do
        local tabs = (tcur + i) % tcnt + 1
        local bs = fn.tabpagebuflist(tabs)
        for j, b in pairs(bs) do
            if b == bnr then
                return {tabs, j}
            end
        end
    end
    return {0,0}
end

function M.jump_tab_win(t,w)
    fn.execute('normal! ' .. t .. 'gt')
    cmd(w .. ' wincmd w')
end

function M.open_test_term(command)
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
            M.open_term('test.term', command)
        end
    else
        M.open_term('test.term', command)
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

function M.print_scala_types()
    -- Create a new buffer
    local new_buffer = vim.api.nvim_create_buf(false, true)

    -- Evaluate the vim.inspect function
    local tree_sitter_output = vim.inspect(vim.treesitter.language.inspect("scala"))

    -- Set the captured output as the contents of the new buffer
    vim.api.nvim_buf_set_lines(new_buffer, 0, -1, true, vim.fn.split(tree_sitter_output, "\n"))
    vim.api.nvim_command("tabnew | b" .. new_buffer)
end

function M.get_class_name(bufnr)
    local ps = vim.treesitter.get_parser(bufnr, 'scala');
    local tree = ps:parse()
    local q = vim.treesitter.query.parse('scala', '(class_definition name: (identifier) @class_definition)')
    local root = tree[1]:root()
    for _, captures, _ in q:iter_matches(root, 1) do
        return vim.treesitter.get_node_text(captures[1],bufnr)
    end
end
function M.package_name(bufnr)
    local ps = vim.treesitter.get_parser(bufnr, 'scala');
    local tree = ps:parse()
    local q = vim.treesitter.query.parse('scala', '(package_clause name: (package_identifier) @package_identifier)')
    local root = tree[1]:root()
    for _, captures, _ in q:iter_matches(root, 1) do
        return vim.treesitter.get_node_text(captures[1],bufnr)
    end
end
return M
