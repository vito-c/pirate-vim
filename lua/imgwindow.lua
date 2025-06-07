-- Simple popup window creator
local M = {}

-- Create a basic popup window
function M.create_popup(opts)
    opts = opts or {}
    
    -- Default options
    local config = {
        title = opts.title or "Popup Window",
        content = opts.content or {"Hello, World!", "This is a popup window!"},
        width = opts.width or 50,
        height = opts.height or 10,
        border = opts.border or "rounded", -- single, double, rounded, solid, shadow
        style = opts.style or "minimal",
        relative = opts.relative or "editor",
        focusable = opts.focusable ~= false, -- default true
    }
    
    -- Calculate position to center the popup
    local win_width = vim.api.nvim_get_option("columns")
    local win_height = vim.api.nvim_get_option("lines")
    
    local row = math.ceil((win_height - config.height) / 2)
    local col = math.ceil((win_width - config.width) / 2)
    
    -- Create buffer
    local buf = vim.api.nvim_create_buf(false, true) -- not listed, scratch buffer
    
    -- Set buffer content
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, config.content)
    
    -- Window configuration
    local win_config = {
        relative = config.relative,
        width = config.width,
        height = config.height,
        row = row,
        col = col,
        style = config.style,
        border = config.border,
        title = config.title,
        title_pos = "center",
        focusable = config.focusable,
        zindex = 50,
    }
    
    -- Create window
    local win = vim.api.nvim_open_win(buf, true, win_config)
    
    -- Set buffer options
    vim.api.nvim_buf_set_option(buf, 'modifiable', false)
    vim.api.nvim_buf_set_option(buf, 'readonly', true)
    
    -- Set window options
    vim.api.nvim_win_set_option(win, 'winhl', 'Normal:Normal,FloatBorder:FloatBorder')
    
    -- Set up keymaps to close the popup
    local close_popup = function()
        if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, true)
        end
    end
    
    -- Map keys to close popup
    vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '', {
        callback = close_popup,
        noremap = true,
        silent = true,
    })
    
    vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', '', {
        callback = close_popup,
        noremap = true,
        silent = true,
    })
    
    return { buf = buf, win = win, close = close_popup }
end

-- Create an input popup
function M.create_input_popup(opts)
    opts = opts or {}
    
    local config = {
        title = opts.title or "Input",
        prompt = opts.prompt or "Enter text:",
        default = opts.default or "",
        width = opts.width or 40,
        height = opts.height or 3,
        on_submit = opts.on_submit or function(text) print("Input:", text) end,
        on_cancel = opts.on_cancel or function() print("Cancelled") end,
    }
    
    -- Calculate position
    local win_width = vim.api.nvim_get_option("columns")
    local win_height = vim.api.nvim_get_option("lines")
    
    local row = math.ceil((win_height - config.height) / 2)
    local col = math.ceil((win_width - config.width) / 2)
    
    -- Create buffer
    local buf = vim.api.nvim_create_buf(false, true)
    
    -- Set initial content
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {config.prompt, config.default})
    
    -- Window configuration
    local win_config = {
        relative = "editor",
        width = config.width,
        height = config.height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
        title = config.title,
        title_pos = "center",
        focusable = true,
        zindex = 50,
    }
    
    -- Create window
    local win = vim.api.nvim_open_win(buf, true, win_config)
    
    -- Position cursor on input line
    vim.api.nvim_win_set_cursor(win, {2, #config.default})
    
    -- Enter insert mode
    vim.cmd('startinsert!')
    
    local close_and_submit = function()
        local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
        local input_text = lines[2] or ""
        
        if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, true)
        end
        
        config.on_submit(input_text)
    end
    
    local close_and_cancel = function()
        if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, true)
        end
        config.on_cancel()
    end
    
    -- Set up keymaps
    vim.api.nvim_buf_set_keymap(buf, 'i', '<CR>', '', {
        callback = close_and_submit,
        noremap = true,
        silent = true,
    })
    
    vim.api.nvim_buf_set_keymap(buf, 'i', '<Esc>', '', {
        callback = close_and_cancel,
        noremap = true,
        silent = true,
    })
    
    vim.api.nvim_buf_set_keymap(buf, 'n', '<CR>', '', {
        callback = close_and_submit,
        noremap = true,
        silent = true,
    })
    
    vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', '', {
        callback = close_and_cancel,
        noremap = true,
        silent = true,
    })
    
    return { buf = buf, win = win, close = close_and_cancel }
