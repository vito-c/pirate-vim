-------------------------------------------------------------------------------
-- Neovim API aliases
-------------------------------------------------------------------------------
local kmap = vim.api.nvim_set_keymap  -- set global keymap
local bmap = vim.api.buf_set_keymap
-- local cmd  = vim.cmd     	          -- execute Vim commands
-- local exec = vim.api.nvim_exec 	      -- execute Vimscript
-- local fn   = vim.fn       		      -- call Vim functions
-- local g    = vim.g         	          -- global variables
-- local opt  = vim.opt         	      -- global/buffer/windows-scoped options

local lsp = require("lspconfig")

-------------------------------------------------------------------------------
-- Neovim API aliases
-------------------------------------------------------------------------------

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local sumneko_root_path = '/Users/vitocutten/code/configs/lua-language-server'
local sumneko_binary = sumneko_root_path .. '/bin/macOS/lua-language-server'

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  print("on_attach")
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- kmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  -- kmap('v', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- kmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- kmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- kmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- kmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- kmap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- kmap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- kmap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- kmap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- kmap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- kmap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- kmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- kmap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  -- kmap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  -- kmap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- kmap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- kmap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  bmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  bmap('v', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  bmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  bmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  bmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  bmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  bmap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  bmap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  bmap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  bmap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  bmap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  bmap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  bmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  bmap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  bmap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  bmap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  bmap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  bmap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

require('lspconfig').sumneko_lua.setup ({
  cmd = { sumneko_binary, "-E", sumneko_root_path .. '/main.lua' },
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
  -- on_attach = function(client)
  --     client.resolved_capabilities.document_formatting = false
  --     on_attach(client)
  -- end
})
-- lsp.bashls.setup{}
-- lsp.tsserver.setup{}
-- lsp.pyright.setup{}
-- lsp.gopls.setup{}

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'bashls', 'sumneko_lua', 'gopls', 'pyright', 'tsserver' }
for _, svr in ipairs(servers) do
  lsp[svr].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
