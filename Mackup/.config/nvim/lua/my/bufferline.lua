local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  return
end

bufferline.setup({
  options = {
    close_command = "Bdelete! %d",     -- can be a string | function, see "Mouse actions"
    right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
    offsets = {
      {
        filetype = "NvimTree",
        text = "Nvim Tree",
        separator = true,
        text_align = "left",
        separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
      },
    },
    diagnostics = "nvim_lsp",
  },
})
