-------------------------------------------------------------------------------
-- Neovim API aliases
-------------------------------------------------------------------------------
-- local cmd = vim.cmd     	    -- execute Vim commands
-- local exec = vim.api.nvim_exec 	-- execute Vimscript
-- local fn = vim.fn       		-- call Vim functions
local g = vim.g -- global variables

---@diagnostic disable-next-line: undefined-global
local tonumber = tonumber -- Silence linter while keeping it explicit
---@diagnostic disable-next-line: undefined-global
local table = table
---@diagnostic disable-next-line: undefined-global
local ipairs = ipairs
---@diagnostic disable-next-line: undefined-global
local math = math
---@diagnostic disable-next-line: undefined-global
local string = string

-- local opt = vim.opt         	-- global/buffer/windows-scoped options local function nmap(keys, command)
local function nmap(keys, command, opts)
    vim.keymap.set("n", keys, command, opts or {})
end
local function vmap(keys, command)
    vim.api.nvim_set_keymap('v', keys, command, { noremap = true })
end

function tmap(keys, command)
    vim.keymap.set('t', keys, command, { buffer = buf, silent = true })
end

-- Check the operating system
local is_mac = vim.fn.has("macunix") == 1
local is_linux = vim.fn.has("unix") == 1

-- Clipboard register based on OS
local clipboard_register = "*"
-- if is_mac then
--     clipboard_register = "*"
-- elseif is_linux then
--     clipboard_register = "+"
-- end

g.mapleader = ' '

-------------------------------------------------------------------------------
-- File 📁 actions
-------------------------------------------------------------------------------
nmap('<leader>w', ':<C-u>wa<CR>')
nmap(
    '<leader><leader>jt',
    ':<C-u>%!python -m json.tool<CR><Esc>:set filetype=json<CR>'
) -- %! jq '.'
nmap('<leader>ev', ':<C-u>execute "tabedit " . $MYVIMRC<CR>')
nmap('<leader>eb', ':<C-U>tabedit $CODE_CONFIGS/pirate-setup/bashrc<CR>')
nmap('<leader>eg', ':<C-U>tabedit $CODE_CONFIGS/pirate-setup/gitconfig<CR>')
nmap('<leader>ee', ':<C-U>e %<CR>')
-- to previous file
nmap('<leader>o', '<C-^>')

-------------------------------------------------------------------------------
-- Copy ✂️  Paste 📋 Actions
-------------------------------------------------------------------------------
-- To Clipboard
local cr = '"' .. clipboard_register
nmap('<leader>y', cr .. 'y')
nmap('<leader>Y', cr .. 'y$')
vmap('<leader>y', cr .. 'y')
vmap('<leader>Y', cr .. 'y$')
-- From Clipboard
nmap('<leader>p', cr .. 'p')
nmap('<leader>P', cr .. 'P')
vmap('<leader>p', cr .. 'p')
vmap('<leader>P', cr .. 'P')
-- last yanked
nmap('<leader>00', ':<C-u>echom "use leader 0p"<CR>')
vmap('<leader>00', ':<C-u>echom "use leader 0p"<CR>')
nmap('<leader>0p', '"0p')
nmap('<leader>0P', '"0P')
vmap('<leader>0p', '"0p')
vmap('<leader>0P', '"0P')

-------------------------------------------------------------------------------
-- 🌶️  TerminalLoading Mapping
-------------------------------------------------------------------------------
nmap(
    '<leader>to',
    require('builtins').test_only_file
)

-- nmap(
--     '<leader>tc',
--     function() require('builtins').test_create_file() end
-- )
-- nmap('<leader>tc',
--     function()
--         vim.fn.chansend(vim.o.channel, { 'c', '' })
--     end
-- )

nmap(
    '<leader>tf',
    function()
        require('builtins').test_function()
    end
)

