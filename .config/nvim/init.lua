vim = vim
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.backup = false -- creates a backup file
vim.o.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.o.fileencoding = "utf-8" -- the encoding written to a file
vim.o.hlsearch = true -- highlight all matches on previous search pattern
vim.o.ignorecase = true -- ignore case in search patterns
vim.o.mouse = "a" -- allow the mouse to be used in neovim
vim.o.pumheight = 10 -- pop up menu height
vim.o.smartcase = true -- smart case
vim.o.smartindent = true -- make indenting smarter again
vim.o.splitbelow = true -- force all horizontal splits to go below current window
vim.o.splitright = true -- force all vertical splits to go to the right of current window
vim.o.swapfile = false -- creates a swapfile
vim.o.termguicolors = true -- set term gui colors (most terminals support this)
vim.o.timeoutlen = 1000 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.o.undofile = true -- enable persistent undo
vim.o.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.o.expandtab = true -- convert tabs to spaces
vim.o.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.o.tabstop = 4 -- insert 2 spaces for a tab
vim.o.cursorline = true -- highlight the current line
vim.o.number = true -- set numbered lines
vim.o.laststatus = 3 -- only the last window will always have a status line
vim.o.showcmd = false -- hide (partial) command in the last line of the screen (for performance)
vim.o.numberwidth = 4 -- minimal number of columns to use for the line number {default 4}
vim.o.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
vim.o.wrap = false -- display lines as one long line
vim.o.scrolloff = 8 -- minimal number of screen lines to keep above and below the cursor
vim.o.sidescrolloff = 8 -- minimal number of screen columns to keep to the left and right of the cursor if wrap is `false`
vim.o.autowriteall = true
vim.o.autoread = true
vim.o.winborder = "rounded"
vim.opt.whichwrap:append("<,>,[,],h,l") -- keys allowed to move to the previous/next line when the beginning/end of line is reached
vim.opt.iskeyword:append("-") -- treats words with `-` as single words

local map = vim.keymap.set
local opts = { silent = true, noremap = true }
--Remap space as leader key
map("", "<space>", "<Nop>", opts)

map({ "n", "v" }, "<leader>w", "<cmd>wall<cr>", opts) -- write all
map({ "n", "v" }, "<leader>W", "<cmd>noautocmd wall<cr>", opts) -- write all (don't auto format)
map({ "n", "v" }, "<leader>q", "<cmd>quitall<cr>", opts) -- quit all
map({ "n", "v" }, "<leader>x", "<cmd>confirm xall<cr>", opts) -- write quit all
map("n", "gq", "<cmd>quit<cr>", opts)
map("n", "j", "gj", opts)
map("n", "k", "gk", opts)
map("v", "j", "gj", opts)
map("v", "k", "gk", opts)

-- show full filename
map("n", "<C-g>", "1<C-g>", opts)
map("n", "<leader><C-g>", function()
	vim.cmd('echo "Copying path to clipboard: " .. expand("%:p")')
	vim.cmd('let @* = expand("%:p")')
end, opts)
map("n", "<leader>gh", "<cmd> Gitsigns preview_hunk<cr>", opts)
map("n", "<leader>gb", "<cmd> Git blame<cr>", opts)
map("n", "<leader>rh", "<cmd> Gitsigns reset_hunk<cr>", opts)
map("n", "<leader>rb", "<cmd> Gitsigns reset_buffer<cr>", opts)
map("n", "<leader>nh", "<cmd> Gitsigns next_hunk<cr>", opts)
map("n", "<leader>ph", "<cmd> Gitsigns prev_hunk<cr>", opts)

-- Better window navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)
-- Resize with arrows
map("n", "<S-Up>", ":resize -2<cr>", opts)
map("n", "<S-Down>", ":resize +2<cr>", opts)
map("n", "<S-Left>", ":vertical resize -2<cr>", opts)
map("n", "<S-Right>", ":vertical resize +2<cr>", opts)
-- Navigate buffers
map("n", "<S-l>", "<cmd>bnext<cr>", opts)
map("n", "<S-h>", "<cmd>bprevious<cr>", opts)
-- Clear highlights
map("n", "<leader>h", "<cmd>nohlsearch<cr>", opts)
-- Close buffers
-- Better paste
map("v", "p", '"_dP', opts)
-- Better escape
map({ "i", "c" }, "jk", "<esc>", opts)
-- Stay in indent mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)
-- Move Test up and down --
map("v", "J", ":m '>+1<cr>gv=gv", opts)
map("v", "K", ":m '<-2<cr>gv=gv", opts)

