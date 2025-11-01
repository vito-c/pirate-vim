local suitetype = "lazy"
-- Add the luarocks directory to package.path
-- This will take care of the luarocks pelanry I installed
local home = os.getenv("HOME")
-- Alternatively, you can use package.path directly
package.path = package.path .. ";" .. home .. "/.luarocks/share/lua/5.1/?.lua"
package.path = package.path .. ";" .. home .. "/.luarocks/share/lua/5.1/?/init.lua"

local home = vim.loop.os_homedir() or os.getenv("HOME")

vim.opt.path:append({
  home .. "/code/startup/videoblast/**",
  home .. "/code/startup/opencv/**",
  home .. "/code/startup/opencv_contrib/modules/**",  -- note: 'modules', not 'ontrib/modules'
  ".",
  vim.fn.expand("$HOME/code/startup/producer"),
  vim.fn.expand("$HOME/code/startup/producer/src"),
  "**",
})


if suitetype == "bootstrap" then
    require('plugins.packs') -- ./lua/plugins/packs.lua
end

-- if suitetype == "treesitter" then
--     require('plugins.packs_treesitter') -- ./lua/plugins/packs_treesitter.lua
-- end

if suitetype == "none" then
	print("vanilla")
end

if suitetype == "lazy" then
    require("groot")
    require("config.lazy")        -- ./lua/config/lazy.lua 
    require("lazy").setup({
        spec = {
            -- import your plugins
            { import = "plugins" },
        },
        change_detection = {
            enabled = false,
            notify = false,
        },
        install = { colorscheme = { "one" } },
        checker = { enabled = true },
    })
    require('autocmds')           -- ./lua/autocmds.lua
    require('builtins')           -- ./lua/builtins.lua
    require('core')               -- ./lua/core.lua
    require('leaders')            -- ./lua/leaders.lua
    require('mappings')           -- ./lua/mappings.lua
    require('packs.fugitive')     -- ./lua/packs/fugitive.lua
    -- require('packs.metals')       -- ./lua/packs/metals.lua
    require('packs.lsp')          -- ./lua/packs/lsp.lua
    require('packs.tabularize')   -- ./lua/packs/tabularize.lua
    require('packs.telescope')    -- ./lua/packs/telescope.lua
    require('packs.luasnip')      -- ./lua/packs/luasnip.lua
end

if suitetype == "packer" then
    require('packs.packs')        -- ./lua/packs/packs.lua
    require('autocmds')           -- ./lua/autocmds.lua
    require('builtins')           -- ./lua/builtins.lua
    require('core')               -- ./lua/core.lua
    require('leaders')            -- ./lua/leaders.lua
    require('mappings')           -- ./lua/mappings.lua
    require('packs.fugitive')     -- ./lua/packs/fugitive.lua
    require('packs.metals')       -- ./lua/packs/metals.lua
    require('packs.lsp')          -- ./lua/packs/lsp.lua
    require('packs.tabularize')   -- ./lua/packs/tabularize.lua
    require('packs.telescope')    -- ./lua/packs/telescope.lua
    require('packs.hologram')     -- ./lua/packs/hologram.lua
    require('packs.luasnip')      -- ./lua/packs/luasnip.lua
    require('packs.undotree')     -- ./lua/packs/undotree.lua
end

-- if suitetype == "small" then
--     require('core') -- ./lua/core.lua
--     -- require('leaders')             -- ./lua/leaders.lua
--     -- require('mappings')            -- ./lua/mappings.lua
--     require('plugins.metals') -- ./lua/plugins/metals.lua
--     vim.cmd [[packadd packer.nvim]]
--
--     return require('packer').startup(function(use)
--         use { 'neovim/nvim-lspconfig' }
--         -- Implementation for code snippets, allowing for quick insertion of templated code blocks.
--         use { 'hrsh7th/vim-vsnip' }
--         use({ 'scalameta/nvim-metals', requires = { "nvim-lua/plenary.nvim" } })
--         -- Packer can manage itself
--         use 'wbthomason/packer.nvim'
--         use 'vito-c/vim-one'
--         use 'joshdick/onedark.vim'
--         use 'tpope/vim-vinegar'
--         use 'tomtom/tcomment_vim'
--     end)
-- end
-- function bufdump()
--     local l = List(vim.fn.getbufinfo({buflisted = 1})):filter(
--         function(x)
--             print(x.bufnr)
--             local v = vim.fn.getbufvar(x.bufnr, '&buftype', 'terminal')
--             pretty.dump(v)
--             return v == "
--         end
--     )
--     pretty.dump(l)
-- end
--
-- for k,v in pairs(t) do
--     for a,b in pairs(v) do
--         print(a,b)
--     end
-- end
--
-- > List = require 'pl.List'
-- > ls = {1,2,3,4}
-- > List(ls):filter(function(x) return x & 1 == 0 end)
-- {2,4}
