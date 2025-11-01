return {
    {
        "AckslD/nvim-neoclip.lua",
        dependencies = {
            { 'nvim-telescope/telescope.nvim' },
        },
        config = function()
            require('neoclip').setup()
        end,
    },
    { "tomtom/tcomment_vim" },
    {
        "mbbill/undotree",
        config = vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
    },
    { "tpope/vim-repeat" },
    { "tpope/vim-surround" },
    { "AndrewRadev/splitjoin.vim" },
    { "tommcdo/vim-exchange" },
    { "godlygeek/tabular" },
    {
        'tpope/vim-abolish',
        config = function()
            vim.cmd('Abolish teh the')
            vim.cmd('Abolish chomd chmod')
            vim.cmd('Abolish ehco echo')
            vim.cmd('Abolish pritnln println')
            vim.cmd('Abolish pritn print')
            vim.cmd('Abolish orig original')
            vim.cmd('Abolish vheicle vehicle')
        end,
    },
    { "tpope/vim-rhubarb" },
    {
        "tpope/vim-fugitive",
        config = function()
            vim.keymap.set('n', '<leader>gdh', ':Gvdiff HEAD<CR>', { noremap = true })
            vim.keymap.set('n', '<leader>gdm', ':Gvdiff origin/master<CR>', { noremap = true })
            vim.keymap.set('n', '<leader>gdu', ':Gvdiff upstream/master<CR>', { noremap = true })
            vim.keymap.set('n', '<leader>gb', ':Git blame<CR>', { noremap = true })
            vim.keymap.set('n', '<leader>gl', ':Gclog<CR>', { noremap = true })
            vim.keymap.set('n', '<leader>gs', ':Git<CR>', { noremap = true })
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            { "nvim-lua/popup.nvim" },
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope-fzy-native.nvim" },
            { "sudormrfbin/cheatsheet.nvim" },
        },
        config = function()
            require("telescope").setup({
                defaults = {
                    color_devicons       = true,
                    path_display         = { "absolute" },
                    results_title        = "Results",
                    file_ignore_patterns = { "^undo/", "/undo/" },
                    layout_config        = {
                        bottom_pane = { height = 25 },
                        center      = { height = 0.9, preview_cutoff = 40, width = 0.8 },
                        cursor      = { height = 0.9, preview_cutoff = 40, width = 0.8 },
                        horizontal  = {
                            height          = 0.9,
                            preview_cutoff  = 120,
                            prompt_position = "bottom",
                            width           = 0.8,
                        },
                        vertical    = { height = 0.95, preview_cutoff = 20, width = 0.9 },
                    },
                    mappings             = {
                        i = {
                            ["<c-j>"] = require("telescope.actions").move_selection_next,
                            ["<c-k>"] = require("telescope.actions").move_selection_previous,
                        },
                        n = {
                            ["<c-j>"] = require("telescope.actions").move_selection_next,
                            ["<c-k>"] = require("telescope.actions").move_selection_previous,
                        },
                    },
                },
                extensions = {
                    media_files = { filetypes = { "png", "jpg", "webp", "jpeg" } },
                    fzf = {
                        fuzzy                   = true,
                        override_generic_sorter = true,
                        override_file_sorter    = true,
                        case_mode               = "smart_case",
                    },
                },
            })

            require("telescope").load_extension("fzy_native")

            local tscope = require("telescope.builtin")
            local function t(cmd, static_opts)
                static_opts = static_opts or {}

                return function()
                    local opts = {}
                    -- if static_opts.groot then
                    --     opts.cwd = _G.groot()
                    -- end
                    for k, v in pairs(static_opts) do
                        if k == 'groot' and v then
                            opts.cwd = _G.groot()
                        else
                            opts[k] = v
                        end
                    end

                    opts.layout_strategy = static_opts.layout_strategy or "vertical"
                    tscope[cmd](opts)
                end
            end

            vim.keymap.set('n', '<leader>ff', t('find_files', { groot = true }))
            vim.keymap.set('n', '<leader>fc', t('find_files'))
            vim.keymap.set('n', '<leader>fr', t('lsp_references', { groot = true }))
            vim.keymap.set('n', '<leader>l', t('buffers'))
            vim.keymap.set('n', '<leader>gc', t('git_bcommits', { groot = true }))
            vim.keymap.set('n', '<leader>sg', t('grep_string', { groot = true }))
            vim.keymap.set('n', '<leader>sf', t('live_grep', { groot = true }))
            vim.keymap.set('n', '<leader>xX', t('diagnostics', { groot = true, desc = 'Diagnostics (workspace)' }))
            vim.keymap.set('n', '<leader>xx', t('diagnostics', {
                groot = true, bufnr = 0, desc = 'diagnostics (buffer)'
            }))

            -- TODO: Move these to autocmds.lua
            local set = vim.api.nvim_create_autocmd
            set("User", {
                pattern = "TelescopePreviewerLoaded",
                callback = function()
                    _G.telescope_open = true
                    require("lualine").refresh()
                    vim.cmd("redrawstatus")
                end,
            })
            set("BufEnter", {
                pattern = "*",
                callback = function()
                    local ft = vim.bo.filetype
                    if ft == "TelescopePrompt" or ft == "TelescopeResults" then
                        _G.telescope_open = true
                        require("lualine").refresh()
                        vim.cmd("redrawstatus")
                    end
                end,
            })
            set("BufLeave", {
                pattern = "*",
                callback = function()
                    local ft = vim.bo.filetype
                    if ft == "TelescopePrompt" or ft == "TelescopeResults" then
                        _G.telescope_open = false
                        vim.schedule(function()
                            require("lualine").refresh()
                            vim.cmd("redrawstatus")
                        end)
                    end
                end,
            })
            set("User", {
                pattern = "TelescopeFinderClosed",
                callback = function()
                    _G.telescope_open = false
                    _G.telescope_type = nil
                    require("lualine").refresh()
                    vim.cmd("redrawstatus")
                end,
            })
        end,
    },
    -- {
    -- 	"nvim-telescope/telescope-media-files.nvim",
    -- 	dependencies = { "nvim-telescope/telescope.nvim" }
    -- },
    { "tpope/vim-obsession" },
    { "mhinz/vim-startify" },
    { 'scalameta/nvim-metals', requires = { "nvim-lua/plenary.nvim" } }
}
