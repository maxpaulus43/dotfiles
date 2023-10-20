-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true, noremap = true }

--Remap space as leader key
keymap("", "<space>", "<Nop>", opts)

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

keymap("n", "<leader>w", "<cmd>wall<cr>", opts)           -- write all
keymap("n", "<leader>W", "<cmd>noautocmd wall<cr>", opts) -- write all (don't auto format)
keymap("n", "<leader>q", "<cmd>quitall<cr>", opts)        -- quit all
keymap("n", "<leader>x", "<cmd>confirm xall<cr>", opts)   -- write quit all
keymap("n", "gq", "<cmd>quit<cr>", opts)

-- Normal --
-- undotree
keymap("n", "<F5>", "<cmd>UndotreeToggle<cr>", opts)

-- show full filename
keymap("n", "<C-g>", "1<C-g>", opts)

-- insert newline
keymap("n", "<leader>o", "o<esc>", opts)
keymap("n", "<leader>O", "O<esc>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<S-Up>", ":resize -2<cr>", opts)
keymap("n", "<S-Down>", ":resize +2<cr>", opts)
keymap("n", "<S-Left>", ":vertical resize -2<cr>", opts)
keymap("n", "<S-Right>", ":vertical resize +2<cr>", opts)

-- Navigate buffers
keymap("n", "<S-l>", "<cmd>bnext<cr>", opts)
keymap("n", "<S-h>", "<cmd>bprevious<cr>", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<cr>", opts)

-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<cr>", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Better escape
keymap({ "i", "c" }, "jk", "<esc>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move Test up and down --
keymap("v", "J", ":m '>+1<cr>gv=gv", opts)
keymap("v", "K", ":m '<-2<cr>gv=gv", opts)

-- Plugins --

-- NvimTree
keymap("n", "<leader>e", "<cmd> NvimTreeToggle<cr>", opts)

-- Telescope
keymap("n", "<leader>fp", "<cmd>Telescope projects<cr>", opts)
keymap("n", "<leader><space>", "<cmd>Telescope buffers<cr>", opts)
keymap("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", opts)
keymap("n", "fr", "<cmd>Telescope registers<cr>", opts)
keymap("n", "<leader>ff", function()
	require("telescope.builtin").find_files({ hidden = true })
end, opts)
keymap("n", "<leader>ft", function()
	require("telescope.builtin").live_grep({ hidden = true, show_line = false })
end, opts)
keymap("n", "g*", function()
	require("telescope.builtin").grep_string({ hidden = true, show_line = false })
end, opts)
keymap('n', '<leader>/', function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
		winblend = 10,
		previewer = false,
	})
end)


-- Git
keymap("n", "<leader>gg", "<cmd> lua _LAZYGIT_TOGGLE()<cr>", opts)
-- keymap("n", "<leader>gh", "<cmd> Gitsigns preview_hunk<cr>", opts)
keymap("n", "<leader>gh", "<cmd> Gitsigns preview_hunk<cr>", opts)
keymap("n", "<leader>gb", "<cmd> Git blame<cr>", opts)
keymap("n", "<leader>rh", "<cmd> Gitsigns reset_hunk<cr>", opts)
keymap("n", "<leader>rb", "<cmd> Gitsigns reset_buffer<cr>", opts)
keymap("n", "<leader>nh", "<cmd> Gitsigns next_hunk<cr>", opts)
keymap("n", "<leader>ph", "<cmd> Gitsigns prev_hunk<cr>", opts)
keymap("n", "<leader>b", "<cmd> Gitsigns toggle_current_line_blame<cr>", opts)

-- LSP
local function lsp_keymaps(bufnr)
	local lsp_opts = { noremap = true, silent = true, buffer = bufnr }

	keymap("n", "<leader>L", vim.diagnostic.setloclist, opts)
	keymap("n", "gD", vim.lsp.buf.declaration, lsp_opts)
	keymap("n", "gd", require("telescope.builtin").lsp_definitions, lsp_opts)
	keymap("n", "K", vim.lsp.buf.hover, lsp_opts)
	keymap("n", "gl", vim.diagnostic.open_float, lsp_opts)
	keymap("n", "<leader>gr", vim.lsp.buf.references, lsp_opts)
	keymap("n", "<leader>li", "<cmd>LspInfo<cr>", lsp_opts)
	keymap("n", "<leader>lm", "<cmd>Mason<cr>", lsp_opts)
	keymap("n", "<leader>lr", vim.lsp.buf.rename, lsp_opts)
	keymap("n", "<leader>ls", vim.lsp.buf.signature_help, lsp_opts)
	keymap("n", "<leader>dd", require("telescope.builtin").diagnostics, lsp_opts)
	keymap("n", "<leader>L", vim.diagnostic.setloclist, lsp_opts)
	keymap("n", "<leader><Enter>", vim.lsp.buf.code_action, lsp_opts)

	keymap("n", "gI", function()
		require("telescope.builtin").lsp_implementations({ show_line = false })
	end, lsp_opts)
	keymap("n", "gr", function()
		require("telescope.builtin").lsp_references({ show_line = false })
	end, lsp_opts)
	keymap("n", "<leader>lf", function()
		vim.lsp.buf.format({ async = true })
	end, lsp_opts)
	keymap("n", "<leader>j", function()
		vim.diagnostic.goto_next({ buffer = bufnr })
	end, lsp_opts)
	keymap("n", "<leader>k", function()
		vim.diagnostic.goto_prev({ buffer = bufnr })
	end, lsp_opts)
end

vim.api.nvim_create_autocmd("User", {
	pattern = "LSPKeymaps",
	callback = function(args)
		local bufnr = args["buf"]
		lsp_keymaps(bufnr)
	end,
})



-- DAP
-- local dap = require("dap")
-- keymap("n", "<leader>db", dap.toggle_breakpoint, opts)
-- keymap("n", "<leader>dc", dap.continue, opts)
-- keymap("n", "<leader>di", dap.step_into, opts)
-- keymap("n", "<leader>do", dap.step_over, opts)
-- keymap("n", "<leader>dO", dap.step_out, opts)
-- keymap("n", "<leader>dr", dap.repl.toggle, opts)
-- keymap("n", "<leader>dl", dap.run_last, opts)
-- keymap("n", "<leader>dt", dap.terminate, opts)
-- keymap("n", "<leader>du", require("dapui").toggle, opts)
