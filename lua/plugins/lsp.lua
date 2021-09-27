-------------------------------------------------------------------------------
-- Neovim API aliases
-------------------------------------------------------------------------------
local kmap = vim.api.nvim_set_keymap  -- set global keymap
local cmd  = vim.cmd     	          -- execute Vim commands
local exec = vim.api.nvim_exec 	      -- execute Vimscript
local fn   = vim.fn       		      -- call Vim functions
local g    = vim.g         	          -- global variables
local opt  = vim.opt         	      -- global/buffer/windows-scoped options

require'lspconfig'.bashls.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.pyright.setup{}
require'lspconfig'.gopls.setup{}

-------------------------------------------------------------------------------
-- Neovim API aliases
-------------------------------------------------------------------------------
require'lspconfig'.sumneko_lua.setup{}
local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = '/Users/vitocutten/code/configs/lua-language-server'
local sumneko_binary = '/Users/vitocutten/code/configs/lua-language-server/bin/macOS/lua-language-server'

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
