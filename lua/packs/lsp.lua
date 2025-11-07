-------------------------------------------------------------------------------
-- Neovim LSP and cmp aliases
-------------------------------------------------------------------------------
local M = {}

-- Keymap helpers --------------------------------------------------------------
-- Diagnostic floats at cursor
vim.keymap.set('n', '<leader>ek', function()
  vim.diagnostic.open_float({
    bufnr = 0,
    scope = 'cursor',
    focus = false,
  })
end, { desc = 'Diagnostic float at cursor' })


-- Diagnostic floats at line
vim.keymap.set('n', '<leader>eK', function()
  vim.diagnostic.open_float({
    bufnr = 0,
    scope = 'line',
    focus = false,
  })
end, { desc = 'Diagnostic float for line' })

-- Next/prev diagnostic
vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump({ count = 1, float = true })   -- show popup on jump
end, { silent = true, desc = 'Next diagnostic' })
vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { silent = true, desc = 'Prev diagnostic' })

-- Next/Prev Only errors
vim.keymap.set('n', ']e', function()
  vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR, float = true })
end, { silent = true, desc = 'Next error' })

vim.keymap.set('n', '[e', function()
  vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR, float = true })
end, { silent = true, desc = 'Prev error' })

-- on_attach ---------------------------------------------------------------
local function on_attach(_, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>kd', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>ka', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)

  -- Telescope-powered definitions/impl/refs
  vim.keymap.set('n', 'gd', function() require('telescope.builtin').lsp_definitions() end, { noremap = true, silent = true })
  vim.keymap.set('n', '<leader>ki', function() require('telescope.builtin').lsp_implementations() end, { noremap = true, silent = true })
  vim.keymap.set('n', '<leader>kr', function() require('telescope.builtin').lsp_references() end, { noremap = true, silent = true })

  -- Clangd helpers
  vim.keymap.set('n', '<leader>kh', ':ClangdSwitchSourceHeader<CR>', { noremap = true, silent = true })
  vim.keymap.set('n', '<leader>ks', ':ClangdShowSymbolInfo<CR>', { noremap = true, silent = true })

  -- Format
  vim.keymap.set('n', '<leader>F', function() vim.lsp.buf.format({ async = true }) end, bufopts)
  vim.keymap.set('n', '<leader>fF', function() vim.lsp.buf.format({ async = true }) end, bufopts)
end

-- capabilities -------------------------------------------------------------
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, {
  offsetEncoding = { 'utf-16' },
  general = { positionEncodings = { 'utf-16' } },
})

-- cmp configuration --------------------------------------------------------
local cmp = require('cmp')
local compare = require('cmp.config.compare')

cmp.setup({
  snippet = {
    expand = function(args) vim.fn["vsnip#anonymous"](args.body) end,
  },

  mapping = cmp.mapping.preset.insert({
    ['<C-n>']     = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ['<C-j>']     = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ['<C-p>']     = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ['<C-k>']     = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ['<C-d>']     = cmp.mapping.scroll_docs(-4),
    ['<C-f>']     = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>']     = cmp.mapping.abort(),
    ['<CR>']      = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
    ['<Tab>']     = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
  }),

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'vsnip' },
    { name = 'buffer' },
    { name = 'nvim_lsp_signature_help' },
  }),

  preselect = cmp.PreselectMode.None,

  matching = {
    disallow_fuzzy_matching = true,
    disallow_fullfuzzy_matching = true,
    disallow_partial_fuzzy_matching = true,
    disallow_partial_matching = true,
    disallow_prefix_unmatching = true,
    disallow_symbol_nonprefix_matching = true,
  },

  sorting = {
    priority_weight = 2,
    comparators = {
      compare.exact,
      compare.locality,
      compare.recently_used,
      compare.score,
      function(e1, e2)
        local l1 = #e1.completion_item.label
        local l2 = #e2.completion_item.label
        if l1 ~= l2 then return l1 < l2 end
      end,
      function(e1, e2)
        local function dots(s) local _, c = s:gsub('%.', '') return c end
        local d1, d2 = dots(e1.completion_item.label), dots(e2.completion_item.label)
        if d1 ~= d2 then return d1 < d2 end
      end,
      compare.kind,
      compare.sort_text,
      compare.length,
      compare.order,
    },
  },

  completion = { completeopt = 'menu,menuone' },

  window = {
    completion    = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },

  performance = {
    debounce = 60,
    throttle = 30,
    fetching_timeout = 200,
    filtering_context_budget = 10,
    confirm_resolve_timeout = 80,
    async_budget = 8,
    max_view_entries = 40,
  },

  experimental = { ghost_text = true },
})

-- LSP flags ----------------------------------------------------------------
local lsp_flags = { debounce_text_changes = 150 }

-- lua-language-server state dir
local state = vim.fn.stdpath('state') .. '/lua-language-server'
vim.fn.mkdir(state, 'p')

-- Utility: enable many servers
local function enable_servers(list)
  for _, name in ipairs(list) do vim.lsp.enable(name) end
end

-- Server configs (core API) ------------------------------------------------
vim.lsp.config['lua_ls'] = {
  cmd = {
    'lua-language-server',
    '--logpath=' .. state,
    '--metapath=' .. (state .. '/meta'),
  },
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = (function()
          local rtp = vim.split(package.path, ';')
          rtp[#rtp + 1] = 'lua/?.lua'
          rtp[#rtp + 1] = 'lua/?/init.lua'
          rtp[#rtp + 1] = os.getenv('HOME') .. '/.luarocks/share/lua/5.1/?.lua'
          return rtp
        end)(),
        pathStrict = true,
      },
      diagnostics = { globals = { 'vim', '_G', 'io', 'os' } },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
        cache = { directory = vim.fn.stdpath('cache') .. '/lua-language-server' },
        ignoreDir = { 'undo', '.git' },
      },
      telemetry = { enable = false },
      cache = { directory = vim.fn.stdpath('cache') .. '/lua-language-server' },
    },
  },
}

vim.lsp.config.cmake = {
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local start = vim.fs.dirname(fname)
    local found = vim.fs.find({ "CMakeLists.txt", ".git" }, { upward = true, path = start })[1]
    local dir = found and vim.fs.dirname(found) or vim.fn.getcwd()
    on_dir(dir)                     -- call the callback; don't return
  end,
}

vim.lsp.config['ts_ls'] = {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}

vim.lsp.config['pyright'] = {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
  -- settings = { python = { analysis = { autoImportCompletions = false } } },
}

vim.lsp.config['bashls'] = {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}

vim.lsp.config['gopls'] = {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}

vim.lsp.config['clangd'] = {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
  filetypes = { 'c', 'cu', 'cpp', 'objc', 'objcpp', 'cuda' },
  cmd = {
    'clangd',
    '--query-driver=/usr/bin/clang++,/opt/cuda/bin/nvcc',
    '--compile-commands-dir=build',
    '--background-index',
    '--all-scopes-completion',
  },
}

-- Enable them all -----------------------------------------------------------
enable_servers({ 'lua_ls', 'cmake', 'ts_ls', 'pyright', 'bashls', 'gopls', 'clangd' })

-- Treesitter ---------------------------------------------------------------
require('nvim-treesitter.configs').setup({
  modules = {},
  ensure_installed = {
    'c','cpp','lua','vim','vimdoc','rust','python','go','bash',
    'toml','json','yaml','scala','cmake','make','markdown','markdown_inline','query','regex'
  },
  sync_install = false,
  ignore_install = { 'javascript', 'typescript' },
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
  fold = { enable = true },
})

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr   = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = false

return M
