------------------------------------------------------------
-- Neovim API aliases
------------------------------------------------------------
local kmap = vim.api.nvim_set_keymap  -- set global keymap
local cmd  = vim.cmd     	          -- execute Vim commands
local exec = vim.api.nvim_exec 	      -- execute Vimscript
local fn   = vim.fn       		      -- call Vim functions
local g    = vim.g         	          -- global variables
local opt  = vim.opt         	      -- global/buffer/windows-scoped options

function nmap(keys, command)
    vim.api.nvim_set_keymap('n', keys, command, {noremap = true})
end

require("telescope").setup({
  defaults = {
    color_devicons = false,
    layout_config = {
      bottom_pane = {
        height = 25
      },
      center = {
        height = 0.9,
        preview_cutoff = 40,
        width = 0.8
      },
      cursor = {
        height = 0.9,
        preview_cutoff = 40,
        width = 0.8
      },
      horizontal = {
        height = 0.9,
        preview_cutoff = 120,
        prompt_position = "bottom",
        width = 0.8
      },
      vertical = {
        height = 0.95,
        preview_cutoff = 20,
        width = 0.9
      }
    },
    mappings = {
      i = {
        ["<c-j>"] = require('telescope.actions').move_selection_next,
        ["<c-k>"] = require('telescope.actions').move_selection_previous,
      },
      n = {
        ["<c-j>"] = require('telescope.actions').move_selection_next,
        ["<c-k>"] = require('telescope.actions').move_selection_previous,
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  },
})

require("telescope").load_extension("fzy_native")
require("telescope").load_extension("fzy_native")

-------------------------------------------------------------------------------
-- Mappings
-------------------------------------------------------------------------------
nmap('<leader>ff', ":lua require('telescope.builtin').find_files({layout_strategy='vertical'})<CR>")
nmap('<leader>l',  ":lua require('telescope.builtin').buffers({layout_strategy='vertical'})<CR>")
nmap('<leader>gc', ":lua require('telescope.builtin').git_bcommits({layout_strategy='vertical'})<CR>")
-- Telescope git_bcommits