map({ "n", "v" }, "<leader>E", "<cmd>e %:h<cr>", opts)

vim.cmd([[autocmd FileType markdown setlocal wrap linebreak]])

local plugins = {
	{ "nvim-tree/nvim-web-devicons" },
	{ "github/copilot.vim" },
	{ "nvim-lualine/lualine.nvim", opts = { sections = { lualine_c = { { "filename", path = 2 } } } } },
	{ "lewis6991/gitsigns.nvim", opts = {} },
	{ "tpope/vim-surround", config = function() end },
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		init = function()
			vim.cmd.colorscheme("tokyonight")
		end,
	},
	{
		"NickvanDyke/opencode.nvim",
		config = function()
			vim.o.autoread = true
			map({ "n", "v" }, "<leader>o", function()
				require("opencode").select()
			end, { desc = "Execute opencode action…" })
			map({ "n", "t" }, "<C-/>", function()
				require("opencode").toggle()
			end, { desc = "Opencode: Toggle terminal" })
		end,
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			gh = {},
			terminal = {},
			words = {},
			lazygit = { win = { style = "lazygit" } },
			zen = {
				toggles = {
					dim = false,
					git_signs = true,
				},
				show = { statusline = true, tabline = true },
				win = { backdrop = { transparent = false } },
			},
			explorer = { replace_netrw = true, trash = true },
			indent = { animate = { enabled = false } },
			styles = {
				lazygit = {
					height = 0,
					width = 0,
				},
			},
			input = {
				win = {
					relative = "cursor",
					row = -3,
					keys = { ["jk"] = { "close", mode = { "i", "n" } } },
				},
			},
			picker = {
				matcher = { ignorecase = true },
				ui_select = true,
				exclude = { -- add folder names here to exclude
					"node_modules",
				},
				win = {
					input = { keys = { ["jk"] = { "close", mode = "i" } } },
					list = {
						keys = {
							["J"] = { "preview_scroll_down", mode = "n" },
							["K"] = { "preview_scroll_up", mode = "n" },
						},
					},
				},
				sources = {
					explorer = {
						hidden = true,
						ignored = true,
						auto_close = true,
						layout = { preset = "default", preview = true, fullscreen = true },
					},
				},
			},
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					Snacks = Snacks
					map({ "n", "v" }, "<leader>gg", Snacks.lazygit.open, opts)
					map("n", "<leader><space>", Snacks.picker.smart, opts)
					map("n", "<leader>fo", Snacks.picker.recent, opts)
					map("n", "<leader>fr", Snacks.picker.registers, opts)
					map("n", "<leader>fl", Snacks.picker.jumps, opts)
					map("n", "<leader>fh", Snacks.picker.help, opts)
					map("n", "<leader>fg", Snacks.picker.git_status, opts)
					map("n", "<leader>ff", Snacks.picker.files, opts)
					map("n", "<leader>ft", Snacks.picker.grep, opts)
					map("n", "g*", Snacks.picker.grep_word, opts)
					map("n", "<leader>/", Snacks.picker.lines, opts)
					map({ "n", "v" }, "<leader>e", function()
						Snacks.explorer()
					end, opts)
					map("n", "<leader>z", function()
						Snacks.zen()
					end, opts)

					map({ "n", "i", "v" }, "<M-j>", function()
						Snacks.words.jump(1, true)
					end, opts)
					map({ "n", "i", "v" }, "<M-k>", function()
						Snacks.words.jump(-1, true)
					end, opts)
					map("n", "<S-q>", function()
						Snacks.bufdelete({ force = true })
					end, opts)
				end,
			})
		end,
	},
	{
		"akinsho/bufferline.nvim",
		opts = {},
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = {
				"html",
				"ts_ls",
				"eslint",
				"pyright",
				"jsonls",
				"yamlls",
				"gopls",
				"bashls",
				"tailwindcss",
				"svelte",
				"rust_analyzer",
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		init = function()
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
			vim.opt.foldlevel = 99
		end,
		opts = {
			ensure_installed = "all",
			sync_install = false,
			auto_install = true,
			highlight = { enable = true },
		},
	},
	{
		"stevearc/conform.nvim", -- file formatter
		opts = {
			default_format_opts = { timeout_ms = 500, lsp_format = "fallback" },
			format_on_save = {},
			formatters_by_ft = {
				typescript = { "biome" },
				typescriptreact = { "biome" },
				json = { "biome" },
				python = { "black" },
				go = { "gofmt" },
				lua = { "stylua" },
				bash = { "shfmt" },
			},
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "1.*",
		opts = {
			enabled = function()
				return not vim.tbl_contains({ "markdown" }, vim.bo.filetype)
			end,
			-- :h blink-cmp-config-keymap
			keymap = {
				preset = "enter",
				["<C-k>"] = { "select_prev", "fallback" },
				["<C-j>"] = { "select_next", "fallback" },
			},
			appearance = { nerd_font_variant = "mono" },
			completion = { documentation = { auto_show = true } },
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(plugins)

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local lsp_opts = { buffer = args.buf, silent = true, noremap = true }

		map("n", "gD", vim.lsp.buf.declaration, lsp_opts)
		-- only map K if not already mapped by snacks explorer
		if vim.fn.mapcheck("K", "n") == "" then
			map("n", "K", vim.lsp.buf.hover, lsp_opts)
		end

		for _, key in ipairs({ "grr", "grn", "gra", "grp", "gri", "grt" }) do
			pcall(vim.keymap.del, "n", key)
		end

		map("n", "gl", vim.diagnostic.open_float, lsp_opts)
		map("n", "<leader>li", "<cmd>LspInfo<cr>", lsp_opts)
		map("n", "<leader>lm", "<cmd>Mason<cr>", lsp_opts)
		map("n", "<leader>lr", vim.lsp.buf.rename, lsp_opts)
		map("n", "<leader>ls", vim.lsp.buf.signature_help, lsp_opts)
		map("n", "<leader>L", vim.diagnostic.setloclist, lsp_opts)
		map("n", "<a-cr>", vim.lsp.buf.code_action, lsp_opts)
		map("n", "gI", Snacks.picker.lsp_implementations, lsp_opts)
		map("n", "gr", Snacks.picker.lsp_references, lsp_opts)
		map("n", "gd", Snacks.picker.lsp_definitions, lsp_opts)

		map("n", "<leader>lf", function()
			vim.lsp.buf.format({ async = true })
		end, lsp_opts)
		map("n", "<leader>j", function()
			vim.diagnostic.jump({
				count = 1,
				float = true,
				on_jump = vim.diagnostic.open_float,
			})
		end, lsp_opts)
		map("n", "<leader>k", function()
			vim.diagnostic.jump({
				count = -1,
				float = true,
				on_jump = vim.diagnostic.open_float,
			})
		end, lsp_opts)
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- change the cwd of nvim to be the .git root when I open a file
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		local buftype = vim.bo[0].buftype
		if buftype ~= "" and buftype ~= "acwrite" then
			return
		end
		local current_file = vim.api.nvim_buf_get_name(0)
		if current_file == "" then
			return
		end
		local git_root = vim.fs.dirname(vim.fs.find(".git", {
			path = vim.fs.dirname(current_file),
			upward = true,
		})[1])
		if git_root and vim.fn.getcwd() ~= git_root then
			vim.cmd.cd(git_root)
		end
	end,
})
