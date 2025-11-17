vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- OPTIONS

vim.opt.backup = false                  -- creates a backup file
vim.opt.clipboard = "unnamedplus"       -- allows neovim to access the system clipboard
vim.opt.cmdheight = 1                   -- more space in the neovim command line for displaying messages
vim.opt.conceallevel = 0                -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"          -- the encoding written to a file
vim.opt.hlsearch = true                 -- highlight all matches on previous search pattern
vim.opt.ignorecase = true               -- ignore case in search patterns
vim.opt.mouse = "a"                     -- allow the mouse to be used in neovim
vim.opt.pumheight = 10                  -- pop up menu height
vim.opt.showmode = true                 -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 0                 -- always show tabs
vim.opt.smartcase = true                -- smart case
vim.opt.smartindent = true              -- make indenting smarter again
vim.opt.splitbelow = true               -- force all horizontal splits to go below current window
vim.opt.splitright = true               -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false                -- creates a swapfile
vim.opt.termguicolors = true            -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 1000               -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true                 -- enable persistent undo
vim.opt.writebackup = false             -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.expandtab = true                -- convert tabs to spaces
vim.opt.shiftwidth = 2                  -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2                     -- insert 2 spaces for a tab
vim.opt.cursorline = true               -- highlight the current line
vim.opt.number = true                   -- set numbered lines
vim.opt.relativenumber = false
vim.opt.laststatus = 3                  -- only the last window will always have a status line
vim.opt.showcmd = false                 -- hide (partial) command in the last line of the screen (for performance)
vim.opt.ruler = false                   -- hide the line and column number of the cursor position
vim.opt.numberwidth = 4                 -- minimal number of columns to use for the line number {default 4}
vim.opt.signcolumn = "yes"              -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = false                    -- display lines as one long line
vim.opt.scrolloff = 8                   -- minimal number of screen lines to keep above and below the cursor
vim.opt.sidescrolloff = 8               -- minimal number of screen columns to keep to the left and right of the cursor if wrap is `false`
vim.opt.shortmess:append("c")           -- hide all the completion messages, e.g. "-- XXX completion (YYY)", "match 1 of 2", "The only match", "Pattern not found"
vim.opt.whichwrap:append("<,>,[,],h,l") -- keys allowed to move to the previous/next line when the beginning/end of line is reached
vim.opt.iskeyword:append("-")           -- treats words with `-` as single words
vim.opt.autowriteall = true
vim.opt.autoread = true
vim.o.winborder = "rounded"

-- Shorten function name
local map = vim.keymap.set
-- Silent keymap option
local opts = { silent = true, noremap = true }
--Remap space as leader key
map("", "<space>", "<Nop>", opts)

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

map({ "n", "v" }, "<leader>w", "<cmd>wall<cr>", opts)           -- write all
map({ "n", "v" }, "<leader>W", "<cmd>noautocmd wall<cr>", opts) -- write all (don't auto format)
map({ "n", "v" }, "<leader>q", "<cmd>quitall<cr>", opts)        -- quit all
map({ "n", "v" }, "<leader>x", "<cmd>confirm xall<cr>", opts)   -- write quit all
map("n", "gq", "<cmd>quit<cr>", opts)
map("n", "j", "gj", opts)
map("n", "k", "gk", opts)
map("v", "j", "gj", opts)
map("v", "k", "gk", opts)
-- Normal --
-- undotree
map("n", "<F5>", "<cmd>UndotreeToggle<cr>", opts)
-- show full filename
map("n", "<C-g>", "1<C-g>", opts)
map("n", "<leader><C-g>", function()
    vim.cmd('echo "Copying path to clipboard: " .. expand("%:p")')
    vim.cmd('let @* = expand("%:p")')
end, opts)
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
map("n", "<S-q>", "<cmd>Bdelete!<cr>", opts)
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


local plugins = {
    { "nvim-lua/plenary.nvim" },                               -- used by other plugins
    { "nvim-tree/nvim-web-devicons" },                         -- used by other plugins
    { "moll/vim-bbye" },
    { "nvim-lualine/lualine.nvim",                opts = {} }, -- status line
    { "nvim-tree/nvim-tree.lua" },                             -- file browser
    { "nvim-telescope/telescope.nvim",            opts = {} },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    require("my.telescope"),
    {
        "akinsho/bufferline.nvim",
        opts = {},
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons"
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
                "lua_ls",
                "rust_analyzer",
            },

        },
    },
    {
        "navarasu/onedark.nvim",
        init = function()
            vim.cmd.colorscheme("onedark")
        end
    },
    {
        "mikavilpas/yazi.nvim",
        version = "*", -- use the latest stable version
        event = "VeryLazy",
        keys = {
            {
                "<leader>e",
                mode = { "n", "v" },
                "<cmd>Yazi<cr>",
                desc = "Open yazi at the current file",
            },
        },
        opts = {
            -- open yazi instead of netrw
            open_for_directories = true,
            keymaps = { show_help = "<f1>" },
        },
        init = function()
            -- mark netrw as loaded so it's not loaded at all.
            -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
            vim.g.loaded_netrwPlugin = 1
        end,
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
            highlight = { enable = true, },
        }
    },
    {
        "stevearc/conform.nvim", -- file formatter
        opts = {
            default_format_opts = { lsp_format = "fallback" },
            formatters_by_ft = {
                typescript = { "prettier" },
                typescriptreact = { "prettier" },
                json = { "prettier" },
            },
        }
    },
    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },
        version = '1.*',
        opts = {
            -- :h blink-cmp-config-keymap
            keymap = {
                preset = "enter",
                ['<C-k>'] = { 'select_prev', 'fallback' },
                ['<C-j>'] = { 'select_next', 'fallback' },
            },
            appearance = { nerd_font_variant = "mono" },
            completion = { documentation = { auto_show = true } },
            sources = { default = { "lsp", "path", "snippets", "buffer" } },
            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    } }

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

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local lsp_opts = { buffer = args.buf, silent = true, noremap = true }

        map("n", "gD", vim.lsp.buf.declaration, lsp_opts)
        map("n", "gd", require("telescope.builtin").lsp_definitions, lsp_opts)
        map("n", "K", vim.lsp.buf.hover, lsp_opts)
        map("n", "gl", vim.diagnostic.open_float, lsp_opts)
        map("n", "<leader>li", "<cmd>LspInfo<cr>", lsp_opts)
        map("n", "<leader>lm", "<cmd>Mason<cr>", lsp_opts)
        map("n", "<leader>lr", vim.lsp.buf.rename, lsp_opts)
        map("n", "<leader>ls", vim.lsp.buf.signature_help, lsp_opts)
        map("n", "<leader>L", vim.diagnostic.setloclist, lsp_opts)
        map("n", "<a-cr>", vim.lsp.buf.code_action, lsp_opts)

        local has_builtin, builtin = pcall(require, "telescope.builtin")
        if has_builtin then
            map("n", "gI", function()
                builtin.lsp_implementations({ show_line = false })
            end, lsp_opts)
            map("n", "gr", function()
                builtin.lsp_references({ show_line = false })
            end, lsp_opts)
        else
            map("n", "gr", vim.lsp.buf.references, lsp_opts)
        end

        map("n", "<leader>lf", function()
            vim.lsp.buf.format({ async = true })
        end, lsp_opts)
        map("n", "<leader>j", function()
            vim.diagnostic.goto_next({ buffer = args.buf })
        end, lsp_opts)
        map("n", "<leader>k", function()
            vim.diagnostic.goto_prev({ buffer = args.buf })
        end, lsp_opts)

        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format({ async = true })
        end, opts)
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})
