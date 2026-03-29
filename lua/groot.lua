local M = {}
---@diagnostic disable-next-line: undefined-field
local home = (vim.uv or vim.loop).os_homedir() or vim.env.HOME or vim.fn.expand("~")

-- Extra search roots you want appended
local libpaths = {
  home .. "/code/startup/opencv/**",
  home .. "/code/startup/opencv_contrib/modules/**",
}
local defaultpath = home .. '/code/**'
local prev_groot = home
local function oil_dir(buf)
  local name = vim.api.nvim_buf_get_name(buf or 0)
  if name:sub(1, 6) ~= "oil://" then return nil end
  local ok, oil = pcall(require, "oil")
  if ok and oil.get_current_dir then return oil.get_current_dir() end
  return "/" .. name:gsub("^oil://+", ""):gsub("%?$","")
end

local function baby_groot(path, prev)
    local fallback = (prev and #prev > 0) and prev or path

    local res = vim.system(
        { "git", "-C", path, "rev-parse", "--show-toplevel" },
        { text = true }
    ):wait()

    if res.code ~= 0 then
        return fallback
    end

    return vim.trim(res.stdout)
end

-- I am groot (git + root)
function M.groot()
    local buffer_name = vim.api.nvim_buf_get_name(0)
    local path

    if vim.startswith(buffer_name or "", "oil://") then
        path = oil_dir()
    else
        path = vim.fn.expand("%:p:h")
    end

    local root = baby_groot(path, prev_groot)
    prev_groot = root
    return root
end

function M.groot_buff()
    if vim.fn.getbufvar(vim.fn.bufnr("%"), "&buftype") == "terminal" then
        return prev_groot
    else
        return M.path_list(M.groot())
    end
end

function M.path_list(path)
    local res = { path .. "/**" }

    for _, lib in ipairs(libpaths or {}) do
        table.insert(res, lib)
    end

    return res
end

return M
