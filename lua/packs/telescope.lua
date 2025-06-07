require("telescope").setup({
    defaults = {
        color_devicons = true,
        path_display = { "absolute" },
        results_title = "Results",
        file_ignore_patterns = {
            "^undo/",
            "/undo/",
        },
        layout_config = {
            bottom_pane = {
                height = 25
            },
            center = {
                height = 0.9,
                preview_cutoff = 40,
                width = 0.8
            },
            cursor = {
                height = 0.9,
                preview_cutoff = 40,
                width = 0.8
            },
            horizontal = {
                height = 0.9,
                preview_cutoff = 120,
                prompt_position = "bottom",
                width = 0.8
            },
            vertical = {
                height = 0.95,
                preview_cutoff = 20,
                width = 0.9
            }
        },
        mappings = {
            i = {
                ["<c-j>"] = require('telescope.actions').move_selection_next,
                ["<c-k>"] = require('telescope.actions').move_selection_previous,
            },
            n = {
                ["<c-j>"] = require('telescope.actions').move_selection_next,
                ["<c-k>"] = require('telescope.actions').move_selection_previous,
            },
        },
    },
    extensions = {
        media_files = {
            filetypes = { "png", "jgp", "webp", "jpeg" }
        },
        fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        }
    },
})

require("telescope").load_extension("fzy_native")

-------------------------------------------------------------------------------
-- Mappings
-------------------------------------------------------------------------------
local tscope_builtin = require('telescope.builtin')
local function t(cmd, opts)
    opts = opts or {}
    opts.layout_strategy = opts.layout_strategy or 'vertical'
    return function()
        _G.telescope_type = cmd
        _G.telescope_open = true
        tscope_builtin[cmd](opts)
    end
end

vim.keymap.set('n', '<leader>ff', t('find_files', { cwd = _G.groot() }))
vim.keymap.set('n', '<leader>fc', t('find_files'))
vim.keymap.set('n', '<leader>fr', t('lsp_references', { cwd = _G.groot() }))
vim.keymap.set('n', '<leader>l',  t('buffers'))
vim.keymap.set('n', '<leader>gc', t('git_bcommits', { cwd = _G.groot() }))
vim.keymap.set('n', '<leader>sg', t('grep_string', { cwd = _G.groot() }))
vim.keymap.set('n', '<leader>sf', t('live_grep', { cwd = _G.groot() }))

-- vim.api.nvim_create_autocmd("User", {
--     pattern = "TelescopePreviewerLoaded",
--     callback = function()
--         _G.telescope_open = true
--     end,
-- })
--
-- vim.api.nvim_create_autocmd("BufLeave", {
--     pattern = "*",
--     callback = function()
--         if vim.bo.filetype == "TelescopePrompt" or vim.bo.filetype == "TelescopeResults" then
--             _G.telescope_open = false
--         end
--     end,
-- })
-- Enhanced autocmds for better telescope state tracking
vim.api.nvim_create_autocmd("User", {
    pattern = "TelescopePreviewerLoaded",
    callback = function()
        _G.telescope_open = true
        require('lualine').refresh()
        vim.cmd('redrawstatus')
    end,
})

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = function()
        local ft = vim.bo.filetype
        if ft == "TelescopePrompt" or ft == "TelescopeResults" then
            _G.telescope_open = true
            require('lualine').refresh()
            vim.cmd('redrawstatus')
        end
    end,
})

vim.api.nvim_create_autocmd("BufLeave", {
    pattern = "*",
    callback = function()
        local ft = vim.bo.filetype
        if ft == "TelescopePrompt" or ft == "TelescopeResults" then
            _G.telescope_open = false
            -- Delay the refresh slightly to ensure buffer change is complete
            vim.schedule(function()
                require('lualine').refresh()
                vim.cmd('redrawstatus')
            end)
        end
    end,
})

-- Additional autocmd to handle telescope closing
vim.api.nvim_create_autocmd("User", {
    pattern = "TelescopeFinderClosed",
    callback = function()
        _G.telescope_open = false
        _G.telescope_type = nil
        require('lualine').refresh()
        vim.cmd('redrawstatus')
    end,
})
