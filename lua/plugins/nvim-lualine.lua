_G.terminal_submode = 'i' -- default
local groot = require("groot")
-- ============================================================================
-- Terminal Keymappings for switching submodes
-- ============================================================================
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

-- ============================================================================
-- Helper functions
-- ============================================================================
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
    if #output > 36 then
        output = "/" .. vim.fn.fnamemodify(path, ':t')
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

local function has_split()
    local win_count = #vim.api.nvim_tabpage_list_wins(0)
    local is_cmd = vim.api.nvim_get_mode().mode == 'c'
    if is_cmd and win_count > 3 then
        return true
    end
    if not is_cmd and win_count > 1 then
        return true
    end

    return false
end
-- ============================================================================
-- Thematic Functions
-- ============================================================================
local function telescope_open()
    return _G.telescope_open or vim.bo.filetype == 'TelescopePrompt' or vim.bo.filetype == 'TelescopeResults'
end
local function inactive_sections()
    return {
        lualine_a = {
            {
                function()
                    if telescope_open() then
                        return ' ' .. 'TELESCOPE'
                    end
                    return 'IDLE'
                    -- return '󰘓 ' .. 'IDLE'
                end,
                color = function()
                    if telescope_open() then
                        return {
                            fg = "#282c34",
                            bg = "#4287f5",
                            gui = "bold",
                        }
                    end
                    return {
                        fg = "#282c34",
                        bg = "#6c6c73",
                        gui = "bold",
                    }
                end
                ,
                separator = { left = '', right = '', },
                right_padding = 2,
            }
        },
        lualine_b = {
            {
                function()
                    local prompt_title = telescope_open() and _G.telescope_type or 'default'
                    local telescope_types = {
                        find_files = { icon = '󰈞', name = 'Files' },
                        buffers = { icon = '', name = 'Buffers' },
                        grep_string = { icon = '󱁵', name = 'Cursor Grep' },
                        live_grep = { icon = '󰜏', name = 'Live Grep' },
                        git_bcommits = { icon = '', name = 'Git' },
                        lsp_references = { icon = '', name = 'References' },
                        help = { icon = '', name = 'Help' },
                    }
                    for pattern, info in pairs(telescope_types) do
                        if prompt_title:match('^' .. pattern) then
                            return info.icon .. ' ' .. info.name
                        end
                    end
                    -- local file = vim.fn.fnamemodify(bufname, ":~:.")
                    if has_split() then
                        local bufname = vim.api.nvim_buf_get_name(0)
                        local file = vim.fn.fnamemodify(bufname, ":p")
                        file = shorten_path(groot.groot(), file, '󱞽 ..')
                        return file
                    end
                    return ' Telescope'
                end,
                color = { bg="#3e4452", fg="#abb2bf" },
                separator = { right = ''},
            }
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {
            {
                'filetype',
                color = { bg="#3e4452", fg="#abb2bf" },
                cond = function()
                    return #vim.api.nvim_tabpage_list_wins(0) < 2
                end,
            },
            {
                'progress',
                color = { bg="#3e4452", fg="#abb2bf" },
                cond = function()
                    return #vim.api.nvim_tabpage_list_wins(0) < 2
                end
            }
        },
        lualine_z = {
            {
                'location',
                cond = function()
                    return not telescope_open()
                end,
                color = {
                    fg = "#282c34",
                    bg = "#6c6c73",
                    gui = "bold",
                },
                separator = { right = '', left = '' },
                left_padding = 2,
            },
            {
                function()
                    local file = vim.fn.bufname('%')
                    local win_count = #vim.api.nvim_tabpage_list_wins(0)
                    if win_count > 7 then
                        return '󱞩 ../' .. vim.fn.fnamemodify(file, ":t")
                    end
                    return shorten_path(groot.groot(), file, '󱞩 ..')
                end,
                cond = telescope_open,
                color = {
                    fg = "#282c34",
                    bg = "#4287f5",
                },
                separator = { right = '', left = '' },
                left_padding = 2,
            },
        }
    }
end

local last_gpu_check = 0
local last_gpu_value = ""

local tmux_cache = {
  value = "",
  at = 0,
}

local tmux_cache_ttl_ms = 1000


local function tmux_location()
    if not vim.env.TMUX or vim.env.TMUX == "" then
      tmux_cache.value = ""
      tmux_cache.at = 0
      return ""
    end

    local now = vim.uv.hrtime() / 1e6
    if (now - tmux_cache.at) < tmux_cache_ttl_ms then
      return tmux_cache.value ~= "" and (" " .. tmux_cache.value) or ""
    end

    local result = vim.system(
      -- { "tmux", "display-message", "-p", "#S:#W" },
      { "tmux", "display-message", "-p", "#W" },
      { text = true }
    ):wait()

    tmux_cache.at = now
    tmux_cache.value = result.code == 0 and vim.trim(result.stdout) or ""
    return tmux_cache.value ~= "" and (" " .. tmux_cache.value) or ""
end


local function tmux_gpu_memory()
    local uv = vim.uv or vim.loop
    local now = uv and uv.now and uv.now() or 0

    if now > 0 and (now - last_gpu_check) < 2000 then
        return last_gpu_value
    end

    last_gpu_check = now

    local ok, handle = pcall(
        io.popen,
        "nvidia-smi --query-gpu=memory.used,memory.total --format=csv,noheader,nounits 2>/dev/null"
    )

    if not ok or not handle then
        last_gpu_value = tmux_location()
        return last_gpu_value
    end

    local result = handle:read("*a")
    handle:close()

    local used, total = result:match("(%d+),%s*(%d+)")
    used = tonumber(used)
    total = tonumber(total)

    if not used or not total or total == 0 then
        last_gpu_value = tmux_location()
        return last_gpu_value
    end

    local pct = math.floor((used / total) * 100 + 0.5)

    -- hide when basically unused
    if pct < 5 then
        last_gpu_value = tmux_location()
        return last_gpu_value
    end

    last_gpu_value = string.format(" %d%%%%", pct)
    return last_gpu_value
end

local function gpu_color()
    local uv = vim.uv or vim.loop
    local now = uv and uv.now and uv.now() or 0
    local display = last_gpu_value

    if now == 0 or (now - last_gpu_check) >= 2000 then
        display = tmux_gpu_memory()
    end

    if display == "" or display:match("^ ") then
        return { fg = "#3e4452", bg = "#abb2bf" }
        -- return nil
    end

    local pct = tonumber(display:match("(%d+)%%%%"))
    if not pct then
        return nil
    end

    if pct >= 90 then
        return { fg = "#1e1e2e", bg = "#f38ba8", gui = "bold" } -- red
    elseif pct >= 60 then
        return { fg = "#1e1e2e", bg = "#f9e2af", gui = "bold" } -- yellow
    else
        return { fg = "#1e1e2e", bg = "#a6e3a1", gui = "bold" } -- green
    end
end

local function filepath_shorter()
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
        icon = '' --     🖥️ 
    elseif bufname == '' then
        file = '[No Name]'
    else
        file = vim.fn.fnamemodify(bufname, ":~:.")
        if vim.bo.readonly then
            icon = '' -- '🔒' --  
        end
        -- if vim.bo.modified then
        --     icon = icon .. '●'
        -- end
    end

    if has_split() then
        bufname = vim.api.nvim_buf_get_name(0)
        file = vim.fn.fnamemodify(bufname, ":p")
        file = shorten_path(groot.groot(), file, '󱞽 ..')
    end
    if icon ~= '' then
        return file .. ' ' .. icon
    end

    return file
end

-- ============================================================================
-- Main Setup
-- ============================================================================
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
                        filepath_shorter,
                        padding = { left = 1, right = 1 }
                    },
                    {
                        'filetype',
                        icon_only = true,
                        separator = { right = '' },
                        padding = { left = 1, right = 1 },
                    },
                    {
                        function()
                          local head = vim.fn.FugitiveHead()
                          return head ~= "" and (head .. " ") or ""
                        end,
                        cond = function()
                          local is_term = vim.bo.buftype == "terminal"
                          local is_split = #vim.api.nvim_tabpage_list_wins(0) > 1
                          return not is_split and not is_term
                        end,
                        padding = { left = 1, right = 1 },
                        color = { fg = "#3e4452", bg = "#abb2bf" },
                        separator = { right = '' },
                        -- 'branch',
                        -- icon = "",
                        -- cond = function()
                        --     local is_split = #vim.api.nvim_tabpage_list_wins(0) > 1
                        --     return not is_split
                        -- end
                    }
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
                lualine_x = {
                    {
                        tmux_gpu_memory,
                        color = gpu_color,
                        separator = { left = '' },
                        -- separator = { left = '', right = '' },
                        right_padding = 1,
                    },
                },
                lualine_y = {
                    {
                        'progress',
                        cond = function()
                            local is_split = #vim.api.nvim_tabpage_list_wins(0) > 1
                            return not is_split
                        end
                    }
                },
                lualine_z = {
                    { 'location', separator = { right = '' }, left_padding = 2 },
                },
            },
            inactive_sections =  inactive_sections(),
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
                            local filename = vim.fn.fnamemodify(name, ":t")
                            if vim.bo[bufnr].buftype == "terminal" then
                                local ok, title = pcall(vim.api.nvim_buf_get_var, bufnr, "vito_term_title")
                                if ok and title ~= "" then
                                    return " " .. title
                                end
                                return " term"
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
