return {
    -- the colorscheme should be available when starting Neovim
    {
        "vito-c/vim-one",
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            vim.cmd([[colorscheme one]])
        end
    },
    {
        "nvim-lua/plenary.nvim",
        priority = 900,
        lazy = false,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        priority = 900,
        lazy = false,
    },
    {
        'nvim-treesitter/playground',
        requires = { 'nvim-treesitter/nvim-treesitter' }
    },
}
