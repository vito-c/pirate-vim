------------------------------------------------------------
-- Neovim plugin configurations
------------------------------------------------------------

------------------------------------------------------------
-- Neovim API aliases
------------------------------------------------------------
local map = vim.api.nvim_set_keymap  -- set global keymap
local cmd = vim.cmd     	    -- execute Vim commands
local exec = vim.api.nvim_exec 	-- execute Vimscript
local fn = vim.fn       		-- call Vim functions
local g = vim.g         	    -- global variables
-- local opt = vim.opt         	-- global/buffer/windows-scoped options

cmd([[packadd packer.nvim]])
return require("packer").startup(function(use)
    use 'wbthomason/packer.nvim'
    ------------------------------------------------------------
    -- Copilot
    ------------------------------------------------------------
    -- use {
    --   "zbirenbaum/copilot.lua",
    --   cmd = "Copilot",
    --   event = "InsertEnter",
    --   config = function()
    --     require('copilot').setup({
    --       panel = {
    --         enabled = true,
    --         auto_refresh = false,
    --         keymap = {
    --           jump_prev = "[[",
    --           jump_next = "]]",
    --           accept = "<CR>",
    --           refresh = "gr",
    --           open = "<M-CR>"
    --         },
    --         layout = {
    --           position = "bottom", -- | top | left | right
    --           ratio = 0.4
    --         },
    --       },
    --       suggestion = {
    --         enabled = true,
    --         auto_trigger = false,
    --         debounce = 75,
    --         keymap = {
    --           accept = "<M-l>",
    --           accept_word = false,
    --           accept_line = false,
    --           next = "<M-]>",
    --           prev = "<M-[>",
    --           dismiss = "<C-]>",
    --         },
    --       },
    --       filetypes = {
    --         yaml = false,
    --         markdown = false,
    --         help = false,
    --         gitcommit = false,
    --         gitrebase = false,
    --         hgcommit = false,
    --         svn = false,
    --         cvs = false,
    --         ["."] = false,
    --       },
    --       copilot_node_command = 'node', -- Node.js version must be > 16.x
    --       server_opts_overrides = {},
    --     })
    --   end,
    -- }
    --TODO: time tracking
    -- wakatime/vim-wakatime

    ------------------------------------------------------------
    -- Visual Plugins
    ------------------------------------------------------------
    use {
        'junegunn/goyo.vim',
        requires = {
            'junegunn/limelight.vim'
        }
    }
    ------------------------------------------------------------
    -- GUI Plugins
    ------------------------------------------------------------
    use 'vito-c/vim-one'
    use 'joshdick/onedark.vim'
    use {
        'hoob3rt/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' }
    }
    use { 'alvarosevilla95/luatab.nvim', requires='kyazdani42/nvim-web-devicons' }

    use {
        'glacambre/firenvim',
        run = function() vim.fn['firenvim#install'](0) end
    }

    ------------------------------------------------------------
    -- Editing Plugins
    ------------------------------------------------------------
    use 'tomtom/tcomment_vim'
    use 'tpope/vim-repeat'
    use 'tpope/vim-surround'
    use 'AndrewRadev/splitjoin.vim'
    use 'tommcdo/vim-exchange'
    use 'godlygeek/tabular'
    use {
      'tpope/vim-abolish',
      cond = 'true',
      config = function ()
        vim.cmd('Abolish teh the')
        vim.cmd('Abolish chomd chmod')
        vim.cmd('Abolish ehco echo')
        vim.cmd('Abolish pritnln println')
        vim.cmd('Abolish pritn print')
        vim.cmd('Abolish orig original')
        vim.cmd('Abolish vheicle vehicle')
      end,
    }

    ------------------------------------------------------------
    -- Syntax Plugins
    ------------------------------------------------------------
    -- use 'vito-c/jq.vim'
    -- use { 'Freed-Wu/jq.vim', branch = 'compiler' }
    use { '~/code/personal/jq.vim' }
    use 'aklt/plantuml-syntax'
    use 'jtratner/vim-flavored-markdown'
    use 'vito-c/applescript.vim'
    -- 783e5fc..80f66cd
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'nvim-treesitter/playground', requires = {'nvim-treesitter/nvim-treesitter'} }
    use({'scalameta/nvim-metals', requires = { "nvim-lua/plenary.nvim" }})

    ------------------------------------------------------------
    -- Git Plugins
    ------------------------------------------------------------
    use 'tpope/vim-rhubarb'
    use 'tpope/vim-fugitive'

    ------------------------------------------------------------
    -- Text Navigation Plugins
    ------------------------------------------------------------
    use 'tpope/vim-unimpaired'

    ------------------------------------------------------------
    -- File Navigation Plugins
    ------------------------------------------------------------
    use 'tpope/vim-vinegar'
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            { 'nvim-lua/popup.nvim' },
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-fzy-native.nvim' },
            { 'pwntester/octo.nvim' },
            { 'sudormrfbin/cheatsheet.nvim'},
        }
    }

    ------------------------------------------------------------
    -- Misc Plugins
    ------------------------------------------------------------
    use 'tpope/vim-obsession'
    use 'mhinz/vim-startify'
    use {'iamcco/markdown-preview.nvim', run = [[sh -c 'cd app && yarn install']]}
    -- use {
    --     'iamcco/markdown-preview.nvim',
    --     run = 'cd app && yarn install',
    --     cmd = 'MarkdownPreview'
    -- }

    ------------------------------------------------------------
    -- LSP Plugins
    ------------------------------------------------------------
    -- Sets up Neovim to use LSP for enhanced language features like code navigation and diagnostics.
    use { 'neovim/nvim-lspconfig' }
    -- Implementation for code snippets, allowing for quick insertion of templated code blocks.
    use { 'hrsh7th/vim-vsnip' }
    -- The core engine for handling autocompletions, integrates with various sources to gather completions.
    use { 'hrsh7th/nvim-cmp', requires={'neovim/nvim-lspconfig'} } -- Autocompletion plugin
    -- Enhances the core completion functionality with support for LSP-driven code suggestions.
    use { 'hrsh7th/cmp-nvim-lsp', requires={'hrsh7th/nvim-cmp'}} -- LSP source for nvim-cmp
    -- Provides suggestions from the text in the current buffer, helping to autocomplete words already typed.
    use { 'hrsh7th/cmp-buffer', requires={'hrsh7th/nvim-cmp'}}
    -- Enables autocompletion of filesystem paths, making it easier to navigate directories and files.
    use { 'hrsh7th/cmp-path', requires={'hrsh7th/nvim-cmp'}}
    -- Allows nvim-cmp to suggest snippets from vim-vsnip in the completion menu.
    use { 'hrsh7th/cmp-vsnip', requires={'hrsh7th/nvim-cmp', 'hrsh7th/vim-vsnip'}}
    -- Adds function signature information to the completions, helping you to see parameter info as you type.
    use { 'hrsh7th/cmp-nvim-lsp-signature-help', requires={'hrsh7th/nvim-cmp'}}
    -- use { 'neovim/nvim-lspconfig' }
    -- use { 'hrsh7th/vim-vsnip' }
    -- use { 'hrsh7th/nvim-cmp', requires={'neovim/nvim-lspconfig'} } -- Autocompletion plugin
    -- use { 'hrsh7th/cmp-nvim-lsp', requires={'hrsh7th/nvim-cmp'}} -- LSP source for nvim-cmp
    -- use { 'hrsh7th/cmp-buffer', requires={'hrsh7th/nvim-cmp'}}
    -- use { 'hrsh7th/cmp-path', requires={'hrsh7th/nvim-cmp'}}
    -- use { 'hrsh7th/cmp-vsnip', requires={'hrsh7th/nvim-cmp', 'hrsh7th/vim-vsnip'}}
    -- use { 'hrsh7th/cmp-nvim-lsp-signature-help', requires={'hrsh7th/nvim-cmp'}}
    -- use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp

  --   {
  --   "hrsh7th/nvim-cmp",
  --   event = "InsertEnter",
  --   dependencies = {
  --     { "hrsh7th/cmp-buffer" },
  --     { "hrsh7th/cmp-nvim-lsp" },
  --     { "hrsh7th/cmp-path" },
  --     { "hrsh7th/cmp-vsnip" },
  --     { "hrsh7th/vim-vsnip" },
  --     { "hrsh7th/cmp-nvim-lsp-signature-help" },
  --   },
  --   config = function()
  --     require("mesopotamia.plugins.cmp").setup()
  --   end
  -- }
    -- use 'L3MON4D3/LuaSnip' -- Snippets plugin
end)
