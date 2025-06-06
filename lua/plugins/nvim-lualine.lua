-- return {
--     {
--         'nvim-lualine/lualine.nvim',
--         dependencies = { 'nvim-tree/nvim-web-devicons' },
--         config = function()
--             require('lualine').setup {
--                 options = { theme = 'onedark' },
--             }
--         end,
--     }
-- }
_G.terminal_submode = 'i'  -- default

-- Exit to terminal-normal
vim.keymap.set('t', '<C-[>', function()
    if _G.terminal_submode == 'i' then
        _G.terminal_submode = 'n'
        vim.cmd('redrawstatus')
    end
    vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes('<C-[>', true, false, true),
        'n', false
    )
end)

-- -- Re-enter terminal-insert
vim.keymap.set('t', 'i', function()
    if _G.terminal_submode == 'n' then
        _G.terminal_submode = 'i'
        vim.cmd('redrawstatus')
    end
    vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes('i', true, false, true),
        'n', false
    )
end, { expr = true })

return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local function terminal_mode()
            local mode = vim.api.nvim_get_mode().mode
            if mode == 't' and _G.terminal_submode == 'i' then
                return 'insert'
            elseif mode == 't' then
                return 'normal'
            end
            return ''
        end
        local function terminal_mode_color()
            local mode = vim.api.nvim_get_mode().mode
            if mode == 't' and _G.terminal_submode == 'i' then
                return 'lualine_a_insert'
            elseif mode == 't' and _G.terminal_submode == 'n' then
                    return 'lualine_a_normal'
            end
            return nil
        end
        require('lualine').setup {
            options = {
                theme = "onedark",
                component_separators = '',
                section_separators = { left = '', right = '' },
            },
            sections = {
                lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
                lualine_b = {
                    {
                        function()
                            local file = vim.fn.expand('%:~:.')
                            if file == '' then
                                file = '[No Name]'
                            end

                            local icon = ''
                            if vim.bo.buftype == 'terminal' then
                                icon = '🖥️'
                            elseif vim.bo.readonly then
                                icon = '🔒'
                            end

                            if vim.bo.modified then
                                icon = icon .. ' ●'
                            end

                            return file .. ' ' .. icon
                        end,
                        -- 'filename',
                        -- path = 1, -- 0 = just file name, 1 = relative path, 2 = absolute path
                        -- symbols = {
                        --     modified = ' ●', -- Text to show when the file is modified
                        --     unnamed = '[No Name]', -- Text to show for unnamed buffers
                        --     newfile = '[New]',     -- Text to show for newly created file before saving
                        -- },
                    },
                    'branch'
                },
                lualine_c = {
                    {
                        terminal_mode,
                        color = terminal_mode_color,
                        cond = function() return vim.bo.buftype == 'terminal' end,
                        separator = { right = '' }, -- ⬅️ this adds the left-side bubble
                        right_padding = 1,
                    },
                },
                lualine_x = {},
                lualine_y = { 'filetype', 'progress' },
                lualine_z = {
                    { 'location', separator = { right = '' }, left_padding = 2 },
                },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {
                lualine_a = {
                    { 'tabs',
                        mode = 1, -- 0: tab nr, 1: filename, 2: both
                        path = 0, -- 0: just filename, 1: relative path, 2: absolute path
                        symbols = {
                            modified = ' ●', -- indicator for modified buffer
                            alternate_file = '#',
                            directory = '',
                        },
                    }
                },
            },
            winbar = {},
            inactive_winbar = {},
            extensions = {}
        }
    end,
}
