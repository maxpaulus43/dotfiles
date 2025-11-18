local map = vim.keymap.set
local opts = { silent = true, noremap = true }

local set_telescope_keymaps = function()
	local builtin = require("telescope.builtin")
	map("n", "<leader>fp", "<cmd>Telescope projects<cr>", opts)
	map("n", "<leader><space>", "<cmd>Telescope buffers<cr>", opts)
	map("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", opts)
	map("n", "<leader>fr", "<cmd>Telescope registers<cr>", opts)
	map("n", "<leader>fl", "<cmd>Telescope jumplist<cr>", opts)
	map("n", "<leader>fh", builtin.help_tags, opts)
	map("n", "<leader>fg", builtin.git_status, opts)
	map("n", "<leader>ff", function()
		builtin.find_files({ hidden = true })
	end, opts)
	map("n", "<leader>ft", function()
		builtin.live_grep({ hidden = true, show_line = false })
	end, opts)
	map("n", "g*", function()
		builtin.grep_string({ hidden = true, show_line = false })
	end, opts)
	map("n", "<leader>/", function()
		-- You can pass additional configuration to telescope to change theme, layout, etc.
		builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
			winblend = 10,
			previewer = false,
		}))
	end)
end

return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
			build = "make",
			config = function()
				local telescope = require("telescope")
				local actions = require("telescope.actions")
				telescope.setup({
					defaults = {
						hidden = true,
						sorting_strategy = "ascending",
						layout_config = {
							prompt_position = "top",
						},
						vimgrep_arguments = {
							"rg",
							"--color=never",
							"--no-heading",
							"--with-filename",
							"--line-number",
							"--column",
							"--smart-case",
							"-uu",
						},
						prompt_prefix = " ",
						selection_caret = " ",
						path_display = { "smart" },
						file_ignore_patterns = { ".git/", "node_modules" },
						extensions = {
							project = {
								hidden_files = true,
							},
							fzf = {
								fuzzy = true, -- false will only do exact matching
								override_generic_sorter = true, -- override the generic sorter
								override_file_sorter = true, -- override the file sorter
								case_mode = "smart_case", -- or "ignore_case" or "respect_case"
								-- the default case_mode is "smart_case"
							},
						},
						mappings = {
							i = {
								["<Down>"] = actions.cycle_history_next,
								["<Up>"] = actions.cycle_history_prev,
								["<C-j>"] = actions.move_selection_next,
								["<C-k>"] = actions.move_selection_previous,
								["œ"] = function(p_bufnr)
									actions.send_selected_to_qflist(p_bufnr)
									actions.open_qflist(p_bufnr)
								end,
								["jk"] = actions.close,
								["<C-o>"] = function(p_bufnr)
									actions.send_selected_to_qflist(p_bufnr)
									vim.cmd.cfdo("edit")
								end,
							},
						},
					},
					pickers = {
						buffers = {
							mappings = {
								i = {
									["<C-l>"] = actions.delete_buffer,
								},
								n = {
									["<C-l>"] = actions.delete_buffer,
								},
							},
						},
					},
				})
				set_telescope_keymaps()
			end,
		},
	},
}
