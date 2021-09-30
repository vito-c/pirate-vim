-------------------------------------------------------------------------------
-- Neovim API aliases
-------------------------------------------------------------------------------
-- local kmap = vim.api.nvim_set_keymap  -- set global keymap
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

local on_attach = function(client, bufnr)
  local function bmap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  bmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
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

lsp.sumneko_lua.setup ({
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
  on_attach = function(client)
      client.resolved_capabilities.document_formatting = false
      on_attach(client)
  end
})
lsp.bashls.setup{
  on_attach = function(client)
      on_attach(client)
  end
}
lsp.tsserver.setup{
  on_attach = function(client)
      on_attach(client)
  end
}
lsp.pyright.setup{
  on_attach = function(client)
      on_attach(client)
  end
}
lsp.gopls.setup{
  on_attach = function(client)
      on_attach(client)
  end
}

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
-- local servers = { 'bashls', 'gopls', 'pyright', 'tsserver' }
-- for _, svr in ipairs(servers) do
--   lsp[svr].setup {
--     on_attach = on_attach,
--     flags = {
--       debounce_text_changes = 150,
--     }
--   }
-- end
