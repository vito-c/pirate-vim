-------------------------------------------------------------------------------
-- Neovim API aliases
-------------------------------------------------------------------------------
local function nmap(keys, command)
    vim.api.nvim_set_keymap('n', keys, command, {noremap = true})
end

-- nmap('<leader>gs', ':call OpenGStatusTab()<CR>')
nmap('<leader>gdh', ':Gvdiff HEAD<CR>')
nmap('<leader>gdm', ':Gvdiff origin/master<CR>')
nmap('<leader>gdu', ':Gvdiff upstream/master<CR>')
nmap('<leader>gb', ':Git blame<CR>')
nmap('<leader>gl', ':Glog<CR>')
