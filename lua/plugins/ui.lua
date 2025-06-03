return {
    {
        "hoob3rt/lualine.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons" }
    },
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true
    },
    {
        "joshdick/onedark.vim",
        lazy = true
    },
    {
        "folke/tokyonight.nvim",
        lazy = true
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            -- "rcarriga/nvim-notify",
        }
    }
}
