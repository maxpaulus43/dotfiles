-- https://neovim.io/doc/user/lua-guide.html

-- :help mapleader
--  Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("my.keymaps")
require("my.options")
require("my.plugins")
require("my.treesitter") -- treesitter handled separately because want to defer loading
require("my.cmp")
require("my.bufferline")
require("my.illuminate")
require("my.toggleterm")
require("telescope").load_extension("projects")
require("my.lsp")

-- :help vim.highlight.on_yank()
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- additional filetypes
vim.filetype.add({
	extension = {
		templ = "templ",
	},
})

vim.api.nvim_set_hl(0, "TelescopePreviewLine", { bg = "#615e3b" })
vim.api.nvim_set_hl(0, "Visual", { bg = "#615e3b" })
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#203d32" })

-- :help modeline
-- vim: ts=2 sts=2 sw=2 et
