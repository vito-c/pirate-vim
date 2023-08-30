local suitetype = "full"
-- List = require 'pl.List'
-- pretty = require 'pl.pretty'

if suitetype == "bootstrap" then
	require('plugins.packs')       -- ./lua/plugins/packs.lua
end
if suitetype == "full" then
    require('plugins.packs')       -- ./lua/plugins/packs.lua
    require('autocmds')            -- ./lua/autocmds.lua
    require('builtins')            -- ./lua/builtins.lua
    require('core')                -- ./lua/core.lua
    require('leaders')             -- ./lua/leaders.lua
    require('mappings')            -- ./lua/mappings.lua
    require('plugins.fugitive')    -- ./lua/plugins/fugitive.lua
    require('plugins.metals')    -- ./lua/plugins/metals.lua
    require('plugins.lsp')         -- ./lua/plugins/lsp.lua
    require('plugins.tabularize')  -- ./lua/plugins/tabularize.lua
    require('plugins.telescope')   -- ./lua/plugins/telescope.lua
    require('plugins.luasnip')     -- ./lua/plugins/luasnip.lua
    require('plugins.airline')     -- ./lua/plugins/airline.lua
end
if suitetype == "small" then
    require('core')                -- ./lua/core.lua
    require('leaders')             -- ./lua/leaders.lua
    require('mappings')            -- ./lua/mappings.lua

    vim.cmd [[packadd packer.nvim]]

    return require('packer').startup(function(use)
        -- Packer can manage itself
        use 'wbthomason/packer.nvim'
        use 'vito-c/vim-one'
        use 'joshdick/onedark.vim'
        use 'tpope/vim-vinegar'
        use 'tomtom/tcomment_vim'
    end)

end



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
