_G.terminal_submode = 'i' -- default

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
local function shorten_path(cut_str, path, replacement)
-- "󱞽"
    local output = ''
    if cut_str and cut_str ~= "" then
        -- Remove cut_str prefix and add git icon
        output = path:gsub("^" .. vim.pesc(cut_str), "")
    else
        -- Keep only last 2 path components
        local parts = vim.split(path, "/")
        if #parts > 2 then
            output = table.concat({parts[#parts - 1], parts[#parts]}, "/")
        else
            output = path
        end
    end
    output = replacement .. output
    return output
end

local function terminal_mode_color()
    local mode = vim.api.nvim_get_mode().mode
    if mode == 't' then
        -- Get the active lualine config
        local lualine_config = require('lualine').get_config()
        local theme = lualine_config.options.theme

        -- If theme is a string, load it; if it's a table, use it directly
        if type(theme) == 'string' then
            theme = require('lualine.themes.' .. theme)
        end

        if _G.terminal_submode == 'i' then
            return {
                bg = theme.insert.a.bg,
                fg = theme.insert.a.fg,
                gui = 'bold'
            }
        elseif _G.terminal_submode == 'n' then
            return {
                bg = theme.normal.a.bg,
                fg = theme.normal.a.fg,
                gui = 'bold'
            }
        end
    end
    return ''
end

local function telescopic()
    return {
      lualine_a = {
        {
            function()
                if _G.telescope_open or vim.bo.filetype == 'TelescopePrompt' or vim.bo.filetype == 'TelescopeResults' then
                    return '󰭎 ' .. 'Telescope'
                end
            end,
            color = function()
                if _G.telescope_open or vim.bo.filetype == 'TelescopePrompt' or vim.bo.filetype == 'TelescopeResults' then
                    return 'lualine_a_visual'
                else
                    return 'lualine_a_inactive'
                end
            end,
            separator = { left = '', right = '', },
            right_padding = 2,
        }
      },
      lualine_b = {
            function()
                if _G.telescope_open or vim.bo.filetype == 'TelescopePrompt' or vim.bo.filetype == 'TelescopeResults' then
                    local prompt_title = _G.telescope_type
                    local file = ''
                    local icon = ''
                    if prompt_title:match('^find_files') then
                        file = 'Files'
                        icon = '󰈞'
                    elseif prompt_title:match('^buffers') then
                        file = 'Buffers'
                        icon = ''
                    elseif prompt_title:match('^grep_string') then
                        file = 'Cursor Grep'
                        icon = '󱁵'
                    elseif prompt_title:match('^live_grep') then
                        file = 'Live Grep'
                        icon = '󰜏'
                    elseif prompt_title:match('^git_bcommits') then
                        file = 'Git'
                        icon = ''
                    elseif prompt_title:match('^lsp_refernces') then
                        file = 'References'
                        icon = ''
                    elseif prompt_title:match('^Help') then
                        file = 'Help'
                        icon = '󰮥'
                    end
                    return icon .. ' ' .. file
                end
            end,

        },
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {
        {
          function()
            if _G.telescope_open or vim.bo.filetype == 'TelescopePrompt' or vim.bo.filetype == 'TelescopeResults' then
                return shorten_path(_G.groot(), vim.fn.bufname('%'), '󱞩 ..')
            end
          end,
          color = function()
            if _G.telescope_open or vim.bo.filetype == 'TelescopePrompt' or vim.bo.filetype == 'TelescopeResults' then
                return 'lualine_a_visual'
            end
          end,
          separator = { right = '', left = '' },
          left_padding = 2,
        }
      }
    }
end

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
                            local bufname = vim.api.nvim_buf_get_name(0)
                            local file = ''
                            local icon = ''
                            if bufname:match("^oil://") then
                                file = bufname
                                icon = '󱞊'
                            elseif bufname:match("^fugitive://") then
                                local short_sha, path = bufname:match("fugitive://.-%.git//([a-f0-9]+)/(.*)")
                                if short_sha and path then
                                    file = string.format("git:///%s/%s", short_sha:sub(1, 7), path)
                                else
                                    file = bufname
                                end
                                icon = '󰊢'
                            elseif vim.bo.buftype == 'terminal' then
                                file = vim.fn.expand('%:~:.')
                                icon = '🖥️'
                            elseif bufname == '' then
                                file = '[No Name]'
                            else
                                local is_split = #vim.api.nvim_tabpage_list_wins(0) > 1
                                file = vim.fn.fnamemodify(bufname, ":~:.")
                                if is_split then
                                    file = shorten_path(_G.groot(), vim.expand(file), '󱞽 ..')
                                end
                                if vim.bo.readonly then
                                    icon = '🔒'
                                end
                                if vim.bo.modified then
                                    icon = icon .. ' ●'
                                end
                            end
                            return file .. ' ' .. icon
                        end,
                    },
                    'branch'
                },
                lualine_c = {
                    {
                        terminal_mode,
                        -- color = terminal_mode_color,
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
            inactive_sections = telescopic(),
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
                        max_length = vim.o.columns, -- use full window width
                        tab_max_length = 25,        -- optional: max width per tab
                        fmt = function(name, context)
                            -- You can inspect context.tabnr here
                            local buflist = vim.fn.tabpagebuflist(context.tabnr)
                            local win = vim.fn.tabpagewinnr(context.tabnr)
                            local bufnr = buflist[win]
                            local bufname = vim.fn.bufname(bufnr)

                            if vim.bo[bufnr].buftype == 'terminal' then
                                return ' term'
                            end
                            if bufname:sub(1, 6) == "oil://" then
                                return '󱞊 oil'
                            end
                            if name == '[No Name]' or bufname == '' or name == '' then
                                if _G.telescope_open then
                                    return vim.fn.fnamemodify(vim.fn.expand('#'), ':t')
                                end
                            end

                            if bufname:match("^fugitive://") then
                                local short_sha, path = bufname:match("fugitive://.-%.git//([a-f0-9]+)/(.*)")
                                local file = ''
                                if short_sha and path then
                                    file = string.format("git:///%s/%s", short_sha:sub(1, 7), path)
                                else
                                    file = bufname
                                end
                                return '󰊢 ' .. file
                            end

                            -- fallback to default name
                            return name
                        end
                    }
                },
            },
            winbar = {},
            inactive_winbar = {},
            extensions = { 'quickfix', 'fugitive', 'oil', 'mundo' }
        }
    end,
}