-- "$:call chansend(&channel, ['testOnly '. expand('<cfile>'), ''])<CR>"
-- nmap('<leader>ta', "$:call chansend(&channel, ['pytest tests/unit', ''])<CR>")
--  \x1b\x5b\x41
-- nmap('<leader>tl', "$:call chansend(&channel, ['!!', ''])<CR>G")
nmap(
    '<leader>tt',
    function()
        require('builtins').open_test_term(nil, 'test.term')
    end
)
nmap(
    '<leader>tc',
    function()
        require('builtins').open_test_term(nil, 'claude.term')
    end
)
nmap(
    '<leader>tq',
    function()
        require('builtins').open_test_term(nil, 'codex.term')
    end
)
nmap(
    '<leader>ts',
    function()
        require('builtins').open_test_term()
        vim.fn.chansend(vim.o.channel, { 'pytest tests/unit', '' })
    end
)
nmap(
    '<leader>tl',
    function()
        require('builtins').open_test_term()
        vim.fn.chansend(vim.o.channel, { '!!', '' })
    end
)
nmap(
    '<leader>tr',
    function()
        local bwd = "/home/nexus/code/startup/videoblast/build"
        vim.api.nvim_echo({ { "➡️ Strating make", "QuickFixLine" } }, false, {})
        -- local make_job = vim.fn.jobstart('make -j test_blast', { cwd = bwd })
        -- Wait for make to complete
        local stderr_output = {} -- Store stderr output
        local progress = 0
        local filename = vim.fn.expand("%:t")

        local project = "video_blast"
        if filename == "main_test.cpp" then
            project = "test_blast"
        end
        -- change this to use cmake
        vim.fn.jobstart('make -j ' .. project, {
            cwd = bwd,
            stdout_buffered = false,
            stderr_buffered = true,
            on_stdout = function(_, data, _)
                if data then
                    for _, line in ipairs(data) do
                        -- Extract progress percentage using regex
                        local percent = line:match("%[ *(%d+)%%]") -- Ensure this pattern is correct

                        if percent then
                            progress = tonumber(percent)

                            -- Blingy progress bar
                            local progress_bar = (
                                string.rep("█", math.floor(progress / 5)) ..
                                string.rep("░", 20 - math.floor(progress / 5))
                            )
                            vim.schedule(function()
                                vim.api.nvim_echo({
                                    { "🛠️ Building: " .. progress .. "% " .. progress_bar, "QuickFixLine" }
                                }, false, {})
                            end)
                        end
                    end
                end
            end,
            on_stderr = function(_, data, _)
                if data then
                    for _, line in ipairs(data) do
                        if line and line ~= "" then
                            table.insert(stderr_output, line) -- Collect stderr lines
                        end
                    end
                end
            end,
            on_exit = function(_, exit_code, _)
                if exit_code ~= 0 then
                    print("❌ 💀 Build failed! Populating quickfix list...")

                    -- Convert collected stderr output into a single string for `errorformat`
                    local error_string = table.concat(stderr_output, "\n")

                    -- Use `cgetexpr` to feed errors into the quickfix list
                    vim.cmd("cgetexpr " .. vim.fn.string(vim.split(error_string, "\n")))

                    -- Open quickfix list if errors exist
                    vim.cmd("copen")
                    -- print("❌ LLDB encountered an error. Check quickfix.")
                    -- vim.fn.setqflist(errors, "r")
                    -- vim.cmd("copen")
                else
                    progress = 100
                    local progress_bar = (
                        string.rep("█", math.floor(progress / 5)) ..
                        string.rep("░", 20 - math.floor(progress / 5))
                    )
                    vim.schedule(function()
                        vim.api.nvim_echo({
                            { "🛠️ Building: " .. progress .. "% " .. progress_bar, "QuickFixLine" }
                        }, false, {})
                    end)
                    vim.schedule(function()
                        vim.api.nvim_echo({
                            { "✨ Make Completed ✨", "QuickFixLine" }
                        }, false, {})
                    end)
                    require('builtins').open_test_term()
                    -- vim.fn.chansend(vim.o.channel, { string.char(3), '' })
                    -- vim.fn.chansend(vim.o.channel, { '!!', '' })
                    vim.fn.chansend(vim.o.channel, { 'rf', '' })
                end
            end
        })

        -- vim.fn.chansend(vim.o.channel, { 'make -j test_blast', '' })
        -- local status = vim.fn.jobwait({ make_job })[1]
        -- print("make job completed")
        -- -- If make was successful, continue
        -- if status == 0 then
        -- else
        --     print("Make failed with status:", status)
        --     vim.fn.chansend(vim.o.channel, { '\x1A', '' })
        --     vim.fn.chansend(vim.o.channel, { 'make -j test_blast', '' })
        -- end
    end
)

vim.keymap.set(
    'n',
    '<leader>tk',
    function()
        -- Get the job ID of the current process
        require('builtins').open_test_term()
        local job_id = vim.b.terminal_job_id
        if not job_id then
            print('Error: No job running in the terminal')
            return
        end
        -- Send the Control-C signal to the job
        vim.fn.chansend(vim.o.channel, { string.char(3), '' })
    end,
    { noremap = true }
)

-- nmap(
--     '<leader>tg',
--     ":lua require('builtins').opentestterm(); vim.fn.chansend(vim.o.channel, {'make lint', ''})<CR>"
-- )
-- nmap(
--     '<leader>tm',
--     ":lua require('builtins').opentestterm(); vim.fn.chansend(vim.o.channel, {'make format mypy', ''})<CR>"
-- )
-- ":<C-U>call rc#leaders#opensbt()<Bar>call chansend(&channel, ['!!' , ''])<CR>G"
-- nmap(
--     '<leader>tsq',
--     ":<C-U>call rc#leaders#opensbt()<Bar>call chansend(&channel, ['testQuick' , ''])<CR>G"
-- )
