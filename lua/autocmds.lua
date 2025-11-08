local cmd = vim.cmd
local M = {}

------------------------------------------------------------
-- Auto Highlight Yank
------------------------------------------------------------
vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    group = "YankHighlight",
    pattern = "*",
    callback = function()
        vim.highlight.on_yank { higroup = "Visual", timeout = 300 }
    end
})

------------------------------------------------------------
-- Git Commit Settings
------------------------------------------------------------
vim.api.nvim_create_augroup("GitSettings", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = "GitSettings",
    pattern = "gitcommit",
    callback = function()
        vim.opt_local.bufhidden = "delete"
    end
})

------------------------------------------------------------
-- Shell Settings
------------------------------------------------------------
vim.g.sh_fold_enabled = 3
vim.g.is_bash = 1

vim.api.nvim_create_augroup("ShellSettings", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = "ShellSettings",
    pattern = "sh",
    callback = function()
        vim.opt_local.foldmethod = "expr"
        vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
    end
})

------------------------------------------------------------
-- Delay Write on Text Change
------------------------------------------------------------
local dont_write = false
local timer = vim.loop.new_timer()

function M.delaywrite()
    if vim.bo.buftype == "terminal" then
        return
    end
    if vim.bo.buftype == "acwrite" then
        return
    end
    if dont_write then
        return
    end
    dont_write = true
    timer:stop()
    timer:start(1200, 0, vim.schedule_wrap(function()
        dont_write = false
        vim.cmd("silent! write")
    end))
end

vim.api.nvim_create_augroup("AutoSave", { clear = true })
vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
    group = "AutoSave",
    callback = M.delaywrite
})

------------------------------------------------------------
-- Terminal Scroll Settings
------------------------------------------------------------
vim.api.nvim_create_augroup("TermScroll", { clear = true })
vim.api.nvim_create_autocmd({ "BufLeave", "BufEnter", "TabEnter", "WinEnter" }, {
    group = "TermScroll",
    pattern = "*.term",
    callback = function()
        vim.opt_local.scrolloff = (vim.fn.expand("<amatch>") == "*.term") and 0 or 999
    end
})

------------------------------------------------------------
-- Text Files Settings
------------------------------------------------------------
vim.api.nvim_create_augroup("TextMagic", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = "TextMagic",
    pattern = "text",
    callback = function()
        vim.opt.wrap = true
        vim.opt.linebreak = true
        vim.opt.spell = true
        vim.opt.spelllang = "en_us"
    end
})

------------------------------------------------------------
-- Builtins Path Handling
------------------------------------------------------------
vim.api.nvim_create_augroup("BuiltinsSettings", { clear = true })
local groot = require("groot")
vim.api.nvim_create_autocmd(
    { "BufEnter", "BufWinEnter", "WinEnter", "TabEnter" },
    {
        group = "BuiltinsSettings",
        callback = function(args)
            local bufnr = args.buf
            local name  = vim.api.nvim_buf_get_name(bufnr)
            if vim.startswith(name or "", "oil://") then
                return
            end
            local path = groot.groot_buff()
            if path then
                vim.opt_local.path = path
            end
        end
    }
)

return M
