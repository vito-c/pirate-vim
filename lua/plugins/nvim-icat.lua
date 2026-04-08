return {
    {
        dir = '/Users/mars/code/configs/nvim-icat',
        dependencies = { 'folke/snacks.nvim' },
        file_browser = {
            enabled = true,
            key = '<CR>',
        },
        config = function()
            require('nvim-icat').setup()
        end,
    }
}
