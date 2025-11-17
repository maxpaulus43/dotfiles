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

-- Plugins --

-- NvimTree
map(
	"n",
	"<leader>e",
	"<cmd> lua if not MiniFiles.close() then MiniFiles.open(vim.api.nvim_buf_get_name(0)) end <cr>",
	opts
)

-- keymap("n", "<leader>e", "<cmd> NvimTreeToggle<cr>", opts)
-- keymap("n", "<leader>e", "<cmd>Oil<cr>", opts)
-- keymap("n", "<leader>e", '<cmd> lua require("oil").toggle_float()<cr>', opts)
-- keymap("n", "<leader>e", "<cmd>Telescope file_browser<cr>", opts)

-- Git
map("n", "<leader>gg", "<cmd> lua _LAZYGIT_TOGGLE()<cr>", opts)
map("n", "<leader>gh", "<cmd> Gitsigns preview_hunk<cr>", opts)
map("n", "<leader>gb", "<cmd> Git blame<cr>", opts)
map("n", "<leader>rh", "<cmd> Gitsigns reset_hunk<cr>", opts)
map("n", "<leader>rb", "<cmd> Gitsigns reset_buffer<cr>", opts)
map("n", "<leader>nh", "<cmd> Gitsigns next_hunk<cr>", opts)
map("n", "<leader>ph", "<cmd> Gitsigns prev_hunk<cr>", opts)
-- keymap("n", "<leader>b", "<cmd> Gitsigns toggle_current_line_blame<cr>", opts)

-- LSP
local function lsp_keymaps(bufnr)
	local lsp_opts = { noremap = true, silent = true, buffer = bufnr }

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
		vim.diagnostic.goto_next({ buffer = bufnr })
	end, lsp_opts)
	map("n", "<leader>k", function()
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
