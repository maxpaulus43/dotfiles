-- https://github.com/folke/lazy.nvim
-- :help lazy.nvim.txt
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"tpope/vim-fugitive",
	"tpope/vim-surround",
	"tpope/vim-repeat",
	"tpope/vim-sleuth",
	"mbbill/undotree",
	"moll/vim-bbye",
	"RRethy/vim-illuminate",
	"akinsho/toggleterm.nvim",
	require("my.telescope"),
	require("my.none-ls"),
	"akinsho/bufferline.nvim",
	{
		"David-Kunz/jester",
		opts = {
			cmd = "npx jest test -t '$result' -- $file",
		},
	},
	require("my.mkdnflow"),
	require("my.project"),
	require("my.gitsigns"),
	require("my.autoformat"),
	require("my.debug"),
	-- require("my.nvim-tree"),
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-files.md
		"echasnovski/mini.files",
		version = "*",
		opts = {
			mappings = {
				go_in = "",
				go_in_plus = "l",
				go_out = "",
				go_out_plus = "h",
				synchronize = "<CR>",
			},
			windows = {
				preview = true,
				width_preview = 50,
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			{ "williamboman/mason-lspconfig.nvim", dependencies = { "mfussenegger/nvim-jdtls" } },
			{ "j-hui/fidget.nvim",                 tag = "legacy",                              config = true },
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"rafamadriz/friendly-snippets",
			-- {
			-- 	-- url = "ssh://git.amazon.com/pkg/AmazonQNVim",
			-- 	dir = "/Users/maxpaulu/workplace/q-nvim/src/AmazonQNVim",
			-- 	opts = {
			-- 		wrap = true,
			-- 		ssoStartUrl = "https://amzn.awsapps.com/start",
			-- 		lsp_server_cmd = {
			-- 			"node",
			-- 			"/Users/maxpaulu/workplace/q-nvim/src/AmazonQNVim/language-server/build/aws-lsp-codewhisperer-token-binary.js",
			-- 			-- vim.fn.stdpath("data")
			-- 			-- .. "/lazy/AmazonQNVim"
			-- 			-- .. "/language-server/build/aws-lsp-codewhisperer-token-binary.js",
			-- 			"--stdio",
			-- 		},
			-- 	},
			-- },
		},
	},
	{
		"navarasu/onedark.nvim",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("onedark")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		-- See `:help lualine.txt`
		opts = {
			options = {
				icons_enabled = false,
				theme = "onedark",
				component_separators = "|",
				section_separators = "",
			},
			sections = {
				lualine_c = { { "filename", path = 3, shorting_target = 80 } },
			},
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		-- :help ibl
		main = "ibl",
		config = true,
	},
	{ "numToStr/Comment.nvim", opts = {} },
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
	},
}, {})
