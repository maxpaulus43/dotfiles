local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end


return {
	'nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			cond = function()
				return vim.fn.executable 'make' == 1
			end,
			build = 'make',
		},
	},
	config = function()
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
					"-uu", -- thats the new thing. this helps with dotfiles
				},

				prompt_prefix = " ",
				selection_caret = " ",
				path_display = { "smart" },
				file_ignore_patterns = { ".git/", "node_modules" },
				extensions = {
					project = {
						hidden_files = true,
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
			extensions = {
				-- file_browser = {
				-- 	hidden = { file_browser = true, folder_browser = true },
				-- 	hijack_netrw = true,
				-- 	initial_mode = 'normal',
				-- 	mappings = {
				-- 		i = {
				-- 			["<leader>e"] = actions.close,
				-- 		},
				-- 		n = {
				-- 			["<leader>e"] = actions.close,
				-- 			["l"] = require('telescope.actions').select_default,
				-- 			["h"] = require('telescope._extensions.file_browser.actions').goto_parent_dir,
				-- 		}
				-- 	},
				-- }
			}
		})
		pcall(require('telescope').load_extension, 'fzf')
	end
}
