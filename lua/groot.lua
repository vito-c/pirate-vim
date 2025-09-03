local defaultpath = '~/code/**'
local libpath = ',~/code/startup/opencv/**,~/code/startup/opencv_contrib/modules/**'
vim.o.path = defaultpath
local prev_groot = defaultpath

-- to set something on the global table use _G
-- I am groot (git + root)
function _G.groot()
    prev_groot = vim.o.path
    local cpath = vim.fn.expand('%:p:h')
    local pcmd = 'git -C ' .. cpath .. ' rev-parse --show-toplevel 2>&1'
    local handle = io.popen(pcmd)
    local groot_ = handle:read("*all"):gsub('\n', '')
    handle:close()
    if groot_:match('fatal.*') then
        vim.o.path = cpath
        return cpath
    end
    return groot_
end

function _G.groot_path()
    if vim.fn.getbufvar(vim.fn.bufnr('%'), '&buftype') == 'terminal' then
        return prev_groot
    else
        return _G.groot() .. '/**' .. libpath
    end
end
