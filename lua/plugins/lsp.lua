return {
    -- Sets up Neovim to use LSP for enhanced language features like code navigation and diagnostics.
    { "neovim/nvim-lspconfig" },
    -- Implementation for code snippets, allowing for quick insertion of templated code blocks.
    { "hrsh7th/vim-vsnip" },
    -- The core engine for handling autocompletions, integrates with various sources to gather completions.
    { "hrsh7th/nvim-cmp",                    requires = { 'neovim/nvim-lspconfig' } },
    -- Enhances the core completion functionality with support for LSP-driven code suggestions.
    { "hrsh7th/cmp-nvim-lsp",                requires = { 'hrsh7th/nvim-cmp' } },
    -- Provides suggestions from the text in the current buffer, helping to autocomplete words already typed.
    { "hrsh7th/cmp-buffer",                  requires = { 'hrsh7th/nvim-cmp' } },
    -- Enables autocompletion of filesystem paths, making it easier to navigate directories and files.
    { "hrsh7th/cmp-path",                    requires = { 'hrsh7th/nvim-cmp' } },
    -- Allows nvim-cmp to suggest snippets from vim-vsnip in the completion menu.
    { "hrsh7th/cmp-vsnip",                   requires = { 'hrsh7th/nvim-cmp', 'hrsh7th/vim-vsnip' } },
    -- Adds function signature information to the completions, helping you to see parameter info as you type.
    { "hrsh7th/cmp-nvim-lsp-signature-help", requires = { 'hrsh7th/nvim-cmp' } },
    -- In your plugin manager
    { 'p00f/clangd_extensions.nvim' },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    keymap = {
                        accept = "<C-g>",
                        next = "<C-n>",
                        prev = "<C-p>",
                        dismiss = "<C-\\>",
                    },
                },
                panel = { enabled = false },
            })
        end,
    }
}
