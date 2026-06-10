local groot = require("groot")
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
    {
        "tpope/vim-surround",
        config = function()
            vim.keymap.del("i", "<C-g>s")
            vim.keymap.del("i", "<C-g>S")
        end,
    },
    { "AndrewRadev/splitjoin.vim" },
    { "tommcdo/vim-exchange" },
    {
        "godlygeek/tabular",
        config = function()
            local function nmap(keys, command)
                vim.api.nvim_set_keymap('n', keys, command, { noremap = true })
            end

            local function vmap(keys, command)
                vim.api.nvim_set_keymap('v', keys, command, { noremap = true })
            end

            nmap("<leader>a&", ":Tabularize /&<CR>")
            vmap("<leader>a&", ":Tabularize /&<CR>")
            nmap("<leader>a+", ":Tabularize /+<CR>")
            vmap("<leader>a+", ":Tabularize /+<CR>")
            nmap("<leader>a=", ":Tabularize /=<CR>")
            vmap("<leader>a=", ":Tabularize /=<CR>")
            nmap("<leader>a:", ":Tabularize /:<CR>")
            vmap("<leader>a:", ":Tabularize /:<CR>")
            nmap("<leader>a::", ":Tabularize /:\\zs<CR>")
            vmap("<leader>a::", ":Tabularize /:\\zs<CR>")
            nmap("<leader>a{", ":Tabularize /{<CR>")
            vmap("<leader>a}", ":Tabularize /}<CR>")
            nmap("<leader>a,", ":Tabularize /,<CR>")
            vmap("<leader>a,", ":Tabularize /,<CR>")
            vmap("<leader>a ", ":Tabularize / <CR>")
            nmap("<leader>a<Bar>", ":Tabularize /<Bar><CR>")
            vmap("<leader>a<Bar>", ":Tabularize /<Bar><CR>")
        end,
    },
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
                            opts.cwd = groot.groot()
                        else
                            opts[k] = v
                        end
                    end
                    opts.preview_title = opts.cwd

                    opts.layout_strategy = static_opts.layout_strategy or "vertical"
                    tscope[cmd](opts)
                end
            end

            local function is_test_path(path)
                if not path or path == "" then
                    return false
                end

                path = path:gsub("\\", "/"):lower()

                return path:match("/test/")
                    or path:match("/tests/")
                    or path:match("/testing/")
                    or path:match("/gtest/")
                    or path:match("_test%.cc$")
                    or path:match("_test%.cpp$")
                    or path:match("_test%.cxx$")
                    or path:match("_test%.h$")
                    or path:match("_test%.hpp$")
                    or path:match("%.test%.ts$")
                    or path:match("%.spec%.ts$")
                    or path:match("/test_[^/]*%.py$")
                    or path:match("_spec%.py$")
            end

            vim.keymap.set('n', '<leader>ff', t('find_files', { groot = true }))
            vim.keymap.set('n', '<leader>fc', t('find_files'))
            vim.keymap.set('n', '<leader>ft', t('lsp_references', { groot = true, path_display = {"smart"} }))
            vim.keymap.set('n', 'fr', t('lsp_references', {
                groot = true,
                file_ignore_patterns = { "test", "spec" },
                path_display = { "smart" },
                desc = "LSP References (No Tests)"}))
            vim.keymap.set('n', '<leader>l', t('buffers'))
            vim.keymap.set('n', '<leader>gc', t('git_bcommits', { groot = true }))
            vim.keymap.set('n', '<leader>sg', t('grep_string', { groot = true }))
            vim.keymap.set('n', '<leader>sf', t('live_grep', { groot = true }))
            vim.keymap.set('n', '<leader>xx', t('diagnostics', { groot = true, desc = 'Diagnostics (workspace)' }))
            vim.keymap.set('n', '<leader>xl', t('diagnostics', {
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
    { 'scalameta/nvim-metals', requires = { "nvim-lua/plenary.nvim" } },
    -- {
    --   dir = "~/code/configs/claude.nvim",
    --   name = "claude.nvim",
    --   dependencies = { "folke/snacks.nvim" }, -- optional
    --   build = "cd bridge && npm install && npm run build",
    --   config = function()
    --     require("claude").setup({
    --   -- Backend
    --   node_path = "node",
    --   model = "claude-sonnet-4-6",
    --   allowed_tools = { "Bash", "Read", "Edit", "Write", "Glob", "Grep" },
    --   max_turns = 50,
    --
    --   -- UI
    --   window = {
    --     default_mode = "float", -- "float" | "tab"
    --     float = {
    --       width = 0.9,
    --       height = 0.9,
    --       border = "rounded",
    --     },
    --     input_height = 5,
    --   },
    --
    --   -- Keymaps (buffer-local)
    --   keymaps = {
    --     isend = "<C-s>",
    --     send = "<leader>cs",          -- Send message
    --     -- cancel = "<C-c>",        -- Cancel stream
    --     history_prev = "<C-p>",  -- Previous input history
    --     history_next = "<C-n>",  -- Next input history
    --     hide = "<leader>ch",          -- Hide window
    --     toggle_fullscreen = "<leader>cf", -- Toggle float/tab
    --     toggle_block = "<CR>",   -- Expand/collapse block
    --     expand_all = "zR",       -- Expand all blocks
    --     collapse_all = "zM",     -- Collapse all blocks
    --   },
    --
    --   -- Logging
    --   log = {
    --     level = "warn", -- "debug" | "info" | "warn" | "error"
    --   },
    --         })
    --   end,
    -- }
}
