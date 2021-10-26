-------------------------------------------------------------------------------
-- Neovim API aliases
-------------------------------------------------------------------------------
local function nmap(keys, command)
    vim.api.nvim_set_keymap('n', keys, command, {noremap = true})
end
local function vmap(keys, command)
    vim.api.nvim_set_keymap('v', keys, command, {noremap = true})
end


nmap("<leader>a&", ":Tabularize /&<CR>")
vmap("<leader>a&", ":Tabularize /&<CR>")
nmap("<leader>a+", ":Tabularize /+<CR>")
vmap("<leader>a+", ":Tabularize /+<CR>")
nmap("<leader>a=", ":Tabularize /=<CR>")
vmap("<leader>a=", ":Tabularize /=<CR>")
nmap("<leader>a:", ":Tabularize /:<CR>")
vmap("<leader>a:", ":Tabularize /:<CR>")
nmap("<leader>a::", ":Tabularize /:\zs<CR>")
vmap("<leader>a::", ":Tabularize /:\zs<CR>")
nmap("<leader>a{", ":Tabularize /{<CR>")
vmap("<leader>a}", ":Tabularize /}<CR>")
nmap("<leader>a,", ":Tabularize /,<CR>")
vmap("<leader>a,", ":Tabularize /,<CR>")
vmap("<leader>a ", ":Tabularize / <CR>")

nmap("<leader>a<Bar>", ":Tabularize /<Bar><CR>")
vmap("<leader>a<Bar>", ":Tabularize /<Bar><CR>")