end

-- Create a selection popup (like a menu)
function M.create_selection_popup(opts)
    opts = opts or {}
    
    local config = {
        title = opts.title or "Select Option",
        items = opts.items or {"Option 1", "Option 2", "Option 3"},
        width = opts.width or 30,
        on_select = opts.on_select or function(item, index) print("Selected:", item, "at", index) end,
        on_cancel = opts.on_cancel or function() print("Selection cancelled") end,
    }
    
    local height = math.min(#config.items + 2, 15) -- max height of 15
    
    -- Calculate position
    local win_width = vim.api.nvim_get_option("columns")
    local win_height = vim.api.nvim_get_option("lines")
    
    local row = math.ceil((win_height - height) / 2)
    local col = math.ceil((win_width - config.width) / 2)
    
    -- Create buffer
    local buf = vim.api.nvim_create_buf(false, true)
    
    -- Prepare content with numbers
    local content = {}
    for i, item in ipairs(config.items) do
        table.insert(content, string.format("%d. %s", i, item))
    end
    
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)
    
    -- Window configuration
    local win_config = {
        relative = "editor",
        width = config.width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
        title = config.title,
        title_pos = "center",
        focusable = true,
        zindex = 50,
    }
    
    -- Create window
    local win = vim.api.nvim_open_win(buf, true, win_config)
    
    -- Make buffer readonly
    vim.api.nvim_buf_set_option(buf, 'modifiable', false)
    vim.api.nvim_buf_set_option(buf, 'readonly', true)
    
    local close_and_select = function()
        local cursor_pos = vim.api.nvim_win_get_cursor(win)
        local selected_index = cursor_pos[1]
        local selected_item = config.items[selected_index]
        
        if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, true)
        end
        
        if selected_item then
            config.on_select(selected_item, selected_index)
        end
    end
    
    local close_and_cancel = function()
        if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, true)
        end
        config.on_cancel()
    end
    
    -- Set up keymaps
    vim.api.nvim_buf_set_keymap(buf, 'n', '<CR>', '', {
        callback = close_and_select,
        noremap = true,
        silent = true,
    })
    
    vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', '', {
        callback = close_and_cancel,
        noremap = true,
        silent = true,
    })
    
    vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '', {
        callback = close_and_cancel,
        noremap = true,
        silent = true,
    })
    
    -- Number key shortcuts
    for i = 1, math.min(#config.items, 9) do
        vim.api.nvim_buf_set_keymap(buf, 'n', tostring(i), '', {
            callback = function()
                if vim.api.nvim_win_is_valid(win) then
                    vim.api.nvim_win_close(win, true)
                end
                config.on_select(config.items[i], i)
            end,
            noremap = true,
            silent = true,
        })
    end
    
    return { buf = buf, win = win, close = close_and_cancel }
end

-- Example usage functions
function M.demo_basic_popup()
    M.create_popup({
        title = "Basic Popup",
        content = {
            "This is a basic popup window!",
            "",
            "Press 'q' or <Esc> to close.",
            "",
            "You can customize:",
            "• Title",
            "• Content",
            "• Size",
            "• Border style",
        },
        width = 40,
        height = 10,
    })
end

function M.demo_input_popup()
    M.create_input_popup({
        title = "Name Input",
        prompt = "What's your name?",
        default = "",
        on_submit = function(name)
            if name and name ~= "" then
                vim.notify("Hello, " .. name .. "!")
            else
                vim.notify("No name entered.")
            end
        end,
        on_cancel = function()
            vim.notify("Input cancelled.")
        end,
    })
end

function M.demo_selection_popup()
    M.create_selection_popup({
        title = "Choose Editor",
        items = {"Neovim", "Vim", "Emacs", "VS Code", "Sublime Text"},
        on_select = function(item, index)
            vim.notify(string.format("You selected: %s (option %d)", item, index))
        end,
        on_cancel = function()
            vim.notify("Selection cancelled.")
        end,
    })
end

-- Create keymaps for demos (optional)
vim.keymap.set('n', '<leader>w1', M.demo_basic_popup, { desc = "Demo: Basic Popup" })
vim.keymap.set('n', '<leader>w2', M.demo_input_popup, { desc = "Demo: Input Popup" })
vim.keymap.set('n', '<leader>w3', M.demo_selection_popup, { desc = "Demo: Selection Popup" })

return M
