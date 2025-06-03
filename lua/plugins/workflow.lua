return {
	{
		"AckslD/nvim-neoclip.lua",
		dependencies = {
			{ 'nvim-telescope/telescope.nvim' },
		},
		config = function()
			require('neoclip').setup()
		end,
	},
	{ "tomtom/tcomment_vim" },
	{ "mbbill/undotree" },
	{ "tpope/vim-repeat" },
	{ "tpope/vim-surround" },
	{ "AndrewRadev/splitjoin.vim" },
	{ "tommcdo/vim-exchange" },
	{ "godlygeek/tabular" },
	{
		'tpope/vim-abolish',
		config = function()
			vim.cmd('Abolish teh the')
			vim.cmd('Abolish chomd chmod')
			vim.cmd('Abolish ehco echo')
			vim.cmd('Abolish pritnln println')
			vim.cmd('Abolish pritn print')
			vim.cmd('Abolish orig original')
			vim.cmd('Abolish vheicle vehicle')
		end,
	},
	{ "tpope/vim-rhubarb" },
	{ "tpope/vim-fugitive" },
	{ "tpope/vim-vinegar" },
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzy-native.nvim" },
			{ "pwntester/octo.nvim" },
			{ "sudormrfbin/cheatsheet.nvim" },
		}
	},
	{
		"nvim-telescope/telescope-media-files.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" }
	},
	{ "tpope/vim-obsession" },
	{ "mhinz/vim-startify" },
	{ 'scalameta/nvim-metals', requires = { "nvim-lua/plenary.nvim" } }
}
