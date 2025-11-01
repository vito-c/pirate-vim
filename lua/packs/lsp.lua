-------------------------------------------------------------------------------
-- Neovim API aliases
-------------------------------------------------------------------------------
local lsp = require("lspconfig") -------------------------------------------------------------------------------
local M = {}
-- Neovim API aliases
-------------------------------------------------------------------------------


local opts = { noremap = true, silent = true }
-- Float at cursor (default)
vim.keymap.set('n', '<leader>ek', function()
  vim.diagnostic.open_float({
    bufnr = 0,
    scope = 'cursor',
    focus = false,
  })
end, { desc = 'Diagnostic float at cursor' })


-- Force show for the whole line:
vim.keymap.set('n', '<leader>eK', function()
  vim.diagnostic.open_float({
    bufnr = 0,
    scope = 'line',
    focus = false,
  })
end, { desc = 'Diagnostic float for line' })

-- Next/prev diagnostic (new API)
vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump({ count = 1, float = true })   -- show popup on jump
end, { silent = true, desc = 'Next diagnostic' })
vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { silent = true, desc = 'Prev diagnostic' })

-- Only errors
vim.keymap.set('n', ']e', function()
  vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR, float = true })
end, { silent = true, desc = 'Next error' })

vim.keymap.set('n', '[e', function()
  vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR, float = true })
end, { silent = true, desc = 'Prev error' })

vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- local function bmap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>kd', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>ka', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    -- vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', 'gd', function() require('telescope.builtin').lsp_definitions() end,
        { noremap = true, silent = true })

    -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<leader>ki', function() require('telescope.builtin').lsp_implementations() end,
        { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>kr', function() require('telescope.builtin').lsp_references() end,
        { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>kh', ':ClangdSwitchSourceHeader<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>ks', ':ClangdShowSymbolInfo<CR>', { noremap = true, silent = true })
    --   -- bmap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    --   -- bmap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    vim.keymap.set('n', '<leader>F', function()
        vim.lsp.buf.format { async = true }
    end, { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>fF', function()
        vim.lsp.buf.format { async = true }
    end, { noremap = true, silent = true })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Force utf-16 encoding for all clients to ensure compatibility with Copilot
capabilities = vim.tbl_deep_extend('force', capabilities, {
    offsetEncoding = { 'utf-16' },
    general = {
        positionEncodings = { 'utf-16' },
    },
})

local cmp = require("cmp")
local compare = require("cmp.config.compare")

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },

  mapping = cmp.mapping.preset.insert({
    ["<C-n>"]     = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-j>"]     = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-p>"]     = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-k>"]     = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-d>"]     = cmp.mapping.scroll_docs(-4),
    ["<C-f>"]     = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"]     = cmp.mapping.abort(),
    ["<CR>"]      = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
    ["<Tab>"]      = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
  }),

  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "vsnip" },
    { name = "buffer" },
    { name = "nvim_lsp_signature_help" },
  }),

  preselect = cmp.PreselectMode.None,

  -- Tame fuzzy so exact/short matches win (e.g., Path)
  matching = {
    disallow_fuzzy_matching = true,
    disallow_fullfuzzy_matching = true,
    disallow_partial_fuzzy_matching = true,
    disallow_partial_matching = true,           -- <- add this
    disallow_prefix_unmatching = true,
    disallow_symbol_nonprefix_matching = true,  -- <- and this
  },
  sorting = {
    priority_weight = 2,
    comparators = {
      compare.exact,        -- exact prefix first
      compare.locality,     -- prefer nearby symbols
      compare.recently_used,
      compare.score,        -- LSP score
      -- prefer shorter labels (puts "Path" over long auto-imports)
      function(e1, e2)
        local l1 = #e1.completion_item.label
        local l2 = #e2.completion_item.label
        if l1 ~= l2 then return l1 < l2 end
      end,
      -- fewer dots earlier (de-prioritize deep dotted names)
      function(e1, e2)
        local function dots(s) local _, c = s:gsub("%.", ""); return c end
        local d1, d2 = dots(e1.completion_item.label), dots(e2.completion_item.label)
        if d1 ~= d2 then return d1 < d2 end
      end,
      compare.kind,
      compare.sort_text,
      compare.length,
      compare.order,
    },
  },

  completion = {
    completeopt = "menu,menuone",
  },

  window = {
    completion    = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },

  performance = {
    debounce = 60,                   -- ms to wait after input before requesting items
    throttle = 30,                   -- ms minimum between refreshes
    fetching_timeout = 200,          -- ms LSP/source fetch timeout
    filtering_context_budget = 10,   -- ms budget to filter items
    confirm_resolve_timeout = 80,    -- ms to resolve additional item info on confirm
    async_budget = 8,                -- ms per tick for async work
    max_view_entries = 40,           -- how many items to render
  },
  experimental = { ghost_text = true },
})

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}

local state = vim.fn.stdpath('state') .. '/lua-language-server'
vim.fn.mkdir(state, 'p')

require 'lspconfig'.lua_ls.setup {
    cmd = {
        'lua-language-server',
        '--logpath=' .. state,
        '--metapath=' .. (state .. '/meta'),
    },
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = (function()
                    local rtp = vim.split(package.path, ';')
                    rtp[#rtp + 1] = 'lua/?.lua'
                    rtp[#rtp + 1] = 'lua/?/init.lua'
                    rtp[#rtp + 1] = os.getenv("HOME") .. '/.luarocks/share/lua/5.1/?.lua'
                    return rtp
                end)(),
                pathStrict = true,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim", "_G", "io", "os" }
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
                cache = {
                    directory = vim.fn.stdpath('cache') .. '/lua-language-server',
                },
                ignoreDir = { 'undo', '.git' },
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
            cache = {
                directory = vim.fn.stdpath('cache') .. '/lua-language-server',
            },
        },
    },
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities
}

require 'lspconfig'.cmake.setup {
    cmd = { "cmake-language-server" },
    capabilities = capabilities,
    filetypes = { "cmake" },
    root_dir = require('lspconfig.util').root_pattern("CMakeLists.txt", ".git"),
    single_file_support = true,
    on_attach = on_attach
}

require 'lspconfig'.ts_ls.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities
}
require('lspconfig').pyright.setup({
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,  -- keep your existing caps
})
require('lspconfig')['bashls'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities
}
require('lspconfig')['gopls'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities
}
require('lspconfig')['clangd'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    filetypes = { "c", "cu", "cpp", "objc", "objcpp", "cuda" },
    cmd = {
        "clangd",
        "--query-driver=/usr/bin/clang++,/opt/cuda/bin/nvcc",
        "--compile-commands-dir=build",
        "--background-index",
        "--all-scopes-completion",
    }
}

require 'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
    modules = {},
    ensure_installed = {
        "c", "cpp", "lua", "vim", "vimdoc",
        "rust", "python", "go", "bash",
        "toml", "json", "yaml", "scala",
        "cmake", "make", "markdown", "markdown_inline", "query", "regex"
    },
    sync_install = false,
    ignore_install = { "javascript", "typescript" },
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
    },
    indent = {
        enable = true, -- Enable Treesitter-based indentation
    },
    fold = {
        enable = true
    }
}

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr   = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = false -- Disable folding by default
return M
