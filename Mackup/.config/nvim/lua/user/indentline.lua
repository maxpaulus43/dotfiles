local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
	return
end

indent_blankline.setup({
	char = "▏",
	show_trailing_blankline_indent = true,
	show_first_indent_level = true,
	use_treesitter = true,
	show_current_context = true,
	buftype_exclude = { "terminal", "nofile" },
	filetype_exclude = {
		"help",
		"packer",
		"NvimTree",
	},
})

vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("IndentBlanklineBigFile", {}),
	pattern = "*",
	callback = function()
		if vim.api.nvim_buf_line_count(0) > 1000 then
			require("indent_blankline.commands").disable()
		end
	end,
})
