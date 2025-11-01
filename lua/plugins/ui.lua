return {
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
            lsp = {
                progress = { enabled = false },
                message = { enabled = false },
                hover = { enabled = false },
                signature = { enabled = false },
            },
            messages = {
                enabled = false,
            },
            notify = {
                enabled = false,
            },
            popupmenu = {
                enabled = false,
            },
            routes = {},
            views = {
                cmdline_popup = {
                    position = {
                        row = "40%",   -- move up (smaller % = higher). Try "15%" or a fixed number like 3
                        col = "50%",
                    },
                    size = {
                        width = 80,
                        height = "auto",
                    },
                    border = { style = "rounded" },
                    win_options = { winblend = 0 },
                },
            },
            cmdline = {
                enabled = true, -- only this is on
            },
            presets = {
                command_palette = false,
                bottom_search = false,
                long_message_to_split = false,
                inc_rename = false,
                lsp_doc_border = false,
            },
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
    }
}
