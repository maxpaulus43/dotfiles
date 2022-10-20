local colorscheme = "base16-tokyo-city-dark"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	return
end

vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#ffffff", bg = "#141a1f" })
