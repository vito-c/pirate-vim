local cmd = vim.cmd     	    -- execute Vim commands
local M = {}
cmd [[
    augroup builtins
        autocmd!
        autocmd BufEnter,BufWinEnter,WinEnter,TabEnter * lua if require('builtins') and require('builtins').groot_path() then vim.o.path=require('builtins').groot_path() end
    augroup END
]]
cmd [[
    augroup git
        autocmd!
        autocmd FileType gitcommit set bufhidden=delete
        " move this to
        " ~/.vim/ftplugin/gitcommit_mappings.vim
        " autocmd FileType gitcommit noremap <buffer> ZZ :w|bd<CR>
    augroup END
]]
cmd [[
    augroup shell
        autocmd!
        au FileType sh let g:sh_fold_enabled=3
        au FileType sh let g:is_bash=1
        au FileType sh setlocal foldmethod=expr
        au FileType sh setlocal foldexpr=nvim_treesitter#foldexpr()
    augroup END
]]
cmd [[
    augroup delaywrite
        autocmd!
        au TextChanged * ++nested lua require('autocmds').delaywrite()
        au TextChangedI * ++nested lua require('autocmds').delaywrite()
    augroup END
]]
cmd [[
    augroup term
        autocmd!
        au BufLeave *.term setlocal scrolloff=999
        au BufEnter *.term setlocal scrolloff=0
        au TabEnter *.term setlocal scrolloff=0
        au WinEnter *.term setlocal scrolloff=0
    augroup END
]]
cmd [[
    augroup textmagic
        autocmd!
        au FileType text set wrap linebreak
        au FileType text set spell spelllang=en_us
    augroup END
]]
local dont_write = false
function M.delaywrite()
    if vim.bo.bt == "terminal" then
        return
    end
    if dont_write then
        return
    end
    dont_write = true
    local timer = vim.loop.new_timer()
    timer:start(1200, 0, vim.schedule_wrap(function()
        dont_write = false
        vim.cmd('silent! write')
    end))
end
-- function M.startit()
--     local timer = vim.loop.new_timer()
--     timer:start(1000, 0, vim.schedule_wrap(function()
--       vim.api.nvim_command('echomsg "test"')
--     end))
-- end
return M
