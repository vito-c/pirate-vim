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
                hover = { enabled = true },
                signature = { enabled = true },
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                }
            },
            messages = {
                enabled = false,
            },
            notify = {
                enabled = false,
            },
            popupmenu = {
                enabled = true,
            },
            -- routes = {},
            views = {
                cmdline_popup = {
                    position = {
                        row = 5,
                        col = "50%",
                    }, size = {
                        width = 80,
                        height = "auto",
                    },
                },
                cmdline_popupmenu = {
                    relative = "editor",
                    position = {
                        row = 8,
                        col = "50%",
                    },
                    size = {
                        width = 80,
                        height = 10,
                    },
                    border = {
                        style = "rounded",
                        padding = { 0, 1 },
                    },
                    win_options = {
                        winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
                    },
                },
            },
            cmdline = {
                enabled = true, -- only this is on
            },
            presets = {
                command_palette = true,
                bottom_search = false,
                long_message_to_split = false,
                inc_rename = false,
                lsp_doc_border = true,
            },
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        lazy = false,
        keys = {
          { "<leader>m", "<cmd>RenderMarkdown toggle<CR>", desc = "Toggle RenderMarkdown" },
        },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {},
    },
    {
        "catgoose/nvim-colorizer.lua",
        event = "BufReadPre",
        opts = {
            filetypes = { "*" },
            options = {
                parsers = {
                    custom = {
                        {
                            name = "rgb_semicolon",
                            parse = function(ctx)
                                local chunk = ctx.line:sub(ctx.col)
                                local r, g, b = chunk:match("^(%d%d?%d?);(%d%d?%d?);(%d%d?%d?)")
                                r, g, b = tonumber(r), tonumber(g), tonumber(b)

                                if not (r and g and b) then
                                    return
                                end

                                if r > 255 or g > 255 or b > 255 then
                                    return
                                end

                                local matched = ("%d;%d;%d"):format(r, g, b)
                                return #matched, ("%02x%02x%02x"):format(r, g, b)
                            end,
                        },
                    },
                },
            },
        },
    },
}
