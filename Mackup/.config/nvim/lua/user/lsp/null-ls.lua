local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	sources = {
		formatting.prettierd.with({
			extra_filetypes = { "toml" },
		}),
		-- formatting.rome,
		-- formatting.eslint_d,
		formatting.black.with({ extra_args = { "--fast" } }),
		formatting.stylua,
		formatting.google_java_format,

		diagnostics.eslint_d,
		diagnostics.flake8,
	},
})
