-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true, noremap = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- insert newline
keymap("n", "<leader>o", "o<ESC>", opts)
keymap("n", "<leader>O", "O<ESC>", opts)

keymap("n", "<leader>q", "<C-w>c", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
-- keymap("n", "<C-Up>", ":resize -2<CR>", opts)
-- keymap("n", "<C-Down>", ":resize +2<CR>", opts)
-- keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
-- keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", "<cmd>bnext<CR>", opts)
keymap("n", "<S-h>", "<cmd>bprevious<CR>", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move Test up and down --
-- keymap("x", "K", "<cmd>move '<-2<CR>gv-gv", opts)
-- keymap("x", "J", "<cmd>move '>+1<CR>gv-gv", opts)

-- Plugins --

-- NvimTree
keymap("n", "<leader>e", "<cmd> NvimTreeToggle<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", function()
	require("telescope.builtin").find_files({ hidden = true })
end, opts)
keymap("n", "<leader>ft", function()
	require("telescope.builtin").live_grep({ hidden = true })
end, opts)
keymap("n", "<leader>fp", "<cmd> Telescope projects<CR>", opts)
keymap("n", "<leader>fb", "<cmd> Telescope buffers<CR>", opts)

-- Git
keymap("n", "<leader>gg", "<cmd> lua _LAZYGIT_TOGGLE()<cr>", opts)
keymap("n", "<leader>gh", "<cmd> Gitsigns preview_hunk<cr>", opts)

-- Comment
keymap("n", "<leader>/", require("Comment.api").toggle.linewise.current, opts)
keymap("x", "<leader>/", '<ESC><cmd> lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>')

-- LSP
-- keymap("n", "<leader>dk", "<cmd> lua vim.diagnostic.goto_prev()<CR>", opts)
-- keymap("n", "<leader>dj", "<cmd> lua vim.diagnostic.goto_next()<CR>", opts)
keymap("n", "<leader>dd", "<cmd> Telescope diagnostics<CR>", opts)
keymap("n", "<leader>gr", "<cmd> Telescope lsp_references<CR>", opts)
keymap("n", "<leader>L", vim.diagnostic.setloclist, opts)

local function lsp_keymaps(bufnr)
	local lsp_opts = { noremap = true, silent = true, buffer = bufnr }
	keymap("n", "gD", vim.lsp.buf.declaration, lsp_opts)
	keymap("n", "gd", vim.lsp.buf.definition, lsp_opts)
	keymap("n", "K", vim.lsp.buf.hover, lsp_opts)
	keymap("n", "gI", vim.lsp.buf.implementation, lsp_opts)
	keymap("n", "gr", vim.lsp.buf.references, lsp_opts)
	keymap("n", "<leader>gr", "<cmd>Telescope lsp_references<CR>", lsp_opts)
	keymap("n", "gl", vim.diagnostic.open_float, lsp_opts)
	keymap("n", "<leader>lf", function()
		vim.lsp.buf.format({ async = true })
	end, lsp_opts)
	keymap("n", "<leader>li", "<cmd>LspInfo<cr>", lsp_opts)
	keymap("n", "<leader>lm", "<cmd>Mason<cr>", lsp_opts)
	keymap("n", "<leader>la", vim.lsp.buf.code_action, lsp_opts)
	keymap("n", "<leader>J", function()
		vim.diagnostic.goto_next({ buffer = bufnr })
	end, lsp_opts)
	keymap("n", "<leader>K", function()
		vim.diagnostic.goto_prev({ buffer = 0 })
	end, lsp_opts)
	keymap("n", "<leader>lr", vim.lsp.buf.rename, lsp_opts)
	keymap("n", "<leader>ls", vim.lsp.buf.signature_help, lsp_opts)
	keymap("n", "<leader>lq", vim.diagnostic.setloclist, lsp_opts)
	keymap("n", "<leader>dd", "<cmd> Telescope diagnostics<CR>", lsp_opts)
	keymap("n", "<leader>L", vim.diagnostic.setloclist, lsp_opts)
end

vim.api.nvim_create_autocmd("User", {
	pattern = "LSPKeymaps",
	callback = function(args)
		local bufnr = args["buf"]
		lsp_keymaps(bufnr)
	end,
})

-- DAP
keymap("n", "<leader>db", require("dap").toggle_breakpoint, opts)
keymap("n", "<leader>dc", require("dap").continue, opts)
keymap("n", "<leader>di", require("dap").step_into, opts)
keymap("n", "<leader>do", require("dap").step_over, opts)
keymap("n", "<leader>dO", require("dap").step_out, opts)
keymap("n", "<leader>dr", require("dap").repl.toggle, opts)
keymap("n", "<leader>dl", require("dap").run_last, opts)
keymap("n", "<leader>du", require("dapui").toggle, opts)
keymap("n", "<leader>dt", require("dap").terminate, opts)
