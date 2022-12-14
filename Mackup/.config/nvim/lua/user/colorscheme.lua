local colorscheme = "base16-tokyo-city-dark"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	return
end

require("colorizer").setup()

vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#ffffff", bg = "#141a1f" })
vim.api.nvim_set_hl(0, "TelescopePreviewLine", { bg = "#615e3b" })
vim.api.nvim_set_hl(0, "Visual", { bg = "#615e3b" })
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#203d32" })
