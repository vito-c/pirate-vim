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
local opt = vim.opt         	-- global/buffer/windows-scoped options

cmd([[packadd packer.nvim]])
return require("packer").startup(function(use)
    use 'wbthomason/packer.nvim'
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

    ------------------------------------------------------------
    -- Editing Plugins
    ------------------------------------------------------------
    use 'tomtom/tcomment_vim'
    use 'tpope/vim-repeat'
    use 'tpope/vim-surround'
    use 'AndrewRadev/splitjoin.vim'
    use 'tommcdo/vim-exchange'
    use 'godlygeek/tabular'
    use 'tpope/vim-abolish'

    ------------------------------------------------------------
    -- Syntax Plugins
    ------------------------------------------------------------
    use 'vito-c/jq.vim'
    use 'jtratner/vim-flavored-markdown'
    use 'vito-c/applescript.vim'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }


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
    -- use 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    -- use 'junegunn/fzf.vim'
    -- use 'pbogut/fzf-mru.vim'
    use {
        'nvim-telescope/telescope.nvim',
        requires = { 
            { "nvim-lua/popup.nvim" },
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope-fzy-native.nvim" },
        }
    }

    ------------------------------------------------------------
    -- Misc Plugins
    ------------------------------------------------------------
    use 'tpope/vim-obsession'
    use 'mhinz/vim-startify'
    use {
        'iamcco/markdown-preview.nvim', 
        run = 'cd app && yarn install', 
        cmd = 'MarkdownPreview'
    }

--
-- ------------------------------------------------------------
-- -- LSP Plugins
-- ------------------------------------------------------------
-- cmd("Plug 'neovim/nvim-lspconfig'")
end)

-- nvim-telescope/telescope.nvim
-- require("telescope").setup({})
--   defaults = {
--     color_devicons = false,
--     mappings = {
--       i = {
--         ["<c-j>"] = require('telescope.actions').next,
--       },
--     },
--   },
-- })
