-------------------------------------------------------------------------------
-- Neovim API aliases
-------------------------------------------------------------------------------
-- local kmap = vim.api.nvim_set_keymap  -- set global keymap
-- local cmd  = vim.cmd     	          -- execute Vim commands
-- local exec = vim.api.nvim_exec 	      -- execute Vimscript
-- local fn   = vim.fn       		      -- call Vim functions
-- local g    = vim.g         	          -- global variables
-- local opt  = vim.opt         	      -- global/buffer/windows-scoped options
local lsp = require("lspconfig") -------------------------------------------------------------------------------
-- Neovim API aliases
-------------------------------------------------------------------------------


local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- local function bmap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>d', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>td', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
--   -- bmap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
--   -- bmap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
--   -- bmap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end


-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- luasnip setup
local luasnip = require('luasnip')
-- nvim-cmp setup
local cmp = require('cmp')
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

-- lspconfig.sumneko_lua.setup {
--   settings = {
--     Lua = {
--       runtime = {
--         version = 'LuaJIT',
--         path = (function()
--           local rtp = vim.split(package.path, ';', { plain = true })
--           rtp[#rtp+1] = './lua/?.lua'
--           rtp[#rtp+1] = './lua/?/init.lua'
--           return rtp
--         end)(),
--         pathStrict = true,
--       },
--       workspace = {
--         library = (function()
--           local lib = {}
--           for _, path in ipairs(vim.api.nvim_get_runtime_file('lua', true)) do
--             lib[#lib+1] = path:sub(1, -5)
--           end
--           return lib
--         end)(),
--       },
--       telemetry = { enable = false },
--     },
--   },
-- }

local sumneko_root_path = '/usr/lib/lua-language-server/bin'
local sumneko_binary = sumneko_root_path .. '/lua-language-server'

-- local runtime_path = vim.split(package.path, ';')
-- table.insert(runtime_path, "lua/?.lua")
-- table.insert(runtime_path, "lua/?/init.lua")
-- table.insert(runtime_path, "~/.luarocks/share/lua/5.1/?/?.lua")

require'lspconfig'.lua_ls.setup {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                -- path = runtime_path,
                path = (function()
                  local rtp = vim.split(package.path, ';')
                  rtp[#rtp+1] = 'lua/?.lua'
                  rtp[#rtp+1] = 'lua/?/init.lua'
                  rtp[#rtp+1] = '/Users/vitocutten/.luarocks/share/lua/5.1/?.lua'
                  return rtp
                end)(),
                pathStrict = true,
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
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities
}

require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities
}
require('lspconfig')['bashls'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities
}
-- require('lspconfig')['tsserver'].setup{
--     on_attach = on_attach,
--     flags = lsp_flags,
--     capabilities = capabilities
-- }
require('lspconfig')['gopls'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities
}
require('lspconfig')['rust_analyzer'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    -- Server-specific settings...
    settings = {
      ["rust-analyzer"] = {}
    }
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

require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
    ensure_installed = { "c", "lua", "rust", "python", "go", "bash", "toml", "json", "yaml" },
    -- Automatically install missing parsers when entering buffer
    auto_install = true,
    highlight = {
      -- `false` will disable the whole extension
      enable = true,

      -- list of language that will be disabled
      -- disable = { "rust" },

      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = { "jq" },
  }
}
