local suitetype = "full"
-- List = require 'pl.List'
-- pretty = require 'pl.pretty'

if suitetype == "full" then
    require('plugins.packs')  -- ./lua/plugins.lua
    require('core')           -- ./lua/core.lua
    require('builtins')       -- ./lua/builtins.lua
    require('leaders')
    require('mappings')
    require('plugins.telescope')
    require('plugins.lsp')
end
print("hello")

-- function bufdump()
--     local l = List(vim.fn.getbufinfo({buflisted = 1})):filter(
--         function(x) 
--             print(x.bufnr)
--             local v = vim.fn.getbufvar(x.bufnr, '&buftype', 'terminal')
--             pretty.dump(v)
--             return v == "" 
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
